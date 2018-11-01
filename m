Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2815C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D182082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Je2VcAAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D182082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeKAWqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:46:34 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:22182 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbeKAWqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1541079811; x=1572615811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aew17NRwZ5W6QaCWBPYUd4gtbOFnX3d1NGvN22K8BtI=;
  b=Je2VcAAgDKuvRVH9Q2pCLxT91fG/tUe/BHXHwRuv7TNvURX+admg9KYG
   c5ivCp1yD3dy7LLd9IWGni6F5B6Pv91t70DMc5dvoKC3ivDSZSkflJJZ5
   jWOmbQm8rzK2jANo2nyFGIxsuBdBbo/3O9EYzt6e73sfVrdIDoI8YsYLH
   Y=;
X-IronPort-AV: E=Sophos;i="5.54,452,1534809600"; 
   d="scan'208";a="702530358"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Nov 2018 13:43:30 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wA1DhPh6069628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 1 Nov 2018 13:43:27 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wA1DhOE8004823;
        Thu, 1 Nov 2018 14:43:24 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id wA1DhOMo004822;
        Thu, 1 Nov 2018 14:43:24 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Julian Stecklina <js@alien8.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] kvm, vmx: fix __invvpid style
Date:   Thu,  1 Nov 2018 14:42:49 +0100
Message-Id: <53059e524a207102f567277ceee57638224b5101.1541079752.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <0b290ddce11ab78951592b9435469cd16773629c.1541079752.git.jsteckli@amazon.de>
References: <0b290ddce11ab78951592b9435469cd16773629c.1541079752.git.jsteckli@amazon.de>
In-Reply-To: <0b290ddce11ab78951592b9435469cd16773629c.1541079752.git.jsteckli@amazon.de>
References: <0b290ddce11ab78951592b9435469cd16773629c.1541079752.git.jsteckli@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code violated the coding style. Fixed by using tabs instead of
spaces. There are only whitespace changes here.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Reviewed-by: Jan H. Schönherr <jschoenh@amazon.de>
Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
---
 arch/x86/kvm/vmx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8ebd41d..9c2e4b2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2100,16 +2100,16 @@ static int __find_msr_index(struct vcpu_vmx *vmx, u32 msr)
 
 static inline void __invvpid(unsigned long ext, u16 vpid, gva_t gva)
 {
-    struct {
-	u64 vpid : 16;
-	u64 rsvd : 48;
-	u64 gva;
-    } operand = { vpid, 0, gva };
-    bool error;
-
-    asm volatile (__ex("invvpid %2, %1") CC_SET(na)
-		  : CC_OUT(na) (error) : "r"(ext), "m"(operand));
-    BUG_ON(error);
+	struct {
+		u64 vpid : 16;
+		u64 rsvd : 48;
+		u64 gva;
+	} operand = { vpid, 0, gva };
+	bool error;
+
+	asm volatile (__ex("invvpid %2, %1") CC_SET(na)
+		      : CC_OUT(na) (error) : "r"(ext), "m"(operand));
+	BUG_ON(error);
 }
 
 static inline void __invept(unsigned long ext, u64 eptp, gpa_t gpa)
-- 
2.7.4

