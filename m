Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF7C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8096A20855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIFyF9Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfBBEVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:21:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33347 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfBBEVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:21:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id c206so7629449oib.0;
        Fri, 01 Feb 2019 20:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+wUJUeSoCHA36NBRl+IpmDJMFkYg49RawpkDbb6XaM=;
        b=WIFyF9EkzeZDrCH+OxgBqb06++6YLZsEYxMV/Ne+ArW4OWZfJ2ZxpkqJahHHZrhNg7
         hrOGBQ3O0D81Ha660nKXYzN8kN+ED85P1jxC3iBvMgdcZbjODnjl4CaDwlzKdC807HHN
         s8XYGYewlS0SrojoIzJ4trPoL5vj/4KaPqDJJgR92NgUUtl994Zp6gwJONqRyDw9sgKX
         21WoFdCPSwYvrNA9vYZ51GoU59Q+u5ta8Wl3cCBOD5kAuXN1SEGzIIzv/JnC7xDRmxZF
         nYwxo6BiPvy2iOeq9Z71/4TKTTyS+G0xPdVYgXTtPoBAhdhb+itNeIMXyw225EwCcV03
         dzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+wUJUeSoCHA36NBRl+IpmDJMFkYg49RawpkDbb6XaM=;
        b=PY/4CplO++aMVmQkXSgCKZNBwPod29r3ZmxhZApoP2AI4wDI7qOiru4hNX99xMcfRI
         Tx6uW1LGd71OGi+0gttgsV/AdS6bI8nHImAdWd5/VQtNDG1+XAxzqe6BtOIJs51d/7+t
         GF7VmCoJIWgL/wZG8qTWfXQaYPhkHZ8L6iAZZtYVdSiBXcit7wzR1US5+zlWkDkVk7Jr
         XexYmX2syNjGSHrfse7CnjY0MQjMYAcFvMwqygkbKh1oM/D6IEtgRISJwRk3RYXBUb6Y
         vrm417mWTPU4KkdSODhkku6o6kkOBsG0Pn+8XSRvpNmLukXrSDu6MipS10Sr2mZRYDhM
         Q10A==
X-Gm-Message-State: AHQUAubPuZkC8t2ZmGo1ym3d479B+tzykMk5kYy5T92TogUXvYs8RQEK
        qtVX96lL7cRNoHGT04oActLQ80cH
X-Google-Smtp-Source: AHgI3Iarhi3mXfCPFRA3S+xpBo2flgObCLfACFmUVEEirJLP3zFV7u1EjUDPC87Dfm5OxlqgifTmAg==
X-Received: by 2002:aca:4307:: with SMTP id q7mr21512301oia.105.1549081263560;
        Fri, 01 Feb 2019 20:21:03 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id t197sm4561217oif.29.2019.02.01.20.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 20:21:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linus.luessing@c0d3.blue, andrew@lunn.ch,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        linux-kernel@vger.kernel.org (open list),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE)
Subject: [PATCH net-next] net: Fix ip_mc_{dec,inc}_group allocation context
Date:   Fri,  1 Feb 2019 20:20:52 -0800
Message-Id: <20190202042055.27202-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 4effd28c1245 ("bridge: join all-snoopers multicast address"), I
started seeing the following sleep in atomic warnings:

[   26.763893] BUG: sleeping function called from invalid context at mm/slab.h:421
[   26.771425] in_atomic(): 1, irqs_disabled(): 0, pid: 1658, name: sh
[   26.777855] INFO: lockdep is turned off.
[   26.781916] CPU: 0 PID: 1658 Comm: sh Not tainted 5.0.0-rc4 #20
[   26.787943] Hardware name: BCM97278SV (DT)
[   26.792118] Call trace:
[   26.794645]  dump_backtrace+0x0/0x170
[   26.798391]  show_stack+0x24/0x30
[   26.801787]  dump_stack+0xa4/0xe4
[   26.805182]  ___might_sleep+0x208/0x218
[   26.809102]  __might_sleep+0x78/0x88
[   26.812762]  kmem_cache_alloc_trace+0x64/0x28c
[   26.817301]  igmp_group_dropped+0x150/0x230
[   26.821573]  ip_mc_dec_group+0x1b0/0x1f8
[   26.825585]  br_ip4_multicast_leave_snoopers.isra.11+0x174/0x190
[   26.831704]  br_multicast_toggle+0x78/0xcc
[   26.835887]  store_bridge_parm+0xc4/0xfc
[   26.839894]  multicast_snooping_store+0x3c/0x4c
[   26.844517]  dev_attr_store+0x44/0x5c
[   26.848262]  sysfs_kf_write+0x50/0x68
[   26.852006]  kernfs_fop_write+0x14c/0x1b4
[   26.856102]  __vfs_write+0x60/0x190
[   26.859668]  vfs_write+0xc8/0x168
[   26.863059]  ksys_write+0x70/0xc8
[   26.866449]  __arm64_sys_write+0x24/0x30
[   26.870458]  el0_svc_common+0xa0/0x11c
[   26.874291]  el0_svc_handler+0x38/0x70
[   26.878120]  el0_svc+0x8/0xc

