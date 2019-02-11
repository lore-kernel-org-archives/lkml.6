Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2157C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B285C222BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897882;
	bh=OEXapRCOKl/VlvJBKW3tv9jPptijdCZ1BXmtIT30GJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=py2DK9As6Ei7GvXVmvLvZcUpXeT6jMQV4qqLTZOljyDkMX6v7M3WepEJspymWYRSA
	 S89OwGoUNyT3a/Jj78mEgbjxrA5TK6vRa1bUUHxjnkKdvOfWIesh7dtECUTnvX+5Zb
	 sp9lCtL7WOgc/a/tzJ3SRmQ50CVIPi3tEoR2qmQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391858AbfBKPLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:11:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391845AbfBKPLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:11:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7A3222BA;
        Mon, 11 Feb 2019 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897876;
        bh=OEXapRCOKl/VlvJBKW3tv9jPptijdCZ1BXmtIT30GJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWRVBK3uM9976amovySHthgolrdIbaCSXzoLTZgAaqh6nCYaCVP1/BPfnvv5nXhtz
         e9yOddnQOG5T2Y7M523x6ZSRXtsKSkWW2/HBhwJXpVuJKvx1XLG8Ze3QyYVo9wYmkt
         ofDVcwPlI1u5+lUsnTaAWkS3F6QJ/m6B8bsTRdJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rundong Ge <rdong.ge@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 112/137] net: dsa: slave: Dont propagate flag changes on down slave interfaces
Date:   Mon, 11 Feb 2019 15:19:53 +0100
Message-Id: <20190211141822.570592750@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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
 net/dsa/slave.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -180,10 +180,14 @@ static void dsa_slave_change_rx_flags(st
 	struct dsa_slave_priv *p = netdev_priv(dev);
 	struct net_device *master = p->parent->dst->master_netdev;
 
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


