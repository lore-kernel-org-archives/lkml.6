Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35B2C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F59F204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F59F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeIJCew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 22:34:52 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44717 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeIJCew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 22:34:52 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AAE3930000892;
        Sun,  9 Sep 2018 23:43:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6A4684F36; Sun,  9 Sep 2018 23:43:46 +0200 (CEST)
Message-Id: <22a6630e04940f942dbcd739275141d4c6cff17d.1536517047.git.lukas@wunner.de>
In-Reply-To: <cover.1536517047.git.lukas@wunner.de>
References: <cover.1536517047.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 9 Sep 2018 23:42:01 +0200
Subject: [PATCH 1/5] thunderbolt: Skip disabled ports on tunnel establishment
To:     Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a PCIe downstream adapter is marked disabled in the DROM, that port
is ineligible for tunnel establishment, so skip over it when searching
for an unused port.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/tb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 1424581fd9af..0da2e7a06ab5 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -147,6 +147,8 @@ static struct tb_port *tb_find_unused_down_port(struct tb_switch *sw)
 	int res;
 	int data;
 	for (i = 1; i <= sw->config.max_port_number; i++) {
+		if (sw->ports[i].disabled)
+			continue;
 		if (tb_is_upstream_port(&sw->ports[i]))
 			continue;
 		if (sw->ports[i].config.type != TB_TYPE_PCIE_DOWN)
-- 
2.18.0

