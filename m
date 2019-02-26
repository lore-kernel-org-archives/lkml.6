Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE711218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfBZQj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:39:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42967 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:39:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so14677861wrg.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 08:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Co5P4eSaFJsfJWpjn+65Ssa593EycSY/h5BKiDZnN2c=;
        b=p/E0GPxXtZ+qGwEltt1k9KOC8yzNDcupx9arcPmEmKWHACTqqrAWEh+LQOJmRAFl0p
         gm1oEMJxd/eTiIJe/9ln5X+avOYCSUvDFlc3cbjHw/GNmaT8q/qxlGPJIc7jS4X77qp7
         Gfrvsl60pAj0d4AiPRGb61vJwhQ7aWBhTV3qbwLhBed+1ieZq4Y0opcL4iHLw4ipG0mG
         4V66Ug7XNOs4ofmdTlCe+gp0zUt7fvcsqhWg78WuYnd3tiR6YqZCsL5wIFUHpEVlFNby
         oBDXzdTqaVWuc7MCs68jTTZ3snqEIIDooo+vo1QDYlMgQDhOPp2DuNyJ2oL9rcNK5Pce
         JLAA==
X-Gm-Message-State: AHQUAub++gM55Kn27dqK4nlW8MB+Qd0CRumoCEMwU4YzSf1vDvQHlNBR
        H9CNB1TlfqG9KHKAy1hqGiNR9g==
X-Google-Smtp-Source: AHgI3IaHSuQfl0Bt5zdLPWjJFE0XZFlhKQ8N6gVzYCqH2+f/Qyh/Itb/LoNl3A4fXKh+6XMQyY2UeA==
X-Received: by 2002:a5d:654a:: with SMTP id z10mr16436187wrv.280.1551199165021;
        Tue, 26 Feb 2019 08:39:25 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o12sm17936601wrx.53.2019.02.26.08.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 08:39:24 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>,
        x86@kernel.org, devel@linuxdriverproject.org,
        Kairui Song <kasong@redhat.com>
Subject: Re: [RFC PATCH] x86, hyperv: fix kernel panic when kexec on HyperV VM
In-Reply-To: <20190226155615.16724-1-kasong@redhat.com>
References: <20190226155615.16724-1-kasong@redhat.com>
Date:   Tue, 26 Feb 2019 17:39:23 +0100
Message-ID: <877edmsdvo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <kasong@redhat.com> writes:

> When hypercalls is used for sending IPIs, kexec will fail with a kernel
> panic like this:
>
> kexec_core: Starting new kernel
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> PGD 8000000057995067 P4D 8000000057995067 PUD 57990067 PMD 0
> Oops: 0002 [#1] SMP PTI
> CPU: 0 PID: 1016 Comm: kexec Not tainted 4.18.16-300.fc29.x86_64 #1
> Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v3.0 03/02/2018
> RIP: 0010:0xffffc9000001d000
> Code: Bad RIP value.
> RSP: 0018:ffffc9000495bcf0 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffffc9000001d000 RCX: 0000000000020015
> RDX: 000000007f553000 RSI: 0000000000000000 RDI: ffffc9000495bd28
> RBP: 0000000000000002 R08: 0000000000000000 R09: ffffffff8238aaf8
> R10: ffffffff8238aae0 R11: 0000000000000000 R12: ffff88007f553008
> R13: 0000000000000001 R14: ffff8800ff553000 R15: 0000000000000000
> FS:  00007ff5c0e67b80(0000) GS:ffff880078e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc9000001cfd6 CR3: 000000004f678006 CR4: 00000000003606f0
> Call Trace:
>  ? __send_ipi_mask+0x1c6/0x2d0
>  ? hv_send_ipi_mask_allbutself+0x6d/0xb0
>  ? mp_save_irq+0x70/0x70
>  ? __ioapic_read_entry+0x32/0x50
>  ? ioapic_read_entry+0x39/0x50
>  ? clear_IO_APIC_pin+0xb8/0x110
>  ? native_stop_other_cpus+0x6e/0x170
>  ? native_machine_shutdown+0x22/0x40
>  ? kernel_kexec+0x136/0x156
>  ? __do_sys_reboot+0x1be/0x210
>  ? kmem_cache_free+0x1b1/0x1e0
>  ? __dentry_kill+0x10b/0x160
>  ? _cond_resched+0x15/0x30
>  ? dentry_kill+0x47/0x170
>  ? dput.part.34+0xc6/0x100
>  ? __fput+0x147/0x220
>  ? _cond_resched+0x15/0x30
>  ? task_work_run+0x38/0xa0
>  ? do_syscall_64+0x5b/0x160
>  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables sunrpc vfat fat crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_rapl_perf hv_balloon joydev xfs libcrc32c hv_storvsc serio_raw scsi_transport_fc hv_netvsc hyperv_keyboard hyperv_fb hid_hyperv crc32c_intel hv_vmbus
>
> That's because HyperV's machine_ops.shutdown allow registering a hook to
> be called upon shutdown, hv_vmbus will invalidate the hypercall page
> using this hook. But hv_hypercall_pg is still pointing to this invalid
> page, any hypercall based operation will panic the kernel. And kexec
> progress will send IPIs for stopping CPUs.
>
> This fix this by simply reset hv_hypercall_pg to NULL when the page is
> revoked to avoid any misuse. IPI sending will fallback to use non
> hypercall based method. This only happens on kexec / kdump so setting to
> NULL should be good enough.
>
> Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
> Signed-off-by: Kairui Song <kasong@redhat.com>
>
> ---
>
> I'm not sure about the details of what happened after the
>
> wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>
> But this fix should be valid, please let me know if I get anything
> wrong, thanks.
>
>  arch/x86/hyperv/hv_init.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 7abb09e2eeb8..92291c18d716 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -406,6 +406,10 @@ void hyperv_cleanup(void)
>  	/* Reset our OS id */
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  
> +	/* Cleanup page reference before reset the page */
> +	hv_hypercall_pg = NULL;
> +	wmb();
> +
>  	/* Reset the hypercall page */
>  	hypercall_msr.as_uint64 = 0;
>  	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);

This all looks correct to me. We need to reset HV_X64_MSR_HYPERCALL as
the hypercall page will remain 'special' otherwise so dumping it may
have undesired consequences (though, I think that last time I checked it
it was possible to read from this page without issues - and this should
be enough for kdump. But I'd rather keep things as they are as one
additional wrmsr doesn't hurt).

-- 
Vitaly
