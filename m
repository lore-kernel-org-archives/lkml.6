Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFD521774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFD521774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeHUJmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:42:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:42:10 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA5519D7;
        Tue, 21 Aug 2018 06:23:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 34/35] net: mvneta: fix mvneta_config_rss on armada 3700
Date:   Tue, 21 Aug 2018 08:21:00 +0200
Message-Id: <20180821055021.418467416@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

[ Upstream commit 0f5c6c30a0f8c629b92ecdaef61b315c43fde10a ]

The mvneta Ethernet driver is used on a few different Marvell SoCs.
Some SoCs have per cpu interrupts for Ethernet events, the driver uses
a per CPU napi structure for this case. Some SoCs such as armada 3700
have a single interrupt for Ethernet events, the driver uses a global
napi structure for this case.

Current mvneta_config_rss() always operates the per cpu napi structure.
Fix it by operating a global napi for "single interrupt" case, and per
cpu napi structure for remaining cases.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvneta.c |   35 +++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4020,13 +4020,18 @@ static int  mvneta_config_rss(struct mvn
 
 	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
 
-	/* We have to synchronise on the napi of each CPU */
-	for_each_online_cpu(cpu) {
-		struct mvneta_pcpu_port *pcpu_port =
-			per_cpu_ptr(pp->ports, cpu);
-
-		napi_synchronize(&pcpu_port->napi);
-		napi_disable(&pcpu_port->napi);
+	if (!pp->neta_armada3700) {
+		/* We have to synchronise on the napi of each CPU */
+		for_each_online_cpu(cpu) {
+			struct mvneta_pcpu_port *pcpu_port =
+				per_cpu_ptr(pp->ports, cpu);
+
+			napi_synchronize(&pcpu_port->napi);
+			napi_disable(&pcpu_port->napi);
+		}
+	} else {
+		napi_synchronize(&pp->napi);
+		napi_disable(&pp->napi);
 	}
 
 	pp->rxq_def = pp->indir[0];
@@ -4043,12 +4048,16 @@ static int  mvneta_config_rss(struct mvn
 	mvneta_percpu_elect(pp);
 	spin_unlock(&pp->lock);
 
-	/* We have to synchronise on the napi of each CPU */
-	for_each_online_cpu(cpu) {
-		struct mvneta_pcpu_port *pcpu_port =
-			per_cpu_ptr(pp->ports, cpu);
-
-		napi_enable(&pcpu_port->napi);
+	if (!pp->neta_armada3700) {
+		/* We have to synchronise on the napi of each CPU */
+		for_each_online_cpu(cpu) {
+			struct mvneta_pcpu_port *pcpu_port =
+				per_cpu_ptr(pp->ports, cpu);
+
+			napi_enable(&pcpu_port->napi);
+		}
+	} else {
+		napi_enable(&pp->napi);
 	}
 
 	netif_tx_start_all_queues(pp->dev);


