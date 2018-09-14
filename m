Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5258DECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 23:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0E520861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 23:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NstPgCUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0E520861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeIOESu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 00:18:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42425 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725753AbeIOESu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 00:18:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so4925445pff.9;
        Fri, 14 Sep 2018 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bGhf4sU3pYC++35W7O4zDjMEyDgUy5YgTDYAOlFZ+To=;
        b=NstPgCUK+PUSUYBaqeO040kkJu3K4u4ubplpGOCNsS1d1ZBAn4S+7/K0MaV6WY5mWS
         QypR7orodqkvT18ERImDiS8mGjGbtFq43AZnAbVBG5lgFKmskIn+cQ6xQhPSorudbsHI
         CxPasdMjnXe+Hm5uhM3+j4ufzKi4VlZzATy1tPYSoDEdO1yojOGipW3xyv8kAGqnF/6G
         UGqLb9YuXv2d90gBfdpRd5UIo3oyCwVWM0LtOfepqn5xr97aSwx0wUTlv9dDVugdXgG5
         2AeKbhjcpdcXk2klewD31ZXE5lmWohD+IeyfU2t6l70L8PMknc63gUK9OH9PEyUw0/Mj
         sUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bGhf4sU3pYC++35W7O4zDjMEyDgUy5YgTDYAOlFZ+To=;
        b=Vj83d6FxJF9al3T1yedIQIPDsVEteO7wfb9C9jYI8F1obf5heGPBqzxB8DHXuLFage
         5Ik9PtigqX5UnjV7H/KxMz3D8WfTi9dpz2bsPyvr2I3rb3l1cAqAv+reztvGL52CE7v7
         4H18dZM3subF5rGrRNellRavgNz4yTPq4F/YVyNnJ7lGnC066ZWPAUPpBjUM4CnJct5/
         2AqTlHLlq/BioQYfbcuT38ljlE3xtkHRVQLP5I3/YILOiV1SQGBQ3WE1tXja5VrM6hAT
         LxbT1Sk6YuemeRhgaQ4IISGsa3NAX535OJSfRyG+wUfHDVjSHFPRzOX09KbBRYqCjphl
         4Fhw==
X-Gm-Message-State: APzg51AaKZTpkCYVd2Ig4ZuXP04hIqBv2kMHwl1uFbPe6pzvLUfZlja6
        j0q59vRhdNIktDLuqYg2jZZA9Nuz
X-Google-Smtp-Source: ANB0Vdaaw3YyrWI16LjTS6DuNIs2mhGDDAMi13yrsYYIA+spLNa4stn3kstgpWAdcPF6IbKzwCtzvA==
X-Received: by 2002:a63:610:: with SMTP id 16-v6mr13452027pgg.96.1536966135043;
        Fri, 14 Sep 2018 16:02:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q62-v6sm10661889pfi.185.2018.09.14.16.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 16:02:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     rmk+kernel@armlinux.org.uk,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: phy: sfp: Prevent NULL deference of socket_ops
Date:   Fri, 14 Sep 2018 16:01:31 -0700
Message-Id: <20180914230132.23228-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we have specified a SFP and an I2C phandle in the Device Tree,
but we somehow failed to look up the I2C adapter (e.g: the driver is not
enabled), we will leave dangling socket_ops, and the sfp_bus will still
have been registered. We can then observe NULL pointer dereferences
while doing ethtool -m:

[   20.218613] Unable to handle kernel NULL pointer dereference at virtual address 00000008
[   20.226977] pgd = (ptrval)
[   20.229785] [00000008] *pgd=7c400831, *pte=00000000, *ppte=00000000
[   20.236274] Internal error: Oops: 17 [#1] SMP ARM
[   20.241122] Modules linked in:
[   20.244278] CPU: 0 PID: 1480 Comm: ethtool Not tainted 4.19.0-rc3 #138
[   20.251013] Hardware name: Broadcom Northstar Plus SoC
[   20.256316] PC is at sfp_get_module_info+0x8/0x10
[   20.261172] LR is at dev_ethtool+0x218c/0x2afc

Specifically guard against that.

Fixes: ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/sfp-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 740655261e5b..9465be501372 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -378,6 +378,9 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
  */
 int sfp_get_module_info(struct sfp_bus *bus, struct ethtool_modinfo *modinfo)
 {
+	if (!bus->socket_ops)
+		return -EOPNOTSUPP;
+
 	return bus->socket_ops->module_info(bus->sfp, modinfo);
 }
 EXPORT_SYMBOL_GPL(sfp_get_module_info);
@@ -396,6 +399,9 @@ EXPORT_SYMBOL_GPL(sfp_get_module_info);
 int sfp_get_module_eeprom(struct sfp_bus *bus, struct ethtool_eeprom *ee,
 			  u8 *data)
 {
+	if (!bus->socket_ops)
+		return -EOPNOTSUPP;
+
 	return bus->socket_ops->module_eeprom(bus->sfp, ee, data);
 }
 EXPORT_SYMBOL_GPL(sfp_get_module_eeprom);
-- 
2.17.1

