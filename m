Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708BD214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708BD214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeHVNRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:17:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728518AbeHVNRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:17:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D44448076894;
        Wed, 22 Aug 2018 09:53:13 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-232.ams2.redhat.com [10.36.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC1762026D74;
        Wed, 22 Aug 2018 09:53:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v1] KVM: s390: store DXC/VXC in fpc on DATA/Vector-processing exceptions
Date:   Wed, 22 Aug 2018 11:53:10 +0200
Message-Id: <20180822095310.29145-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 22 Aug 2018 09:53:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 22 Aug 2018 09:53:13 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DATA exceptions and vector-processing exceptions (program interrupts)
are injected, the DXC/VXC is also to be stored in the fpc, if AFP is
enabled in CR0.

This can happen inside KVM when reinjecting an interrupt during program
interrupt intercepts. These are triggered for example when debugging the
guest (concurrent PER events result in an intercept instead of an
injection of such interrupts).

Signed-off-by: David Hildenbrand <david@redhat.com>
---

Only compile-tested.

 arch/s390/include/asm/ctl_reg.h | 1 +
 arch/s390/kvm/interrupt.c       | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index 4600453536c2..88f3f14baee9 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -11,6 +11,7 @@
 #include <linux/const.h>
 
 #define CR0_CLOCK_COMPARATOR_SIGN	_BITUL(63 - 10)
+#define CR0_AFP_REGISTER_CONTROL	_BITUL(63 - 45)
 #define CR0_EMERGENCY_SIGNAL_SUBMASK	_BITUL(63 - 49)
 #define CR0_EXTERNAL_CALL_SUBMASK	_BITUL(63 - 50)
 #define CR0_CLOCK_COMPARATOR_SUBMASK	_BITUL(63 - 52)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fcb55b02990e..5b5754d8f460 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -765,6 +765,14 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 		break;
 	case PGM_VECTOR_PROCESSING:
 	case PGM_DATA:
+		if (vcpu->arch.sie_block->gcr[0] & CR0_AFP_REGISTER_CONTROL) {
+			/* make sure the new fpc will be lazily loaded */
+			save_fpu_regs();
+			/* the DXC/VXC cannot make the fpc invalid */
+			current->thread.fpu.fpc &= ~0xff00u;
+			current->thread.fpu.fpc |= (pgm_info.data_exc_code << 8)
+						   & 0xff00u;
+		}
 		rc = put_guest_lc(vcpu, pgm_info.data_exc_code,
 				  (u32 *)__LC_DATA_EXC_CODE);
 		break;
-- 
2.17.1

