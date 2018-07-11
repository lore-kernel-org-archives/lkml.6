Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827102087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex2xbDSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827102087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbeGKT2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33740 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732685AbeGKT2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id x5-v6so16334741edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkF24UAKFKQ1a8n4V+O8zXyzLJu2dgSQ/3ouVrFaQl8=;
        b=Ex2xbDSknexQT6sYx6A6kuNAopUWkWrPJ14DkVHpYCLdAZyqZFDZGJVMHR1MRUxfOY
         ujKphLfb5h2QD+G3A+ovXiynE397VjOGhez6jq40EDifG17YNJuBeMIUh51Obd8f2wdl
         lZS8FIwplp7ZSoohmBDzw+V3mc+N5+VlSQwgAdV80goj7ALr9Tx537XCWfm0TsPr5o/Z
         1fsjcROUrOWORq7YG+4Sa8oWCcWucmR56eFnRUOamwY2kaC/qSoSU7X9AvX96KN7v6nD
         0lBFKXZtm/Tt4M/Y3tkgnNZXe3tjrfVR2vIe1Q9W77rJJmu8uyo+oAqdz5tiG9Imm0DS
         Z6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vkF24UAKFKQ1a8n4V+O8zXyzLJu2dgSQ/3ouVrFaQl8=;
        b=um7/FcUBgMBWP+kM0rPCPYKq2BqWuouzZqBR+cXqb/RVJKxV9lVjuKGFzqu+4PZ6g5
         SAuNmuvuMPpeaE/fi3S97/c6OKGUCWqpPHltpoyX3G+ZC4DRMuUch55KAOkQcroTUsdn
         L1ZyJzswALsJ6OrWeSc6xGaVFh4aTJvadQ+Bi3n88lig+kMKzUOH0BW2B9qcL4zgoDTh
         ip+/IPrDhhdLVHkU7uz89kkmOZLT1mpEPru9fYfqzde1WzkJ6fnAj19T9HOFwlbzTcdW
         ARtpcSv+KW9S4MqaHTYLOKJYX7SthV07YqfkStOjPfISRea2ZMBJZv81MKWfXmP7kQnh
         j4lw==
X-Gm-Message-State: APt69E3y7dkwew38hL8uL3OvC7NPJYg93bolVShjKk86GjIlv60ZwQWI
        5GfOq5Wqoq36WGJ+cv+D/GpndRcY
X-Google-Smtp-Source: AAOMgpe8UC5/1g5sxJruRiBj51JJMJ4xNKfWKlZ2ozKla73+gC2emETPmlKThNtHNWjrRmw3J2zzMw==
X-Received: by 2002:a50:baae:: with SMTP id x43-v6mr32059380ede.65.1531336947012;
        Wed, 11 Jul 2018 12:22:27 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:26 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/10] staging:rtl8192u: remove unused structure tx_desc_819x_usb_aggr_subframe
Date:   Wed, 11 Jul 2018 20:21:42 +0100
Message-Id: <20180711192149.21621-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Structure tx_desc_819x_usb_aggr_subframe is defined in a local header file but
is not used outside of the header file. Removed from the code as a result.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index da23e7e9e3b9..a653a51f7b90 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -213,31 +213,6 @@ struct tx_desc_819x_usb {
 	u32	Reserved7;
 };
 
-#ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
-typedef struct _tx_desc_819x_usb_aggr_subframe {
-	/* DWORD 0 */
-	u16	PktSize;
-	u8	Offset;
-	u8	TxFWInfoSize;
-
-	/* DWORD 1 */
-	u8	RATid:3;
-	u8	DISFB:1;
-	u8	USERATE:1;
-	u8	MOREFRAG:1;
-	u8	NoEnc:1;
-	u8	PIFS:1;
-	u8	QueueSelect:5;
-	u8	NoACM:1;
-	u8	Reserved1:2;
-	u8	SecCAMID:5;
-	u8	SecDescAssign:1;
-	u8	SecType:2;
-	u8	PacketID:7;
-	u8	OWN:1;
-} tx_desc_819x_usb_aggr_subframe, *ptx_desc_819x_usb_aggr_subframe;
-#endif
-
 typedef struct _tx_desc_cmd_819x_usb {
 	/* DWORD 0 */
 	u16	Reserved0;
@@ -374,9 +349,6 @@ typedef struct rx_drvinfo_819x_usb {
 #else
 #define MAX_TRANSMIT_BUFFER_SIZE			8000
 #endif
-#ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
-#define TX_PACKET_DRVAGGR_SUBFRAME_SHIFT_BYTES (sizeof(tx_desc_819x_usb_aggr_subframe) + sizeof(tx_fwinfo_819x_usb))
-#endif
 /* Octets for crc32 (FCS, ICV) */
 #define scrclng					4
 
-- 
2.18.0

