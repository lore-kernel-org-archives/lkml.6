Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD7C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2678720867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMfggQZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2678720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeLALML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:12:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34400 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLALMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:12:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id r14so7927447qtp.1;
        Fri, 30 Nov 2018 16:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W1nBtzVUcRCUfSdX8ZWBsao8qJgnwwX+MKZQoaxO4/Q=;
        b=OMfggQZKxF8tZrbA5JdmCkb5Fg3ihqtTTHl3LnsPwLuIrmph3c1KLtTTdKL2GFokzf
         qfRWIi2YLBED/UgoPqHe9TsJfcmzeN0+sHSvRpTJEZYmRf1gMZ+5IIdyDDHI4P5wOMQE
         3ZrEAVk3TRrXm2qHuJ9AqbsiXXIXZXny+NsZEq7Y2AamVoAcK3U3+zCK6VMTNgv/9Q5w
         Hfs0sQNb7+P+IdakHjOxJ8NKXEyZJHL3wDPh48UUrcl58ifm4c70l9HPdBgIIn2/vKjV
         wCXmuAXLhXiKTlBTCIpY2GqWHB7cPywKzGetemweO98vBc8xEaYHd4CJmHwnpXt/wOmh
         oFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W1nBtzVUcRCUfSdX8ZWBsao8qJgnwwX+MKZQoaxO4/Q=;
        b=sdQ5ExN5L15hYM8JibacAMDCCa5x7TQzmDQRoJxDlgCSxP1fSwZxepjXa0NmV19Sl+
         TchmbGKabNX7h3BYVpqJ2YBoqPNTToyqNqncR19572BuceCKppI68bBEDuQQtSgeN+q+
         V9OOJhud2puNQR/6FBjF1u0ZWz1vcSCVLbexrh/wyS/FaHHNQfmlojJ74GtyPxj3z8A1
         pk+bwO9PxNiZD+yWsOqlGsgMMXxIgkd4Mj1tG0o6GYfs4n8wxj8H3SYMr8QVV2A22sno
         loxAMr4yCKTzuemM1DOMVDwj5dFOOrJQCvczN7VKL2w3vlTPAHCpR7S+86Jegxvw39wq
         1VpQ==
X-Gm-Message-State: AA+aEWZTjZBpOmWJTb8NESb+aB9ykZ6QwSRKXdRzDLEoczUnDTrRj3yV
        Lb3GC8yooDwr7bBb66YAoQJ1sOfffGM=
X-Google-Smtp-Source: AFSGD/UtGlRcsqcFdrbAKOHEs6N74NGGSFr1of8bGTcF2KW61bFBPv2pgVEn0lp9Ldc/VWMuiZwK+Q==
X-Received: by 2002:a0c:eb41:: with SMTP id c1mr7774095qvq.211.1543622466489;
        Fri, 30 Nov 2018 16:01:06 -0800 (PST)
Received: from localhost.localdomain ([2804:7f4:338b:c48c:14b0:21c6:dbe:33b0])
        by smtp.gmail.com with ESMTPSA id k38sm4315382qkh.72.2018.11.30.16.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:01:06 -0800 (PST)
From:   Anderson Luiz Alves <alacn1@gmail.com>
To:     andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Anderson Luiz Alves <alacn1@gmail.com>
Subject: [PATCH v3 net] mv88e6060: disable hardware level MAC learning
Date:   Fri, 30 Nov 2018 21:58:36 -0200
Message-Id: <20181130235836.11741-1-alacn1@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable hardware level MAC learning because it breaks station roaming.
When enabled it drops all frames that arrive from a MAC address
that is on a different port at learning table.

Signed-off-by: Anderson Luiz Alves <alacn1@gmail.com>
---

Notes:
    v2: Updated code comments.
    v3: Sent with correct whitespaces.

 drivers/net/dsa/mv88e6060.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index 65f10fec2..0b3e51f24 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -116,8 +116,7 @@ static int mv88e6060_switch_reset(struct dsa_switch *ds)
 	/* Reset the switch. */
 	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
 		  GLOBAL_ATU_CONTROL_SWRESET |
-		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
-		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
+		  GLOBAL_ATU_CONTROL_LEARNDIS);
 
 	/* Wait up to one second for reset to complete. */
 	timeout = jiffies + 1 * HZ;
@@ -142,13 +141,10 @@ static int mv88e6060_setup_global(struct dsa_switch *ds)
 	 */
 	REG_WRITE(REG_GLOBAL, GLOBAL_CONTROL, GLOBAL_CONTROL_MAX_FRAME_1536);
 
-	/* Enable automatic address learning, set the address
-	 * database size to 1024 entries, and set the default aging
-	 * time to 5 minutes.
+	/* Disable automatic address learning.
 	 */
 	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
-		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
-		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
+		  GLOBAL_ATU_CONTROL_LEARNDIS);
 
 	return 0;
 }
-- 
2.17.1

