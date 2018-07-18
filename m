Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC3BECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD842084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD842084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbeGRHIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:08:55 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60091 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeGRHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:08:39 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.32.110]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LheU5-1gSEE62hjl-00mu8m; Wed, 18 Jul 2018 08:32:19 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/3] net: qca_spi: Avoid packet drop during initial sync
Date:   Wed, 18 Jul 2018 08:31:43 +0200
Message-Id: <1531895505-26971-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531895505-26971-1-git-send-email-stefan.wahren@i2se.com>
References: <1531895505-26971-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:iWY8HDKD4qxhiarp2oX6kZtiFR33vqvj+JaiXkJXMvXR3FGK9Ti
 HBRejgMgdsCblwdjoN/db73nbaezUd8wb1GEPJd7IM/0wrcrgQIhgEJcl0l1KhANnE9c6t2
 3Kdb4cMZGkZuIhpwdvWxox1K8vrvL0pbUBdk+UWoVBz9Zy8zeE2MA7dF1eCOvx84535TcT2
 QjWrC5HcSevJT6c8xeSnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AKzZbpuezK8=:5u5qO0UlEItxfTedT2eNtF
 aXNnq+AlZXy8Odj3MbJddsUEUKwzCuDwZe2Xe6MyhWUpJWtLt5SBK92gsTMdmZ2BZeuU3zmdU
 e2jml/6ektO/ldSmAbYIAH+8UHUN+o4CLd7qvqvRux1UDbxdzh1MpzQ5Fh7oqM+rhEgbfEAn9
 LN41ltCdjKh/DW2Z+Dm/DLboAowDvhK1eo37+BZWEpetvV4ukjMX7x+yIO5xOj0KFdHtknlVa
 1Dkwg18Wna2iHPxRhG2G21xo4A/fJft+52VaLM05LB/fh/d7fi2fA92xsGEI18CgaztoCTG+I
 AdKHyUKGxSc1GPFgq+i0/T7Ec6FP6Y65BNp39lryVTqEoSuoFXynACNHw0dIDmgfEc3w6/DqC
 Dt8nmWlZ8CU5mTskJ1x7zkoQtfXrCmU0bdAHBNAFfNkxvnbwsoWOAbUeKxNcLCZBaBsy95yCJ
 8mwtTowR7XB28TK0qP3UKZ+NuWBoOn1qHUScXBpz8wkO/SswWfF+pXKZcF1RavyMV7mWJxYN2
 IVeLYNg0u/TDJ6o0HN4KfzfLB2BGcTVh1WWLABZHYghcT3AwSSuf2imulmlw9ovwlA3ISM9tC
 YCNfYM0YwG7lxGZBspi417ScN9+FLCWxB3G/3MOOf59WigG3YEYF8lZJpXQmEn3QDb7+1BoiH
 yK0O3Ih5sr8ZYiLtN0CuMGeStmwJH0bp2gcw30CUdqsg+GcaZwr0nQ8mejU4jus4z9c0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As long as the synchronization with the QCA7000 isn't finished, we
cannot accept packets from the upper layers. So let the SPI thread
enable the TX queue after sync and avoid unwanted packet drop.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
---
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 5803cd6..7db149f 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -658,7 +658,7 @@ qcaspi_netdev_open(struct net_device *dev)
 		return ret;
 	}
 
-	netif_start_queue(qca->net_dev);
+	/* SPI thread takes care of TX queue */
 
 	return 0;
 }
-- 
2.7.4

