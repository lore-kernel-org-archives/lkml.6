Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43BDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E8F20645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E8F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeIZPma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:42:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeIZPma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:42:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30AA9300308C;
        Wed, 26 Sep 2018 09:30:27 +0000 (UTC)
Received: from rules.brq.redhat.com (dhcp-10-40-5-28.brq.redhat.com [10.40.5.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A146F1834F;
        Wed, 26 Sep 2018 09:30:23 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH] net: arp, ipv6: handle special case of tap device
Date:   Wed, 26 Sep 2018 11:30:18 +0200
Message-Id: <20180926093018.6646-1-vdronov@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 26 Sep 2018 09:30:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev->type can be set to any value for tun/tap devices by TUNSETLINK ioctl.
Nevertheless, all other dev's fields related to the link level like addr_len
and broadcast remain the same as configured previously for ARPHRD_ETHER type,
making dev inconsistent. This can lead to read from uninitialized memory.
Fix this by checking for the case of tun/tap device and act according to the
real link level type of dev while mapping a multicast IP onto multicast MAC

Reported-by: syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 net/ipv4/arp.c   | 9 ++++++++-
 net/ipv6/ndisc.c | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index e90c89ef8c08..9ce472cf98a3 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -187,7 +187,14 @@ EXPORT_SYMBOL(arp_tbl);
 
 int arp_mc_map(__be32 addr, u8 *haddr, struct net_device *dev, int dir)
 {
-	switch (dev->type) {
+	unsigned short type = dev->type;
+
+#if IS_ENABLED(CONFIG_TAP)
+	if (dev->rtnl_link_ops && !strcmp(dev->rtnl_link_ops->kind, "tun"))
+		type = ARPHRD_ETHER;
+#endif /* CONFIG_TAP */
+
+	switch (type) {
 	case ARPHRD_ETHER:
 	case ARPHRD_FDDI:
 	case ARPHRD_IEEE802:
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 0ec273997d1d..9371ff4454f7 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -283,7 +283,14 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 
 int ndisc_mc_map(const struct in6_addr *addr, char *buf, struct net_device *dev, int dir)
 {
-	switch (dev->type) {
+	unsigned short type = dev->type;
+
+#if IS_ENABLED(CONFIG_TAP)
+	if (dev->rtnl_link_ops && !strcmp(dev->rtnl_link_ops->kind, "tun"))
+		type = ARPHRD_ETHER;
+#endif /* CONFIG_TAP */
+
+	switch (type) {
 	case ARPHRD_ETHER:
 	case ARPHRD_IEEE802:	/* Not sure. Check it later. --ANK */
 	case ARPHRD_FDDI:
-- 
2.19.0
