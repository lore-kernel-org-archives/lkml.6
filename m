Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACD7ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39422145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGM7+VNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39422145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeJSB6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbeJSB6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:58:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D37C3204FD;
        Thu, 18 Oct 2018 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885377;
        bh=YippU6/2OZcRJNEXCw0fPv0gSpZmLPYBSaSFOP7qlUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGM7+VNF2DNW4WlTg3X1CyUDrc1HNTnf93blwwx67EeO83uBXSPjt4/xG5/523nDj
         Kpug0cfE6PwkquulGubLrEJ/YZGodXXEw39tv71v2MOlxQT0XGB11muw+LCkuMlAPF
         /H/3Vznoa+cuQchTXG6Y51bMS8VsCu35R7KJLEpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Lindner <mareklindner@neomailbox.ch>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 15/53] batman-adv: fix hardif_neigh refcount on queue_work() failure
Date:   Thu, 18 Oct 2018 19:54:08 +0200
Message-Id: <20181018175419.604019557@linuxfoundation.org>
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

[ Upstream commit 4c4af6900844ab04c9434c972021d7b48610e06a ]

The hardif_neigh refcounter is to be decreased by the queued work and
currently is never decreased if the queue_work() call fails.
Fix by checking the queue_work() return value and decrease refcount
if necessary.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_v_elp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -268,6 +268,7 @@ static void batadv_v_elp_periodic_work(s
 	struct batadv_priv *bat_priv;
 	struct sk_buff *skb;
 	u32 elp_interval;
+	bool ret;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
@@ -329,8 +330,11 @@ static void batadv_v_elp_periodic_work(s
 		 * may sleep and that is not allowed in an rcu protected
 		 * context. Therefore schedule a task for that.
 		 */
-		queue_work(batadv_event_workqueue,
-			   &hardif_neigh->bat_v.metric_work);
+		ret = queue_work(batadv_event_workqueue,
+				 &hardif_neigh->bat_v.metric_work);
+
+		if (!ret)
+			batadv_hardif_neigh_put(hardif_neigh);
 	}
 	rcu_read_unlock();
 


