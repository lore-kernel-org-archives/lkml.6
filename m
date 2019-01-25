Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F96C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD804218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAYLTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:19:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41199 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbfAYLTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:19:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so9858836wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6yhpZQzcn+9JBMSIZS6widjg9wc9aPVmdpk6Zov9nE=;
        b=mxF/TQICRnxQ/oNoVzPXoBzXZ02CY5sVLevgZPJkep1zXakeA5HvSgZOQfDsRDxkeE
         hZ6zqfKkIPwSJUCruMizXwQiws0wTqzxFGO/T7Z1cok99tDeyj0Jd6P7tknj0vI9KVAQ
         GjWWOHGvPy/NZfiKBtD2nWavRiCOSq94cU8fbOo3ftRqbGisN5BEWcpIi3omxK2PxXw/
         TxkONmMZ5lhdkPkjA9wGuq05SthO+jqw87QRGPaqT29dtgvA+IdqK1i2urGDgwtyBmpt
         hYgtIC/9AKYpRuSmzTbDCNZU4XJZWMYaRVdg1kd7bfBDpZnLauFBbYCDotqCaxzvrMlq
         ij+Q==
X-Gm-Message-State: AJcUukeGA9xkMTXdFnt/tNJGSNSLM+6tyokqiF5DautGu3oOEfPaEYfC
        pTzlYnB4GCwKaqsAXlrq1sdpvc0mqzYsDw==
X-Google-Smtp-Source: ALg8bN6/iIA6z/ESY3qBrqYi6U8TPXZ9BzrqgmoL2bA2GXLIw9p7+nC9mQ5m4FZLq1/NytiyPqxA5w==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr10750246wrv.116.1548415184997;
        Fri, 25 Jan 2019 03:19:44 -0800 (PST)
Received: from vitty.brq.redhat.com.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id f2sm98101713wru.14.2019.01.25.03.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:19:44 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] x86/kvm/hyper-v: recommend using eVMCS only when it is enabled
Date:   Fri, 25 Jan 2019 12:19:34 +0100
Message-Id: <20190125111934.28782-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125111934.28782-1-vkuznets@redhat.com>
References: <20190125111934.28782-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't probably be suggesting using Enlightened VMCS when it's not
enabled (not supported from guest's point of view). Hyper-V on KVM seems
to be fine either way but let's be consistent.

Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4840f5b3c88f..4730fcaa70cf 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1850,7 +1850,8 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
 			ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
 			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
-			ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
+			if (evmcs_ver)
+				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
 
 			/*
 			 * Default number of spinlock retry attempts, matches
-- 
2.20.1

