Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE76AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BFC2190B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nSbz6GIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfABSTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:19:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34190 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfABSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:19:37 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so34444811qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=66uiRQw2tbUZfXoRZlWYct5mCcghkGuGgYIOfIgC8JI=;
        b=nSbz6GIQlWaaolMMDAPpCaDfuQlVhvG1qESXNOHS+z1/mMA2aDyNDmzljjcu/E/YT+
         sffwhOmQ83YJJHntLFCZuMfa9JS8AV8aY5idulmC5MvC0fHaCqdfjT5OouBzHVEW9s4K
         DIubDUtKDZFDdv8b6MhnopfDILEdY9jOKWNSyI4BoZFJLg7Qd8EKIpLeucUk5QEiddJf
         9sRavfYQVyMhNURxY9uBsZZLd9K+JZ2pFfi79irhg4evPEkEBHbtGqnBDeDBY9oysUyL
         xGUcabZ0mFHlU36TB5ROy8s5u0kaQMYem69ILh353WQsKZqCeoy1iz7JQJFzFoSbVkX0
         j3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=66uiRQw2tbUZfXoRZlWYct5mCcghkGuGgYIOfIgC8JI=;
        b=YVFfWvA0HmSlp7gcNwLoHNy7Bo8rdXmmjomPFv/I/MbtktZZZ2MnaaSyJ2QUhM4xc8
         kVaE9fxD3JB08QmpP97qGN/anHQyr0FZ+pYAzMec+xJYpsDaVGiNWxPLOLwIqnhaS+wr
         0vUMw2AsM8nFVYLspeatttA1Y+lqfp3wxCvq3EmDwuDk6PAAMiKd6f7Rt9RNx8M/pZ/1
         fjbwk68fUe9/1KQETkn0hrHs4WERUbGaziq6aF3+fWL2jiqQYYbMn/UT295n2WdiqFg6
         CLAIoPyx21rdFylY6+oYlVPTj6Rip99ALVigmbqJMkO/yhkiYfY7XzKNuPMu6n66XHTV
         jS3Q==
X-Gm-Message-State: AJcUukcAn8Z59X3nseVzBfsQrWfQEuUnex7LUdg7faxuNEYFk6oCm1/y
        sJ8mzzoDSsvtJ86vn/heZUEhJkTv+ywffA==
X-Google-Smtp-Source: ALg8bN6wrBg2oj4RS/uGNRGYC/xa/4N3u1ZIgITacgPVFRkF98sLwICg/9vgdKlRksSt23oosOO0sQ==
X-Received: by 2002:a0c:a3e2:: with SMTP id v89mr7792522qvv.226.1546453175402;
        Wed, 02 Jan 2019 10:19:35 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y6sm6413987qke.34.2019.01.02.10.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 10:19:35 -0800 (PST)
Subject: Re: possible deadlock in __wake_up_common_lock
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        xieyisheng1@huawei.com, zhongjiang@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <000000000000f67ca2057e75bec3@google.com>
 <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
 <20190102180611.GE31517@techsingularity.net>
From:   Qian Cai <cai@lca.pw>
Message-ID: <73c41960-e282-e2ec-4edd-788a1f49f06a@lca.pw>
Date:   Wed, 2 Jan 2019 13:19:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190102180611.GE31517@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/19 1:06 PM, Mel Gorman wrote:

> While I recognise there is no test case available, how often does this
> trigger in syzbot as it would be nice to have some confirmation any
> patch is really fixing the problem.

I think I did manage to trigger this every time running a mmap() workload
causing swapping and a low-memory situation [1].

[1]
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c

