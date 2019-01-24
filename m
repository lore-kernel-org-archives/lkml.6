Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B2D218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfAXRPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:15:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34470 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfAXRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:15:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so7379052wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 09:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jGO4yYK/mHcYbbZOA4voGTiVjt6/xAHjeCPNmXeieEc=;
        b=BbUJ/x/2omD22Y1SpEcFCZ2dCItaRQ/MK1mpYfzeMSc+KIwHU68pydIG3rWw8UGtla
         3euPAQTlxg2ipFa7N3Q8rNhZf8rTdffBWLE8QxEV9kfaTBnMphHjwCJT5ULyXVpd0PwB
         n2laN3GPcW3pLGt/fMJoJMHCwu5puQ8treHGIX9Fj08boyC2N57yLxyxD/SBy3QjTlmf
         qLyWt06kA1na5CACxXznvc46rPwA3FT8csrSq7nPKJZ1NCz8zUf1aZJkBbarjdxS19Q9
         FsH7XhAoocR2sLINuWADWswrDouE1QPAD865xFtMJDj8FPugIMmOryHJw3+96nONu9HI
         4mgg==
X-Gm-Message-State: AJcUukeGqr8C9+n1BD7A0wCitbUWM4DNK2npJ+mTP7mJ+GcEvdWb+VuP
        FvxJbAlP/4sjUFDbhZ8oxofJ1IO3EPn6Pw==
X-Google-Smtp-Source: ALg8bN6usWgducjOpMhEHTPH58zjC82k9lqDEMTn07J/NZCrbBvf56bO7/UI0iZ+AVbvbPmWKD0VGw==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr7867861wrg.230.1548350118986;
        Thu, 24 Jan 2019 09:15:18 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n9sm83624972wrx.80.2019.01.24.09.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 09:15:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kvm/hyper-v: tweak HYPERV_CPUID_ENLIGHTMENT_INFO
Date:   Thu, 24 Jan 2019 18:15:16 +0100
Message-Id: <20190124171516.23626-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't probably be suggesting using Enlightened VMCS when it's not
enabled (not supported from guest's point of view). System reset through
synthetic MSR is not recommended neither by genuine Hyper-V nor my QEMU.

Windows seems to be fine either way but let's be consistent.

Fixes: 2bc39970e932 ("x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index ac44a681f065..4730fcaa70cf 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1847,11 +1847,11 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 		case HYPERV_CPUID_ENLIGHTMENT_INFO:
 			ent->eax |= HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
 			ent->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
-			ent->eax |= HV_X64_SYSTEM_RESET_RECOMMENDED;
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

