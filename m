Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68537C67790
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D0620895
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D0620895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbeGXVtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:49:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:61800 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388721AbeGXVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:49:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 13:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="74172849"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2018 13:40:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH 7/7] video: fbdev: i810: replace direct wbinvd invoke with kernel api
Date:   Tue, 24 Jul 2018 13:40:18 -0700
Message-Id: <bbd941308f4b17dbc263e1b77fbc0d256e446823.1532463771.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i810 driver contains a direct wbinvd invocations in the form:
asm volatile ("wbinvd":::"memory")

Replace this call with the kernel API "native_wbinvd()" that
translates to same as "asm volatile("wbinvd" : : : "memory")" and
provides a central location where calls to this destructive instruction
can be tracked and potentially acted on.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/video/fbdev/i810/i810_main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/i810/i810_main.h b/drivers/video/fbdev/i810/i810_main.h
index 7bfaaad1d0fa..37fd765c89a3 100644
--- a/drivers/video/fbdev/i810/i810_main.h
+++ b/drivers/video/fbdev/i810/i810_main.h
@@ -54,7 +54,7 @@ static inline void i810_delete_i2c_busses(struct i810fb_par *par) { }
 #ifdef CONFIG_X86
 static inline void flush_cache(void)
 {
-	asm volatile ("wbinvd":::"memory");
+	native_wbinvd();
 }
 #else
 #define flush_cache() do { } while(0)
-- 
2.17.0

