Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D5DC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68109218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfAYLTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:19:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35645 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfAYLTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:19:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so6336248wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OymLaeZkDqCUBdn/5EkTjADbVQG+txQBjbSU5EvNNfY=;
        b=gP+H8xw6G9x6hMdgP+zhEuIjIkwweskXICCKjdUCJEZ+B33sNQjXEGr0Or1O9KPKLD
         dGdIdKv7YZLjvp2CEoEJ132adBJInwaONsBAmOr186muFm5L/99Jw9uhtdgft+3pe7nH
         h7BxakJMjGoYMyP8aIuFqwTyYao4Kx9cO8k806C7LzQst21IOvOcFF22wQvQDyb9Kfbg
         Q3M7PpsRMRWasfSrWtu8DCcRAiqTCQAaLcep1vdPYTD0oQM2kePWbk7SPLAzNYkiVfSy
         ClFVWbvSGE8AOysBtv8MgVUrcu1KrVeqZmUlpCzhUxjWgX7NLHP24GJFh59ujh1n9oRY
         iLLg==
X-Gm-Message-State: AJcUukeNJz0lwe8t13DA+zJcNa8kA2q337TG1xFhtpvbvwVYkYXi+icj
        0pnNYCv4ld3nE8RQt90dF54wvQ==
X-Google-Smtp-Source: ALg8bN5uE6ngqEwW+Qx72iqaWsKkJEUmcEBRBUD+aZ1x1+As4rwbP4PB2NQIF+uNhtkfUbcqbS7NeA==
X-Received: by 2002:a1c:e383:: with SMTP id a125mr944968wmh.1.1548415183845;
        Fri, 25 Jan 2019 03:19:43 -0800 (PST)
Received: from vitty.brq.redhat.com.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id f2sm98101713wru.14.2019.01.25.03.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:19:43 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/kvm/hyper-v: don't recommend doing reset via synthetic MSR
Date:   Fri, 25 Jan 2019 12:19:33 +0100
Message-Id: <20190125111934.28782-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125111934.28782-1-vkuznets@redhat.com>
References: <20190125111934.28782-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System reset through synthetic MSR is not recommended neither by genuine
Hyper-V nor my QEMU.

Fixes: 2bc39970e932 ("x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/kvm/hyperv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index ac44a681f065..4840f5b3c88f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1847,7 +1847,6 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 		case HYPERV_CPUID_ENLIGHTMENT_INFO:
 			ent->eax |= HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
 			ent->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
-			ent->eax |= HV_X64_SYSTEM_RESET_RECOMMENDED;
 			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
 			ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
 			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
-- 
2.20.1

