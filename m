Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C26C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8203A21533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8203A21533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeI0PuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:50:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeI0PuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:50:21 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 328B81120;
        Thu, 27 Sep 2018 09:32:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Willy Tarreau <w@1wt.eu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 13/28] net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT
Date:   Thu, 27 Sep 2018 11:06:37 +0200
Message-Id: <20180927090638.245970931@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090637.687829444@linuxfoundation.org>
References: <20180927090637.687829444@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willy Tarreau <w@1wt.eu>

[ Upstream commit 9824dfae5741275473a23a7ed5756c7b6efacc9d ]

Fields ->dev and ->next of struct ipddp_route may be copied to
userspace on the SIOCFINDIPDDPRT ioctl. This is only accessible
to CAP_NET_ADMIN though. Let's manually copy the relevant fields
instead of using memcpy().

BugLink: http://blog.infosectcbr.com.au/2018/09/linux-kernel-infoleaks.html
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/appletalk/ipddp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/appletalk/ipddp.c
+++ b/drivers/net/appletalk/ipddp.c
@@ -284,8 +284,12 @@ static int ipddp_ioctl(struct net_device
                 case SIOCFINDIPDDPRT:
 			spin_lock_bh(&ipddp_route_lock);
 			rp = __ipddp_find_route(&rcp);
-			if (rp)
-				memcpy(&rcp2, rp, sizeof(rcp2));
+			if (rp) {
+				memset(&rcp2, 0, sizeof(rcp2));
+				rcp2.ip    = rp->ip;
+				rcp2.at    = rp->at;
+				rcp2.flags = rp->flags;
+			}
 			spin_unlock_bh(&ipddp_route_lock);
 
 			if (rp) {


