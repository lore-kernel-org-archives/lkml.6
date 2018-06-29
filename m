Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20499C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E0123ECA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E0123ECA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755081AbeF2Rke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:40:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:3214 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752103AbeF2Rkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:40:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 10:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,286,1526367600"; 
   d="scan'208";a="61160014"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2018 10:40:28 -0700
Date:   Fri, 29 Jun 2018 10:39:48 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 3/4] x86/split_lock: Handle #AC exception for split
 lock
Message-ID: <20180629173948.GN18979@romley-ivt3.sc.intel.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-4-git-send-email-fenghua.yu@intel.com>
 <f528ef21-0e6f-3c76-5fac-bd88279facc0@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7D348C9A@ORSMSX110.amr.corp.intel.com>
 <20180629171641.GM18979@romley-ivt3.sc.intel.com>
 <0c7be6ac-8268-11af-7256-13c08572b302@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7be6ac-8268-11af-7256-13c08572b302@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:29:08AM -0700, Dave Hansen wrote:
> On 06/29/2018 10:16 AM, Fenghua Yu wrote:
> > On Fri, Jun 29, 2018 at 09:33:54AM -0700, Luck, Tony wrote:
> >>>> +	WARN_ONCE(1, "A split lock issue is detected. Please FIX it\n");
> >>>
> >>> But, warning here is also not super useful.  Shouldn't we be dumping out
> >>> the info in 'regs' instead of the current context?  We don't care about
> >>> the state in the #AC handler, we care about 'regs'.
> > 
> > But WARN dump not only the state in the #AC handler, but also dump the regs
> > in the current context. And WARN dumps stack.
> 
> Oh, I forgot about the fancy stack following.  That might give us useful
> output, although mixed with useless output about the #AC handler.

The useful split lock info follows useless #AC handler info.

> 
> But, in any case, could you please at least confirm that this does what
> you think it does?  *Actually* generate #AC inside the kernel, with this
> code, and share the output?

Actually I did that already. Below is the dumped info for an actual kernel
split lock:

