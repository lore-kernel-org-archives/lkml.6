Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BB7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAF62054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="eQ4bUXst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAF62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJ3Aah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:30:37 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:47197 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeJ3Aag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540827687; x=1572363687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SdGxs4CHf5TRhTYKYm5KecJ6+mGYsQYqjbP+I6JaFLw=;
  b=eQ4bUXstjUcH7c0mlWutL6Of17Ft6S68I4ntSW56t6GRpfJXSWUh43Xv
   7X9R2ebdZj7ns+L72vWP9R1+zWY7VkOZ3gfh2VUuAj2promgWN5Q7YdOq
   COmBbHYH+CHW2ZlhNXJTFKM6nDcmSM8N3tTIniMRZo0C4pVCyof4yC7YV
   U=;
X-IronPort-AV: E=Sophos;i="5.54,440,1534809600"; 
   d="scan'208";a="701924541"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Oct 2018 15:41:25 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9TFfK5E016030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 29 Oct 2018 15:41:22 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9TFfKMr000676;
        Mon, 29 Oct 2018 16:41:20 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w9TFfJ0Q000675;
        Mon, 29 Oct 2018 16:41:19 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Julian Stecklina <js@alien8.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] kvm, vmx: fix __invvpid style
Date:   Mon, 29 Oct 2018 16:40:44 +0100
Message-Id: <d47f6d087f9f125ee34671f62dc30180c83e2d09.1540822350.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <74fa3809ea293cc05d37b1449b16e08480c4ddbd.1540822350.git.jsteckli@amazon.de>
References: <74fa3809ea293cc05d37b1449b16e08480c4ddbd.1540822350.git.jsteckli@amazon.de>
In-Reply-To: <74fa3809ea293cc05d37b1449b16e08480c4ddbd.1540822350.git.jsteckli@amazon.de>
References: <74fa3809ea293cc05d37b1449b16e08480c4ddbd.1540822350.git.jsteckli@amazon.de>
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
index 29a2ee7..9bd7c6c 100644
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

