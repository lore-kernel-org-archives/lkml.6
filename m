Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41357C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 05:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB212080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 05:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gnYENC3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfAAFoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 00:44:38 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44826 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfAAFoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 00:44:38 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so30639736qte.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 21:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jpVzcdxGIszSzxvb5QxULHsU0tDtjhNEHECdTWGahmE=;
        b=gnYENC3OAE0gsPUWanr96RgkFE0vrwwo3GHwzOjJyne6ZehImdEEQAw1TLXkY2gbnX
         auWK1lIx+2n1birGq2jepqnpKv0fD3NGUaytHtj1/T5B/N9zVrBpVdPcD7fDTBAruzDZ
         0OQ0uTwEA/TULJeh/5bRmnBRU6VdKlSfZbRr+8coc/5AbDRpLG9K0ebGHPZ/7isOBzic
         1qsrU73DRnqZu93FH2E1Z+uSv81aN/bUYsLlxXp0fKP27KcDd0HyAmIpSCTszXQqdFBt
         s9/NnGy4XNTw6FvjVMs2HiPwIgkd+opw2SJlvWQSG0ThhSmf9xwT1jU0uCjUkdOt94nH
         fmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jpVzcdxGIszSzxvb5QxULHsU0tDtjhNEHECdTWGahmE=;
        b=kFwTjnQhJgHTusdQWCcTQglCUD80KafoMymKUV2JUdjDxrtyXYzVg5PG/q9tD+J1/t
         ca9wbxRFpquQA4a3i7via1aKriEp6ktWhIFAE8yc3J45Md3oLldT4ua0l9T7iigt1zvj
         Dg3DSzPro5sd9Di+v7t0SAz4QfcUJQQ1J3M76e504RfkdGD5nZ1P1L807qOWwVIoeR4c
         czyw8AYw3eeKdENUhknUsRTaoHf1oZLX/426z82RvosWID5H0K3BNCH5NahmTdt7Qtsn
         iOky79q6rgvv8A0udYIMdTbH84RabZwForCHv0dAyoC3KZiCR4hvSevVVlp7wA3e/2Yu
         9P6g==
X-Gm-Message-State: AJcUukf3uxeGpmhy4c5M/txNzE5Dw8m4N9AP/2tEujjsLKXHN24sV008
        pcHOv1v4G1QoCpNVqJTLO0LVCLBOAZA0iQ==
X-Google-Smtp-Source: ALg8bN6jqq5eQQsd89m5fBc0baGxc46PcTBCdYEtFqDeV/4MrBX5a16b+bawDXuKn3WKgaOgX1DC0g==
X-Received: by 2002:a0c:8542:: with SMTP id n60mr38422016qva.205.1546321476856;
        Mon, 31 Dec 2018 21:44:36 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 189sm19721982qkh.9.2018.12.31.21.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 21:44:36 -0800 (PST)
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux kernel <linux-kernel@vger.kernel.org>
From:   Qian Cai <cai@lca.pw>
Subject: kernel BUG at kernel/sched/core.c:3490!
Message-ID: <ba9c5ad8-d78c-904d-0430-a67d8e3ea729@lca.pw>
Date:   Tue, 1 Jan 2019 00:44:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running some mmap() workloads to put the system on low memory situation with
swapping and OOM, and then it trigger this BUG(),

void __noreturn do_task_dead(void)
{
        /* Causes final put_task_struct in finish_task_switch(): */
        set_special_state(TASK_DEAD);

        /* Tell freezer to ignore us: */
        current->flags |= PF_NOFREEZE;

        __schedule(false);
        BUG();

        /* Avoid "noreturn function does return" - but don't continue if BUG()
is a NOP: */
        for (;;)
                cpu_relax();
}

[  422.863911] kernel BUG at kernel/sched/core.c:3490!
[  422.868634] oom01 (3177) used greatest stack depth: 28712 bytes left
[  422.869109] invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  422.880325] CPU: 86 PID: 3235 Comm: oom01 Kdump: loaded Tainted: G        W
      4.20.0+ #5
