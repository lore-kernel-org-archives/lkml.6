Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6569DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFD620895
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFD620895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404795AbeHGVQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:16:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404424AbeHGVQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:16:23 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E50353EE;
        Tue,  7 Aug 2018 19:00:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 75/85] net: dsa: Do not suspend/resume closed slave_dev
Date:   Tue,  7 Aug 2018 20:52:17 +0200
Message-Id: <20180807172400.142527956@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit a94c689e6c9e72e722f28339e12dff191ee5a265 ]

If a DSA slave network device was previously disabled, there is no need
to suspend or resume it.

Fixes: 2446254915a7 ("net: dsa: allow switch drivers to implement suspend/resume hooks")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/slave.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -503,6 +503,9 @@ int dsa_slave_suspend(struct net_device
 {
 	struct dsa_slave_priv *p = netdev_priv(slave_dev);
 
+	if (!netif_running(slave_dev))
+		return 0;
+
 	netif_device_detach(slave_dev);
 
 	if (p->phy) {
@@ -520,6 +523,9 @@ int dsa_slave_resume(struct net_device *
 {
 	struct dsa_slave_priv *p = netdev_priv(slave_dev);
 
+	if (!netif_running(slave_dev))
+		return 0;
+
 	netif_device_attach(slave_dev);
 
 	if (p->phy) {


