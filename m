Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB9FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB6E21939
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qvsfBg6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfAYH6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:58:13 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:65476 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfAYH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:58:13 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0P7vbeP015362;
        Fri, 25 Jan 2019 16:57:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0P7vbeP015362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548403058;
        bh=phPwmRVMqEdjlJMQIKUpBp/wAJ1bDKhDrtq2/FhuRcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvsfBg6lhP3K8lJ5f5e2aER8yxllOXRbR5TuPecPiwH/S4cMqYJfmhKLleKz/KRnH
         dEmUPlFpx952SKIc4/N5AbW37AYSr3PzDNzsFxkvkC+MP6h/o7MzdlrAsBnHznPRDx
         xN6qRzZOSLab47vRI8fcfjaIoPlTy3bEWoywHZgnIJ8wKJhZuu1cZe2xpCGkOzhEML
         UhORY5rdioVdo0c5koqoL9Ydzx5UdGVxDURDDiX5T43vyOBcYx9CvVC/4kHw0qh69D
         FaGOLEvFc6JOJWYrkb7QgY8KA1cusuOeSjcfuQ67ZSMjUVWTjM8qyH+PQy+43Mg/td
         +/MtiNnBC0wHQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: arm/arm64: fix TRACE_INCLUDE_PATH
Date:   Fri, 25 Jan 2019 16:57:28 +0900
Message-Id: <1548403050-6585-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comment block in include/trace/define_trace.h says,
TRACE_INCLUDE_PATH should be a relative path to the define_trace.h

../../virt/kvm/arm is the correct relative path.

../../../virt/kvm/arm is working by coincidence because the top
Makefile adds -I$(srctree)/arch/$(SRCARCH)/include as a header
search path, but we should not rely on it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 virt/kvm/arm/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
index 3828bea..853f3b1 100644
--- a/virt/kvm/arm/trace.h
+++ b/virt/kvm/arm/trace.h
@@ -265,7 +265,7 @@ TRACE_EVENT(kvm_timer_update_irq,
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH ../../../virt/kvm/arm
+#define TRACE_INCLUDE_PATH ../../virt/kvm/arm
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace
 
-- 
2.7.4