[  422.888995] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10,
BIOS A40 09/07/2018
[  422.897590] RIP: 0010:do_task_dead+0x73/0x90
[  422.901893] Code: 48 c7 43 10 80 00 00 00 4c 89 ee 4c 89 e7 e8 34 26 8a 00 48
8d 7b 24 e8 3b b6 2e 00 81 4b 24 00 80 00 00 31 ff e8 8d 4c 89 00 <0f> 0b 48 c7
c7 40 2c 53 b1 e8 da e7 51 00 0f 1f 44 00 00 66 2e 0f
[  422.920783] RSP: 0018:ffff888392daf5a8 EFLAGS: 00010282
[  422.926048] RAX: 0000000000000000 RBX: ffff88810e23aec0 RCX: 0000000000000000
[  422.933234] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffffed10725b5ea8
[  422.940419] RBP: ffff888392daf5c0 R08: fffffbfff6338a76 R09: fffffbfff6338a75
[  422.947604] R10: fffffbfff6338a75 R11: ffffffffb19c53ab R12: ffff88810e23b510
[  422.954789] R13: 0000000000000246 R14: 0000000000000000 R15: ffff888638f636d8
[  422.961974] FS:  00007f105ff5d700(0000) GS:ffff88905e300000(0000)
knlGS:0000000000000000
[  422.970118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  422.975905] CR2: 00007f105ff5d9d0 CR3: 0000000a23e1e000 CR4: 00000000001406a0
[  422.983087] Call Trace:
[  422.985564]  do_exit+0x95e/0xe30
[  422.988821]  ? dump_align+0x50/0x50
[  422.992338]  ? mm_update_next_owner+0x570/0x570
[  422.996906]  ? __kasan_slab_free+0x1af/0x210
[  423.001207]  ? kmem_cache_free+0xc0/0x350
[  423.005247]  ? __dequeue_signal+0x2bd/0x370
[  423.009460]  ? dequeue_signal+0x90/0x2d0
[  423.013410]  ? get_signal+0x296/0xf30
[  423.017100]  ? do_signal+0x93/0x9d0
[  423.020619]  ? exit_to_usermode_loop+0x130/0x170
[  423.025271]  ? prepare_exit_to_usermode+0x1d7/0x1f0
[  423.030187]  ? retint_user+0x8/0x18
[  423.033704]  ? trace_hardirqs_off+0x9d/0x230
[  423.038005]  ? trace_hardirqs_on_caller+0x230/0x230
[  423.042919]  ? do_raw_spin_trylock+0x180/0x180
[  423.047396]  ? do_raw_spin_lock+0xf0/0x1f0
[  423.051524]  ? rwlock_bug.part.0+0x60/0x60
[  423.055656]  ? __dequeue_signal+0x2bd/0x370
[  423.059871]  ? _raw_spin_unlock_irqrestore+0x34/0x50
[  423.064873]  ? __debug_check_no_obj_freed+0x204/0x330
[  423.069963]  ? debug_object_free+0x10/0x10
[  423.074092]  ? trace_hardirqs_on_caller+0x9f/0x230
[  423.078920]  ? check_stack_object+0x22/0x60
[  423.083138]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  423.087964]  ? kmem_cache_free+0x22e/0x350
[  423.092091]  ? __dequeue_signal+0x2bd/0x370
[  423.096309]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  423.101137]  ? get_signal+0x530/0xf30
[  423.104828]  ? __flush_itimer_signals+0x310/0x310
[  423.109567]  ? check_flags.part.18+0x220/0x220
[  423.114045]  ? recalc_sigpending+0x6e/0x110
[  423.118258]  ? __sigqueue_alloc+0x4e0/0x4e0
[  423.122470]  ? lockdep_hardirqs_on+0x11/0x290
[  423.126861]  do_group_exit+0xc1/0x1d0
[  423.130552]  ? __x64_sys_exit+0x30/0x30
[  423.134416]  get_signal+0x4a6/0xf30
[  423.137933]  ? ptrace_notify+0xb0/0xb0
[  423.141708]  ? force_sig_fault+0xb3/0xf0
[  423.145659]  ? force_sigsegv+0x90/0x90
[  423.149440]  ? set_signal_archinfo+0x6f/0xa0
[  423.153738]  ? __do_page_fault+0x6b1/0x6d0
[  423.157863]  ? mm_fault_error+0x140/0x140
[  423.161903]  do_signal+0x93/0x9d0
[  423.165244]  ? lockdep_hardirqs_on+0x11/0x290
[  423.169632]  ? trace_hardirqs_on+0x9d/0x230
[  423.173846]  ? ftrace_destroy_function_files+0x50/0x50
[  423.179022]  ? do_raw_spin_trylock+0x180/0x180
[  423.183498]  ? setup_sigcontext+0x260/0x260
[  423.187712]  ? do_page_fault+0x119/0x53c
[  423.191663]  ? lockdep_hardirqs_on+0x11/0x290
[  423.196050]  ? trace_hardirqs_on+0x9d/0x230
[  423.200264]  ? ftrace_destroy_function_files+0x50/0x50
[  423.205441]  ? task_work_run+0x118/0x1a0
[  423.209393]  ? mark_held_locks+0x23/0xb0
[  423.213345]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  423.217999]  ? retint_user+0x18/0x18
[  423.221602]  exit_to_usermode_loop+0x130/0x170
[  423.226081]  ? lockdep_sys_exit_thunk+0x29/0x29
[  423.230647]  prepare_exit_to_usermode+0x1d7/0x1f0
[  423.235387]  ? syscall_slow_exit_work+0x380/0x380
[  423.240127]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  423.244866]  ? page_fault+0x5/0x20
[  423.248294]  retint_user+0x8/0x18
[  423.251637] RIP: 0033:0x40f910
[  423.254719] Code: Bad RIP value.
[  423.257970] RSP: 002b:00007f105ff5cec0 EFLAGS: 00010206
[  423.263230] RAX: 0000000000001000 RBX: 00000000c0000000 RCX: 00007f5dd40bd497
[  423.270413] RDX: 0000000013ff8000 RSI: 00000000c0000000 RDI: 0000000000000000
[  423.277594] RBP: 00007f0edef5c000 R08: 00000000ffffffff R09: 0000000000000000
[  423.284777] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000001
[  423.291958] R13: 00007ffe090ed89f R14: 0000000000000000 R15: 00007f105ff5cfc0
[  423.299141] Modules linked in: af_packet nls_iso8859_1 nls_cp437 vfat fat ses
enclosure efivars ip_tables x_tables xfs libcrc32c crc32c_generic crypto_hash
sd_mod smartpqi tg3 scsi_transport_sas mlx5_core libphy firmware_class dm_mirror
dm_region_hash dm_log dm_mod efivarfs
