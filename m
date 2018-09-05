Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F77C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C564320861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C564320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeIETwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:52:40 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:39490 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIETwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:52:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 153142180A;
        Wed,  5 Sep 2018 15:21:58 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KQzfJyioDO0h; Wed,  5 Sep 2018 15:21:58 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id D08922184A;
        Wed,  5 Sep 2018 15:21:46 +0000 (UTC)
Subject: Re: [PATCH 2/2] Add tests for memory.oom.group
To:     jgkamat@fb.com
Cc:     linux-kselftest@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, jaygkamat@gmail.com,
        Shuah Khan <shuah@kernel.org>
References: <20180905010827.27743-1-jgkamat@fb.com>
 <20180905010827.27743-3-jgkamat@fb.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <2f5ffeaf-3161-37e2-73a3-ae449aecca40@kernel.org>
Date:   Wed, 5 Sep 2018 09:21:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905010827.27743-3-jgkamat@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jay,

Thanks for the patch. Comments below:

On 09/04/2018 07:08 PM, jgkamat@fb.com wrote:
> From: Jay Kamat <jgkamat@fb.com>
> 
> Add tests for memory.oom.group for the following cases:
> - Killing all processes in a leaf cgroup, but leaving the
>   parent untouched
> - Killing all processes in a parent and leaf cgroup
> - Keeping processes marked by OOM_SCORE_ADJ_MIN alive when considered
>   for being killed by the group oom killer.
> 
> Signed-off-by: Jay Kamat <jgkamat@fb.com>
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c  |  21 ++
>  tools/testing/selftests/cgroup/cgroup_util.h  |   1 +
>  .../selftests/cgroup/test_memcontrol.c        | 205 ++++++++++++++++++
>  3 files changed, 227 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 4aadf38bcd5d..6799c69d7f03 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -338,3 +338,24 @@ int is_swap_enabled(void)
>  
>  	return cnt > 1;
>  }
> +
> +int set_oom_adj_score(int pid, int score)
> +{
> +	char path[PATH_MAX];
> +	int fd, len;
> +
> +	sprintf(path, "/proc/%d/oom_score_adj", pid);
> +
> +	fd = open(path, O_WRONLY | O_APPEND);
> +	if (fd < 0)
> +		return fd;
> +
> +	len = dprintf(fd, "%d", score);
> +	if (len < 0) {
> +		close(fd);
> +		return len;
> +	}
> +
> +	close(fd);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
> index fe82a297d4e0..cabd43fd137a 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/cgroup_util.h
> @@ -39,3 +39,4 @@ extern int get_temp_fd(void);
>  extern int alloc_pagecache(int fd, size_t size);
>  extern int alloc_anon(const char *cgroup, void *arg);
>  extern int is_swap_enabled(void);
> +extern int set_oom_adj_score(int pid, int score);
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index cf0bddc9d271..017c15a7a935 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -2,6 +2,7 @@
>  #define _GNU_SOURCE
>  
>  #include <linux/limits.h>
> +#include <linux/oom.h>
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -202,6 +203,36 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
>  	return 0;
>  }
>  
> +static int alloc_anon_noexit(const char *cgroup, void *arg)
> +{
> +	int ppid = getppid();
> +
> +	if (alloc_anon(cgroup, arg))
> +		return -1;
> +
> +	while (getppid() == ppid)
> +		sleep(1);
> +
> +	return 0;
> +}
> +
> +/*
> + * Wait until processes are killed asynchronously by the OOM killer
> + * If we exceed a timeout, fail.
> + */
> +static int cg_test_proc_killed(const char *cgroup)
> +{
> +	int limit;
> +
> +	for (limit = 10; limit > 0; limit--) {
> +		if (cg_read_strcmp(cgroup, "cgroup.procs", "") == 0)
> +			return 0;
> +
> +		usleep(100000);
> +	}
> +	return -1;
> +}
> +
>  /*
>   * First, this test creates the following hierarchy:
>   * A       memory.min = 50M,  memory.max = 200M
> @@ -964,6 +995,177 @@ static int test_memcg_sock(const char *root)
>  	return ret;
>  }
>  
> +/*
> + * This test disables swapping and tries to allocate anonymous memory
> + * up to OOM with memory.group.oom set. Then it checks that all
> + * processes in the leaf (but not the parent) were killed.
> + */
> +static int test_memcg_oom_group_leaf_events(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *parent, *child;
> +
> +	parent = cg_name(root, "memcg_test_0");
> +	child = cg_name(root, "memcg_test_0/memcg_test_1");
> +
> +	if (!parent || !child)
> +		goto cleanup;
> +
> +	if (cg_create(parent))
> +		goto cleanup;
> +
> +	if (cg_create(child))
> +		goto cleanup;
> +
> +	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
> +		goto cleanup;
> +
> +	if (cg_write(child, "memory.max", "50M"))
> +		goto cleanup;
> +
> +	if (cg_write(child, "memory.swap.max", "0"))
> +		goto cleanup;
> +
> +	if (cg_write(child, "memory.oom.group", "1"))
> +		goto cleanup;
> +
> +	cg_run_nowait(parent, alloc_anon_noexit, (void *) MB(60));
> +	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
> +	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
> +	if (!cg_run(child, alloc_anon, (void *)MB(100)))
> +		goto cleanup;
> +
> +	if (cg_test_proc_killed(child))
> +		goto cleanup;
> +
> +	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
> +		goto cleanup;
> +
> +	if (cg_read_key_long(parent, "memory.events", "oom_kill ") != 0)
> +		goto cleanup;
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (child)
> +		cg_destroy(child);
> +	if (parent)
> +		cg_destroy(parent);
> +	free(child);
> +	free(parent);
> +
> +	return ret;
> +}
> +
> +/*
> + * This test disables swapping and tries to allocate anonymous memory
> + * up to OOM with memory.group.oom set. Then it checks that all
> + * processes in the parent and leaf were killed.
> + */
> +static int test_memcg_oom_group_parent_events(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *parent, *child;
> +
> +	parent = cg_name(root, "memcg_test_0");
> +	child = cg_name(root, "memcg_test_0/memcg_test_1");
> +
> +	if (!parent || !child)
> +		goto cleanup;
> +
> +	if (cg_create(parent))
> +		goto cleanup;
> +
> +	if (cg_create(child))
> +		goto cleanup;
> +
> +	if (cg_write(parent, "memory.max", "80M"))
> +		goto cleanup;
> +
> +	if (cg_write(parent, "memory.swap.max", "0"))
> +		goto cleanup;
> +
> +	if (cg_write(parent, "memory.oom.group", "1"))
> +		goto cleanup;
> +
> +	cg_run_nowait(parent, alloc_anon_noexit, (void *) MB(60));
> +	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
> +	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
> +
> +	if (!cg_run(child, alloc_anon, (void *)MB(100)))
> +		goto cleanup;
> +
> +	if (cg_test_proc_killed(child))
> +		goto cleanup;
> +	if (cg_test_proc_killed(parent))
> +		goto cleanup;
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (child)
> +		cg_destroy(child);
> +	if (parent)
> +		cg_destroy(parent);
> +	free(child);
> +	free(parent);
> +
> +	return ret;
> +}
> +
> +/*
> + * This test disables swapping and tries to allocate anonymous memory
> + * up to OOM with memory.group.oom set. Then it checks that all
> + * processes were killed except those set with OOM_SCORE_ADJ_MIN
> + */
> +static int test_memcg_oom_group_score_events(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *memcg;
> +	int safe_pid;
> +
> +	memcg = cg_name(root, "memcg_test_0");
> +
> +	if (!memcg)
> +		goto cleanup;
> +
> +	if (cg_create(memcg))
> +		goto cleanup;
> +
> +	if (cg_write(memcg, "memory.max", "50M"))
> +		goto cleanup;
> +
> +	if (cg_write(memcg, "memory.swap.max", "0"))
> +		goto cleanup;
> +
> +	if (cg_write(memcg, "memory.oom.group", "1"))
> +		goto cleanup;
> +
> +	safe_pid = cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(1));
> +	if (set_oom_adj_score(safe_pid, OOM_SCORE_ADJ_MIN))
> +		goto cleanup;
> +
> +	cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(1));
> +	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
> +		goto cleanup;
> +
> +	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 3)
> +		goto cleanup;
> +
> +	if (kill(safe_pid, SIGKILL))
> +		return -1;

Missing cleanup? Should the return be just ret which is KSFT_FAIL
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (memcg)
> +		cg_destroy(memcg);
> +	free(memcg);
> +
> +	return ret;
> +}
> +
> +
>  #define T(x) { x, #x }
>  struct memcg_test {
>  	int (*fn)(const char *root);
> @@ -978,6 +1180,9 @@ struct memcg_test {
>  	T(test_memcg_oom_events),
>  	T(test_memcg_swap_max),
>  	T(test_memcg_sock),
> +	T(test_memcg_oom_group_leaf_events),
> +	T(test_memcg_oom_group_parent_events),
> +	T(test_memcg_oom_group_score_events),
>  };
>  #undef T
>  
> 

thanks,
-- Shuah
