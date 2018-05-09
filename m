Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934139AbeEIKTr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:19:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42415 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932215AbeEIKTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:19:44 -0400
X-Google-Smtp-Source: AB8JxZr96ycDk4lquzFtzrO+XEc/FMGVvf81Lyeijyy7uCARxHQw7Se6iZHLuzn6KdVp9aRangf3lg==
Date: Wed, 9 May 2018 11:49:36 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: mqueue: delete RUN_TESTS and EMIT_TESTS
 overrides
Message-ID: <20180509094936.GD10043@localhost.localdomain>
References: <20180502211848.22404-1-shuah@kernel.org>
 <20180502211848.22404-5-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180502211848.22404-5-shuah@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-02 15:18, Shuah Khan (Samsung OSG) wrote:
> Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in lib.mk.
> The overrides are in place to call mq_open_tests with queue name argument.
> The change to delete overrides is coupled with a change to mq_open_tests
> to use default queue name when it is called without one.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Anders Roxell <anders.roxell@linaro.org>

> ---
>  tools/testing/selftests/mqueue/Makefile        | 12 +----------
>  tools/testing/selftests/mqueue/mq_open_tests.c | 29 +++++++++++++-------------
>  2 files changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/mqueue/Makefile b/tools/testing/selftests/mqueue/Makefile
> index 743d3f9e5918..8a58055fc1f5 100644
> --- a/tools/testing/selftests/mqueue/Makefile
> +++ b/tools/testing/selftests/mqueue/Makefile
> @@ -1,17 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS += -O2
>  LDLIBS = -lrt -lpthread -lpopt
> +
>  TEST_GEN_PROGS := mq_open_tests mq_perf_tests
>  
>  include ../lib.mk
> -
> -override define RUN_TESTS
> -	@$(OUTPUT)/mq_open_tests /test1 || echo "selftests: mq_open_tests [FAIL]"
> -	@$(OUTPUT)/mq_perf_tests || echo "selftests: mq_perf_tests [FAIL]"
> -endef
> -
> -override define EMIT_TESTS
> -	echo "./mq_open_tests /test1 || echo \"selftests: mq_open_tests [FAIL]\""
> -	echo "./mq_perf_tests || echo \"selftests: mq_perf_tests [FAIL]\""
> -endef
> -
> diff --git a/tools/testing/selftests/mqueue/mq_open_tests.c b/tools/testing/selftests/mqueue/mq_open_tests.c
> index e0a74bd207a5..677140aa25fd 100644
> --- a/tools/testing/selftests/mqueue/mq_open_tests.c
> +++ b/tools/testing/selftests/mqueue/mq_open_tests.c
> @@ -53,6 +53,7 @@ int saved_def_msgs, saved_def_msgsize, saved_max_msgs, saved_max_msgsize;
>  int cur_def_msgs, cur_def_msgsize, cur_max_msgs, cur_max_msgsize;
>  FILE *def_msgs, *def_msgsize, *max_msgs, *max_msgsize;
>  char *queue_path;
> +char *default_queue_path = "/test1";
>  mqd_t queue = -1;
>  
>  static inline void __set(FILE *stream, int value, char *err_msg);
> @@ -238,27 +239,27 @@ int main(int argc, char *argv[])
>  	struct mq_attr attr, result;
>  
>  	if (argc != 2) {
> -		fprintf(stderr, "Must pass a valid queue name\n\n");
> -		fprintf(stderr, usage, argv[0]);
> -		exit(1);
> -	}
> +		printf("Using Default queue path - %s\n", default_queue_path);
> +		queue_path = default_queue_path;
> +	} else {
>  
>  	/*
>  	 * Although we can create a msg queue with a non-absolute path name,
>  	 * unlink will fail.  So, if the name doesn't start with a /, add one
>  	 * when we save it.
>  	 */
> -	if (*argv[1] == '/')
> -		queue_path = strdup(argv[1]);
> -	else {
> -		queue_path = malloc(strlen(argv[1]) + 2);
> -		if (!queue_path) {
> -			perror("malloc()");
> -			exit(1);
> +		if (*argv[1] == '/')
> +			queue_path = strdup(argv[1]);
> +		else {
> +			queue_path = malloc(strlen(argv[1]) + 2);
> +			if (!queue_path) {
> +				perror("malloc()");
> +				exit(1);
> +			}
> +			queue_path[0] = '/';
> +			queue_path[1] = 0;
> +			strcat(queue_path, argv[1]);
>  		}
> -		queue_path[0] = '/';
> -		queue_path[1] = 0;
> -		strcat(queue_path, argv[1]);
>  	}
>  
>  	if (getuid() != 0) {
> -- 
> 2.14.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kselftest" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Anders Roxell
anders.roxell@linaro.org
M: +46 709 71 42 85 | IRC: roxell
