Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0DA20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895728;
	bh=1bpTAvtInffAGMrfRbwkwZB1SlXyrwFD3ojN2JkfZV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nG2Smktdc/kxsF3zuITxslxF6KHYvhL5BN0fZL2Y/GxMVxD5jVQnH26e6vzz5S87l
	 nZ9J6EbHv+6fkbZGmtkrJx00k+gsphUNu33Uhl3MhsNsznx7v8V+k79sy/gDS5GICz
	 4v8NWy1XGUFD2B+otBoA0NwvhrxlwrEyQUHqq2oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfBKOf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbfBKOfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C699F204EC;
        Mon, 11 Feb 2019 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895717;
        bh=1bpTAvtInffAGMrfRbwkwZB1SlXyrwFD3ojN2JkfZV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0X6NzZnQd8Df8GMC9F0zZJul0Cr5KZxbH3TkF0W5WMn+JX0PUJSb4hHWnXmRK1zXd
         lhRxPZrJIScz56vighYIDflJZ8M1JjNPbBzA2p8biXQ3shATdQ+DUJwZLAmoNm/vxF
         R+FgklD2v6C4WYvj83CHRRQAPd7xQMjOS8ilmRW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rundong Ge <rdong.ge@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 299/352] net: dsa: slave: Dont propagate flag changes on down slave interfaces
Date:   Mon, 11 Feb 2019 15:18:46 +0100
Message-Id: <20190211141905.895692087@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rundong Ge <rdong.ge@gmail.com>

[ Upstream commit 17ab4f61b8cd6f9c38e9d0b935d86d73b5d0d2b5 ]

The unbalance of master's promiscuity or allmulti will happen after ifdown
and ifup a slave interface which is in a bridge.

When we ifdown a slave interface , both the 'dsa_slave_close' and
'dsa_slave_change_rx_flags' will clear the master's flags. The flags
of master will be decrease twice.
In the other hand, if we ifup the slave interface again, since the
slave's flags were cleared the 'dsa_slave_open' won't set the master's
flag, only 'dsa_slave_change_rx_flags' that triggered by 'br_add_if'
will set the master's flags. The flags of master is increase once.

Only propagating flag changes when a slave interface is up makes
sure this does not happen. The 'vlan_dev_change_rx_flags' had the
same problem and was fixed, and changes here follows that fix.

Fixes: 91da11f870f0 ("net: Distributed Switch Architecture protocol support")
Signed-off-by: Rundong Ge <rdong.ge@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/slave.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -140,11 +140,14 @@ static int dsa_slave_close(struct net_de
 static void dsa_slave_change_rx_flags(struct net_device *dev, int change)
 {
 	struct net_device *master = dsa_slave_to_master(dev);
-
-	if (change & IFF_ALLMULTI)
-		dev_set_allmulti(master, dev->flags & IFF_ALLMULTI ? 1 : -1);
-	if (change & IFF_PROMISC)
-		dev_set_promiscuity(master, dev->flags & IFF_PROMISC ? 1 : -1);
+	if (dev->flags & IFF_UP) {
+		if (change & IFF_ALLMULTI)
+			dev_set_allmulti(master,
+					 dev->flags & IFF_ALLMULTI ? 1 : -1);
+		if (change & IFF_PROMISC)
+			dev_set_promiscuity(master,
+					    dev->flags & IFF_PROMISC ? 1 : -1);
+	}
 }
 
 static void dsa_slave_set_rx_mode(struct net_device *dev)


