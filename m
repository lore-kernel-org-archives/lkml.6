Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4028C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2AC20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="irzvmnCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2AC20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeJQBFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E9620866;
        Tue, 16 Oct 2018 17:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710034;
        bh=rE1iPSM7JRQONVBZi5I1HTPB+863oL079uf/lhsatmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irzvmnCZHf0//oJaEhNbL1/1RozXhtHNZwWkyk1V1q+gfoai6Rwge9oijIJl1LUuD
         bqQ+t7sS28OfuAevQKV3qQ3mgsG5c9T+tft1LNH84Hzk6fYoysmWA44HAZknS5Nnje
         N7m0G8BlUQrUzvVF9p6ZYsc6Z7ZBnGR+d/adYa1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH 4.18 044/135] net-ethtool: ETHTOOL_GUFO did not and should not require CAP_NET_ADMIN
Date:   Tue, 16 Oct 2018 19:04:34 +0200
Message-Id: <20181016170517.824538847@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej Żenczykowski" <maze@google.com>

[ Upstream commit 474ff2600889e16280dbc6ada8bfecb216169a70 ]

So it should not fail with EPERM even though it is no longer implemented...

This is a fix for:
  (userns)$ egrep ^Cap /proc/self/status
  CapInh: 0000003fffffffff
  CapPrm: 0000003fffffffff
  CapEff: 0000003fffffffff
  CapBnd: 0000003fffffffff
  CapAmb: 0000003fffffffff

  (userns)$ tcpdump -i usb_rndis0
  tcpdump: WARNING: usb_rndis0: SIOCETHTOOL(ETHTOOL_GUFO) ioctl failed: Operation not permitted
  Warning: Kernel filter failed: Bad file descriptor
  tcpdump: can't remove kernel filter: Bad file descriptor

With this change it returns EOPNOTSUPP instead of EPERM.

See also https://github.com/the-tcpdump-group/libpcap/issues/689

Fixes: 08a00fea6de2 "net: Remove references to NETIF_F_UFO from ethtool."
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/ethtool.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -2623,6 +2623,7 @@ int dev_ethtool(struct net *net, struct
 	case ETHTOOL_GPHYSTATS:
 	case ETHTOOL_GTSO:
 	case ETHTOOL_GPERMADDR:
+	case ETHTOOL_GUFO:
 	case ETHTOOL_GGSO:
 	case ETHTOOL_GGRO:
 	case ETHTOOL_GFLAGS:


