Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D710DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE7C26A98
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE7C26A98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935466AbeFZMcB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:32:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934690AbeFZMb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:31:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A8A440744F3;
        Tue, 26 Jun 2018 12:31:58 +0000 (UTC)
Received: from treble (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F35581117626;
        Tue, 26 Jun 2018 12:31:55 +0000 (UTC)
Date:   Tue, 26 Jun 2018 07:31:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>, linux-crypto@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        tglx@linutronix.de, luto@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
Message-ID: <20180626123154.unjji5glpokedwal@treble>
References: <1529242717.4472.3.camel@gmx.de>
 <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
 <20180624071105.GA29407@gmail.com>
 <20180624104449.GA20159@avx2>
 <20180625072438.GA19063@gmail.com>
 <20180625131932.sge43esxdb5ejoxg@treble>
 <20180626064930.GB25879@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180626064930.GB25879@gmail.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 12:31:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 12:31:58 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 08:49:30AM +0200, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Mon, Jun 25, 2018 at 09:24:38AM +0200, Ingo Molnar wrote:
> > > 
> > > * Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > 
> > > > On Sun, Jun 24, 2018 at 09:11:05AM +0200, Ingo Molnar wrote:
> > > > > > Add explicit RETs to the tail calls of AEGIS and MORUS crypto algorithms
> > > > > > otherwise they run into INT3 padding due to
> > > > > > 
> > > > > >   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
> > > > > > 
> > > > > > leading to spurious debug exceptions.
> > > > > > 
> > > > > > Mike Galbraith <efault@gmx.de> took care of all the remaining callsites.
> > > > > 
> > > > > Note that 51bad67ffbce has been zapped because it caused too many problems like 
> > > > > this, but the explicit RETs make sense nevertheless.
> > > > 
> > > > So commit which found real bug(s) was zapped.
> > > > 
> > > > OK
> > > 
> > > No, what happened is that the commit was first moved into WIP.x86/debug showing 
> > > its work-in-progress status, because it was incomplete and caused bugs:
> > > 
> > >    https://lore.kernel.org/lkml/20180518073644.GA8593@gmail.com/T/#u
> > > 
> > > ... and finally, after weeks of inaction I zapped it because I didn't see progress 
> > > and you didn't answer my question.
> > > 
> > > If a fixed patch with updated tooling to detect these crashes before they occur on 
> > > live systems is submitted we'll reconsider - it didn't get NAK-ed, it's just 
> > > incomplete in the current form.
> > 
> > Hm, what happened to the objtool patch to detect these at build time?
> > Did it not work?
> > 
> >   https://lore.kernel.org/lkml/20180517134934.eog2fgoby5azq5a7@treble
> 
> So that's still incomplete in that doesn't analyze the 32-bit build yet, right?

We could do INT3s on 64-bit and NOPs on 32-bit.

Or, possibly even better, we could just keep NOPs everywhere and instead
make objtool smart enough to detect function fallthroughs.  That should
be pretty easy, actually.  It already does it for C files.

Something like the below should work, though it's still got a few
issues:

  a) objtool is currently disabled for crypto code because it doesn't
     yet understand crypto stack re-alignments (which really needs
     fixing anyway); and

  b) it complains about the blank xen hypercalls falling through.  Those
     aren't actual functions anyway, so we should probably annotate
     those somehow so that objtool ignores them anyway.

I'm a bit swamped at the moment but I can fix those once I get a little
more bandwidth.  I at least verified that this patch caught the crypto
missing RETs.


diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index a450ad573dcb..a2c52eec2863 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -3,8 +3,6 @@
 # Arch-specific CryptoAPI modules.
 #
 
-OBJECT_FILES_NON_STANDARD := y
-
 avx_supported := $(call as-instr,vpxor %xmm0$(comma)%xmm0$(comma)%xmm0,yes,no)
 avx2_supported := $(call as-instr,vpgatherdd %ymm0$(comma)(%eax$(comma)%ymm1\
 				$(comma)4)$(comma)%ymm2,yes,no)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2928939b98ec..f740fd828cba 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1798,13 +1798,14 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
-		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
+		if (func && insn->func && func != insn->func->pfunc) {
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
 		}
 
-		func = insn->func ? insn->func->pfunc : NULL;
+		if (insn->type != INSN_NOP)
+			func = insn->func ? insn->func->pfunc : NULL;
 
 		if (func && insn->ignore) {
 			WARN_FUNC("BUG: why am I validating an ignored function?",
