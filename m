Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26864ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA712148D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpcTCmT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA712148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeJSCGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbeJSCGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:06:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C0D21479;
        Thu, 18 Oct 2018 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885873;
        bh=MSCqvXLcaXdyXkMbNyh7tCEpIjxDsTJftOlIN7/dKtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpcTCmT8dpDTEYRhHK9gU+xwoE41nXrYxth53kF7WGkalJ6A5rkqMHZlg1HPnv1by
         v2AT7062A6jXvr5kEzN2XKxl+q804CyYhPXELkGwsfCAbX3RO7/1bsSh4kOTf+C4EU
         D42PJfJ4XufKWLsYw7oZwKCz8kBgnd7K0wNftW00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Lindner <mareklindner@neomailbox.ch>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 09/35] batman-adv: fix hardif_neigh refcount on queue_work() failure
Date:   Thu, 18 Oct 2018 19:54:38 +0200
Message-Id: <20181018175423.858656815@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -243,6 +243,7 @@ static void batadv_v_elp_periodic_work(s
 	struct batadv_priv *bat_priv;
 	struct sk_buff *skb;
 	u32 elp_interval;
+	bool ret;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
@@ -304,8 +305,11 @@ static void batadv_v_elp_periodic_work(s
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
 


