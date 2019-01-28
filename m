Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEEBC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9A62087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694109;
	bh=kDkHzGQDNmFra8kTBsURHGrbFKxXF4L0CAap0A9iJQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ihdmj4eeduPCFNi5aaQ59EAqVfLkBBqMTBHWZ32GXwLjjirXxjqcryNVS1gDasTn0
	 y9n5lCN/T6BEoue54L44iXChtzET76b95pijYVv03SFji9UNNTvWMfuvgmpv65XJWW
	 Ez7mKyC4w7DfzqHOmvACJHWj1DXKabf6s74ldzTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbfA1QVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:21:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388189AbfA1QVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 532D620663;
        Mon, 28 Jan 2019 16:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692492;
        bh=kDkHzGQDNmFra8kTBsURHGrbFKxXF4L0CAap0A9iJQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/GQl/xoP3ZA8HvGF2dyQzSh8kQi7Q9X57Ms5+l0P6ncz7bovqT6AjvM2mEHCqK5H
         UravVWk7CNOEFIrjYk+T8UT6qnDtthSx0wQMZGtCCa3DravT4acILiTqx9WXkEZgU5
         S99Ccn3W2cPGcEHibT37e1l76iF/CrTpSMKtyc3M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvm ML <kvm@vger.kernel.org>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 037/107] x86/fpu: Add might_fault() to user_insn()
Date:   Mon, 28 Jan 2019 11:18:37 -0500
Message-Id: <20190128161947.57405-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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

