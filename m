Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B156EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAD520855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAD520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbeK0Dys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:54:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55146 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0Dyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:54:47 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gRKEn-0005Pt-Dz; Mon, 26 Nov 2018 17:59:57 +0100
Date:   Mon, 26 Nov 2018 17:59:57 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Subject: Backtrace after invalid XRSTOR after "x86/fault: BUG() when uaccess
 helpers fault on kernel addresses"
Message-ID: <20181126165957.xhsyu2dhyy45mrjo@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 75045f77f7a7 ("x86/extable: Introduce _ASM_EXTABLE_UA for uaccess
fixups") made copy_user_to_xregs() -> XSTATE_OP() use _ASM_EXTABLE_UA.
Commit 9da3f2b74054 ("x86/fault: BUG() when uaccess helpers fault on
kernel addresses") then decided that a #GP is not good and has to be
reported loudly.

I had a TC which sets a few invalid bits in xstate which is used by
copy_user_to_xregs() on sig-return. Before that change I had:
| sig-xstate-bum[2253] bad frame in rt_sigreturn frame:0000000056078134 ip:7f9da336c227 sp:7ffc871325e8 orax:ffffffffffffffff in  libc-2.27.so[7f9da3358000+146000]

after those two patches are applied:
|BUG: GPF in non-whitelisted uaccess (non-canonical address?)
|general protection fault: 0000 [#1] PREEMPT SMP NOPTI
|CPU: 26 PID: 2236 Comm: sig-xstate-bum Not tainted 4.20.0-rc3 #45
|RIP: 0010:__fpu__restore_sig+0x1c1/0x540
|Code: 02 00 00 48 8b 95 58 ff ff ff 48 f7 d2 48 21 d0 0f 85 6e 03 00 00 0f 01 cb 48 8b 85 58 ff ff ff 48 89 df 48 89 c2 48 c1 ea 20 <48> 0f ae 2f 31 db 0f 01 ca 85 db 0f 84 d7 00 00 00 4c 89 f7 bb ff
|Call Trace:
| fpu__restore_sig+0x28/0x40
| restore_sigcontext+0x13a/0x180
| __ia32_sys_rt_sigreturn+0xae/0x100
| do_syscall_64+0x4f/0x100
| entry_SYSCALL_64_after_hwframe+0x44/0xa9
|RIP: 0033:0x7f9b06aea227
|---[ end trace a45ac23b593e9ab0 ]---

The expected behaviour would that `xrstor' performs a #GP and this does
not a produce a backtrace like that and copy_user_to_fxregs() returns an
error.
copy_user_to_fxregs() / user_insn() does not have this behaviour and
that also might generate a #GP (if invalid bits are set in MCSR).
What do we do?

Sebastian
