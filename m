Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD17FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D93C223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D93C223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbeKNILB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:11:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNILB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:11:01 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D262A2C;
        Tue, 13 Nov 2018 22:10:47 +0000 (UTC)
Date:   Tue, 13 Nov 2018 14:10:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/1] vmalloc: add test driver to analyse vmalloc
 allocator
Message-Id: <20181113141046.f62f5bd88d4ebc663b0ac100@linux-foundation.org>
In-Reply-To: <20181113151629.14826-2-urezki@gmail.com>
References: <20181113151629.14826-1-urezki@gmail.com>
        <20181113151629.14826-2-urezki@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 16:16:29 +0100 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> This adds a new kernel module for analysis of vmalloc allocator. It is
> only enabled as a module. There are two main reasons this module should
> be used for. Those are performance evaluation and stressing of vmalloc
> subsystem.
> 
> It consists of several test cases. As of now there are 8. The module
> has four parameters we can specify, therefore change the behaviour.
> 
> 1) run_test_mask - set of tests to be run
> 
> 0 fix_size_alloc_test
> 1 full_fit_alloc_test
> 2 long_busy_list_alloc_test
> 3 random_size_alloc_test
> 4 fix_align_alloc_test
> 5 random_size_align_alloc_test
> 6 align_shift_alloc_test
> 7 pcpu_alloc_test
> 
> By default all tests are in run test mask. If you want to select some
> specific tests it is possible to pass the mask. For example for first,
> second and fourth tests we go with (1 << 0 | 1 << 1 | 1 << 3) that is
> 11 value.
> 
> 2) test_repeat_count - how many times each test should be repeated
> By default it is one time per test. It is possible to pass any number.
> As high the value is the test duration gets increased.
> 
> 3) single_cpu_test - use one CPU to run the tests
> By default this parameter is set to false. It means that all online
> CPUs execute tests. By setting it to 1, the tests are executed by
> first online CPU only.
> 
> 4) sequential_test_order - run tests in sequential order
> By default this parameter is set to false. It means that before running
> tests the order is shuffled. It is possible to make it sequential, just
> set it to 1.
> 
> Performance analysis:
> In order to evaluate performance of vmalloc allocations, usually it
> makes sense to use only one CPU that runs tests, use sequential order,
> number of repeat tests can be different as well as set of test mask.
> 
> For example if we want to run all tests, to use one CPU and repeat each
> test 3 times. Insert the module passing following parameters:
> 
> single_cpu_test=1 sequential_test_order=1 test_repeat_count=3
> 
> with following output:
> 
> <snip>
> Summary: fix_size_alloc_test 3 passed, 0 failed, test_count: 3, average: 918249 usec
> Summary: full_fit_alloc_test 3 passed, 0 failed, test_count: 3, average: 1046232 usec
> Summary: long_busy_list_alloc_test 3 passed, 0 failed, test_count: 3, average: 12000280 usec
> Summary: random_size_alloc_test 3 passed, 0 failed, test_count: 3, average: 6184357 usec
> Summary: fix_align_alloc_test 3 passed, 0 failed, test_count: 3, average: 2319067 usec
> Summary: random_size_align_alloc_test 3 passed, 0 failed, test_count: 3, average: 2858425 usec
> Summary: align_shift_alloc_test 0 passed, 3 failed, test_count: 3, average: 373 usec
> Summary: pcpu_alloc_test 3 passed, 0 failed, test_count: 3, average: 93407 usec
> All test took CPU0=197829986888 cycles
> <snip>
> 
> The align_shift_alloc_test is expected to be failed.
> 
> Stressing:
> In order to stress the vmalloc subsystem we run all available test cases
> on all available CPUs simultaneously. In order to prevent constant behaviour
> pattern, the test cases array is shuffled by default to randomize the order
> of test execution.
> 
> For example if we want to run all tests(default), use all online CPUs(default)
> with shuffled order(default) and to repeat each test 30 times. The command
> would be like:
> 
> modprobe vmalloc_test test_repeat_count=30
> 
> Expected results are the system is alive, there are no any BUG_ONs or Kernel
> Panics the tests are completed, no memory leaks.
> 

Seems useful.

Yes, there are plenty of scripts in tools/testing/selftests which load
a kernel module for the testing so a vmalloc test under
tools/testing/selftests/vm would be appropriate.

Generally the tests under tools/testing/selftests are for testing
userspace-visible interfaces, and generally linux-specific ones.  But
that doesn't mean that we shouldn't add tests for internal
functionality.

