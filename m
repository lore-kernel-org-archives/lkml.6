Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332ECC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0AC208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="jMW7cZ7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0AC208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeGJJ1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:27:36 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:28039 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeGJJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1531214854; x=1562750854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wHvoDS8E2GkRTDdrYrjWXyfHo5TDODH56BUf1Q//WFs=;
  b=jMW7cZ7kUN99K3+qtZKJ/RKc/5wv5xJRDDoUC+Y6nHYntwh9s4Wzk1DR
   ZQ+UIFP0OqvAJlLdCM27taXTVcBHTR4jCPSkFcnVL4yoYWX0j4K1b6n4V
   cEMPUc7yjP09XfZrUC3Yg52+TQqJakhjLu7aCJfblGAyf7FMpslnO6ULT
   0=;
X-IronPort-AV: E=Sophos;i="5.51,333,1526342400"; 
   d="scan'208";a="351902121"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Jul 2018 09:27:33 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w6A9RTI5007752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 10 Jul 2018 09:27:31 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w6A9RSon024913;
        Tue, 10 Jul 2018 11:27:28 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w6A9RR6p024912;
        Tue, 10 Jul 2018 11:27:27 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v5 1/2] KVM: Switch 'requests' to be 64-bit (explicitly)
Date:   Tue, 10 Jul 2018 11:27:19 +0200
Message-Id: <1531214840-24686-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch 'requests' to be explicitly 64-bit and update BUILD_BUG_ON check to
use the size of "requests" instead of the hard-coded '32'.

That gives us a bit more room again for arch-specific requests as we
already ran out of space for x86 due to the hard-coded check.

The only exception here is ARM32 as it is still 32-bits.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Use FIELD_SIZEOF
---
 include/linux/kvm_host.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4ee7bc5..64518a1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -130,7 +130,7 @@ static inline bool is_error_page(struct page *page)
 #define KVM_REQUEST_ARCH_BASE     8
 
 #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
-	BUILD_BUG_ON((unsigned)(nr) >= 32 - KVM_REQUEST_ARCH_BASE); \
+	BUILD_BUG_ON((unsigned)(nr) >= (FIELD_SIZEOF(struct kvm_vcpu, requests) * 8) - KVM_REQUEST_ARCH_BASE); \
 	(unsigned)(((nr) + KVM_REQUEST_ARCH_BASE) | (flags)); \
 })
 #define KVM_ARCH_REQ(nr)           KVM_ARCH_REQ_FLAGS(nr, 0)
@@ -224,7 +224,7 @@ struct kvm_vcpu {
 	int vcpu_id;
 	int srcu_idx;
 	int mode;
-	unsigned long requests;
+	u64 requests;
 	unsigned long guest_debug;
 
 	int pre_pcpu;
@@ -1124,7 +1124,7 @@ static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
 	 * caller.  Paired with the smp_mb__after_atomic in kvm_check_request.
 	 */
 	smp_wmb();
-	set_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
+	set_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
 }
 
 static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
@@ -1134,12 +1134,12 @@ static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
 
 static inline bool kvm_test_request(int req, struct kvm_vcpu *vcpu)
 {
-	return test_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
+	return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
 }
 
 static inline void kvm_clear_request(int req, struct kvm_vcpu *vcpu)
 {
-	clear_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
+	clear_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
 }
 
 static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
-- 
2.7.4

