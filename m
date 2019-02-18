Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027202177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499403;
	bh=4yOOMGYXLngRg8dBAeZuYQomeVIibsYrAzuEU8o/+gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UiBHOmEBw9OJag5NuEwGzaiKRfrRSveaNkHJYhZdeEbp5jeV/Y/D+TLPcTEHSYQtm
	 4q99nazfHEBiCf3Y6nH3LXKWGCkmaXnfE3LAWezRPmQ3MNoiokDioE4djIiqX/N/wq
	 07gFn1/G2MoVAgK7WuSJ0yG5THPrg6Bk/JKPJoM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391569AbfBROKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:10:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390554AbfBROKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:10:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA9C217D9;
        Mon, 18 Feb 2019 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499046;
        bh=4yOOMGYXLngRg8dBAeZuYQomeVIibsYrAzuEU8o/+gM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBc1iT098OLSTg5W6IlavMeaRDcJk9szdvBwcl+n2scOZ+SSlo+80lYIoVGTC3l5n
         mSJqndI0gvwMs6EsiC9DkCL1DtKfLO7bY46Lgd0FMa10oLbBHXYYaQBHrYaSPpykD/
         ZwcEl5KAdsj517Z9h+KjQZ4P8aVKy8acLCrFo4Wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rundong Ge <rdong.ge@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 060/108] net: dsa: slave: Dont propagate flag changes on down slave interfaces
Date:   Mon, 18 Feb 2019 14:43:56 +0100
Message-Id: <20190218133522.298402347@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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
@@ -140,10 +140,14 @@ static void dsa_slave_change_rx_flags(st
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


