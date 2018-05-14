Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeENLFS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:05:18 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:34859 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752121AbeENLFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:05:16 -0400
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH] sched: refill quota for current period when refilling
 timer activates
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Ben Segall <bsegall@google.com>
References: <152629550328.178124.4904326637886063654.stgit@buzz>
Message-ID: <bf413365-9cb3-be9e-18b7-4be52e0fa1cf@yandex-team.ru>
Date: Mon, 14 May 2018 14:05:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152629550328.178124.4904326637886063654.stgit@buzz>
Content-Type: multipart/mixed;
 boundary="------------6E0F7ABCF3C69E5DBE7D8550"
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6E0F7ABCF3C69E5DBE7D8550
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.05.2018 13:58, Konstantin Khlebnikov wrote:
> Period timer deactivates if task group has no activity during past period,
> i.e. if were no throttle and runtime from global pool weren't consumed.
> When timer activates back global pool contains unpredictable amount of
> expired runtime allocated long ago. In some cases this works fine and
> task could use it until next refill. But series short execution slices
> could drain all that leftovers because each switch expires local poll.
> In this case task group will be throttled until quota refill.

Attached piece of code allows to reproduce problem.

run
sched-burst 10 10000000 1000000000

in cgroup with

cpu.cfs_period_us = 100000
cpu.cfs_quota_us = 1100000

Series of sched_yield() drains stale runtime from global pool before refilling.

> 
> This patch refills quota right at the moment of timer's activation.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   kernel/sched/fair.c |    2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 79f574dba096..b8d73ed17ff6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5165,6 +5165,8 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>   
>   	if (!cfs_b->period_active) {
>   		cfs_b->period_active = 1;
> +		/* refill quota for current period after inactivity */
> +		__refill_cfs_bandwidth_runtime(cfs_b);
>   		hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>   		hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>   	}
> 

--------------6E0F7ABCF3C69E5DBE7D8550
Content-Type: text/x-csrc;
 name="sched-burst.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sched-burst.c"

#define _GNU_SOURCE
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdatomic.h>
#include <sched.h>
#include <unistd.h>
#include <string.h>
#include <time.h>


pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t wakeup = PTHREAD_COND_INITIALIZER;
pthread_cond_t done = PTHREAD_COND_INITIALIZER;
int nr_threads;
int nr_booting;
int nr_running;
int64_t burn_ns;
int64_t pace_ns;

#define NSEC_PER_SEC	1000000000L

int64_t clock_diff(struct timespec *a, struct timespec *b) {
	return (a->tv_sec - b->tv_sec) * NSEC_PER_SEC + a->tv_nsec - b->tv_nsec;
}

struct thread_data {
	struct timespec wakeup;
	struct timespec start;
	struct timespec finish;
	int64_t burn;
};

void *thread_fn(void *_data) {
	struct thread_data *data = _data;

	pthread_mutex_lock(&mutex);
	if (!--nr_booting)
		pthread_cond_signal(&done);
	while (1) {
		pthread_cond_wait(&wakeup, &mutex);
		clock_gettime(CLOCK_MONOTONIC, &data->start);
		pthread_mutex_unlock(&mutex);
		do {
			sched_yield();
			clock_gettime(CLOCK_MONOTONIC, &data->finish);
		} while (clock_diff(&data->finish, &data->start) < burn_ns);
		pthread_mutex_lock(&mutex);
		if (!--nr_running)
			pthread_cond_signal(&done);
	}
	pthread_mutex_unlock(&mutex);

	return NULL;
}

int main(int argc, char **argv) {
	nr_threads = atoi(argv[1]);
	burn_ns = atol(argv[2]);
	pace_ns = atol(argv[3]);

	pthread_t thread[nr_threads];
	struct thread_data thread_data[nr_threads];
	int nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);

	nr_booting = nr_threads;
	for (int i = 0; i < nr_threads; i++)
		pthread_create(thread + i, NULL, thread_fn, thread_data + i);

	pthread_mutex_lock(&mutex);
	pthread_cond_wait(&done, &mutex);
	pthread_mutex_unlock(&mutex);

	while (1) {
		struct timespec pace_ts = {
			.tv_sec = pace_ns / NSEC_PER_SEC,
			.tv_nsec = pace_ns % NSEC_PER_SEC
		};

		clock_nanosleep(CLOCK_MONOTONIC, 0, &pace_ts, NULL);

		nr_running = nr_threads;
		pthread_cond_broadcast(&wakeup);

		pthread_mutex_lock(&mutex);
		pthread_cond_wait(&done, &mutex);
		pthread_mutex_unlock(&mutex);
	}

	return 0;
}

--------------6E0F7ABCF3C69E5DBE7D8550--
