Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD3C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E24B208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E24B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeJAEjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:39:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJAEjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:39:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8D461260A8A
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Milo Kim <milo.kim@ti.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Breck <kernel@networkimprov.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 08/14] power: supply: charger-manager: simplify generation of sysfs attribute group name
Date:   Mon,  1 Oct 2018 00:03:43 +0200
Message-Id: <20180930220349.10515-9-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple cleanup and there should be no functional changes.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/charger-manager.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index faa1a67cf3d2..7ce0a4a2645c 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1369,8 +1369,7 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 	struct charger_desc *desc = cm->desc;
 	struct charger_regulator *charger;
 	int chargers_externally_control = 1;
-	char buf[11];
-	char *str;
+	char *name;
 	int ret;
 	int i;
 
@@ -1378,19 +1377,15 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 	for (i = 0; i < desc->num_charger_regulators; i++) {
 		charger = &desc->charger_regulators[i];
 
-		snprintf(buf, 10, "charger.%d", i);
-		str = devm_kzalloc(cm->dev,
-				strlen(buf) + 1, GFP_KERNEL);
-		if (!str)
+		name = devm_kasprintf(cm->dev, GFP_KERNEL, "charger.%d", i);
+		if (!name)
 			return -ENOMEM;
 
-		strcpy(str, buf);
-
 		charger->attrs[0] = &charger->attr_name.attr;
 		charger->attrs[1] = &charger->attr_state.attr;
 		charger->attrs[2] = &charger->attr_externally_control.attr;
 		charger->attrs[3] = NULL;
-		charger->attr_g.name = str;
+		charger->attr_g.name = name;
 		charger->attr_g.attrs = charger->attrs;
 
 		sysfs_attr_init(&charger->attr_name.attr);
-- 
2.19.0

