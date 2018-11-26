Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C8C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B2820873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B2820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeK0Cm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:42:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbeK0CmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:42:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 049803082E51;
        Mon, 26 Nov 2018 15:47:56 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEE495DD84;
        Mon, 26 Nov 2018 15:47:53 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v2 4/4] x86/kvm/hyper-v: avoid open-coding stimer_mark_pending() in kvm_hv_notify_acked_sint()
Date:   Mon, 26 Nov 2018 16:47:32 +0100
Message-Id: <20181126154732.23025-5-vkuznets@redhat.com>
In-Reply-To: <20181126154732.23025-1-vkuznets@redhat.com>
References: <20181126154732.23025-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 26 Nov 2018 15:47:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stimers_pending optimization only helps us to avoid multiple
kvm_make_request() calls. This doesn't happen very often and these
calls are very cheap in the first place, remove open-coded version of
stimer_mark_pending() from kvm_hv_notify_acked_sint().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9533133be566..e6a2a085644a 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -206,7 +206,7 @@ static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
 	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
 	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
 	struct kvm_vcpu_hv_stimer *stimer;
-	int gsi, idx, stimers_pending;
+	int gsi, idx;
 
 	trace_kvm_hv_notify_acked_sint(vcpu->vcpu_id, sint);
 
@@ -214,19 +214,13 @@ static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
 		synic_clear_sint_msg_pending(synic, sint);
 
 	/* Try to deliver pending Hyper-V SynIC timers messages */
-	stimers_pending = 0;
 	for (idx = 0; idx < ARRAY_SIZE(hv_vcpu->stimer); idx++) {
 		stimer = &hv_vcpu->stimer[idx];
 		if (stimer->msg_pending && stimer->config.enable &&
 		    !stimer->config.direct_mode &&
-		    stimer->config.sintx == sint) {
-			set_bit(stimer->index,
-				hv_vcpu->stimer_pending_bitmap);
-			stimers_pending++;
-		}
+		    stimer->config.sintx == sint)
+			stimer_mark_pending(stimer, false);
 	}
-	if (stimers_pending)
-		kvm_make_request(KVM_REQ_HV_STIMER, vcpu);
 
 	idx = srcu_read_lock(&kvm->irq_srcu);
 	gsi = atomic_read(&synic->sint_to_gsi[sint]);
-- 
2.19.1

