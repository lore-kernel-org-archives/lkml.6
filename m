Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0A1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A398218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Fs7U81Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfAYHeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:34:05 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:33570 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAYHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:34:05 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x0P7WwQf018950;
        Fri, 25 Jan 2019 16:32:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0P7WwQf018950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548401579;
        bh=tbbuiCD7IbfQSxtcRUBQrQMr2BXXvMyScGRF6PcyoDI=;
        h=From:To:Cc:Subject:Date:From;
        b=Fs7U81ZlT9/ijMJkA921Qgf2+hkeTHQPFvNKWazjFiV2i64ReRYAgaY1URp4xx3+U
         oRXca2uYQbWPpnKUMdsy2Huck4jER7fP0BGMUG6amKoM3Y4Kk3ueOSi+Bs769SO07i
         IG1jsTx4+yZEKRnInnT0U6S9cxmShjGpkHHDYxsAwQ0vJTk2pV0cLxDp8FAlN/3TDd
         ycbz9ckYkq1+VvivmVM6coI+gs8f+RA4ir1Kf7XB/Y0Ibtn7hZq9x8Bc5o5uRr0jpO
         ewfK8yc96SpwcS4B9mYXmOch1kBsJ1TUEqpahZYUfVxFC1w/6tAJXTXdKBJaG6U8UT
         yFlEJp40zbxjA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=8F=AB=ADm=8F=AB=A1=8F=AB=DA?= 
        <rkrcmar@redhat.com>, kvm@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] KVM: x86: fix TRACE_INCLUDE_PATH and remove -I. header search paths
Date:   Fri, 25 Jan 2019 16:32:46 +0900
Message-Id: <1548401566-29835-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header search path -I. in kernel Makefiles is very suspicious;
it allows the compiler to search for headers in the top of $(srctree),
where obviously no header file exists.

The reason of having -I. here is to make the incorrectly set
TRACE_INCLUDE_PATH working.

As the comment block in include/trace/define_trace.h says,
TRACE_INCLUDE_PATH should be a relative path to the define_trace.h

Fix the TRACE_INCLUDE_PATH, and remove the iffy include paths.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/kvm/Makefile | 4 ----
 arch/x86/kvm/trace.h  | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 69b3a7c..31ecf7a 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -2,10 +2,6 @@
 
 ccflags-y += -Iarch/x86/kvm
 
-CFLAGS_x86.o := -I.
-CFLAGS_svm.o := -I.
-CFLAGS_vmx.o := -I.
-
 KVM := ../../../virt/kvm
 
 kvm-y			+= $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 705f40a..6432d08 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1465,7 +1465,7 @@ TRACE_EVENT(kvm_hv_send_ipi_ex,
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH arch/x86/kvm
+#define TRACE_INCLUDE_PATH ../../arch/x86/kvm
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace
 
-- 
2.7.4

