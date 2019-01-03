Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F13C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B509B21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="k6DUtDqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfACTxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:53:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43965 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfACTxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:53:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so38150283qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 11:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ABbHuvjg/ka3xs9hPRvpRI7tYmpTxdAVsQmtjKOnVQ=;
        b=k6DUtDqmtLPSPc7a1MVq1EGvLXlzSk4jaUZJqpsPElFRxm1WDE8AM05A9okmHLOujV
         0AzXPtsBxRqZHyujX4tVNWwOy1i9g2UliUSzYxM4/ehVtWvpAn7Ot8YZJB/zEJOfvZJ6
         uajS4PyYOFDh3VM/Nj3cT5s9I0V359fWorc+O/XVmMxOic98SnZnBJq7pNV67gI5yxxU
         jp+fhlLGiw68lhZ/AeBQP7/ElMem4wIey8+a5INN/k4mmr/mwTYTiGbc9fzUem5aquMS
         PqjIl+hW86b4bWdmwlxyGoy7usPKsEDLPUViwLbUlLZMAhFD768mHL3j4cTvdSM0Uhaa
         DIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ABbHuvjg/ka3xs9hPRvpRI7tYmpTxdAVsQmtjKOnVQ=;
        b=tVMAh/S3XeivUkL2egUu03c7lo7H4wgkhcDhrIjkTeBJISOkn6cIGn5XFY4YjIB57g
         naDpj4GqNn/LgVOb3Px1iQ2P0KuJBbwbWIF6devWe24GTPkFaJe48rDeYDIexTmJTnae
         Te2a0SbTXM+zB7clDKeGYA0ZJc38fdTL+gYrC0+Q1FER1SFCOkdNDpQemGTCC9YnKtiY
         iyUxfVh0kQOvjHlAR+1wMJdPr7OPo8lJEozM3ztoj+QDLti9BBKu4iTn16GzES+WCGn1
         oP7v9a6ZNIbwpdygcWqDwG0FDdSqq7gt500HmM6IcalcXb+fYqudD4S/8r1kE96lrVqj
         s54w==
X-Gm-Message-State: AJcUukckxVvPmbvsHk/UNF3J2rEqPMI7q6FCbQuEPBpAk/KgwhMAJ3WQ
        UI2cUj+Eu6LPFR+qvD4idl7qvtg8i1AB+A==
X-Google-Smtp-Source: ALg8bN4Lq1MMGzYbhRFVd8lpUqz0cmNyQ5W+S17t9TO07vYDmo/XqyozZBcowAvDvWcD4NBr/O+9kg==
X-Received: by 2002:a0c:d2f7:: with SMTP id x52mr47643166qvh.35.1546545229352;
        Thu, 03 Jan 2019 11:53:49 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a2sm4156779qkk.4.2019.01.03.11.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 11:53:48 -0800 (PST)
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181220185031.43146-1-cai@lca.pw>
 <20181220203156.43441-1-cai@lca.pw> <20190103115114.GL31793@dhcp22.suse.cz>
 <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
 <20190103165927.GU31793@dhcp22.suse.cz>
 <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
 <20190103190715.GZ31793@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
Date:   Thu, 3 Jan 2019 14:53:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103190715.GZ31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 2:07 PM, Michal Hocko wrote> So can we make the revert with an
explanation that the patch was wrong?
> If we want to make hacks to catch more objects to be tracked then it
> would be great to have some numbers in hands.

Well, those numbers are subject to change depends on future start_kernel()
order. Right now, there are many functions could be caught earlier by page owner.

	kmemleak_init();
	debug_objects_mem_init();
	setup_per_cpu_pageset();
	numa_policy_init();
	acpi_early_init();
	if (late_time_init)
		late_time_init();
	sched_clock_init();
	calibrate_delay();
	pid_idr_init();
	anon_vma_init();
#ifdef CONFIG_X86
	if (efi_enabled(EFI_RUNTIME_SERVICES))
		efi_enter_virtual_mode();
#endif
	thread_stack_cache_init();
	cred_init();
	fork_init();
	proc_caches_init();
	uts_ns_init();
	buffer_init();
	key_init();
	security_init();
	dbg_late_init();
	vfs_caches_init();
	pagecache_init();
	signals_init();
	seq_file_init();
	proc_root_init();
	nsfs_init();
	cpuset_init();
	cgroup_init();
	taskstats_init_early();
	delayacct_init();

	check_bugs();

	acpi_subsystem_init();
	arch_post_acpi_subsys_init();
	sfi_init_late();

	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
		efi_free_boot_services();

	rcu_scheduler_starting();
	/*
	 * Wait until kthreadd is all set-up.
	 */
	wait_for_completion(&kthreadd_done);

	/* Now the scheduler is fully set up and can do blocking allocations */
	gfp_allowed_mask = __GFP_BITS_MASK;

	/*
	 * init can allocate pages on any node
	 */
	set_mems_allowed(node_states[N_MEMORY]);

	cad_pid = task_pid(current);

	smp_prepare_cpus(setup_max_cpus);

	workqueue_init();

	init_mm_internals();

	do_pre_smp_initcalls();
	lockup_detector_init();

	smp_init();
	sched_init_smp();
