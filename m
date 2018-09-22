Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F2C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A9521569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A9521569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392259AbeIVGSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:18:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44069 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391843AbeIVGKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008BO-Af; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000ps-5k; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Alistair Strachan" <astrachan@google.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.130132461@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 03/63] Revert "vti4: Don't override MTU passed on
 link creation via IFLA_MTU"
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

This reverts commit 5a79e43ffa5014c020e0d0f4e383205f87b10111, which
was commit 03080e5ec72740c1a62e6730f2a5f3f114f11b19 upstream, as it
causes test failures.  It should not have been backported to anything
older than 4.16.  Thanks to Alistair Strachan for debugging this.

Cc: Alistair Strachan <astrachan@google.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/ip_vti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index b4fc9e710308..778ee1bf40ad 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -359,6 +359,7 @@ static int vti_tunnel_init(struct net_device *dev)
 	memcpy(dev->dev_addr, &iph->saddr, 4);
 	memcpy(dev->broadcast, &iph->daddr, 4);
 
+	dev->mtu		= ETH_DATA_LEN;
 	dev->flags		= IFF_NOARP;
 	dev->iflink		= 0;
 	dev->addr_len		= 4;

