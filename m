Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA038C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7228220895
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co5gakQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7228220895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeGZUnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37829 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbeGZUnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so2254254eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vfWpYAEaCaFA9gveOEMiVzOGWR9nIwypn07809Ecgrc=;
        b=co5gakQqdYCOjqo7hlNUkJuBYlz+QpxthE3LoQhmCwgoAP21kDJG01fQMPzwY2fX6o
         XwmmRvBxjsbH/f3TVCavHE3nk0llx3MeoQE0VNTGWKmZVDLQm0LMQhLXPQB7byOebiq9
         2MgGJBGNUV4rQY2BVlgp7NGkMgbhejUyWsYjesD9YYLIkT0w5rHuaxIZDhKFC3s3QkGk
         0siMZNlMyg496q1xFNqU1spXwRgfP84hbj637ZnCDHXnx8meMRu8xBPQweG++8JRnzK5
         ke0lZx3hwxpmtWg5KvtO2CCUj1ohBJ5q1r+/HwcNjfHWw3SxpgvcB/4P89LUXQ/Nq5ls
         Jr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vfWpYAEaCaFA9gveOEMiVzOGWR9nIwypn07809Ecgrc=;
        b=oNbpqJKryIRC7DXm4rBgLc+70+i73yGiepbZehg/jmcgOYCMMI00t7zjrW6GbZc7a6
         bNsPNlA1/edr2IA9Qm/v40uhXEacRZdWJJhwfi7EYKG7eflXPUFSLAIUezWu4Rl7vzaV
         p53a1ThBDYmkrH2/RiVgDUjUDygagDcfEdBxHjMb9ZJkoKA4dfqolwHU7fRFn3BS5cEG
         S5FSGMybqxfJu3b4i8lUPAjViNpOcyExPmT1Xp4pHZBEOVMY0gACpzc2ygIDuNDoU1Ek
         b8K39O2/XuI376oxhwTFaLn2WBMWs9ASdgGpR8Ogo9Tg8VOYC6R/mJ3oca329yWtILyL
         7emA==
X-Gm-Message-State: AOUpUlEd2uzJQ4kwdTBRDh21nlyPCWNH8Z6hbxr6ZcoWsOtuh12Hn45U
        Ydl75vE4RmfUQ9W/cqdQAfcvepy7
X-Google-Smtp-Source: AAOMgpfdzRucIyXP5Kotle87XCEYvWokXgI3GmTp9TLC5eRulEnuPfx1hiSKvOiMVYZEvmAvLs4Wqg==
X-Received: by 2002:a50:9182:: with SMTP id g2-v6mr4104903eda.24.1532633093481;
        Thu, 26 Jul 2018 12:24:53 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:24:52 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/16] staging:rtl8192u: Rename Para1 > para_1 - Style
Date:   Thu, 26 Jul 2018 20:24:13 +0100
Message-Id: <20180726192426.31913-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable Para1 to para_1. This change clears the
checkpatch issue with CamelCase naming. The change is purely a coding
style change and should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 10 +++++-----
 drivers/staging/rtl8192u/r819xU_phy.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 17cc47e20145..c2a73ec90f70 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1245,7 +1245,7 @@ static u8 rtl8192_phy_SetSwChnlCmdArray(struct sw_chnl_cmd *CmdTable, u32 CmdTab
 
 	pCmd = CmdTable + CmdTableIdx;
 	pCmd->cmd_id = CmdID;
-	pCmd->Para1 = Para1;
+	pCmd->para_1 = Para1;
 	pCmd->Para2 = Para2;
 	pCmd->msDelay = msDelay;
 
@@ -1380,22 +1380,22 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 				rtl8192_SetTxPowerLevel(dev, channel);
 			break;
 		case CMD_ID_WRITE_PORT_ULONG:
-			write_nic_dword(dev, CurrentCmd->Para1,
+			write_nic_dword(dev, CurrentCmd->para_1,
 					CurrentCmd->Para2);
 			break;
 		case CMD_ID_WRITE_PORT_USHORT:
-			write_nic_word(dev, CurrentCmd->Para1,
+			write_nic_word(dev, CurrentCmd->para_1,
 				       (u16)CurrentCmd->Para2);
 			break;
 		case CMD_ID_WRITE_PORT_UCHAR:
-			write_nic_byte(dev, CurrentCmd->Para1,
+			write_nic_byte(dev, CurrentCmd->para_1,
 				       (u8)CurrentCmd->Para2);
 			break;
 		case CMD_ID_RF_WRITE_REG:
 			for (eRFPath = 0; eRFPath < RF90_PATH_MAX; eRFPath++) {
 				rtl8192_phy_SetRFReg(dev,
 						     (enum RF90_RADIO_PATH_E)eRFPath,
-						     CurrentCmd->Para1,
+						     CurrentCmd->para_1,
 						     bZebra1_ChannelNum,
 						     CurrentCmd->Para2);
 			}
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 75970febaac5..77ae606c77ce 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -20,7 +20,7 @@ enum switch_chan_cmd_id {
 /* 1. Switch channel related */
 struct sw_chnl_cmd {
 	enum switch_chan_cmd_id	cmd_id;
-	u32		        Para1;
+	u32		        para_1;
 	u32		        Para2;
 	u32		        msDelay;
 } __packed;
-- 
2.18.0

