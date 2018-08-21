Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92236C43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CDB2088F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CDB2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeHUJoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:44:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeHUJoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:44:00 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7850F8A5;
        Tue, 21 Aug 2018 06:25:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 09/42] net: aquantia: Fix IFF_ALLMULTI flag functionality
Date:   Tue, 21 Aug 2018 08:20:41 +0200
Message-Id: <20180821055018.060361180@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
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

From: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>

[ Upstream commit 11ba961c916127651e12af6cad3891f8aeb25aa9 ]

It was noticed that NIC always pass all multicast traffic to the host
regardless of IFF_ALLMULTI flag on the interface.
The rule in MC Filter Table in NIC, that is configured to accept any
multicast packets, is turning on if IFF_MULTICAST flag is set on the
interface. It leads to passing all multicast traffic to the host.
This fix changes the condition to turn on that rule by checking
IFF_ALLMULTI flag as it should.

Fixes: b21f502f84be ("net:ethernet:aquantia: Fix for multicast filter handling.")
Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -762,7 +762,7 @@ static int hw_atl_b0_hw_packet_filter_se
 
 	hw_atl_rpfl2promiscuous_mode_en_set(self, IS_FILTER_ENABLED(IFF_PROMISC));
 	hw_atl_rpfl2multicast_flr_en_set(self,
-					 IS_FILTER_ENABLED(IFF_MULTICAST), 0);
+					 IS_FILTER_ENABLED(IFF_ALLMULTI), 0);
 
 	hw_atl_rpfl2_accept_all_mc_packets_set(self,
 					       IS_FILTER_ENABLED(IFF_ALLMULTI));


