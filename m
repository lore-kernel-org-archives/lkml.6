Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7ABC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8843921C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8843921C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeHIK3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:29:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729822AbeHIK3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:29:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11999402332F;
        Thu,  9 Aug 2018 08:06:09 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89D1E23149;
        Thu,  9 Aug 2018 08:06:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 2/2] KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
Date:   Thu,  9 Aug 2018 10:06:01 +0200
Message-Id: <20180809080601.31797-3-david@redhat.com>
In-Reply-To: <20180809080601.31797-1-david@redhat.com>
References: <20180809080601.31797-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 08:06:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 08:06:09 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we change the crycb (or execution controls), we also have to make sure
that the vSIE shadow datastructures properly consider the changed
values before rerunning the vSIE. We can achieve that by simply using a
VCPU request now.

This has to be a synchronous request (== handled before entering the
(v)SIE again).

The request will make sure that the vSIE handler is left, and that the
request will be processed (NOP), therefore forcing a reload of all
vSIE data (including rebuilding the crycb) when re-entering the vSIE
interception handler the next time.

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 29c940bf8506..75d39628f21d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -44,6 +44,7 @@
 #define KVM_REQ_ICPT_OPEREXC	KVM_ARCH_REQ(2)
 #define KVM_REQ_START_MIGRATION KVM_ARCH_REQ(3)
 #define KVM_REQ_STOP_MIGRATION  KVM_ARCH_REQ(4)
+#define KVM_REQ_VSIE_RESTART	KVM_ARCH_REQ(5)
 
 #define SIGP_CTRL_C		0x80
 #define SIGP_CTRL_SCN_MASK	0x3f
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c87734a31fdb..2fdc017d91f0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -842,8 +842,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
 
 	kvm_s390_vcpu_block_all(kvm);
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_s390_vcpu_crypto_setup(vcpu);
+		/* recreate the shadow crycb by leaving the VSIE handler */
+		kvm_s390_sync_request(KVM_REQ_VSIE_RESTART, vcpu);
+	}
 
 	kvm_s390_vcpu_unblock_all(kvm);
 }
@@ -3201,6 +3204,8 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 
 	/* nothing to do, just clear the request */
 	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
+	/* we left the vsie handler, nothing to do, just clear the request */
+	kvm_clear_request(KVM_REQ_VSIE_RESTART, vcpu);
 
 	return 0;
 }
-- 
2.17.1

