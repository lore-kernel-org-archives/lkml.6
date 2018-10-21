Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD40ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF742083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF742083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeJVEQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:16:44 -0400
Received: from sauhun.de ([88.99.104.3]:46022 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbeJVEQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:16:35 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id A52132E35DD;
        Sun, 21 Oct 2018 22:01:07 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 1/1] net: dsa: legacy: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 22:01:05 +0200
Message-Id: <20181021200105.2414-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021200105.2414-1-wsa+renesas@sang-engineering.com>
References: <20181021200105.2414-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 net/dsa/legacy.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dsa/legacy.c b/net/dsa/legacy.c
index 8aa92b09db76..cb42939db776 100644
--- a/net/dsa/legacy.c
+++ b/net/dsa/legacy.c
@@ -686,8 +686,7 @@ static void dsa_shutdown(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int dsa_suspend(struct device *d)
 {
-	struct platform_device *pdev = to_platform_device(d);
-	struct dsa_switch_tree *dst = platform_get_drvdata(pdev);
+	struct dsa_switch_tree *dst = dev_get_drvdata(d);
 	int i, ret = 0;
 
 	for (i = 0; i < dst->pd->nr_chips; i++) {
@@ -702,8 +701,7 @@ static int dsa_suspend(struct device *d)
 
 static int dsa_resume(struct device *d)
 {
-	struct platform_device *pdev = to_platform_device(d);
-	struct dsa_switch_tree *dst = platform_get_drvdata(pdev);
+	struct dsa_switch_tree *dst = dev_get_drvdata(d);
 	int i, ret = 0;
 
 	for (i = 0; i < dst->pd->nr_chips; i++) {
-- 
2.19.0

