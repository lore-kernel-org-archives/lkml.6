Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E48420848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E48420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeLCSEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:04:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:25319 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbeLCSEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:04:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 10:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="98294605"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2018 10:04:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC4389F; Mon,  3 Dec 2018 20:04:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] driver core: platform: Respect return code of platform_device_register_full()
Date:   Mon,  3 Dec 2018 20:04:38 +0200
Message-Id: <20181203180438.85261-1-andriy.shevchenko@linux.intel.com>
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
 drivers/base/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 41b91af95afb..e1ba610482c0 100644
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
 		device_remove_properties(&pdev->dev);
 		device_del(&pdev->dev);
 
-- 
2.19.2

