Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015F5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AEE2073F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfBGARo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:17:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:17565 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfBGARo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:17:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 16:17:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; 
   d="scan'208";a="136487289"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2019 16:17:42 -0800
Date:   Wed, 6 Feb 2019 16:17:42 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [GIT PULL] x86/mm changes for v4.21
Message-ID: <20190207001737.GA32096@agluck-desk>
References: <20181224231106.GA27438@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224231106.GA27438@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 12:11:06AM +0100, Ingo Molnar wrote:
> Peter Zijlstra (9):
>       x86/mm/cpa: Add ARRAY and PAGES_ARRAY selftests
>       x86/mm/cpa: Add __cpa_addr() helper
>       x86/mm/cpa: Make cpa_data::vaddr invariant
>       x86/mm/cpa: Simplify the code after making cpa->vaddr invariant
>       x86/mm/cpa: Optimize cpa_flush_array() TLB invalidation
>       x86/mm/cpa: Make cpa_data::numpages invariant
>       x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array() into a single cpa_flush() function
>       x86/mm/cpa: Better use CLFLUSHOPT
>       x86/mm/cpa: Rename @addrinarray to @numpages

Something in this series from Peter is causing problems with
machine check recovery.  The kernel dies with a #GP fault

[   93.363295] Disabling lock debugging due to kernel taint
[   93.369700] mce: Uncorrected hardware memory error in user-access at 3fbeeab400
[   93.369709] mce: [Hardware Error]: Machine check events logged
[   93.384415] mce: [Hardware Error]: Machine check events logged
[   93.390973] EDAC MC2: 1 UE memory read error on CPU_SrcID#1_Ha#0_Chan#0_DIMM#0 (channel:0 slot:0 page:0x3fbeeab offset:0x400 grain:32 -  OVERFLOW recoverable area:DRAM err_code:0001:0090 socket:1 ha:0 channel_mask:1 rank:0)
[   93.413569] Memory failure: 0x3fbeeab: Killing einj_mem_uc:4810 due to hardware memory corruption
[   93.423501] Memory failure: 0x3fbeeab: recovery action for dirty LRU page: Recovered
[   93.432508] general protection fault: 0000 [#1] SMP PTI
[   93.438359] CPU: 11 PID: 0 Comm: swapper/11 Tainted: G   M              4.20.0-rc5+ #13
[   93.447294] Hardware name: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRBDXSD1.86B.0338.V01.1603162127 03/16/2016
[   93.458869] RIP: 0010:native_flush_tlb_one_user+0x8c/0xa0
[   93.464899] Code: 02 48 8b 44 24 18 65 48 33 04 25 28 00 00 00 75 20 c9 c3 83 c0 01 48 89 7c 24 08 48 89 e1 80 cc 08 0f b7 c0 48 89 04 24 31 c0 <66> 0f 38 82 01 eb d0 e8 78 0e 05 00 0f 1f 84 00 00 00 00 00 0f 1f
[   93.485859] RSP: 0018:ffff99623f2c3f70 EFLAGS: 00010046
[   93.491692] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff99623f2c3f70
[   93.499658] RDX: 2e6b58da00000121 RSI: 0000000000000000 RDI: 7fff9981feeab000
[   93.507623] RBP: ffff99623f2c3f98 R08: 0000000000000002 R09: 0000000000021640
[   93.515587] R10: 000ecaed3e716d58 R11: 0000000000000000 R12: ffffffff84fe9920
[   93.523550] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   93.531518] FS:  0000000000000000(0000) GS:ffff99623f2c0000(0000) knlGS:0000000000000000
[   93.540551] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   93.546966] CR2: 00005566b2cd5470 CR3: 00000049bee0a006 CR4: 00000000003606e0
[   93.554927] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   93.562892] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   93.570857] Call Trace:
[   93.573593]  <IRQ>
[   93.575846]  ? recalibrate_cpu_khz+0x10/0x10
[   93.580628]  __cpa_flush_tlb+0x2e/0x50
[   93.584830]  flush_smp_call_function_queue+0x35/0xe0
[   93.590390]  smp_call_function_interrupt+0x3a/0xd0
[   93.595740]  call_function_interrupt+0xf/0x20
[   93.600604]  </IRQ>

Build errors during bisection couldn't point to a single commit, but
it did limit it to:

	There are only 'skip'ped commits left to test.
	The first bad commit could be any of:
	83b4e39146aa70913580966e0f2b78b7c3492760
	935f5839827ef54b53406e80906f7c355eb73c1b
	fe0937b24ff5d7b343b9922201e469f9a6009d9d
	We cannot bisect more!

so (more descriptively):
83b4e39146aa ("x86/mm/cpa: Make cpa_data::numpages invariant")
935f5839827e ("x86/mm/cpa: Optimize cpa_flush_array() TLB invalidation")
fe0937b24ff5 ("x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array() into a single cpa_flush() function")


If I revert those three (together with the following three from this
merge - because I didn't want to run into more build problems). Then
machine check recovery starts working again.

Potentially the problem might be a non-canonical address passed down
by the machine check recovery code to switch the page with the error
to uncacheable. Perhaps the refactored code is now using that in the

	invpcid (%rcx),%rax

instruction that gets the #GP fault?

-Tony
