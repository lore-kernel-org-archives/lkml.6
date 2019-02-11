Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0485C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF26222B5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897555;
	bh=aQyvR2wnIA9FoVI/hGCWRyyHBUVmf75Dcn9vmm8Pcg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sxfDxQ759pNRfq3Sucb1yCigDOAItUmXLs+IQxObMMnKqjMN5EUdzG2V1hmHGOtzi
	 OkzAFVsj3ky2tV8zd+pNdHAZpTqEU7ia7loEEynvKuDC6W9nXZ0zP72sLmLlaWCtyS
	 hVIJxgQbPvC0WJjuzXzc7dmH8ezH5uYHB2vK9I1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391100AbfBKPFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391066AbfBKPFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:05:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 901F4217D9;
        Mon, 11 Feb 2019 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897551;
        bh=aQyvR2wnIA9FoVI/hGCWRyyHBUVmf75Dcn9vmm8Pcg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSR+ATgpDF5lUAF0+Xvngu5Q0tMvDnS3ma9QFHGe5XwcqH4n31UgJh5b2XTTqUWkc
         KJ+M7fXjRHR/1V0adX2TRjQ6krBGErpw/6JuYhdht+0T3B65WqDFx68C/5ewDxyr79
         X8xsVwZZUAk7hiGkUgGd906wfMABcBp9eVHoYJ1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvm ML <kvm@vger.kernel.org>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 035/137] x86/fpu: Add might_fault() to user_insn()
Date:   Mon, 11 Feb 2019 15:18:36 +0100
Message-Id: <20190211141815.229427929@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6637401c35b2f327a35d27f44bda05e327f2f017 ]

Every user of user_insn() passes an user memory pointer to this macro.

Add might_fault() to user_insn() so we can spot users which are using
this macro in sections where page faulting is not allowed.

 [ bp: Space it out to make it more visible. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181128222035.2996-6-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/fpu/internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 499d6ed0e376..21d6fa27b4a9 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -97,6 +97,9 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
+									\
+	might_fault();							\
+									\
 	asm volatile(ASM_STAC "\n"					\
 		     "1:" #insn "\n\t"					\
 		     "2: " ASM_CLAC "\n"				\
-- 
2.19.1



