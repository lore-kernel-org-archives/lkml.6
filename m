Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED06C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783D520685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFvlUnTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783D520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeKHSul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:50:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42462 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHSul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:50:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id u10-v6so3289798pfn.9;
        Thu, 08 Nov 2018 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mf4jQKDBupERk9IP8j/c7DldYt9kVutHpnKEjeY1Ldg=;
        b=qFvlUnTwf8mkn8q8geC7QphecA07wjvdx/2EoV7iCtwNLDma89hkjq3gNjwUcl8FLW
         vXW1+7m8un2xZvK8GRmj/aNpMvykLO3BqdSaN3UbRsqcdRRE6u0y2Z2vXMpk+McsVqDy
         wM8iP61ovMgwB+JwX3AX9DBwJhJ1Pfpi2NkODQwIKG0E756yloHLGHzmBj1+VbcEttsJ
         z4fKwivTpDKirZKOCEzB11mAuiAd+wFOVojW4gsJaEYRRJl6GXQI7CDcP1zVU3FboSpH
         jZI3cDcbHhPvAbDmwbxfxVINsRQHJie8Nfh0iHogG7PKK85M0hpnj6deyIUQeCIvjpg5
         +9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mf4jQKDBupERk9IP8j/c7DldYt9kVutHpnKEjeY1Ldg=;
        b=lD7oPQxokhflxtOMhjkMI/Vn1eBgWR3JfXdxZCQKldU72k8aUmLqIdlYWo69biaQb8
         awQakyQbY89DKADE57weTXf1P+LHuGs/7oVi+5/kipXccbTpSBvnEhsPzCnXy8xk2Zdj
         KBJTe3/sWkAsnuJx9pZX5NdqlkYdhkV4DORoAuaOFUOSdjb/RyYafK8lIeceEkhzJmu4
         GTy16qWTGZuKyNjfRWcRiLjvWPDepmqyJVmhoOiKCu8z5ZuZ36dNP+FV7CDuIQQsDDGr
         jYI4m9Kuz1rP2V0GR+qIhVGL3LOMZerbdU8ylEd41MitGvLupIhQQ+vwB4nRv8hr9hML
         vjjQ==
X-Gm-Message-State: AGRZ1gKhC1r99mOziY+iz57QCsyf86TJjoe+Ge4og6nG9k+Mi5Whb/Ke
        CBQe4I/zWZk4Tgs5kj+d5ec=
X-Google-Smtp-Source: AJdET5erW+aY8VP9uRwInYHOrvptDypjA6boOWPxTG4eRUnWTKpQG0OPxeYjO5VPecyQrdHnQ0YbWA==
X-Received: by 2002:a62:da54:: with SMTP id w20-v6mr3793532pfl.106.1541668567203;
        Thu, 08 Nov 2018 01:16:07 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id w66-v6sm3284114pfb.51.2018.11.08.01.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 01:16:06 -0800 (PST)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [PATCH V5 9/10] KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
Date:   Thu,  8 Nov 2018 17:14:46 +0800
Message-Id: <20181108091447.8275-10-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108091447.8275-1-Tianyu.Lan@microsoft.com>
References: <20181108091447.8275-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb directly in the kvm_set_pte_rmapp()
and return 0.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index b13b419166c4..39e0e2572710 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1776,6 +1776,11 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		}
 	}
 
+	if (need_flush && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		return 0;
+	}
+
 	return need_flush;
 }
 
-- 
2.14.4