[  507.192079] ======================================================
[  507.198294] WARNING: possible circular locking dependency detected
[  507.204510] 4.20.0+ #27 Not tainted
[  507.208018] ------------------------------------------------------
[  507.214233] oom01/7666 is trying to acquire lock:
[  507.218965] 00000000bc163d02 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x10a/0xe80
[  507.226415]
[  507.226415] but task is already holding lock:
[  507.232280] 0000000064eb4795 (&pgdat->kswapd_wait){....}, at:
__wake_up_common_lock+0x112/0x1c0
[  507.241036]
[  507.241036] which lock already depends on the new lock.
[  507.241036]
[  507.249260]
[  507.249260] the existing dependency chain (in reverse order) is:
[  507.256787]
[  507.256787] -> #3 (&pgdat->kswapd_wait){....}:
[  507.262748]        lock_acquire+0x1b3/0x3c0
[  507.266960]        _raw_spin_lock_irqsave+0x35/0x50
[  507.271867]        __wake_up_common_lock+0x112/0x1c0
[  507.276863]        wakeup_kswapd+0x3d0/0x560
[  507.281159]        steal_suitable_fallback+0x40b/0x4e0
[  507.286330]        rmqueue_bulk.constprop.26+0xa36/0x1090
[  507.291760]        get_page_from_freelist+0xb79/0x28f0
[  507.296930]        __alloc_pages_nodemask+0x453/0x21f0
[  507.302099]        alloc_pages_vma+0x87/0x280
[  507.306482]        do_anonymous_page+0x443/0xb80
[  507.311128]        __handle_mm_fault+0xbb8/0xc80
[  507.315773]        handle_mm_fault+0x3ae/0x68b
[  507.320243]        __do_page_fault+0x329/0x6d0
[  507.324712]        do_page_fault+0x119/0x53c
[  507.329008]        page_fault+0x1b/0x20
[  507.332863]
[  507.332863] -> #2 (&(&zone->lock)->rlock){-.-.}:
[  507.338997]        lock_acquire+0x1b3/0x3c0
[  507.343205]        _raw_spin_lock_irqsave+0x35/0x50
[  507.348111]        get_page_from_freelist+0x108f/0x28f0
[  507.353368]        __alloc_pages_nodemask+0x453/0x21f0
[  507.358538]        alloc_page_interleave+0x6a/0x1b0
[  507.363446]        allocate_slab+0x319/0xa20
[  507.367742]        new_slab+0x41/0x60
[  507.371427]        ___slab_alloc+0x509/0x8a0
[  507.375721]        __slab_alloc+0x3a/0x70
[  507.379754]        kmem_cache_alloc+0x29c/0x310
[  507.384312]        __debug_object_init+0x984/0x9b0
[  507.389130]        hrtimer_init+0x9b/0x310
[  507.393250]        init_dl_task_timer+0x1c/0x40
[  507.397808]        __sched_fork+0x187/0x290
[  507.402015]        init_idle+0xa1/0x3a0
[  507.405875]        fork_idle+0x122/0x150
[  507.409823]        idle_threads_init+0xea/0x17a
[  507.414379]        smp_init+0x16/0xf2
[  507.418064]        kernel_init_freeable+0x31f/0x7ae
[  507.422971]        kernel_init+0xc/0x127
[  507.426916]        ret_from_fork+0x3a/0x50
[  507.431034]
[  507.431034] -> #1 (&rq->lock){-.-.}:
[  507.436119]        lock_acquire+0x1b3/0x3c0
[  507.440326]        _raw_spin_lock+0x2c/0x40
[  507.444535]        task_fork_fair+0x93/0x310
[  507.448830]        sched_fork+0x194/0x380
[  507.452863]        copy_process+0x1446/0x41f0
[  507.457247]        _do_fork+0x16a/0xac0
[  507.461107]        kernel_thread+0x25/0x30
[  507.465226]        rest_init+0x28/0x319
[  507.469085]        start_kernel+0x634/0x674
[  507.473296]        secondary_startup_64+0xb6/0xc0
[  507.478026]
[  507.478026] -> #0 (&p->pi_lock){-.-.}:
[  507.483286]        __lock_acquire+0x46d/0x860
[  507.487670]        lock_acquire+0x1b3/0x3c0
[  507.491879]        _raw_spin_lock_irqsave+0x35/0x50
[  507.496787]        try_to_wake_up+0x10a/0xe80
[  507.501170]        autoremove_wake_function+0x7e/0x1a0
[  507.506338]        __wake_up_common+0x12d/0x380
[  507.510895]        __wake_up_common_lock+0x149/0x1c0
[  507.515889]        wakeup_kswapd+0x3d0/0x560
[  507.520184]        steal_suitable_fallback+0x40b/0x4e0
[  507.525354]        rmqueue_bulk.constprop.26+0xa36/0x1090
[  507.530786]        get_page_from_freelist+0xb79/0x28f0
[  507.535955]        __alloc_pages_nodemask+0x453/0x21f0
[  507.541124]        alloc_pages_vma+0x87/0x280
[  507.545506]        do_anonymous_page+0x443/0xb80
[  507.550152]        __handle_mm_fault+0xbb8/0xc80
[  507.554797]        handle_mm_fault+0x3ae/0x68b
[  507.559267]        __do_page_fault+0x329/0x6d0
[  507.563738]        do_page_fault+0x119/0x53c
[  507.568034]        page_fault+0x1b/0x20
[  507.571890]
[  507.571890] other info that might help us debug this:
[  507.571890]
[  507.579938] Chain exists of:
[  507.579938]   &p->pi_lock --> &(&zone->lock)->rlock --> &pgdat->kswapd_wait
[  507.579938]
[  507.591311]  Possible unsafe locking scenario:
[  507.591311]
[  507.597265]        CPU0                    CPU1
[  507.601821]        ----                    ----
[  507.606375]   lock(&pgdat->kswapd_wait);
[  507.610321]                                lock(&(&zone->lock)->rlock);
[  507.616973]                                lock(&pgdat->kswapd_wait);
[  507.623452]   lock(&p->pi_lock);
[  507.626698]
[  507.626698]  *** DEADLOCK ***
[  507.626698]
[  507.632652] 3 locks held by oom01/7666:
[  507.636509]  #0: 000000000ed9e0f8 (&mm->mmap_sem){++++}, at:
__do_page_fault+0x236/0x6d0
[  507.644653]  #1: 00000000592a7e32 (&(&zone->lock)->rlock){-.-.}, at:
rmqueue_bulk.constprop.26+0x16f/0x1090
[  507.654453]  #2: 0000000064eb4795 (&pgdat->kswapd_wait){....}, at:
__wake_up_common_lock+0x112/0x1c0
[  507.663644]
[  507.663644] stack backtrace:
[  507.668027] CPU: 75 PID: 7666 Comm: oom01 Kdump: loaded Not tainted 4.20.0+ #27
[  507.675378] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10,
BIOS U30 06/20/2018
[  507.683953] Call Trace:
[  507.686416]  dump_stack+0xd1/0x160
[  507.689840]  ? dump_stack_print_info.cold.0+0x1b/0x1b
[  507.694923]  ? print_stack_trace+0x8f/0xa0
[  507.699044]  print_circular_bug.isra.10.cold.34+0x20f/0x297
[  507.704651]  ? print_circular_bug_header+0x50/0x50
[  507.709473]  check_prev_add.constprop.19+0x7ad/0xad0
[  507.714468]  ? check_usage+0x3e0/0x3e0
[  507.718241]  ? graph_lock+0xef/0x190
[  507.721838]  ? usage_match+0x27/0x40
[  507.725435]  validate_chain.isra.14+0xbd5/0x16c0
[  507.730082]  ? check_prev_add.constprop.19+0xad0/0xad0
[  507.735252]  ? stack_access_ok+0x35/0x80
[  507.739200]  ? deref_stack_reg+0xa2/0xf0
[  507.743148]  ? __read_once_size_nocheck.constprop.4+0x10/0x10
[  507.748929]  ? debug_lockdep_rcu_enabled.part.0+0x16/0x30
[  507.754362]  ? ftrace_ops_trampoline+0x131/0le_mm_fault+0xbb8/0xc80
[  508.142595]  ? handle_mm_fault+0x3ae/0x68b
[  508.146716]  ? __do_page_fault+0x329/0x6d0
[  508.150836]  ? trace_hardirqs_off+0x9d/0x230
[  508.155132]  ? trace_hardirqs_on_caller+0x230/0x230
[  508.160038]  ? pageset_set_high_and_batch+0x180/0x180
[  508.165122]  get_page_from_freelist+0xb79/0x28f0
[  508.169772]  ? __isolate_free_page+0x430/0x430
[  508.174242]  ? print_irqtrace_events+0x110/0x110
[  508.178885]  ? __isolate_free_page+0x430/0x430
[  508.183355]  ? free_unref_page_list+0x3e6/0x570
[  508.187914]  ? mark_held_locks+0x8b/0xb0
[  508.191861]  ? free_unref_page_list+0x3e6/0x570
[  508.196418]  ? free_unref_page_list+0x3e6/0x570
[  508.200976]  ? lockdep_hardirqs_on+0x1a4/0x290
[  508.205445]  ? trace_hardirqs_on+0x9d/0x230
[  508.209654]  ? ftrace_destroy_function_files+0x50/0x50
[  508.214823]  ? validate_chain.isra.14+0x16c/0x16c0
[  508.219642]  ? check_chain_key+0x13b/0x200
[  508.223766]  ? page_mapping+0x2be/0x460
[  508.227627]  ? page_evictable+0x1de/0x320
[  508.231660]  ? __page_frag_cache_drain+0x180ad0
[  508.619426]  ? lock_downgrade+0x360/0x360
[  508.623458]  ? rwlock_bug.part.0+0x60/0x60
[  508.627580]  ? do_raw_spin_unlock+0x157/0x220
[  508.631963]  ? do_raw_spin_trylock+0x180/0x180
[  508.636434]  ? do_raw_spin_lock+0x137/0x1f0
[  508.640641]  ? mark_lock+0x11c/0xd80
[  508.644238]  alloc_pages_vma+0x87/0x280
[  508.648097]  do_anonymous_page+0x443/0xb80
[  508.652219]  ? mark_lock+0x11c/0xd80
[  508.655815]  ? mark_lock+0x11c/0xd80
[  508.659412]  ? finish_fault+0xf0/0xf0
[  508.663096]  ? print_irqtrace_events+0x110/0x110
[  508.667741]  ? check_flags.part.18+0x220/0x220
[  508.672213]  ? do_raw_spin_unlock+0x157/0x220
[  508.676598]  ? do_raw_spin_trylock+0x180/0x180
[  508.681070]  ? rwlock_bug.part.0+0x60/0x60
[  508.685191]  ? check_chain_key+0x13b/0x200
[  508.689313]  ? __lock_acquire+0x4c0/0x860
[  508.693347]  ? check_chain_key+0x13b/0x200
[  508.697469]  ? handle_mm_fault+0x315/0x68b
[  508.701590]  __handle_mm_fault+0xbb8/0xc80
[  508.705711]  ? handle_mm_fault+0x4c3/0x68b
