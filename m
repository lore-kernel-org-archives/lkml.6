Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE615C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAE82152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAE82152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeI0Pkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:40:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeI0Pkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:40:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F7291120;
        Thu, 27 Sep 2018 09:23:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rafael Tinoco <rafael.tinoco@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 35/64] Revert "rpmsg: core: add support to power domains for devices"
Date:   Thu, 27 Sep 2018 11:03:52 +0200
Message-Id: <20180927090255.076036785@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 1ed3a93072307265d6385031b72929a904b50f87 which is
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
@@ -23,7 +23,6 @@
 #include <linux/module.h>
 #include <linux/rpmsg.h>
 #include <linux/of_device.h>
-#include <linux/pm_domain.h>
 #include <linux/slab.h>
 
 #include "rpmsg_internal.h"
@@ -419,10 +418,6 @@ static int rpmsg_dev_probe(struct device
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, true);
-	if (err)
-		goto out;
-
 	if (rpdrv->callback) {
 		strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
 		chinfo.src = rpdev->src;
@@ -464,8 +459,6 @@ static int rpmsg_dev_remove(struct devic
 
 	rpdrv->remove(rpdev);
 
-	dev_pm_domain_detach(dev, true);
-
 	if (rpdev->ept)
 		rpmsg_destroy_ept(rpdev->ept);
 