while toggling the bridge's multicast_snooping attribute dynamically.

Pass a gfp_t down to igmpv3_add_delrec(), introduce
__igmp_group_dropped() and introduce __ip_mc_dec_group() to take a gfp_t
argument.

Similarly introduce ____ip_mc_inc_group() and __ip_mc_inc_group() to
allow caller to specify gfp_t.

IPv6 part of the patch appears fine.

Fixes: 4effd28c1245 ("bridge: join all-snoopers multicast address")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Reproducer:

brctl addbr br0
brctl addif br0 eth0
ip link set dev br0 up
ip link set dev eth0 up
ip ro add 226.94.1.1/32 dev br0
echo 0 > /sys/class/net/br0/bridge/multicast_snooping
echo 1 > /sys/class/net/br0/bridge/multicast_snooping

 include/linux/igmp.h      |  8 +++++++-
 net/bridge/br_multicast.c |  4 ++--
 net/ipv4/igmp.c           | 35 ++++++++++++++++++++++++-----------
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 8b4348f69bc5..cc85f4524dbf 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -137,7 +137,13 @@ extern void ip_mc_up(struct in_device *);
 extern void ip_mc_down(struct in_device *);
 extern void ip_mc_unmap(struct in_device *);
 extern void ip_mc_remap(struct in_device *);
-extern void ip_mc_dec_group(struct in_device *in_dev, __be32 addr);
+extern void __ip_mc_dec_group(struct in_device *in_dev, __be32 addr, gfp_t gfp);
+static inline void ip_mc_dec_group(struct in_device *in_dev, __be32 addr)
+{
+	return __ip_mc_dec_group(in_dev, addr, GFP_KERNEL);
+}
+extern void __ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
+			      gfp_t gfp);
 extern void ip_mc_inc_group(struct in_device *in_dev, __be32 addr);
 int ip_mc_check_igmp(struct sk_buff *skb);
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 780757b7a82f..1fb885a33c66 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1841,7 +1841,7 @@ static void br_ip4_multicast_join_snoopers(struct net_bridge *br)
 	if (!in_dev)
 		return;
 
-	ip_mc_inc_group(in_dev, htonl(INADDR_ALLSNOOPERS_GROUP));
+	__ip_mc_inc_group(in_dev, htonl(INADDR_ALLSNOOPERS_GROUP), GFP_ATOMIC);
 	in_dev_put(in_dev);
 }
 
@@ -1872,7 +1872,7 @@ static void br_ip4_multicast_leave_snoopers(struct net_bridge *br)
 	if (WARN_ON(!in_dev))
 		return;
 
-	ip_mc_dec_group(in_dev, htonl(INADDR_ALLSNOOPERS_GROUP));
+	__ip_mc_dec_group(in_dev, htonl(INADDR_ALLSNOOPERS_GROUP), GFP_ATOMIC);
 	in_dev_put(in_dev);
 }
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index a40e48ded10d..b448cf32296c 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -159,7 +159,8 @@ static int unsolicited_report_interval(struct in_device *in_dev)
 	return interval_jiffies;
 }
 
-static void igmpv3_add_delrec(struct in_device *in_dev, struct ip_mc_list *im);
+static void igmpv3_add_delrec(struct in_device *in_dev, struct ip_mc_list *im,
+			      gfp_t gfp);
 static void igmpv3_del_delrec(struct in_device *in_dev, struct ip_mc_list *im);
 static void igmpv3_clear_delrec(struct in_device *in_dev);
 static int sf_setstate(struct ip_mc_list *pmc);
