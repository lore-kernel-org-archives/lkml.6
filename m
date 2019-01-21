Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A53C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1817120823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="P4KwHcSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfAUHWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:22:14 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:41872 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfAUHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:22:14 -0500
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1548052012; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MESqb8y/Ovmq8x7mqvPcI8wCsbQROuFrMoXhprkHf8=;
        b=P4KwHcSSXig/wm+bKawJU3T1lkMW0Q9Ofn88QsEGE3mk4bdNwXHVb0sdPifoQ1wwki832v
        PuFqvQP2cMt+8veDX7ECuJPdLQustMX+xjutgXfkJUer1On/NYwb8vfJwgOcuW//VGzTyh
        fj6oj4Vh30KEKsox3i7/JVIe1G7wnoJxIKnCebMaPybQ0dE/w638YEZfil1B2IeXBpyYzM
        t9/fTuuF79UsuxaTiCkodRVzi5g8PBKs48QaDEGutzKw5kO7Yy8O692QV6xnLFC1XwBkZp
        aJL0Qq+2xvXqgGEIc1bYvfhiBkySKtxpTlKzdqBc6KvzOamv4QWx6t/mHLT4RQ==
To:     netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v2 3/4] bridge: join all-snoopers multicast address
Date:   Mon, 21 Jan 2019 07:26:27 +0100
Message-Id: <20190121062628.2710-4-linus.luessing@c0d3.blue>
In-Reply-To: <20190121062628.2710-1-linus.luessing@c0d3.blue>
References: <20190121062628.2710-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue;
        s=2018; t=1548052012; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MESqb8y/Ovmq8x7mqvPcI8wCsbQROuFrMoXhprkHf8=;
        b=L8/uXfKtN6Pws2JY79Sh3fU5t4kKpfxSsaFfgY8bmrNsslUJLwp9pcXhUNdcqfgs3BlxMj
        i0yEKFUBbnfsU38iCc1+8hIGk/sGBLWpE57+RUoLJQUsQ5y5LYKPpUG+RrTXwL+U4lUPMA
        wLvn1OJJaXJK3piz55uwq+7kLqAbN+TNkv0niatuCFf/reGkCFXtM+3hjaHzBfbQEpFskM
        D5WUmO0JcvYMyelLxZl/oAXZiCgtTrrpVmVnBVMm061qjBZHmH1NFL0HujFmOfmazOTbS+
        N+Dw4SGV7I8KjoIUX7wgUzPGOIMjNqgcUo1lGchUxTj5FTPSXQh8Rj7BV59Kkg==
ARC-Seal: i=1; s=2018; d=c0d3.blue; t=1548052012; a=rsa-sha256; cv=none;
        b=bEkzEjuotMyUD8KxLQ0MSNb4OOO81rT7cB7Gt0q8vK8h78KUVGUVItyKZtYMLU3JBDKh3L
        OV7J4Vm2gvBz3jcUVFCU15i5+ZKErLd2YFHpTJrgBRfVWovNb80X1TC9bW5yzdw0cvBx2/
        3tyqdzulvuReIHVni3rpIZzSLpS8xw+ZsB+B4BsUWX1LsK2TWKYPZrFASbt3ClRStCd9N8
        Nsu+fi3KgISLhXBhas4COo2VQGU+2dSHvqK8+2xDhk3hhVDZtOK/o91BTIZktyVqLDdcVA
        gnwApFe5HKYBgIJ7updXRH8vnOd2ZMe5RvqCB0LqOaSSRcGiOxQHw5KI+Gewgw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next to snooping IGMP/MLD queries RFC4541, section 2.1.1.a) recommends
to snoop multicast router advertisements to detect multicast routers.

Multicast router advertisements are sent to an "all-snoopers"
multicast address. To be able to receive them reliably, we need to
join this group.

