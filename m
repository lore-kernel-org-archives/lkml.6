Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E7EC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2F920857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkJTGnl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2F920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeG2WkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34107 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbeG2WkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so10599561wrt.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ToL7ZXRip2C4HloVJz5p63aPsFPJAuy2RKtnDYCpTbk=;
        b=FkJTGnl3cj+vq2yQYOwi+Pzinz10b1SIpOjbn9ufurzlvZMewDfeXNl7tNVzGgdsdq
         kMBKDBxVMSR6X5h92eVNg10TJ4CKH9aY728alqYh88alUDFdCjo5NYbHFfSBsUIAx/fc
         Vwr5El8q/uL6dN9gSh1bSc9ElmfDl5fk8oIrue9jhFr1NSQ+xIysJ/M1RpIqLskP6xYX
         2JPBON1+4X7xrEySHPoF/zzm/GVIjLniyLVPQc9O639QskJdo8ggkGUu+BmFKWys7ttx
         cdjeqe6qt3WhvHj5p19UYfQ0sBCBqMIQHuSIKpFcvvzVU/JbNq1ViSp5lPKS0WFd6i/f
         kIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ToL7ZXRip2C4HloVJz5p63aPsFPJAuy2RKtnDYCpTbk=;
        b=dFl2lLGevfToNBECZBvmws/Su2xA+yvaZUanfBQhi7AlKK6Q7de6AF6isMKnUBCgoG
         yTQ/rrb403Pwc2ui/ZEYyGWu3plz+4weoWusgypdcDvuV/8ipV1G/fl7JiqN1xuiF1gb
         PmUOO96pySrHDFITcF4BjyDIH0TOgdEDw8l45shmGEbEMQ4JcwUts5UApxFwpR82QfNz
         hSRh6b2ntisa0PSnTaMgkc1lte7WBOHJ3XbbAWb7NfVQgGJUyQvFOS1Pkum2mAfCN1Al
         A2a6aBUYhcXvTzmYt+Q5kKj0jaBfg8eeFTPP5toJQwD5yoQWgd2emz6DiDSRSLljjhYH
         ao0Q==
X-Gm-Message-State: AOUpUlFzwr8pNZNn7lkm4oOF8wOMb7FmAnaf0yOdsQ+fdhhacC+c6Y0P
        eC9DGrxBfG1HgQOm0qaKvkVXyUwUhiw=
X-Google-Smtp-Source: AAOMgpc3Q7gj3qpjDP/MsQ4fk5Cbpi2k15w+rhNH1p6ZdvKRPKE+vf+F6EqXjJRMJdmk3qmwnzxgNg==
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr14722221wrr.105.1532898508693;
        Sun, 29 Jul 2018 14:08:28 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:28 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 05/15] staging:rtl8192u: Remove typedef of cmpk_intr_sta_t - Style
Date:   Sun, 29 Jul 2018 22:07:37 +0100
Message-Id: <20180729210747.10803-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef of struct cmpk_intr_sta_t, the name of the structure
has been left as cmd_pkt_interrupt_status. This clears the checkpatch
issue with creating new types in code. The change is purely a coding
style change and should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 6 +++---
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index 630cf612f265..c71fda0f13b2 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -225,7 +225,7 @@ static void cmdpkt_beacontimerinterrupt_819xusb(struct net_device *dev)
  */
 static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
 {
-	cmpk_intr_sta_t		rx_intr_status;	/* */
+	struct cmd_pkt_interrupt_status	 rx_intr_status;	/* */
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
 	DMESG("---> cmpk_Handle_Interrupt_Status()\n");
@@ -236,7 +236,7 @@ static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
 	 * endian type before copy the message copy.
 	 */
 	rx_intr_status.length = pmsg[1];
-	if (rx_intr_status.length != (sizeof(cmpk_intr_sta_t) - 2)) {
+	if (rx_intr_status.length != (sizeof(struct cmd_pkt_interrupt_status) - 2)) {
 		DMESG("cmpk_Handle_Interrupt_Status: wrong length!\n");
 		return;
 	}
@@ -528,7 +528,7 @@ u32 cmpk_message_handle_rx(struct net_device *dev,
 
 		case RX_INTERRUPT_STATUS:
 			cmpk_handle_interrupt_status(dev, pcmd_buff);
-			cmd_length = sizeof(cmpk_intr_sta_t);
+			cmd_length = sizeof(struct cmd_pkt_interrupt_status);
 			break;
 
 		case BOTH_QUERY_CONFIG:
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index d2e07b0ff30b..d2590b00fe98 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -55,12 +55,12 @@ struct cmd_pkt_tx_feedback {
 /* 2. RX side: Interrupt status packet. It includes Beacon State,
  * Beacon Timer Interrupt and other useful information in MAC ISR Reg.
  */
-typedef struct tag_cmd_pkt_interrupt_status {
+struct cmd_pkt_interrupt_status {
 	u8	element_id;			/* Command packet type. */
 	u8	length;				/* Command packet length. */
 	u16	reserve;
 	u32	interrupt_status;		/* Interrupt Status. */
-} cmpk_intr_sta_t;
+};
 
 /* 3. TX side: Set configuration packet. */
 typedef struct tag_cmd_pkt_set_configuration {
-- 
2.18.0

