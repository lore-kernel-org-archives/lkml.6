Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EA0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D61A20684
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D61A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbeIXSch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:32:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbeIXSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:32:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E4A51099;
        Mon, 24 Sep 2018 12:30:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 066/235] staging: bcm2835-camera: fix timeout handling in wait_for_completion_timeout
Date:   Mon, 24 Sep 2018 13:50:52 +0200
Message-Id: <20180924113111.828466629@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit b7afce51d95726a619743aaad8870db66dfa1479 ]

wait_for_completion_timeout returns unsigned long not int so a variable of
proper type is introduced. Further the check for <= 0 is ambiguous and should
be == 0 here indicating timeout which is the only error case so no additional
check needed here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -630,6 +630,7 @@ static int send_synchronous_mmal_msg(str
 {
 	struct mmal_msg_context *msg_context;
 	int ret;
+	unsigned long timeout;
 
 	/* payload size must not cause message to exceed max size */
 	if (payload_len >
@@ -668,11 +669,11 @@ static int send_synchronous_mmal_msg(str
 		return ret;
 	}
 
-	ret = wait_for_completion_timeout(&msg_context->u.sync.cmplt, 3 * HZ);
-	if (ret <= 0) {
-		pr_err("error %d waiting for sync completion\n", ret);
-		if (ret == 0)
-			ret = -ETIME;
+	timeout = wait_for_completion_timeout(&msg_context->u.sync.cmplt,
+					      3 * HZ);
+	if (timeout == 0) {
+		pr_err("timed out waiting for sync completion\n");
+		ret = -ETIME;
 		/* todo: what happens if the message arrives after aborting */
 		release_msg_context(msg_context);
 		return ret;


