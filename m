Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA09C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCFA21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866369;
	bh=/cQLdfcbFfz7bxFsx5gOpWgoqOQKLzd3C/yqgA37hbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gPPU0ZOJJQkkSy+Rd5xvJGTW1HTBTnFRpE5Z9A+BF5+oduG2O1JVjzPZki4uEchtM
	 kGtMsnpBLY9WVDYXwb2nmsqza3/59H394X8RAQ2wNjYNYQ40JPkWIwkRIA2DVOfsM3
	 xoXO34/rbDa6GQySJIavKoiTmEQNKH9LYRzARCPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfAGNGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:06:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfAGNGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:06:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543B021736;
        Mon,  7 Jan 2019 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866366;
        bh=/cQLdfcbFfz7bxFsx5gOpWgoqOQKLzd3C/yqgA37hbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWuk1WRNEUAYbch3+icpR86WYBSa8dhn6+YiJ898pMsFGEL+EuqAC+3ei85eSt/0B
         0INd70/0Bhw+yboAXZqlRYlMH5IiXTh0xvlMzKLTF1Hkshbk0zWsrH/qUgMY5tY39n
         vB3ZPqnnd8hK7li/79e3P1v63yyZRHozz9WIXkpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+ae6bb869cbed29b29040@syzkaller.appspotmail.com
Subject: [PATCH 4.9 06/71] ax25: fix a use-after-free in ax25_fillin_cb()
Date:   Mon,  7 Jan 2019 13:32:35 +0100
Message-Id: <20190107105330.681072921@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit c433570458e49bccea5c551df628d058b3526289 ]

There are multiple issues here:

1. After freeing dev->ax25_ptr, we need to set it to NULL otherwise
   we may use a dangling pointer.

2. There is a race between ax25_setsockopt() and device notifier as
   reported by syzbot. Close it by holding RTNL lock.

3. We need to test if dev->ax25_ptr is NULL before using it.

Reported-and-tested-by: syzbot+ae6bb869cbed29b29040@syzkaller.appspotmail.com
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ax25/af_ax25.c  |   11 +++++++++--
 net/ax25/ax25_dev.c |    2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -654,15 +654,22 @@ static int ax25_setsockopt(struct socket
 			break;
 		}
 
-		dev = dev_get_by_name(&init_net, devname);
+		rtnl_lock();
+		dev = __dev_get_by_name(&init_net, devname);
 		if (!dev) {
+			rtnl_unlock();
 			res = -ENODEV;
 			break;
 		}
 
 		ax25->ax25_dev = ax25_dev_ax25dev(dev);
+		if (!ax25->ax25_dev) {
+			rtnl_unlock();
+			res = -ENODEV;
+			break;
+		}
 		ax25_fillin_cb(ax25, ax25->ax25_dev);
-		dev_put(dev);
+		rtnl_unlock();
 		break;
 
 	default:
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -116,6 +116,7 @@ void ax25_dev_device_down(struct net_dev
 	if ((s = ax25_dev_list) == ax25_dev) {
 		ax25_dev_list = s->next;
 		spin_unlock_bh(&ax25_dev_lock);
+		dev->ax25_ptr = NULL;
 		dev_put(dev);
 		kfree(ax25_dev);
 		return;
@@ -125,6 +126,7 @@ void ax25_dev_device_down(struct net_dev
 		if (s->next == ax25_dev) {
 			s->next = ax25_dev->next;
 			spin_unlock_bh(&ax25_dev_lock);
+			dev->ax25_ptr = NULL;
 			dev_put(dev);
 			kfree(ax25_dev);
 			return;


