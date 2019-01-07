Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A96FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280F82089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfAGQkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:40:04 -0500
Received: from mail114-240.sinamail.sina.com.cn ([218.30.114.240]:46119 "HELO
        mail114-240.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1726535AbfAGQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:40:04 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 11:40:02 EST
Received: from unknown (HELO MiWiFi-R3-srv.localdomain)([110.184.35.115])
        by sina.com with ESMTP
        id 5C337E9C00003A61; Mon, 8 Jan 2019 00:30:23 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 4474825953099
From:   Peng Hao <penghao122@sina.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  x86/kvm: convert to DEFINE_DEBUGFS_ATTRIBUTE
Date:   Tue,  8 Jan 2019 00:30:17 +0800
Message-Id: <1546878617-25713-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

The preferred strategy to define debugfs attributes is to use
the DEFINE_DEBUGFS_ATTRIBUTE() macro and to use
debugfs_create_file_unsafe().

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/debugfs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index c19c7ed..cc1187f 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -22,7 +22,8 @@ static int vcpu_get_tsc_offset(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_offset_fops, vcpu_get_tsc_offset, NULL, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vcpu_tsc_offset_fops,
+			 vcpu_get_tsc_offset, NULL, "%lld\n");
 
 static int vcpu_get_tsc_scaling_ratio(void *data, u64 *val)
 {
@@ -31,7 +32,8 @@ static int vcpu_get_tsc_scaling_ratio(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_fops, vcpu_get_tsc_scaling_ratio, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vcpu_tsc_scaling_fops,
+			 vcpu_get_tsc_scaling_ratio, NULL, "%llu\n");
 
 static int vcpu_get_tsc_scaling_frac_bits(void *data, u64 *val)
 {
@@ -39,25 +41,26 @@ static int vcpu_get_tsc_scaling_frac_bits(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_frac_fops, vcpu_get_tsc_scaling_frac_bits, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vcpu_tsc_scaling_frac_fops,
+			 vcpu_get_tsc_scaling_frac_bits, NULL, "%llu\n");
 
 int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 {
 	struct dentry *ret;
 
-	ret = debugfs_create_file("tsc-offset", 0444,
+	ret = debugfs_create_file_unsafe("tsc-offset", 0444,
 							vcpu->debugfs_dentry,
 							vcpu, &vcpu_tsc_offset_fops);
 	if (!ret)
 		return -ENOMEM;
 
 	if (kvm_has_tsc_control) {
-		ret = debugfs_create_file("tsc-scaling-ratio", 0444,
+		ret = debugfs_create_file_unsafe("tsc-scaling-ratio", 0444,
 							vcpu->debugfs_dentry,
 							vcpu, &vcpu_tsc_scaling_fops);
 		if (!ret)
 			return -ENOMEM;
-		ret = debugfs_create_file("tsc-scaling-ratio-frac-bits", 0444,
+		ret = debugfs_create_file_unsafe("tsc-scaling-ratio-frac-bits", 0444,
 							vcpu->debugfs_dentry,
 							vcpu, &vcpu_tsc_scaling_frac_fops);
 		if (!ret)
-- 
1.8.3.1


