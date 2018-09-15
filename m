Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46D4ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634862083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634862083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIOPkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 11:40:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIOPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 11:40:41 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g17iG-0005wk-C7; Sat, 15 Sep 2018 12:22:04 +0200
Date:   Sat, 15 Sep 2018 12:22:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 4/9] x86/intel_rdt: Fix invalid mode warning when
In-Reply-To: <1536957129-70380-5-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1809151216260.1650@nanos.tec.linutronix.de>
References: <1536957129-70380-1-git-send-email-fenghua.yu@intel.com> <1536957129-70380-5-git-send-email-fenghua.yu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018, Fenghua Yu wrote:
> If information for a cache instance with more CLOSIDs than another is
> being generated we thus encounter a warning like:
> 
> [  130.010591] ------------[ cut here ]------------
> [  130.016680] invalid mode for closid 8
> [  130.021791] WARNING: CPU: 88 PID: 1791 at [SNIP]/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> :827 rdt_bit_usage_show+0x221/0x2b0
> [  130.037974] Modules linked in: intel_rapl x86_pkg_temp_thermal kvm ipmi_ssif iTCO_wdt vfat fat iTCO_vendor_support pcspkr irqbyp
> ass lpc_ich ipmi_si ioatdma joydev i2c_i801 mfd_core ipmi_devintf dca wmi ipmi_msghandler acpi_pad i40e crct10dif_pclmul crc32_pclm
> ul nvme crc32c_intel nvme_core sunrpc scsi_transport_iscsi
> [  130.067581] CPU: 88 PID: 1791 Comm: grep Not tainted 4.18.0-rc1+ #18
> [  130.075065] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.01.00.0833.051120182255 05/11/2018
> [  130.087022] RIP: 0010:rdt_bit_usage_show+0x221/0x2b0
> [  130.093365] Code: 45 84 c0 75 58 84 c0 74 42 be 50 00 00 00 4c 89 e7 e8 53 18 26 00 e9 30 ff ff ff 44 89 fe 48 c7 c7 ed f6 e4 95
>  e8 4f d4 06 00 <0f> 0b e9 e3 fe ff ff 41 8b 45 00 09 44 24 08 e9 d6 fe ff ff 41 8b
> [  130.113872] RSP: 0018:ffffa7874f147d88 EFLAGS: 00010286
> [  130.120347] RAX: 0000000000000000 RBX: ffff8975434e0400 RCX: 0000000000000000
> [  130.128963] RDX: ffff898d5f41dbd8 RSI: ffff898d5f415c78 RDI: ffff898d5f415c78
> [  130.137562] RBP: ffffffff960285a0 R08: 00000000000005a4 R09: 0000000000aaaaaa
> [  130.146158] R10: ffff898d3e040600 R11: 00000000ffffffff R12: ffff898d4b592000
> [  130.154755] R13: ffff897543e62de0 R14: 0000000000000001 R15: 0000000000000008
> [  130.163355] FS:  00007ff6f43dd740(0000) GS:ffff898d5f400000(0000) knlGS:0000000000000000
> [  130.172920] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  130.180093] CR2: 000055b84a20f4d8 CR3: 0000002fcb5c6003 CR4: 00000000007606e0
> [  130.187846] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  130.195091] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  130.202336] PKRU: 55555554
> [  130.205093] Call Trace:
> [  130.207588]  seq_read+0xee/0x460
> [  130.210866]  __vfs_read+0x36/0x170
> [  130.214324]  vfs_read+0x89/0x130
> [  130.217605]  ksys_read+0x52/0xc0
> [  130.220885]  do_syscall_64+0x5b/0x180
> [  130.224609]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  130.229733] RIP: 0033:0x7ff6f3c88701

Can you please condense all these backtraces to the absolute minimum?

In this case the only interresting part is:

 invalid mode for closid 8
 WARNING: CPU: 88 PID: 1791 at [SNIP]/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:827
 rdt_bit_usage_show

and if at all a stripped stack trace:

 seq_read
 __vfs_read
 vfs_read
 ksys_read
 do_syscall_64

But think about it whether the stack trace provides actually useful
information or not. It's a well defined call chain.

The rest of the stuff I stripped is really completely irrelevant for
describing the problem. It just occupies space and distracts.

Thanks,

	tglx


