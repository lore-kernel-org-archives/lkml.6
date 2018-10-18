Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD8C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693D8204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="btgMjyGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693D8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeJSB6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbeJSB6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:58:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDDB0214C2;
        Thu, 18 Oct 2018 17:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885373;
        bh=Jzdu7zUy3Phb6dMJpUsuIwC7HaPTCl5brA78+U3QoOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btgMjyGjtQ5cmSlYbov5Qnx+CZzIcH5Q9dlS43coDUtj761rX6yKF2i3mX0aXsrUR
         E3mcQVIcqA8mRK2nu5BrdyAGmECRMAw2xRM4952U+cMZm2QoRp9H9lEmDb0P7SD3E7
         f2FsebhxdvSmTXvbHyl0/pk0YY31l0xVKCVnui98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Lindner <mareklindner@neomailbox.ch>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 14/53] batman-adv: fix backbone_gw refcount on queue_work() failure
Date:   Thu, 18 Oct 2018 19:54:07 +0200
Message-Id: <20181018175419.365804476@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
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

From: Marek Lindner <mareklindner@neomailbox.ch>

[ Upstream commit 5af96b9c59c72fb2af2d19c5cc2f3cdcee391dff ]

The backbone_gw refcounter is to be decreased by the queued work and
currently is never decreased if the queue_work() call fails.
Fix by checking the queue_work() return value and decrease refcount
if necessary.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bridge_loop_avoidance.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1772,6 +1772,7 @@ batadv_bla_loopdetect_check(struct batad
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct ethhdr *ethhdr;
+	bool ret;
 
 	ethhdr = eth_hdr(skb);
 
@@ -1795,8 +1796,13 @@ batadv_bla_loopdetect_check(struct batad
 	if (unlikely(!backbone_gw))
 		return true;
 
-	queue_work(batadv_event_workqueue, &backbone_gw->report_work);
-	/* backbone_gw is unreferenced in the report work function function */
+	ret = queue_work(batadv_event_workqueue, &backbone_gw->report_work);
+
+	/* backbone_gw is unreferenced in the report work function function
+	 * if queue_work() call was successful
+	 */
+	if (!ret)
+		batadv_backbone_gw_put(backbone_gw);
 
 	return true;
 }


