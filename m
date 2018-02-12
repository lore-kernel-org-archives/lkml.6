Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933870AbeBLNN7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:13:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933035AbeBLNN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:13:58 -0500
Date: Mon, 12 Feb 2018 07:13:51 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:x86/pti 19/20] arch/x86/entry/entry_64.o: warning: objtool:
 paranoid_entry()+0x11: call without frame pointer save/setup
Message-ID: <20180212131351.ezb34yvghc3eqhvu@treble>
References: <201802121926.YqVjXPha%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201802121926.YqVjXPha%fengguang.wu@intel.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 07:33:27PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti
> head:   5a10e729bc0aa9420a23a70b169eadd229c27bc1
> commit: f09d160992d129b6d8fada7543761d40f5b33596 [19/20] x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS macros
> config: x86_64-randconfig-s0-02121550 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         git checkout f09d160992d129b6d8fada7543761d40f5b33596
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/entry/entry_64.o: warning: objtool: paranoid_entry()+0x11: call without frame pointer save/setup
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Oops, looks like one of my suggested unwind hint changes wasn't so good
for the frame pointer case.  The below should fix it.  I'll submit a
proper patch in a little bit after running it through 0-day.

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cfbf43366731..1c54204207d8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1128,6 +1128,7 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
+	UNWIND_HINT_FUNC
 	cld
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1141,7 +1142,7 @@ ENTRY(paranoid_entry)
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
 	ret
-ENDPROC(paranoid_entry)
+END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
