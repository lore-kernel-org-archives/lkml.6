Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C204ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EB521523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EB521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbeIUHbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:31:39 -0400
Received: from mail1.windriver.com ([147.11.146.13]:39553 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeIUHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:31:39 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8L1iqoB026769
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 20 Sep 2018 18:44:52 -0700 (PDT)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Sep 2018 18:44:51 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Feuerer <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 1/6] platform/x86: acerhdf: clarify modinfo messages for BIOS override
Date:   Thu, 20 Sep 2018 21:44:16 -0400
Message-ID: <20180921014421.30804-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180921014421.30804-1-paul.gortmaker@windriver.com>
References: <20180921014421.30804-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, a module parameter for a BIOS check override implies "pretend
you support this version" (and the user will enter their local version).

However, this driver uses the model/BIOS module parameters in a way that
is "pretend my system is the supported model XYZ with BIOS version ABC."
which is less common.

Since the help strings don't make such a distinction, one gets this
somewhat frustrating scenario, where the user sees the error, enters
*their* BIOS version and then gets the same error:

  root@gw:~# modprobe acerhdf
  acerhdf: Acer Aspire One Fan driver, v.0.7.0
  acerhdf: unknown (unsupported) BIOS version Gateway  /LT31   /v1.3307 , please report, aborting!
  modprobe: ERROR: could not insert 'acerhdf': Invalid argument

  root@gw:~# modprobe acerhdf force_bios=v1.3307
  acerhdf: Acer Aspire One Fan driver, v.0.7.0
  acerhdf: forcing BIOS version: v1.3307
  acerhdf: unknown (unsupported) BIOS version Gateway  /LT31   /v1.3307 , please report, aborting!
  modprobe: ERROR: could not insert 'acerhdf': Invalid argument

Clarify the module param help text to make it clear that the driver
expects a choice from existing supported models/versions.

Cc: Peter Feuerer <peter@piie.net>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/platform/x86/acerhdf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index ea22591ee66f..3d5c4e183111 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -105,9 +105,9 @@ MODULE_PARM_DESC(fanoff, "Turn the fan off below this temperature");
 module_param(verbose, uint, 0600);
 MODULE_PARM_DESC(verbose, "Enable verbose dmesg output");
 module_param_string(force_bios, force_bios, 16, 0);
-MODULE_PARM_DESC(force_bios, "Force BIOS version and omit BIOS check");
+MODULE_PARM_DESC(force_bios, "Pretend system has this known supported BIOS version");
 module_param_string(force_product, force_product, 16, 0);
-MODULE_PARM_DESC(force_product, "Force BIOS product and omit BIOS check");
+MODULE_PARM_DESC(force_product, "Pretend system is this known supported model");
 
 /*
  * cmd_off: to switch the fan completely off and check if the fan is off
-- 
2.15.0

