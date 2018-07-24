Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2D5C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58C820894
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58C820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbeGXVtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:49:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:61800 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388868AbeGXVtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:49:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 13:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="74172848"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2018 13:40:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH 6/7] mtd: replace direct wbinvd invoke with kernel api
Date:   Tue, 24 Jul 2018 13:40:17 -0700
Message-Id: <c455c2a5c172b7e1f72fcb8741d213d6a71e56d0.1532463771.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nettel driver contains a few direct wbinvd invocations in the form:
__asm__ ("wbinvd")

Replace all of these calls with the kernel API "native_wbinvd()" that
translates to same as "asm volatile("wbinvd" : : : "memory")" and
provides a central location where calls to this destructive instruction
can be tracked and potentially acted on.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/mtd/maps/nettel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/nettel.c b/drivers/mtd/maps/nettel.c
index 729579fb654f..325357cda202 100644
--- a/drivers/mtd/maps/nettel.c
+++ b/drivers/mtd/maps/nettel.c
@@ -213,7 +213,7 @@ static int __init nettel_init(void)
 	maxsize = AMD_WINDOW_MAXSIZE;
 
 	*amdpar = SC520_PAR(SC520_PAR_BOOTCS, amdaddr, maxsize);
-	__asm__ ("wbinvd");
+	native_wbinvd();
 
 	nettel_amd_map.phys = amdaddr;
 	nettel_amd_map.virt = ioremap_nocache(amdaddr, maxsize);
@@ -326,7 +326,7 @@ static int __init nettel_init(void)
 	 */
 	intel1addr = intel0addr + intel0size;
 	*intel1par = SC520_PAR(intel1cs, intel1addr, maxsize);
-	__asm__ ("wbinvd");
+	native_wbinvd();
 
 	maxsize += intel0size;
 
@@ -352,7 +352,7 @@ static int __init nettel_init(void)
 	intel1size = intel_mtd->size - intel0size;
 	if (intel1size > 0) {
 		*intel1par = SC520_PAR(intel1cs, intel1addr, intel1size);
-		__asm__ ("wbinvd");
+		native_wbinvd();
 	} else {
 		*intel1par = 0;
 	}
-- 
2.17.0

