Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B20C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1BF2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1BF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLCSVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:21:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:58514 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeLCSVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:21:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 10:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="115583829"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2018 10:21:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E5EB9F; Mon,  3 Dec 2018 20:21:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] driver core: platform: Respect return code of platform_device_register_full()
Date:   Mon,  3 Dec 2018 20:21:41 +0200
Message-Id: <20181203182141.29720-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_device_register_full() might return an error pointer. If we
instantiate platform device which is optional we may simplify the routine at
removal stage by simply calling platform_device_unregister(). For now it
requires to check parameter for being an error pointer in each caller.

To make users' life easier, check for an error pointer inside driver core.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- rebase on top of linux-next since the conflicting patch has been applied there

 drivers/base/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0fb5f140f1b0..2c36bf490944 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -234,7 +234,7 @@ struct platform_object {
  */
 void platform_device_put(struct platform_device *pdev)
 {
-	if (pdev)
+	if (!IS_ERR_OR_NULL(pdev))
 		put_device(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(platform_device_put);
@@ -447,7 +447,7 @@ void platform_device_del(struct platform_device *pdev)
 {
 	int i;
 
-	if (pdev) {
+	if (!IS_ERR_OR_NULL(pdev)) {
 		device_del(&pdev->dev);
 
 		if (pdev->id_auto) {
-- 
2.19.2

