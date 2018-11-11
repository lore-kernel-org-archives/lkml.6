Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5056EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F61420818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F61420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeKLGQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:16:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50830 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730599AbeKLFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:27 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000lJ-GP; Sun, 11 Nov 2018 19:58:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001nB-JP; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.786298835@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 299/366] ipv4: remove BUG_ON() from fib_compute_spec_dst
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

commit 9fc12023d6f51551d6ca9ed7e02ecc19d79caf17 upstream.

Remove BUG_ON() from fib_compute_spec_dst routine and check
in_dev pointer during flowi4 data structure initialization.
fib_compute_spec_dst routine can be run concurrently with device removal
where ip_ptr net_device pointer is set to NULL. This can happen
if userspace enables pkt info on UDP rx socket and the device
is removed while traffic is flowing

Fixes: 35ebf65e851c ("ipv4: Create and use fib_compute_spec_dst() helper")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -209,19 +209,20 @@ __be32 fib_compute_spec_dst(struct sk_bu
 		return ip_hdr(skb)->daddr;
 
 	in_dev = __in_dev_get_rcu(dev);
-	BUG_ON(!in_dev);
 
 	net = dev_net(dev);
 
 	scope = RT_SCOPE_UNIVERSE;
 	if (!ipv4_is_zeronet(ip_hdr(skb)->saddr)) {
+		bool vmark = in_dev && IN_DEV_SRC_VMARK(in_dev);
+
 		fl4.flowi4_oif = 0;
 		fl4.flowi4_iif = LOOPBACK_IFINDEX;
 		fl4.daddr = ip_hdr(skb)->saddr;
 		fl4.saddr = 0;
 		fl4.flowi4_tos = RT_TOS(ip_hdr(skb)->tos);
 		fl4.flowi4_scope = scope;
-		fl4.flowi4_mark = IN_DEV_SRC_VMARK(in_dev) ? skb->mark : 0;
+		fl4.flowi4_mark = vmark ? skb->mark : 0;
 		if (!fib_lookup(net, &fl4, &res))
 			return FIB_RES_PREFSRC(net, res);
 	} else {

