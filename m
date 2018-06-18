Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D609C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3759B208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3759B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935636AbeFRIUQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:20:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964849AbeFRIUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:20:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35CFBC83;
        Mon, 18 Jun 2018 08:20:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 112/279] vti6: Change minimum MTU to IPV4_MIN_MTU, vti6 can carry IPv4 too
Date:   Mon, 18 Jun 2018 10:11:37 +0200
Message-Id: <20180618080613.450619159@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit b4331a681822b420511b3258f1c3db35001fde48 ]

A vti6 interface can carry IPv4 as well, so it makes no sense to
enforce a minimum MTU of IPV6_MIN_MTU.

If the user sets an MTU below IPV6_MIN_MTU, IPv6 will be
disabled on the interface, courtesy of addrconf_notify().

Reported-by: Xin Long <lucien.xin@gmail.com>
Fixes: b96f9afee4eb ("ipv4/6: use core net MTU range checking")
Fixes: c6741fbed6dc ("vti6: Properly adjust vti6 MTU from MTU of lower device")
Fixes: 53c81e95df17 ("ip6_vti: adjust vti mtu according to mtu of lower device")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -669,7 +669,7 @@ static void vti6_link_config(struct ip6_
 	else
 		mtu = ETH_DATA_LEN - LL_MAX_HEADER - sizeof(struct ipv6hdr);
 
-	dev->mtu = max_t(int, mtu, IPV6_MIN_MTU);
+	dev->mtu = max_t(int, mtu, IPV4_MIN_MTU);
 }
 
 /**
@@ -881,7 +881,7 @@ static void vti6_dev_setup(struct net_de
 	dev->priv_destructor = vti6_dev_free;
 
 	dev->type = ARPHRD_TUNNEL6;
-	dev->min_mtu = IPV6_MIN_MTU;
+	dev->min_mtu = IPV4_MIN_MTU;
 	dev->max_mtu = IP_MAX_MTU - sizeof(struct ipv6hdr);
 	dev->flags |= IFF_NOARP;
 	dev->addr_len = sizeof(struct in6_addr);


