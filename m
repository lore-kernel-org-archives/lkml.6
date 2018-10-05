Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C6BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38497208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG60MuzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38497208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeJFBqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:46:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42627 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeJFBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:46:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so5092782pgq.9;
        Fri, 05 Oct 2018 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=yogDDg05zvklkRx+bBWTKi4FQqVG5HYZew4q+ES0rJY=;
        b=HG60MuzUmXFyE2MZ3tfce4k7WCH3g4z/BukrOhLXpAbsT1FOItHgkqn898QPaQZEqv
         rn3r2eqil43RoXFtDQ+QIYEXPETFwJrU2CODfg60/pX73oITYcUBaL10IG/JXgSphWiW
         +w/GBTi70lrAzx/PTn60WPlBC4wx1XFDwxKZR0j5Eap5gtRLH9d376twRtpcD0F/HQ25
         8pH0qA25utQjog/bhqnJraIPor6/wrskUOQGTQA58VY4Id17pQbTErA7BCr23El/F08V
         wXsOFSpcjYV7PtRGVwwcyvsz9HFiDbcHLwKLqGU8fMzsyacRuQ20Y9zK3hIxBLKQjSke
         aWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=yogDDg05zvklkRx+bBWTKi4FQqVG5HYZew4q+ES0rJY=;
        b=cA06Bvk8H3iym1mIYSfoiUHr0qO0OdNhpf5zqwe2S83cNllapaNXoEjtrjChnsS1Kj
         PQL21cetm77uOLiEfCcZNDswv2se+5ZVonv+JPx3lFMCmYNdaIDfW3TCFZum3WRcxrIY
         zsE7848855GJW2kICnTzJ/aeKBREQ+ojRmP8OqpLX8Fonvo4zqsCqZtu7bH7X9baYMU0
         APzcO9wj1PKrgwHmHckyGwtpOAyDbLOYs/NG2SrW87o0gkQLrxwvb166VTFxCxcEPFaL
         aov0cjYxNgZsRS1zqRld8tPIa6eR0f5+qxWy1UDoo07dv+QSrdu8LpAnKuQGIe9Q6oIW
         mpjg==
X-Gm-Message-State: ABuFfogsHCvRHp9sXI+wDRxjJSzwRTsHfqqcKaL90UU1tF39j0mp83g/
        PgWr3AJEfN2wCElLezRtwbg=
X-Google-Smtp-Source: ACcGV61NPol3DcDxlxtDRFN11yZlY4oaTi8DVHVAxnzZrwETR8ENzfi6i0L4/T0jEfL3pyW7oQ0ZxQ==
X-Received: by 2002:a63:da17:: with SMTP id c23-v6mr11607420pgh.23.1538765168537;
        Fri, 05 Oct 2018 11:46:08 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o24-v6sm13257272pfa.90.2018.10.05.11.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 11:46:07 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] KVM: X86: Add missing KVM_AMD dependency
Date:   Fri,  5 Oct 2018 11:46:05 -0700
Message-Id: <1538765165-19177-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building an image with KVM_AMD=y, CRYPTO_DEV_SP_PSP=y, and
CRYPTO_DEV_CCP_DD=m fails with the following error messages.

arch/x86/kvm/svm.c:6287: undefined reference to `sev_issue_cmd_external_user'
arch/x86/kvm/svm.o: In function `sev_unbind_asid':
arch/x86/kvm/svm.c:1747: undefined reference to `sev_guest_deactivate'
arch/x86/kvm/svm.c:1750: undefined reference to `sev_guest_df_flush'
arch/x86/kvm/svm.c:1759: undefined reference to `sev_guest_decommission'

Analysis shows that commit 59414c9892208 ("KVM: SVM: Add support for
KVM_SEV_LAUNCH_START command") added a dependency of KVM_AMD on
CRYPTO_DEV_CCP_DD if CRYPTO_DEV_SP_PSP is enabled: If CRYPTO_DEV_CCP_DD
is built as module, KVM_AMD must be built as module as well.

Fixes: 59414c9892208 ("KVM: SVM: Add support for KVM_SEV_LAUNCH_START command")
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 1bbec387d289..a8eff6910ea3 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -74,6 +74,7 @@ config KVM_INTEL
 config KVM_AMD
 	tristate "KVM for AMD processors support"
 	depends on KVM
+	depends on !CRYPTO_DEV_SP_PSP || (CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD)
 	---help---
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
-- 
2.7.4

