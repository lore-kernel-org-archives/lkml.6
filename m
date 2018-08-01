Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CF72083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CF72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbeHATwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:52:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405817AbeHATIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 560801100;
        Wed,  1 Aug 2018 17:04:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 213/336] staging: most: cdev: fix chrdev_region leak
Date:   Wed,  1 Aug 2018 18:49:08 +0200
Message-Id: <20180801165037.224090530@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Gromm <christian.gromm@microchip.com>

[ Upstream commit aba258b73101670c06b1dd700e500ed0a3fa0e8e ]

The function unregister_chrdev_region is called with a different counter
as the alloc_chrdev_region. To fix this, this patch introduces the
constant CHRDEV_REGION_SIZE that is used in both functions.

Signed-off-by: Christian Gromm <christian.gromm@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/most/cdev/cdev.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/staging/most/cdev/cdev.c
+++ b/drivers/staging/most/cdev/cdev.c
@@ -18,6 +18,8 @@
 #include <linux/idr.h>
 #include "most/core.h"
 
+#define CHRDEV_REGION_SIZE 50
+
 static struct cdev_component {
 	dev_t devno;
 	struct ida minor_id;
@@ -513,7 +515,7 @@ static int __init mod_init(void)
 	spin_lock_init(&ch_list_lock);
 	ida_init(&comp.minor_id);
 
-	err = alloc_chrdev_region(&comp.devno, 0, 50, "cdev");
+	err = alloc_chrdev_region(&comp.devno, 0, CHRDEV_REGION_SIZE, "cdev");
 	if (err < 0)
 		goto dest_ida;
 	comp.major = MAJOR(comp.devno);
@@ -523,7 +525,7 @@ static int __init mod_init(void)
 	return 0;
 
 free_cdev:
-	unregister_chrdev_region(comp.devno, 1);
+	unregister_chrdev_region(comp.devno, CHRDEV_REGION_SIZE);
 dest_ida:
 	ida_destroy(&comp.minor_id);
 	class_destroy(comp.class);


