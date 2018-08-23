Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0096AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAC720657
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAHRhUFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAC720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeHXAJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:09:05 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33563 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHXAJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:09:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so11673735oip.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L0zlVb16/YCru7lcj24JRdh47dmzHr+1MUoUck31wRQ=;
        b=XAHRhUFaYFUuKKaVq6s4b4A5OGD2kgL3kMi7p4BLpsiwIVxOHLgfJznLb9E+8cEuka
         +x25scK26j9+iGAFRMkRczXwPRQQvpV3+2jxwUfkQuhgeGGFabwPY06pdSFfzzMjFLxc
         amYbHuKZ4QT2c1fEOCWZNg53XIB6324Kb24a7ReZaR3iUSmDBUQ6/3vSNxGizOVfw0hh
         M6PK76UP+t0WW+SCiF7mI1N58+WCtx2dUDm/YWTOFZxjZ5aAVi56qtg2yFWry8aSrhHM
         bihNnKwJSG0X7mBGg7rsz0BMPcBFteHZPE+qJLhUF5Vcu7fQCLgtJj6QTkYBBdfu3u0R
         xFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=L0zlVb16/YCru7lcj24JRdh47dmzHr+1MUoUck31wRQ=;
        b=iwLkJrlHro2haLVk3VImnXlB2IzmsyLKLSe1ZEXNZfCVyCt+iObnuiXK+THhqfCzlB
         WRoJtnx+CfzQpShMKEM8HlwGFOGzLbMOmaKn1SNA8u2y6MRPVDqTx41avIyHri82IX6l
         kWzNHFgWCHaQblXsBPZ6T2fts9q+Uq4BN/ZvzKVZI7jJWZFEvUgW1SV5cSXkDlXaLAo7
         Jeev/4F2CuoZRvuohokQLqwzHQMb67I5tpS8NHdXYU6hdx01FRC+C8G/sdRrfNKU1Oie
         sWuLVfkGEKFsvgRV8Fe+Jk4i146IjzDtzZ/0zTfa5gCpvcnz1sTFPkWpV2Y/0rAa0qAF
         0AMw==
X-Gm-Message-State: APzg51BLRSoz6J5OGM+lPr+d+G/qVsDHbGvWkagx2u/vb7kfW3AXGDmQ
        QXAuC+kKt4dQ5f+xMw6/qA==
X-Google-Smtp-Source: ANB0VdapFqn8rNdyeC2XNnIMXsR24ptKOaJL9AICjn3VZC5zaUf2rttwVLn3d/VzLNczKpeauH9u+Q==
X-Received: by 2002:aca:338a:: with SMTP id z132-v6mr10694859oiz.184.1535056662940;
        Thu, 23 Aug 2018 13:37:42 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id o9-v6sm1194517oia.21.2018.08.23.13.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:37:42 -0700 (PDT)
Received: from t430.minyard.net (unknown [IPv6:2001:470:b8f6:1b:a11a:38c7:7111:773f])
        by serve.minyard.net (Postfix) with ESMTPA id 384291271;
        Thu, 23 Aug 2018 15:37:11 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id D59F230000A; Thu, 23 Aug 2018 15:37:09 -0500 (CDT)
From:   minyard@acm.org
To:     Andrew Banman <abanman@hpe.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, rja@hpe.com, frank.ramsay@hpe.com,
        justin.ernst@hpe.com, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 2/2] ipmi: Convert pr_xxx() to dev_xxx() in the BT code
Date:   Thu, 23 Aug 2018 15:37:03 -0500
Message-Id: <1535056623-26634-3-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535056623-26634-1-git-send-email-minyard@acm.org>
References: <1535056623-26634-1-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Cleanups, do the replacement and change the levels to the proper
ones for the function they are serving, as many were wrong.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_bt_sm.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
index b4133832e..f3f216c 100644
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -8,6 +8,8 @@
  *  Author:	Rocky Craig <first.last@hp.com>
  */
 
+#define DEBUG /* So dev_dbg() is always available. */
+
 #include <linux/kernel.h> /* For printk. */
 #include <linux/string.h>
 #include <linux/module.h>
