Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A109DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5365F20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="cYa18H3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5365F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeGaRL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:11:59 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:35883 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbeGaRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1533051067; x=1564587067;
  h=from:to:subject:date:message-id;
  bh=qFQnasX9Jg0BaeXrjfwWFyeG5Rcmffh9Jg8D2l/Zc1A=;
  b=cYa18H3wA/ijzbY2TujMQmC50WQe3wNI21T51OsD3CtmB/+mkBLQYRqN
   2VEF5cqbnFPXXmM1erDcPIGigcPwsqgF+0y1lR8uvEiWuz5DtJs0qGRIS
   Wx/IYrmZa+jgyJBJoa7y5lGKffyJUi/T+qGBMYJ6SXyaOygWdWq0kf03v
   A=;
X-IronPort-AV: E=Sophos;i="5.51,427,1526342400"; 
   d="scan'208";a="731450687"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jul 2018 15:31:04 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w6VFTfFS105140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 31 Jul 2018 15:29:43 GMT
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w6VFTe5Q014583;
        Tue, 31 Jul 2018 17:29:40 +0200
Received: (from sironi@localhost)
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id w6VFTerA014580;
        Tue, 31 Jul 2018 17:29:40 +0200
From:   Filippo Sironi <sironi@amazon.de>
To:     sironi@amazon.de, bp@alien8.de, prarit@redhat.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] x86/microcode: Don't duplicate code to update ucode cpu info and cpu info
Date:   Tue, 31 Jul 2018 17:29:30 +0200
Message-Id: <1533050970-14385-1-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... on late microcode loading when handling a CPU that's already been
updated and a CPU that's yet to be updated.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 arch/x86/kernel/cpu/microcode/amd.c   | 15 +++++++++------
 arch/x86/kernel/cpu/microcode/intel.c | 10 ++++++----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 0624957aa068..77758e10f16f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -505,6 +505,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
 	u32 rev, dummy;
+	enum ucode_state ret;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
 
@@ -521,9 +522,8 @@ static enum ucode_state apply_microcode_amd(int cpu)
 
 	/* need to apply patch? */
 	if (rev >= mc_amd->hdr.patch_id) {
-		c->microcode = rev;
-		uci->cpu_sig.rev = rev;
-		return UCODE_OK;
+		ret = UCODE_OK;
+		goto out;
 	}
 
 	if (__apply_microcode_amd(mc_amd)) {
@@ -534,10 +534,13 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	pr_info("CPU%d: new patch_level=0x%08x\n", cpu,
 		mc_amd->hdr.patch_id);
 
-	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
-	c->microcode = mc_amd->hdr.patch_id;
+	ret = UCODE_UPDATED;
+	rev = mc_amd->hdr.patch_id;
+out:
+	uci->cpu_sig.rev = rev;
+	c->microcode = rev;
 
-	return UCODE_UPDATED;
+	return ret;
 }
 
 static int install_equiv_cpu_table(const u8 *buf)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 97ccf4c3b45b..4bc869e829eb 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -797,6 +797,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	struct microcode_intel *mc;
 	static int prev_rev;
 	u32 rev;
+	enum ucode_state ret;
 
 	/* We should bind the task to the CPU */
 	if (WARN_ON(raw_smp_processor_id() != cpu))
@@ -817,9 +818,8 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	 */
 	rev = intel_get_microcode_revision();
 	if (rev >= mc->hdr.rev) {
-		uci->cpu_sig.rev = rev;
-		c->microcode = rev;
-		return UCODE_OK;
+		ret = UCODE_OK;
+		goto out;
 	}
 
 	/*
@@ -848,10 +848,12 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		prev_rev = rev;
 	}
 
+	ret = UCODE_UPDATED;
+out:
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
-	return UCODE_UPDATED;
+	return ret;
 }
 
 static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
-- 
2.7.4

