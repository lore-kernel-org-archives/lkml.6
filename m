Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14E5208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14E5208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390314AbeHATiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:38:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406036AbeHATIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E4B01379;
        Wed,  1 Aug 2018 17:13:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 048/246] powerpc/eeh: Fix use-after-release of EEH driver
Date:   Wed,  1 Aug 2018 18:49:18 +0200
Message-Id: <20180801165014.025848432@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit 46d4be41b987a6b2d25a2ebdd94cafb44e21d6c5 ]

Correct two cases where eeh_pcid_get() is used to reference the driver's
module but the reference is dropped before the driver pointer is used.

In eeh_rmv_device() also refactor a little so that only two calls to
eeh_pcid_put() are needed, rather than three and the reference isn't
taken at all if it wasn't needed.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/eeh_driver.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -450,9 +450,11 @@ static void *eeh_add_virt_device(void *d
 
 	driver = eeh_pcid_get(dev);
 	if (driver) {
-		eeh_pcid_put(dev);
-		if (driver->err_handler)
+		if (driver->err_handler) {
+			eeh_pcid_put(dev);
 			return NULL;
+		}
+		eeh_pcid_put(dev);
 	}
 
 #ifdef CONFIG_PPC_POWERNV
@@ -489,17 +491,19 @@ static void *eeh_rmv_device(void *data,
 	if (eeh_dev_removed(edev))
 		return NULL;
 
-	driver = eeh_pcid_get(dev);
-	if (driver) {
-		eeh_pcid_put(dev);
-		if (removed &&
-		    eeh_pe_passed(edev->pe))
-			return NULL;
-		if (removed &&
-		    driver->err_handler &&
-		    driver->err_handler->error_detected &&
-		    driver->err_handler->slot_reset)
+	if (removed) {
+		if (eeh_pe_passed(edev->pe))
 			return NULL;
+		driver = eeh_pcid_get(dev);
+		if (driver) {
+			if (driver->err_handler &&
+			    driver->err_handler->error_detected &&
+			    driver->err_handler->slot_reset) {
+				eeh_pcid_put(dev);
+				return NULL;
+			}
+			eeh_pcid_put(dev);
+		}
 	}
 
 	/* Remove it from PCI subsystem */


