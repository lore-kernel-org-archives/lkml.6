Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAF3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E5920661
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2ojEy7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E5920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeH0A7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41027 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeH0A66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so9098076edd.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48dgcqpsOS9RG+Nr0FuuzO8h8QpcHdAHxGT6Of+mNK4=;
        b=R2ojEy7pzJ7R15vS9vtL0um2xtkrR5kxEumEzhgASqYLEuW0OMV99LwHhtn1aQ1dt3
         LaK6+nLVK1fXZ57jkeRknDnj7yvBY6MQmDMz6b05QkvflsQsWV82/63b0hXb+eYW+Kwk
         DzagBxTq1FI/lDFgKDCs0GhjDkb6HK4YlAb0AnfU6NPAhnhM9/cnJacK0wbzDI/KJowu
         c7ApU/nxvLFX1rt9kIiWYMRzSddwpEdoIbhgF1KZkuZKOyAz/72ugOf0ZMfacmBbHESA
         /dVEhkPF7iJdF1n4GztUauKfMTt+2QvH8EeHtOJ7JqSe7pGv7PK1unQht2+Ll7viPneH
         KbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48dgcqpsOS9RG+Nr0FuuzO8h8QpcHdAHxGT6Of+mNK4=;
        b=DVnx4r29/v1Y9OBl2Yzv/q2SQAPgsKrvTm2+v4igq34Nb3n2gakKNhNuhQasJVGbs5
         zg2D+VMWRrJwhgJmHduq2kVExhl6YSNP5SqDqzQDPmCVO75yo3ftN4leAgZW43yHrFoL
         jk5ArhC0HCXo/Ru6bGt5jvXVI55bFrGfgyO87DwIm4F8rkH0/6RwiRgWJhI7qYd0hGNU
         RIQkvFH0uA1cCMJZh8kDaSCXAbOvJ7q3jtGXy8d6OjVY48rmKpumkx8FhIhbw/IOmETN
         kN7qqDPdsWlWZ4/UXqtG0ksiEagxy8ICvRu45tcxamm96BwHaEs7wykqI4Rb1dc2GSa6
         5LEg==
X-Gm-Message-State: APzg51Cd9s52Goyvf0rjBfyVFtzp1WwZuf9GV6GpVIzm/zIQ4MaowpdG
        qbPOLIZYtooxGVL8KlZyTsdb2oWp
X-Google-Smtp-Source: ANB0VdZA4o+ErtIQ43Vmv/DABYimZ7CEgiGw7eBGkOma0fhvjpTHntfe3Nutkbq8P3jbpKHwCqniJg==
X-Received: by 2002:a50:8c06:: with SMTP id p6-v6mr13440012edp.282.1535318113460;
        Sun, 26 Aug 2018 14:15:13 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:12 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/21] staging:rtl8192u: Rename EEPROM_TxPwIndex_OFDM_24G - Style
Date:   Sun, 26 Aug 2018 22:14:31 +0100
Message-Id: <20180826211439.14326-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_TxPwIndex_OFDM_24G to
EEPROM_TX_PW_INDEX_OFDM_24G, this change clears the checkpatch
issue with CamelCase naming.

This change is a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 4 ++--
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 7189249a898f..3742dd8410b2 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2483,10 +2483,10 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 			RT_TRACE(COMP_EPROM, "CCK Tx Power Levl: 0x%02x\n", priv->EEPROMTxPowerLevelCCK);
 			for (i = 0; i < 3; i++) {
 				if (bLoad_From_EEPOM) {
-					ret = eprom_read(dev, (EEPROM_TxPwIndex_OFDM_24G + i) >> 1);
+					ret = eprom_read(dev, (EEPROM_TX_PW_INDEX_OFDM_24G + i) >> 1);
 					if (ret < 0)
 						return ret;
-					if (((EEPROM_TxPwIndex_OFDM_24G + i) % 2) == 0)
+					if (((EEPROM_TX_PW_INDEX_OFDM_24G + i) % 2) == 0)
 						tmpValue = (u16)ret & 0x00ff;
 					else
 						tmpValue = ((u16)ret & 0xff00) >> 8;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 4cf3a7fc705e..a7d1a7f9faf0 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -43,7 +43,7 @@
 #define EEPROM_CRYSTAL_CAP	0x22	//0x22
 
 #define EEPROM_TX_PW_INDEX_CCK	0x23	//0x23
-#define EEPROM_TxPwIndex_OFDM_24G	0x24	//0x24~0x26
+#define EEPROM_TX_PW_INDEX_OFDM_24G	0x24	//0x24~0x26
 #define EEPROM_TxPwIndex_CCK_V1		0x29	//0x29~0x2B
 #define EEPROM_TX_PW_INDEX_OFDM_24G_V1	0x2C	//0x2C~0x2E
 #define EEPROM_TxPwIndex_Ver		0x27	//0x27
-- 
2.18.0

