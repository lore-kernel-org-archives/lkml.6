Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A645C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EB52177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219624;
	bh=pdS8msKkP7S5fvCe6Kx6fer6qbBpdqhXPLSeXCx+FsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uq+IAYpLCoFz2G0qV4bGH4fhI88LvF59Xiqmd+9Q78oRp10WdVNOxJorncp8pIVmo
	 Cq7Bb49M+GAg0/7TRFgR9zqupuv2newlH6/skwFzeGdBqBRIQs61pJyRSoNGo0TZ5k
	 S2a8UswtU12+4A/ro+773ikhSCsfgJvU+2id9/S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbfAKPNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733137AbfAKOOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 130072177B;
        Fri, 11 Jan 2019 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216086;
        bh=pdS8msKkP7S5fvCe6Kx6fer6qbBpdqhXPLSeXCx+FsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ct3HemASYc2I95hAe2emfNsxDeaGCJKXrcHXeSL5PtdWRH0U2W8Zhs15KaIryCIv8
         H7OriiQ2MWJHGTxdXjNpV63ZArHnFzAbF33GEYMBLZa4wgrQ28dqCnuzGiB0lo+Lnw
         DwEQvMKkKRgxNNeRBiPbMiDDGhSCtd7vk9J4H17g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+ae6bb869cbed29b29040@syzkaller.appspotmail.com
Subject: [PATCH 3.18 08/47] ax25: fix a use-after-free in ax25_fillin_cb()
Date:   Fri, 11 Jan 2019 15:07:53 +0100
Message-Id: <20190111130957.183353754@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -655,15 +655,22 @@ static int ax25_setsockopt(struct socket
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


