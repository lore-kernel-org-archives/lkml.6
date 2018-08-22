Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF448C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E632083A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E632083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeHVLN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:13:29 -0400
Received: from mail.valinux.co.jp ([210.128.90.3]:60990 "EHLO
        mail.valinux.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeHVLN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:13:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.valinux.co.jp (Postfix) with ESMTP id BAB36B3A36;
        Wed, 22 Aug 2018 16:49:45 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
        by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fMzRV-S21IYM; Wed, 22 Aug 2018 16:49:45 +0900 (JST)
Received: from brer (vagw.valinux.co.jp [210.128.90.14])
        by mail.valinux.co.jp (Postfix) with ESMTP id A6DF1B39D3;
        Wed, 22 Aug 2018 16:49:45 +0900 (JST)
From:   =?iso-2022-jp?B?TUlOT1VSQSBNYWtvdG8gLyAbJEJMJzE6GyhCIBskQj8/GyhC?= 
        <minoura@valinux.co.jp>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kvm/vmx: Fix GPF on reading vmentry_l1d_flush
Date:   Wed, 22 Aug 2018 16:49:45 +0900
Message-ID: <kk5mute6dt2.fsf@brer.local.valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When EPT is not enabled, reading
/sys/module/kvm_intel/parameters/vmentry_l1d_flush causes
general protection fault in vmentry_l1d_flush_get() due to
access beyond the end of the array vmentry_l1d_param[].

Signed-off-by: Minoura Makoto <minoura@valinux.co.jp>
---
 arch/x86/include/asm/vmx.h | 1 +
 arch/x86/kvm/vmx.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 95f9107449bf..c4b834b05178 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -581,6 +581,7 @@ enum vmx_l1d_flush_state {
 	VMENTER_L1D_FLUSH_NEVER,
 	VMENTER_L1D_FLUSH_COND,
 	VMENTER_L1D_FLUSH_ALWAYS,
+	VMENTER_L1D_FLUSH_PARAM_MAX = VMENTER_L1D_FLUSH_ALWAYS,
 	VMENTER_L1D_FLUSH_EPT_DISABLED,
 	VMENTER_L1D_FLUSH_NOT_REQUIRED,
 };
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 1519f030fd73..155ba2a9139f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -204,6 +204,8 @@ static const struct {
 	{"never",	VMENTER_L1D_FLUSH_NEVER},
 	{"cond",	VMENTER_L1D_FLUSH_COND},
 	{"always",	VMENTER_L1D_FLUSH_ALWAYS},
+	{"ept-disabled", VMENTER_L1D_FLUSH_EPT_DISABLED},
+	{"not-required", VMENTER_L1D_FLUSH_NOT_REQUIRED},
 };
 
 #define L1D_CACHE_ORDER 4
@@ -286,7 +288,7 @@ static int vmentry_l1d_flush_parse(const char *s)
 	unsigned int i;
 
 	if (s) {
-		for (i = 0; i < ARRAY_SIZE(vmentry_l1d_param); i++) {
+		for (i = 0; i <= VMENTER_L1D_FLUSH_PARAM_MAX; i++) {
 			if (sysfs_streq(s, vmentry_l1d_param[i].option))
 				return vmentry_l1d_param[i].cmd;
 		}