[41652.528398] ------------[ cut here ]------------
[41652.528408] A split lock issue is detected. Please FIX it
[41652.528422] WARNING: CPU: 5 PID: 6873 at arch/x86/kernel/cpu/test_ctl.c:71 do_ac_split_lock+0x3a/0x50
[41652.528432] Modules linked in: test_split_lock_drv(PO+) efivarfs
[41652.528445] CPU: 5 PID: 6873 Comm: insmod Tainted: P        W  O      4.18.0-rc2+ #60
[41652.528456] Hardware name: Intel Corporation WHITLEY/WHITLEY, BIOS WLYDCRB1.86B.0005.D60.1802040214 02/04/2018
[41652.528469] RIP: 0010:do_ac_split_lock+0x3a/0x50
[41652.528479] Code: 00 00 bf 33 00 00 00 e8 44 8e 36 00 0f b6 05 6e 32 4f 01 84 c0 75 e4 48 c7 c7 68 52 a0 97 c6 05 5c 32 4f 01 01 e8 16 0f 02 00 <0f> 0b b8 01 00 00 00 c3 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 
[41652.528518] RSP: 0018:ffffa979c13e7a60 EFLAGS: 00010082
[41652.528530] RAX: 0000000000000000 RBX: ffffa979c13e7b18 RCX: 0000000000000006
[41652.528541] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffffa0323b755420
[41652.528552] RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000056d
[41652.528563] R10: 0000000000000000 R11: 000000000000056d R12: 0000000000000000
[41652.528574] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[41652.528586] FS:  00007fa1ee559700(0000) GS:ffffa0323b740000(0000) knlGS:0000000000000000
[41652.528597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[41652.528608] CR2: 000055ba38138518 CR3: 0000000177138006 CR4: 00000000007606e0
[41652.528619] PKRU: 55555554
[41652.528629] Call Trace:
[41652.528642]  do_alignment_check+0x79/0x100
[41652.528654]  ? sched_clock_cpu+0xc/0xa0
[41652.528665]  ? up+0xd/0x50
[41652.528678]  alignment_check+0x1e/0x30
[41652.528690] RIP: 0010:init_module+0x46/0x9a [test_split_lock_drv]
[41652.528701] Code: b5 4d ff ff ff 48 81 ec e8 00 00 00 c7 85 4d ff ff ff 00 00 00 00 65 48 8b 04 25 28 00 00 00 48 89 45 c8 31 c0 e8 23 05 6b d6 <f0> 0f ba ad 4d ff ff ff 00 83 bd 4d ff ff ff 01 74 2f 48 c7 c7 77 
[41652.528740] RSP: 0018:ffffa979c13e7bc0 EFLAGS: 00010282
[41652.528752] RAX: 0000000000000036 RBX: ffffffffc01fd000 RCX: 0000000000000006
[41652.528763] RDX: 0000000000000000 RSI: 0000000000000086 RDI: ffffa0323b755420
[41652.528774] RBP: ffffa979c13e7cb0 R08: 0000000000000001 R09: 000000000000056b
[41652.528785] R10: ffffa979c13e7cd0 R11: 000000000000056b R12: ffffa03237b29920
[41652.528796] R13: 0000000000000000 R14: ffffa979c13e7ea0 R15: ffffa032351984e0
[41652.528808]  ? 0xffffffffc01fd000
[41652.528821]  ? __wake_up_common_lock+0x84/0xb0
[41652.528834]  ? netlink_broadcast_filtered+0x132/0x3f0
[41652.528846]  ? do_one_initcall+0x45/0x1b6
[41652.528857]  ? 0xffffffffc01fd000
[41652.528869]  do_one_initcall+0x45/0x1b6
[41652.528881]  ? _cond_resched+0x11/0x40
[41652.528893]  ? kmem_cache_alloc_trace+0x36/0x170
[41652.528905]  do_init_module+0x56/0x1f0
[41652.528918]  load_module+0x206a/0x2830
[41652.528930]  ? vfs_read+0x10f/0x130
[41652.528941]  ? vfs_read+0x10f/0x130
[41652.528954]  ? __do_sys_finit_module+0xce/0xe0
[41652.528966]  __do_sys_finit_module+0xce/0xe0
[41652.528979]  do_syscall_64+0x39/0xe0
[41652.528991]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[41652.529003] RIP: 0033:0x7fa1ee075c19
[41652.529013] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 22 2c 00 f7 d8 64 89 01 48 
[41652.529052] RSP: 002b:00007ffdd9bc74c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000139
[41652.529064] RAX: ffffffffffffffda RBX: 000055ba381381f0 RCX: 00007fa1ee075c19
[41652.529075] RDX: 0000000000000000 RSI: 000055ba371d1246 RDI: 0000000000000003
[41652.529086] RBP: 000055ba371d1246 R08: 0000000000000000 R09: 00007fa1ee33af00
[41652.529098] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[41652.529109] R13: 000055ba38137130 R14: 0000000000000000 R15: 0000000000000000
[41652.529120] ---[ end trace ae353afe85d7514d ]---
[41652.529205] split lock kernel test passes

> 
> >> Maybe:
> >>
> >> 	WARN_ONCE(1, "split lock detected at %pF\n", regs[EIP]);
> > 
> > Should we dump redundant regs info while WARN shows them all already?
> 
> I bet it actually makes it easier to read the output and locate the real
> source of the problem.  It's especially important if you're going to do
> the WARN_() from the #AC handler with all the #AC information as noise
> in the warning.

From the above WARN info, it's sufficient for people to know a split lock
happens and where it is.

Maybe remove "please FIX it" and just:
	WARN_ONCE(1, "split lock detected\n");
?

Thanks.

-Fenghua
