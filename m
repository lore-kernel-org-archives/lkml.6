Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8336ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458B320846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="b5ph9s0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458B320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=castello.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeGWFyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:54:47 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.107]:35861 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbeGWFyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:54:46 -0400
X-Greylist: delayed 1505 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2018 01:54:46 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 3C414753D
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:09:41 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hSAHf4nUuPvAdhSAHf949R; Sun, 22 Jul 2018 23:09:41 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xbVF/gG+TGE44CgZMh960mEdaHIB1v2hHfiYYFUNTK8=; b=b5ph9s0XBW9J0Y/Hz+97ESsL2
        j5LfZNZJKf7EPTh2i5Qm4TBQm9OEqTf0ccA1AavSxYewnq/xuJevc/qGdIs90+96vjxXlNp0PV1gU
        iYxxa7/KkJFRlNaZj9V5B9bP3YA+wOIzfWYjlv7MlddzpE8UNt7LIruhg84FoZvfKkoZEl8Gkd1aN
        ZLz2X/DzVLlN1r86ZFu+kh4ZiWXZSNysL+Q6sRf/TMZcTbsk1wen7AD04Ecu06Oc7ed/JxkbohXOF
        wTnWkda74XbEf6AqctAdu0YMVXR6fZ+8t0Tu2a6+fgxCS5lO8qvh8VFfnsi1+CkICkJ0smVo2+hKe
        HOGt99EPg==;
Received: from [191.189.20.114] (port=7927 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1fhSAG-001oyu-BT; Mon, 23 Jul 2018 01:09:40 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 4/4] power: supply: max17040: Send uevent in SOC changes
Date:   Mon, 23 Jul 2018 00:08:16 -0400
Message-Id: <20180723040816.19455-5-matheus@castello.eng.br>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.20.114
X-Source-L: No
X-Exim-ID: 1fhSAG-001oyu-BT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.20.114]:7927
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 29
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for changes in state of charge from delayed work, so
in case of changes we call power_supply_changed to send an uevent.

power_supply_changed send an uevent for alert user space about
changes, is useful for example to user space apps made changes in
UI battery level or made other decisions.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 3efa52d32b44..72915ac9e13b 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -202,14 +202,22 @@ static void max17040_get_of_data(struct max17040_chip *chip)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
+	u16 last_soc;
 
 	chip = container_of(work, struct max17040_chip, work.work);
 
+	/* store SOC for check change */
+	last_soc = chip->soc;
+
 	max17040_get_vcell(chip->client);
 	max17040_get_soc(chip->client);
 	max17040_get_online(chip->client);
 	max17040_get_status(chip->client);
 
+	/* check changes and send uevent */
+	if (last_soc != chip->soc)
+		power_supply_changed(chip->battery);
+
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 }
-- 
2.13.3

