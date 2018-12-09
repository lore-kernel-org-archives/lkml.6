Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585DBC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B4A20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B4A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeLIWG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:06:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37140 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727816AbeLIWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:06:52 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002ir-GW; Sun, 09 Dec 2018 21:55:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003Sp-6G; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Hangbin Liu" <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.84949074@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 181/328] igmp: fix incorrect unsolicit report count
 after link down and up
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

From: Hangbin Liu <liuhangbin@gmail.com>

commit ff06525fcb8ae3c302ac1319bf6c07c026dea964 upstream.

After link down and up, i.e. when call ip_mc_up(), we doesn't init
im->unsolicit_count. So after igmp_timer_expire(), we will not start
timer again and only send one unsolicit report at last.

Fix it by initializing im->unsolicit_count in igmp_group_added(), so
we can respect igmp robustness value.

Fixes: 24803f38a5c0b ("igmp: do not remove igmp souce list info when set link down")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Keep using constant IGMP_Unsolicited_Report_Count
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1256,6 +1256,8 @@ static void igmp_group_added(struct ip_m
 
 	if (in_dev->dead)
 		return;
+
+	im->unsolicit_count = IGMP_Unsolicited_Report_Count;
 	if (IGMP_V1_SEEN(in_dev) || IGMP_V2_SEEN(in_dev)) {
 		spin_lock_bh(&im->lock);
 		igmp_start_timer(im, IGMP_Initial_Report_Delay);
@@ -1360,7 +1362,6 @@ void ip_mc_inc_group(struct in_device *i
 	spin_lock_init(&im->lock);
 #ifdef CONFIG_IP_MULTICAST
 	setup_timer(&im->timer, &igmp_timer_expire, (unsigned long)im);
-	im->unsolicit_count = IGMP_Unsolicited_Report_Count;
 #endif
 
 	im->next_rcu = in_dev->mc_list;

