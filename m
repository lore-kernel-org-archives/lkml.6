Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9732241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9732241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbeKLWMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:12:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:38478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729133AbeKLWMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:12:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47D51B0CE;
        Mon, 12 Nov 2018 12:19:09 +0000 (UTC)
Date:   Mon, 12 Nov 2018 13:19:02 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, wang.yi59@zte.com.cn,
        linux-kernel@vger.kernel.org, matz@suse.de,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:ras/core] x86/mce: Fix -Wmissing-prototypes warnings
Message-ID: <20181112121902.GA9953@zn.tnic>
References: <alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de>
 <tip-d813dfb28641306f66cf1e2c3586f39ab4f84b27@git.kernel.org>
 <20181110141647.GA20073@zn.tnic>
 <20181112052453.GA126795@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181112052453.GA126795@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 06:24:53AM +0100, Ingo Molnar wrote:
> Nit: please use full declarations in prototypes, i.e. 'struct pt_regs 
> *regs' or so.

Done.

I'll test them some more and add them to tip:ras/core.

> Much of traps.h does this wrong so I guess this should be a separate
> cleanup patch.

See below.

Btw, do you remember why do_page_fault()'s error_code is "unsigned long"
vs all the others which are only "long" type?

Because the error code pushed by the hardware is only a couple of (least
significant) bits. 5 to be exact + there's bit 15 which is new for SGX.
But all that should still fit in a long.

Hmmm?

---
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index afbc87206886..877afdedbbc5 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -61,34 +61,34 @@ asmlinkage void xen_machine_check(void);
 asmlinkage void xen_simd_coprocessor_error(void);
 #endif
 
-dotraplinkage void do_divide_error(struct pt_regs *, long);
-dotraplinkage void do_debug(struct pt_regs *, long);
-dotraplinkage void do_nmi(struct pt_regs *, long);
-dotraplinkage void do_int3(struct pt_regs *, long);
-dotraplinkage void do_overflow(struct pt_regs *, long);
-dotraplinkage void do_bounds(struct pt_regs *, long);
-dotraplinkage void do_invalid_op(struct pt_regs *, long);
-dotraplinkage void do_device_not_available(struct pt_regs *, long);
-dotraplinkage void do_coprocessor_segment_overrun(struct pt_regs *, long);
-dotraplinkage void do_invalid_TSS(struct pt_regs *, long);
-dotraplinkage void do_segment_not_present(struct pt_regs *, long);
-dotraplinkage void do_stack_segment(struct pt_regs *, long);
+dotraplinkage void do_divide_error(struct pt_regs *regs, long error_code);
+dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
+dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
+dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
+dotraplinkage void do_overflow(struct pt_regs *regs, long error_code);
+dotraplinkage void do_bounds(struct pt_regs *regs, long error_code);
+dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
+dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
+dotraplinkage void do_coprocessor_segment_overrun(struct pt_regs *regs, long error_code);
+dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
+dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
+dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_64
-dotraplinkage void do_double_fault(struct pt_regs *, long);
+dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code);
 #endif
-dotraplinkage void do_general_protection(struct pt_regs *, long);
-dotraplinkage void do_page_fault(struct pt_regs *, unsigned long);
-dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *, long);
-dotraplinkage void do_coprocessor_error(struct pt_regs *, long);
-dotraplinkage void do_alignment_check(struct pt_regs *, long);
+dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
+dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code);
+dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
+dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
+dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_MCE
-dotraplinkage void do_machine_check(struct pt_regs *, long);
+dotraplinkage void do_machine_check(struct pt_regs *regs, long error_code);
 #endif
-dotraplinkage void do_simd_coprocessor_error(struct pt_regs *, long);
+dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_32
-dotraplinkage void do_iret_error(struct pt_regs *, long);
+dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
 #endif
-dotraplinkage void do_mce(struct pt_regs *, long);
+dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
 
 static inline int get_si_code(unsigned long condition)
 {

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