@@ -215,8 +217,8 @@ static int bt_start_transaction(struct si_sm_data *bt,
 		return IPMI_NOT_IN_MY_STATE_ERR;
 
 	if (bt_debug & BT_DEBUG_MSG) {
-		pr_warn("BT: +++++++++++++++++ New command\n");
-		pr_warn("BT: NetFn/LUN CMD [%d data]:", size - 2);
+		dev_dbg(bt->io->dev, "+++++++++++++++++ New command\n");
+		dev_dbg(bt->io->dev, "NetFn/LUN CMD [%d data]:", size - 2);
 		for (i = 0; i < size; i ++)
 			pr_cont(" %02x", data[i]);
 		pr_cont("\n");
@@ -260,7 +262,7 @@ static int bt_get_result(struct si_sm_data *bt,
 		memcpy(data + 2, bt->read_data + 4, msg_len - 2);
 
 	if (bt_debug & BT_DEBUG_MSG) {
-		pr_warn("BT: result %d bytes:", msg_len);
+		dev_dbg(bt->io->dev, "result %d bytes:", msg_len);
 		for (i = 0; i < msg_len; i++)
 			pr_cont(" %02x", data[i]);
 		pr_cont("\n");
@@ -274,7 +276,7 @@ static int bt_get_result(struct si_sm_data *bt,
 static void reset_flags(struct si_sm_data *bt)
 {
 	if (bt_debug)
-		pr_warn("IPMI BT: flag reset %s\n", status2txt(BT_STATUS));
+		dev_dbg(bt->io->dev, "flag reset %s\n", status2txt(BT_STATUS));
 	if (BT_STATUS & BT_H_BUSY)
 		BT_CONTROL(BT_H_BUSY);	/* force clear */
 	BT_CONTROL(BT_CLR_WR_PTR);	/* always reset */
@@ -300,7 +302,8 @@ static void drain_BMC2HOST(struct si_sm_data *bt)
 	BT_CONTROL(BT_B2H_ATN);		/* some BMCs are stubborn */
 	BT_CONTROL(BT_CLR_RD_PTR);	/* always reset */
 	if (bt_debug)
-		pr_warn("IPMI BT: stale response %s; ", status2txt(BT_STATUS));
+		dev_dbg(bt->io->dev, "stale response %s; ",
+			status2txt(BT_STATUS));
 	size = BMC2HOST;
 	for (i = 0; i < size ; i++)
 		BMC2HOST;
@@ -314,7 +317,7 @@ static inline void write_all_bytes(struct si_sm_data *bt)
 	int i;
 
 	if (bt_debug & BT_DEBUG_MSG) {
-		pr_warn("BT: write %d bytes seq=0x%02X",
+		dev_dbg(bt->io->dev, "write %d bytes seq=0x%02X",
 			bt->write_count, bt->seq);
 		for (i = 0; i < bt->write_count; i++)
 			pr_cont(" %02x", bt->write_data[i]);
@@ -338,7 +341,8 @@ static inline int read_all_bytes(struct si_sm_data *bt)
 
 	if (bt->read_count < 4 || bt->read_count >= IPMI_MAX_MSG_LENGTH) {
 		if (bt_debug & BT_DEBUG_MSG)
-			pr_warn("BT: bad raw rsp len=%d\n", bt->read_count);
+			dev_dbg(bt->io->dev,
+				"bad raw rsp len=%d\n", bt->read_count);
 		bt->truncated = 1;
 		return 1;	/* let next XACTION START clean it up */
 	}
@@ -349,7 +353,8 @@ static inline int read_all_bytes(struct si_sm_data *bt)
 	if (bt_debug & BT_DEBUG_MSG) {
 		int max = bt->read_count;
 
-		pr_warn("BT: got %d bytes seq=0x%02X", max, bt->read_data[2]);
+		dev_dbg(bt->io->dev,
+			"got %d bytes seq=0x%02X", max, bt->read_data[2]);
 		if (max > 16)
 			max = 16;
 		for (i = 0; i < max; i++)
@@ -364,7 +369,8 @@ static inline int read_all_bytes(struct si_sm_data *bt)
 			return 1;
 
 	if (bt_debug & BT_DEBUG_MSG)
-		pr_warn("IPMI BT: bad packet: want 0x(%02X, %02X, %02X) got (%02X, %02X, %02X)\n",
+		dev_dbg(bt->io->dev,
+			"IPMI BT: bad packet: want 0x(%02X, %02X, %02X) got (%02X, %02X, %02X)\n",
 			bt->write_data[1] | 0x04, bt->write_data[2],
 			bt->write_data[3],
 			bt->read_data[1],  bt->read_data[2],  bt->read_data[3]);
@@ -390,8 +396,8 @@ static enum si_sm_result error_recovery(struct si_sm_data *bt,
 		break;
 	}
 
-	pr_warn("IPMI BT: %s in %s %s ", 	/* open-ended line */
-		reason, STATE2TXT, STATUS2TXT);
+	dev_warn(bt->io->dev, "IPMI BT: %s in %s %s ", /* open-ended line */
+		 reason, STATE2TXT, STATUS2TXT);
 
 	/*
 	 * Per the IPMI spec, retries are based on the sequence number
@@ -405,14 +411,14 @@ static enum si_sm_result error_recovery(struct si_sm_data *bt,
 		return SI_SM_CALL_WITHOUT_DELAY;
 	}
 
-	pr_warn("failed %d retries, sending error response\n",
-		bt->BT_CAP_retries);
+	dev_warn(bt->io->dev, "failed %d retries, sending error response\n",
+		 bt->BT_CAP_retries);
 	if (!bt->nonzero_status)
-		pr_err("IPMI BT: stuck, try power cycle\n");
+		dev_err(bt->io->dev, "stuck, try power cycle\n");
 
 	/* this is most likely during insmod */
 	else if (bt->seq <= (unsigned char)(bt->BT_CAP_retries & 0xFF)) {
-		pr_warn("IPMI: BT reset (takes 5 secs)\n");
+		dev_warn(bt->io->dev, "BT reset (takes 5 secs)\n");
 		bt->state = BT_STATE_RESET1;
 		return SI_SM_CALL_WITHOUT_DELAY;
 	}
@@ -448,7 +454,7 @@ static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 	status = BT_STATUS;
 	bt->nonzero_status |= status;
 	if ((bt_debug & BT_DEBUG_STATES) && (bt->state != last_printed)) {
-		pr_warn("BT: %s %s TO=%ld - %ld\n",
+		dev_dbg(bt->io->dev, "BT: %s %s TO=%ld - %ld\n",
 			STATE2TXT,
 			STATUS2TXT,
 			bt->timeout,
-- 
2.7.4

