Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A87C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4DD2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="IUzGmazB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4DD2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeJXQ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:56:53 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43720 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJXQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540369783; x=1571905783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ia1bA2EwUCIicadXyP2boItppd2fNM58Z5bAjO88G64=;
  b=IUzGmazBE2smmVykcUPZXSByg+CdWDh9Bo1SNCLjZ9Cd6N3CCNxvJmkW
   d9PyEC6NSr9nYajrP1FsqxXD9NGIf0JVhNSrUS6dXKFIvUT9LiGoPOpVA
   17R8psUJoeSfHM7wWlJcMy8G1D1mjHZFWvfCQf33db0PT+sjp1PiW5CC4
   M=;
X-IronPort-AV: E=Sophos;i="5.54,419,1534809600"; 
   d="scan'208";a="760955894"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Oct 2018 08:29:41 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9O8TcJ7080732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 24 Oct 2018 08:29:39 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9O8Tbe2030182;
        Wed, 24 Oct 2018 10:29:37 +0200
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w9O8Tbjs030181;
        Wed, 24 Oct 2018 10:29:37 +0200
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>, js@alien8.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kvm, vmx: fix __invvpid style
Date:   Wed, 24 Oct 2018 10:28:58 +0200
Message-Id: <16eda1c463f357607b6d7ae5cfe967055fc17ec5.1540369608.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
In-Reply-To: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
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
 arch/x86/kvm/vmx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9225099..82cfb909 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2079,17 +2079,17 @@ static int __find_msr_index(struct vcpu_vmx *vmx, u32 msr)
 
 static inline void __invvpid(int ext, u16 vpid, gva_t gva)
 {
-    struct {
-	u64 vpid : 16;
-	u64 rsvd : 48;
-	u64 gva;
-    } operand = { vpid, 0, gva };
-    bool error;
-
-    asm volatile (__ex(ASM_VMX_INVVPID) CC_SET(na)
-		  : CC_OUT(na) (error) : "a"(&operand), "c"(ext)
-		  : "memory");
-    BUG_ON(error);
+	struct {
+		u64 vpid : 16;
+		u64 rsvd : 48;
+		u64 gva;
+	} operand = { vpid, 0, gva };
+	bool error;
+
+	asm volatile (__ex(ASM_VMX_INVVPID) CC_SET(na)
+		      : CC_OUT(na) (error) : "a"(&operand), "c"(ext)
+		      : "memory");
+	BUG_ON(error);
 }
 
 static inline void __invept(int ext, u64 eptp, gpa_t gpa)
-- 
2.7.4

