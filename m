Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DEA2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jAFbZwJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfBYMxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:53:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfBYMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tH2zk9Q9xKncZKqbRrrR6Wex8uiJgY7ibqKzmn47QAI=; b=jAFbZwJMgUB8KzkOQHG3dkLfi/
        zyOk2XWa4PkbTCRlCHklkUxull6lX6IrAbd7naMunESx5/IyeytWONWdv6bGumzansvUV11BIc5fK
        b/LjCYgOpdWwe5UDjEsib332cvt6rUGoLkAdk6poFXnIzc66kBOaSmBtY143LwVcYsKDSgFkZIjPX
        FraA+NF8S0NnOJuasSFM1uJZ+SMMVpfv2BCYeUYf/TgOn38ByeH2C8CBho+aMWVGs7bxvW1yo7V8a
        ALfKTpjnWX9gmqDdzVMFqfG8OHjfyvztUNvErGrhJ8fXMueWMWwCebzFxG6/zohx0wjsm/LQHcEbm
        TBvKLRVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyFkm-0006MM-5O; Mon, 25 Feb 2019 12:53:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9B40B2030E108; Mon, 25 Feb 2019 13:53:02 +0100 (CET)
Message-Id: <20190225125231.936952143@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 25 Feb 2019 13:43:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 2/6] x86/ia32: Fix ia32_restore_sigcontext AC leak
References: <20190225124330.613028745@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't call load_gs_index() with AC set; delay the segment setting
until after the AC section.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/ia32/ia32_signal.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -60,17 +60,21 @@
 	regs->seg = GET_SEG(seg) | 3;			\
 } while (0)
 
-#define RELOAD_SEG(seg)		{		\
-	unsigned int pre = GET_SEG(seg);	\
-	unsigned int cur = get_user_seg(seg);	\
-	pre |= 3;				\
-	if (pre != cur)				\
-		set_user_seg(seg, pre);		\
+#define LOAD_SEG(seg)		{			\
+	pre_##seg = 3 | GET_SEG(seg);			\
+	cur_##seg = get_user_seg(seg);			\
+}
+
+#define RELOAD_SEG(seg)		{			\
+	if (pre_##seg != cur_##seg)			\
+		set_user_seg(seg, pre_##seg);		\
 }
 
 static int ia32_restore_sigcontext(struct pt_regs *regs,
 				   struct sigcontext_32 __user *sc)
 {
+	u16 pre_gs, pre_fs, pre_ds, pre_es;
+	u16 cur_gs, cur_fs, cur_ds, cur_es;
 	unsigned int tmpflags, err = 0;
 	void __user *buf;
 	u32 tmp;
@@ -85,10 +89,10 @@ static int ia32_restore_sigcontext(struc
 		 * the handler, but does not clobber them at least in the
 		 * normal case.
 		 */
-		RELOAD_SEG(gs);
-		RELOAD_SEG(fs);
-		RELOAD_SEG(ds);
-		RELOAD_SEG(es);
+		LOAD_SEG(gs);
+		LOAD_SEG(fs);
+		LOAD_SEG(ds);
+		LOAD_SEG(es);
 
 		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
 		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
@@ -106,6 +110,11 @@ static int ia32_restore_sigcontext(struc
 		buf = compat_ptr(tmp);
 	} get_user_catch(err);
 
+	RELOAD_SEG(gs);
+	RELOAD_SEG(fs);
+	RELOAD_SEG(ds);
+	RELOAD_SEG(es);
+
 	err |= fpu__restore_sig(buf, 1);
 
 	force_iret();