Otherwise other snooping switches might refrain from forwarding these
advertisements to us.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/in.h   |  9 +++---
 net/bridge/br_multicast.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-
 net/ipv6/mcast.c          |  2 ++
 3 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index f6052e70bf40..7ab685cacb8f 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -292,10 +292,11 @@ struct sockaddr_in {
 #define	IN_LOOPBACK(a)		((((long int) (a)) & 0xff000000) == 0x7f000000)
 
 /* Defines for Multicast INADDR */
-#define INADDR_UNSPEC_GROUP   	0xe0000000U	/* 224.0.0.0   */
-#define INADDR_ALLHOSTS_GROUP 	0xe0000001U	/* 224.0.0.1   */
-#define INADDR_ALLRTRS_GROUP    0xe0000002U	/* 224.0.0.2 */
-#define INADDR_MAX_LOCAL_GROUP  0xe00000ffU	/* 224.0.0.255 */
+#define INADDR_UNSPEC_GROUP		0xe0000000U	/* 224.0.0.0   */
+#define INADDR_ALLHOSTS_GROUP		0xe0000001U	/* 224.0.0.1   */
+#define INADDR_ALLRTRS_GROUP		0xe0000002U	/* 224.0.0.2 */
+#define INADDR_ALLSNOOPERS_GROUP	0xe000006aU	/* 224.0.0.106 */
+#define INADDR_MAX_LOCAL_GROUP		0xe00000ffU	/* 224.0.0.255 */
 #endif
 
 /* <asm/byteorder.h> contains the htonl type stuff.. */
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 156c4905639e..2366f4a2780e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1780,6 +1780,68 @@ void br_multicast_init(struct net_bridge *br)
 	INIT_HLIST_HEAD(&br->mdb_list);
 }
 
+static void br_ip4_multicast_join_snoopers(struct net_bridge *br)
+{
+	struct in_device *in_dev = in_dev_get(br->dev);
+
+	if (!in_dev)
+		return;
+
+	ip_mc_inc_group(in_dev, htonl(INADDR_ALLSNOOPERS_GROUP));
+	in_dev_put(in_dev);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_join_snoopers(struct net_bridge *br)
+{
+	struct in6_addr addr;
+
+	ipv6_addr_set(&addr, htonl(0xff020000), 0, 0, htonl(0x6a));
+	ipv6_dev_mc_inc(br->dev, &addr);
+}
+#else
+static inline void br_ip6_multicast_join_snoopers(struct net_bridge *br)
+{
+}
+#endif
+
+static void br_multicast_join_snoopers(struct net_bridge *br)
+{
+	br_ip4_multicast_join_snoopers(br);
+	br_ip6_multicast_join_snoopers(br);
+}
+
+static void br_ip4_multicast_leave_snoopers(struct net_bridge *br)
+{
+	struct in_device *in_dev = in_dev_get(br->dev);
+
+	if (WARN_ON(!in_dev))
+		return;
+
+	ip_mc_dec_group(in_dev, htonl(INADDR_ALLSNOOPERS_GROUP));
+	in_dev_put(in_dev);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_leave_snoopers(struct net_bridge *br)
+{
+	struct in6_addr addr;
+
+	ipv6_addr_set(&addr, htonl(0xff020000), 0, 0, htonl(0x6a));
+	ipv6_dev_mc_dec(br->dev, &addr);
+}
+#else
+static inline void br_ip6_multicast_leave_snoopers(struct net_bridge *br)
+{
+}
+#endif
+
+static void br_multicast_leave_snoopers(struct net_bridge *br)
+{
+	br_ip4_multicast_leave_snoopers(br);
+	br_ip6_multicast_leave_snoopers(br);
+}
+
 static void __br_multicast_open(struct net_bridge *br,
 				struct bridge_mcast_own_query *query)
 {
@@ -1793,6 +1855,9 @@ static void __br_multicast_open(struct net_bridge *br,
 
 void br_multicast_open(struct net_bridge *br)
 {
+	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
+		br_multicast_join_snoopers(br);
+
 	__br_multicast_open(br, &br->ip4_own_query);
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open(br, &br->ip6_own_query);
@@ -1808,6 +1873,9 @@ void br_multicast_stop(struct net_bridge *br)
 	del_timer_sync(&br->ip6_other_query.timer);
 	del_timer_sync(&br->ip6_own_query.timer);
 #endif
+
+	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
+		br_multicast_leave_snoopers(br);
 }
 
 void br_multicast_dev_del(struct net_bridge *br)
@@ -1943,8 +2011,10 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 
 	br_mc_disabled_update(br->dev, val);
 	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
-	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
+	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
+		br_multicast_leave_snoopers(br);
 		goto unlock;
+	}
 
 	if (!netif_running(br->dev))
 		goto unlock;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 21f6deb2aec9..42f3f5cd349f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -940,6 +940,7 @@ int ipv6_dev_mc_inc(struct net_device *dev, const struct in6_addr *addr)
 {
 	return __ipv6_dev_mc_inc(dev, addr, MCAST_EXCLUDE);
 }
+EXPORT_SYMBOL(ipv6_dev_mc_inc);
 
 /*
  *	device multicast group del
@@ -987,6 +988,7 @@ int ipv6_dev_mc_dec(struct net_device *dev, const struct in6_addr *addr)
 
 	return err;
 }
+EXPORT_SYMBOL(ipv6_dev_mc_dec);
 
 /*
  *	check if the interface/address pair is valid
-- 
2.11.0

