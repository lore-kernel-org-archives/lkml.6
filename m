Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D8EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C0A20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C0A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeLIWNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:13:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37944 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbeLIWNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:13:41 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW734-0002ib-GP; Sun, 09 Dec 2018 21:55:38 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003WI-PU; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sven Eckelmann" <sven@narfation.org>,
        "Antonio Quartulli" <a@unstable.cc>,
        "Marek Lindner" <mareklindner@neomailbox.ch>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.925561656@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 214/328] batman-adv: Use kref_get for batadv_nc_get_nc_node
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 0de32ceee156787429035c974316f4e5098cf722 upstream.

batadv_nc_get_nc_node requires that the caller already has a valid
reference for orig_neigh_node. It is therefore not possible that it has an
reference counter of 0 and was still given to this function

The kref_get function instead WARNs (with debug information) when the
reference counter would still be 0. This makes a bug in batman-adv better
visible because kref_get_unless_zero would have ignored this problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
[bwh: Backported to 3.16: Reference counts are not krefs here, so open-
 code the equivalent of kref_get()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/network-coding.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -813,8 +813,7 @@ static struct batadv_nc_node
 	if (!nc_node)
 		return NULL;
 
-	if (!atomic_inc_not_zero(&orig_neigh_node->refcount))
-		goto free;
+	WARN_ON_ONCE(atomic_inc_return(&orig_neigh_node->refcount) < 2);
 
 	/* Initialize nc_node */
 	INIT_LIST_HEAD(&nc_node->list);
@@ -840,10 +839,6 @@ static struct batadv_nc_node
 	spin_unlock_bh(lock);
 
 	return nc_node;
-
-free:
-	kfree(nc_node);
-	return NULL;
 }
 
 /**

