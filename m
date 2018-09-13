Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BEEC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8820881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD8820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbeIMS4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:56:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbeIMS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:56:53 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E508D19;
        Thu, 13 Sep 2018 13:47:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 057/115] s390/dasd: fix hanging offline processing due to canceled worker
Date:   Thu, 13 Sep 2018 15:31:17 +0200
Message-Id: <20180913131827.250776906@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
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

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 669f3765b755fd8739ab46ce3a9c6292ce8b3d2a ]

During offline processing two worker threads are canceled without
freeing the device reference which leads to a hanging offline process.

Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_eckd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2032,8 +2032,11 @@ static int dasd_eckd_basic_to_ready(stru
 
 static int dasd_eckd_online_to_ready(struct dasd_device *device)
 {
-	cancel_work_sync(&device->reload_device);
-	cancel_work_sync(&device->kick_validate);
+	if (cancel_work_sync(&device->reload_device))
+		dasd_put_device(device);
+	if (cancel_work_sync(&device->kick_validate))
+		dasd_put_device(device);
+
 	return 0;
 };
 


