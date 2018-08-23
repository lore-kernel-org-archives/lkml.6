Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7910CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3547C2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3547C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbeHWM2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:28:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53154 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeHWM2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:28:19 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8487C83;
        Thu, 23 Aug 2018 08:59:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Alexander Aring <aring@mojatatu.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 191/324] ieee802154: 6lowpan: set IFLA_LINK
Date:   Thu, 23 Aug 2018 09:54:17 +0200
Message-Id: <20180823075005.714463382@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit b30c122c0bbb0a1dc413085e177ea09467e65fdb ]

Otherwise NetworkManager (and iproute alike) is not able to identify the
parent IEEE 802.15.4 interface of a 6LoWPAN link.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/6lowpan/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -90,12 +90,18 @@ static int lowpan_neigh_construct(struct
 	return 0;
 }
 
+static int lowpan_get_iflink(const struct net_device *dev)
+{
+	return lowpan_802154_dev(dev)->wdev->ifindex;
+}
+
 static const struct net_device_ops lowpan_netdev_ops = {
 	.ndo_init		= lowpan_dev_init,
 	.ndo_start_xmit		= lowpan_xmit,
 	.ndo_open		= lowpan_open,
 	.ndo_stop		= lowpan_stop,
 	.ndo_neigh_construct    = lowpan_neigh_construct,
+	.ndo_get_iflink         = lowpan_get_iflink,
 };
 
 static void lowpan_setup(struct net_device *ldev)


