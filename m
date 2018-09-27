Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED9EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68B521582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68B521582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeI0P2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:28:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeI0P2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:28:33 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C8BC1111D;
        Thu, 27 Sep 2018 09:11:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rafael Tinoco <rafael.tinoco@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 53/88] Revert "rpmsg: core: add support to power domains for devices"
Date:   Thu, 27 Sep 2018 11:03:34 +0200
Message-Id: <20180927090307.257805682@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit e5d9ae0077a5cf336d298002959dc0c8dcfe7b89 which is
commit fe782affd0f440a4e60e2cc81b8f2eccb2923113 upstream

Rafael reports that this patch causes problems:
	> -rc2 looks good. There is a problem on dragonboard during boot that was
	> introduced in v4.14.71 that I didn't notice last week. We'll bisect it
	> and report back later this week. dragonboard on the other branches (4.9,
	> 4.18, mainline) looks fine.

	As Dan pointed out, during validation, we have bisected this issue on
	a dragonboard 410c (can't find root device) to the following commit
	for v4.14:

	[1ed3a9307230] rpmsg: core: add support to power domains for devices

	There is an on-going discussion on "[PATCH] rpmsg: core: add support
	to power domains for devices" about this patch having other
	dependencies and breaking something else on v4.14 as well.

so drop it.

Reported-by: Rafael Tinoco <rafael.tinoco@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rpmsg/rpmsg_core.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/rpmsg.h>
 #include <linux/of_device.h>
-#include <linux/pm_domain.h>
 #include <linux/slab.h>
 
 #include "rpmsg_internal.h"
@@ -450,10 +449,6 @@ static int rpmsg_dev_probe(struct device
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, true);
-	if (err)
-		goto out;
-
 	if (rpdrv->callback) {
 		strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
 		chinfo.src = rpdev->src;
@@ -495,8 +490,6 @@ static int rpmsg_dev_remove(struct devic
 
 	rpdrv->remove(rpdev);
 
-	dev_pm_domain_detach(dev, true);
-
 	if (rpdev->ept)
 		rpmsg_destroy_ept(rpdev->ept);
 


