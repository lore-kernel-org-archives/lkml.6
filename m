Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2385AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DDD20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DDD20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeLFQ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:58:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLFQ6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:58:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40E123078A20;
        Thu,  6 Dec 2018 16:58:44 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4F4D19C7D;
        Thu,  6 Dec 2018 16:58:41 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 5/6] x86/kvm/hyper-v: Drop KVM_CAP_HYPERV_STIMER_DIRECT
Date:   Thu,  6 Dec 2018 17:58:24 +0100
Message-Id: <20181206165825.1832-6-vkuznets@redhat.com>
In-Reply-To: <20181206165825.1832-1-vkuznets@redhat.com>
References: <20181206165825.1832-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 06 Dec 2018 16:58:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced KVM_GET_SUPPORTED_HV_CPUID covers Direct Mode stimers
feature so we can drop KVM_CAP_HYPERV_STIMER_DIRECT and reuse its number.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- This patch only makes sense befor 4.21 merge window, disregard if it
 doesn't make it in time.
---
 arch/x86/kvm/x86.c       | 1 -
 include/uapi/linux/kvm.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 142776435166..67ba42929c11 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2997,7 +2997,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_TLBFLUSH:
 	case KVM_CAP_HYPERV_SEND_IPI:
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-	case KVM_CAP_HYPERV_STIMER_DIRECT:
 	case KVM_CAP_HYPERV_CPUID:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9d0038eae002..a9121c9bada5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -975,8 +975,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
-#define KVM_CAP_HYPERV_STIMER_DIRECT 166
-#define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_HYPERV_CPUID 166
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.19.2