@@ -1145,7 +1146,8 @@ static void ip_mc_filter_del(struct in_device *in_dev, __be32 addr)
 /*
  * deleted ip_mc_list manipulation
  */
-static void igmpv3_add_delrec(struct in_device *in_dev, struct ip_mc_list *im)
+static void igmpv3_add_delrec(struct in_device *in_dev, struct ip_mc_list *im,
+			      gfp_t gfp)
 {
 	struct ip_mc_list *pmc;
 	struct net *net = dev_net(in_dev->dev);
@@ -1156,7 +1158,7 @@ static void igmpv3_add_delrec(struct in_device *in_dev, struct ip_mc_list *im)
 	 * for deleted items allows change reports to use common code with
 	 * non-deleted or query-response MCA's.
 	 */
-	pmc = kzalloc(sizeof(*pmc), GFP_KERNEL);
+	pmc = kzalloc(sizeof(*pmc), gfp);
 	if (!pmc)
 		return;
 	spin_lock_init(&pmc->lock);
@@ -1261,7 +1263,7 @@ static void igmpv3_clear_delrec(struct in_device *in_dev)
 }
 #endif
 
-static void igmp_group_dropped(struct ip_mc_list *im)
+static void __igmp_group_dropped(struct ip_mc_list *im, gfp_t gfp)
 {
 	struct in_device *in_dev = im->interface;
 #ifdef CONFIG_IP_MULTICAST
@@ -1292,13 +1294,18 @@ static void igmp_group_dropped(struct ip_mc_list *im)
 			return;
 		}
 		/* IGMPv3 */
-		igmpv3_add_delrec(in_dev, im);
+		igmpv3_add_delrec(in_dev, im, gfp);
 
 		igmp_ifc_event(in_dev);
 	}
 #endif
 }
 
+static void igmp_group_dropped(struct ip_mc_list *im)
+{
+	__igmp_group_dropped(im, GFP_KERNEL);
+}
+
 static void igmp_group_added(struct ip_mc_list *im)
 {
 	struct in_device *in_dev = im->interface;
@@ -1400,8 +1407,8 @@ static void ip_mc_hash_remove(struct in_device *in_dev,
 /*
  *	A socket has joined a multicast group on device dev.
  */
-static void __ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
-			      unsigned int mode)
+static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
+				unsigned int mode, gfp_t gfp)
 {
 	struct ip_mc_list *im;
 
@@ -1415,7 +1422,7 @@ static void __ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
 		}
 	}
 
-	im = kzalloc(sizeof(*im), GFP_KERNEL);
+	im = kzalloc(sizeof(*im), gfp);
 	if (!im)
 		goto out;
 
@@ -1448,6 +1455,12 @@ static void __ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
 	return;
 }
 
+void __ip_mc_inc_group(struct in_device *in_dev, __be32 addr, gfp_t gfp)
+{
+	____ip_mc_inc_group(in_dev, addr, MCAST_EXCLUDE, gfp);
+}
+EXPORT_SYMBOL(__ip_mc_inc_group);
+
 void ip_mc_inc_group(struct in_device *in_dev, __be32 addr)
 {
 	__ip_mc_inc_group(in_dev, addr, MCAST_EXCLUDE);
@@ -1634,7 +1647,7 @@ static void ip_mc_rejoin_groups(struct in_device *in_dev)
  *	A socket has left a multicast group on device dev
  */
 
-void ip_mc_dec_group(struct in_device *in_dev, __be32 addr)
+void __ip_mc_dec_group(struct in_device *in_dev, __be32 addr, gfp_t gfp)
 {
 	struct ip_mc_list *i;
 	struct ip_mc_list __rcu **ip;
@@ -1649,7 +1662,7 @@ void ip_mc_dec_group(struct in_device *in_dev, __be32 addr)
 				ip_mc_hash_remove(in_dev, i);
 				*ip = i->next_rcu;
 				in_dev->mc_count--;
-				igmp_group_dropped(i);
+				__igmp_group_dropped(i, gfp);
 				ip_mc_clear_src(i);
 
 				if (!in_dev->dead)
@@ -1662,7 +1675,7 @@ void ip_mc_dec_group(struct in_device *in_dev, __be32 addr)
 		}
 	}
 }
-EXPORT_SYMBOL(ip_mc_dec_group);
+EXPORT_SYMBOL(__ip_mc_dec_group);
 
 /* Device changing type */
 
-- 
2.19.1

