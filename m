Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73228C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D69E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdOAHqF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfBVPIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:08:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45664 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfBVPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:08:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so1234012pgc.12;
        Fri, 22 Feb 2019 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u6cGY9f/1fLgbquD67Dct4WMbt1Dkw35cYwHxSmOtD4=;
        b=tdOAHqF4GgbAeHweNCzA16M68T+XfIiTKr/CjYC/XPqRvo/ejca0klODiD0qmOX5Ct
         LKRVpb9znzg8T5OcRCC5JJ5gwto0nEzzGsLItJWGGLnZ66hjol3+V4nnKHalC+vcAFtB
         TBi1WAWveAiTIBW75whUqU5aX7fdAwWSl0nm1+k7tHsplBxwEeBp1LwllVOjodM4YOLb
         nv+Rxp+BM8p14rUBgyYspSXpvQjizhRAo5+Vku2nw8dUxmdJwbx2EPWePygETWbmyTCr
         AmctM3BqsoYqv0OBI7t652HD7Dg6RpBAKJ9PFYHAfQcOnqjkVYiTUV6MfPf6kBmrvR+l
         67qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6cGY9f/1fLgbquD67Dct4WMbt1Dkw35cYwHxSmOtD4=;
        b=QHSRW14OiH84S/EFLqu1QJpdMWA93elcf8KwGylnfG/8sClRNmGuh9JPX0D6WxntSe
         UuRDELVgHdtR/MgTseZOa1Hu4OXe92bf8bVfqjJvZXrORM4m9S2/RlkpZCj215KyrmhD
         LfxJFsRZD6lbw7+g1b9uzvnuIMyS74quz8wuNtnyN4tqJiufSPnUrxVivNSlRWCx92fM
         B0IV6r77HCiJn6D23SPzS43yfPADRkFRPeBPGqsAh0NLg2SMCCR9Dv+f4hDCR9z5OhVp
         MzCvMrfu4XqLkI1oXeIiqLjOKC6ykXL9P1rqDwHTrrSYygU3X9rPjPv1NmzGV3SHUR82
         8kkg==
X-Gm-Message-State: AHQUAubtunY5jNXQ0W43iQhAFLll/xLNmHe9o5Chtis7DlVghrfpEr8o
        CvH9aOB4viZ+LSOMeTGafnk=
X-Google-Smtp-Source: AHgI3IaRDXnL1BSd0qalvZhNFSPAvifp3xWi8m1mu8//sy6ICBQtWnTpdutY6+qnJp400pG0viq0sw==
X-Received: by 2002:a63:f84d:: with SMTP id v13mr4460681pgj.384.1550848082371;
        Fri, 22 Feb 2019 07:08:02 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:08:01 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [PATCH V3 9/10] KVM/MMU: Use tlb range flush in the kvm_age_hva()
Date:   Fri, 22 Feb 2019 23:06:36 +0800
Message-Id: <20190222150637.2337-10-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to use tlb range flush in the kvm_age_hva().
If range flush is not available, kvm_flush_remote_tlbs_with_address()
will call kvm_flush_remote_tlbs().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 295833dafc59..2e13aac28293 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1994,7 +1994,7 @@ int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
 	int young = kvm_handle_hva_range(kvm, start, end, 0, kvm_age_rmapp);
 
 	if (flush && young > 0)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, start, end - start + 1);
 
 	return young;
 }
-- 
2.14.4