>
> ...
>
> +static int test_func(void *private)
> +{
> +	struct test_driver *t = private;
> +	cpumask_t newmask = CPU_MASK_NONE;
> +	int random_array[ARRAY_SIZE(test_case_array)];
> +	int index, repeat, i, j, ret;
> +	ktime_t kt;
> +
> +	cpumask_set_cpu(t->cpu, &newmask);
> +	set_cpus_allowed_ptr(current, &newmask);
> +
> +	atomic_inc(&tests_running);
> +	wait_for_completion(&completion1);
> +
> +	for (i = 0; i < ARRAY_SIZE(test_case_array); i++)
> +		random_array[i] = i;
> +
> +	if (!sequential_test_order)
> +		shuffle_array(random_array, ARRAY_SIZE(test_case_array));
> +
> +	t->start = get_cycles();
> +	for (i = 0; i < ARRAY_SIZE(test_case_array); i++) {
> +		index = random_array[i];
> +
> +		/*
> +		 * Skip tests if run_test_mask has been specified.
> +		 */
> +		if (!((run_test_mask & (1 << index)) >> index))
> +			continue;
> +
> +		repeat = per_cpu_test_data[t->cpu][index].test_count;
> +
> +		kt = ktime_get();
> +		for (j = 0; j < repeat; j++) {
> +			ret = test_case_array[index].test_func();
> +			if (!ret)
> +				per_cpu_test_data[t->cpu][index].test_passed++;
> +			else
> +				per_cpu_test_data[t->cpu][index].test_failed++;
> +		}
> +
> +		/*
> +		 * Take an average time that test took.
> +		 */
> +		per_cpu_test_data[t->cpu][index].time =
> +			ktime_us_delta(ktime_get(), kt) / repeat;
> +	}
> +	t->stop = get_cycles();
> +
> +	atomic_inc(&phase1_complete);
> +	wait_for_completion(&completion2);
> +
> +	atomic_dec(&tests_running);
> +	set_current_state(TASK_UNINTERRUPTIBLE);
> +	schedule();

This looks odd.  What causes this thread to wake up again?

> +	return 0;
> +}
> +
>
> ...
>
> +	if (single_cpu_test) {
> +		cpumask_clear(&cpus_run_test_mask);
> +
> +		cpumask_set_cpu(cpumask_first(cpu_online_mask),
> +			&cpus_run_test_mask);
> +	}
> +
> +	for_each_cpu(cpu, &cpus_run_test_mask) {
> +		struct test_driver *t = &per_cpu_test_driver[cpu];
> +
> +		t->cpu = cpu;
> +		t->task = kthread_run(test_func, t, "test%d", cpu);
> +		if (IS_ERR(t->task)) {
> +			pr_err("Failed to start test func\n");
> +			return;
> +		}
> +	}
> +
> +	/* Wait till all processes are running */
> +	while (atomic_read(&tests_running) <
> +			cpumask_weight(&cpus_run_test_mask)) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(10);

schedule_timeout_interruptible().  Or, better, plain old msleep().

> +	}
> +	complete_all(&completion1);
> +
> +	/* Wait till all processes have completed phase 1 */
> +	while (atomic_read(&phase1_complete) <
> +			cpumask_weight(&cpus_run_test_mask)) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(10);

Ditto.

> +	}
> +	complete_all(&completion2);
> +
> +	while (atomic_read(&tests_running)) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(10);
> +	}
> +
> +	for_each_cpu(cpu, &cpus_run_test_mask) {
> +		struct test_driver *t = &per_cpu_test_driver[cpu];
> +		int i;
> +
> +		kthread_stop(t->task);
> +
> +		for (i = 0; i < ARRAY_SIZE(test_case_array); i++) {
> +			if (!((run_test_mask & (1 << i)) >> i))
> +				continue;
> +
> +			pr_info(
> +				"Summary: %s %d passed, %d failed, test_count: %d, average: %llu usec\n",
> +				test_case_array[i].test_name,
> +				per_cpu_test_data[cpu][i].test_passed,
> +				per_cpu_test_data[cpu][i].test_failed,
> +				per_cpu_test_data[cpu][i].test_count,
> +				per_cpu_test_data[cpu][i].time);
> +		}
> +
> +		pr_info("All test took CPU%d=%lu cycles\n",
> +			cpu, t->stop - t->start);
> +	}
> +
> +	schedule_timeout(200);

This doesn't actually do anything when we're in state TASK_RUNNING.

> +}
> +
> +static int vmalloc_test_init(void)
> +{
> +	__my_vmalloc_node_range =
> +		(void *) kallsyms_lookup_name("__vmalloc_node_range");
> +
> +	if (__my_vmalloc_node_range)
> +		do_concurrent_test();
> +
> +	return -EAGAIN; /* Fail will directly unload the module */
> +}

It's unclear why this module needs access to the internal
__vmalloc_node_range().  Please fully explain this in the changelog.

Then, let's just export the thing.  (I expect this module needs a
Kconfig dependency on CONFIG_KALLSYMS, btw).  A suitable way of doing
that would be

/* Exported for lib/test_vmalloc.c.  Please do not use elsewhere */
EXPORT_SYMBOL_GPL(__vmalloc_node_range);

>
> ...
>

Generally speaking, I hope this code can use existing kernel
infrastructure more completely.  All that fiddling with atomic
counters, completions and open-coded schedule() calls can perhaps be
replaced with refcounts, counting semapores (rswems), mutexes, etc?  I
mean, from a quick glance, a lot of that code appears to be doing just
what rwsems and mutexes do?


