Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCBAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6CE20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX2/f22M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6CE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbeGaWmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43032 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeGaWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20-v6so5851448edt.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SgrJxrU4b4dUf4S6x4SwldagEDT+jYC4EVz7P7yEysg=;
        b=ZX2/f22MjVybkZBw04aREWM0DgHbA7U/u7ifhobBHDwzzeF/Bdx1u8llECXFfLQ5QG
         ptlZrYDpkStbBR4jB5vFt7knJAKVyEShWBnyHlmzQm9ugUNyfXysbrwfIktqXJm2U6RQ
         81ZLwo8gMdZU6npChgAudXkoeapt9EtfZC2ZFu3cZWfCiPxaKDjqU+zyYJIDlL8EuVgu
         L/YNqDFjUy7ogpUFInxcQ7ra6dLYib57+ImYJJv9RrX5vZFHfvwZjFq4TKX7AR15F5W3
         l2wwAMtRLHF9sfFpa3e9+8IaO/o6alQ1kx97lWyf0efZK39Xn8fx5HmdrFSLHoqFlVgB
         WhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SgrJxrU4b4dUf4S6x4SwldagEDT+jYC4EVz7P7yEysg=;
        b=eSyFAXBru4KRfWRRmXC6esGSYqhf98uz9e06ESeD00hoXbk8cQp1zqsWO5XhXezyfi
         OAoyVeSYOBm0dOdQ//UPbO72TiuUd56xnapSfKJzzTWzdepDutxOVPrOb02Ki88tM+ww
         FIqmIy2i0n+In0oYymrV8luB7TOwraltGRACYSOxtFLDSDpiiQQYjtOvmPKwSavTQuwN
         NnFPTfLgUmGFpi1vs9ai5nezgwXq+C5i4wU3SOwV40caoE/BO8AmiN3AmX9s4QaDxY5k
         ZC6EM9v8AfKZn+y0u64j+gx73kXjZzIIYY8yEWrkbJfVUjylCjOSXHCv/6cnY4EpnHMW
         n6EA==
X-Gm-Message-State: AOUpUlFUkUMgbY8IYy+9v8q8gl8lpZentHjBt53olYIBa0QprsEqS8rf
        QPAFrl9XK0/JhUDbaOC1xrx8VxRR
X-Google-Smtp-Source: AAOMgpeAuC4aQk+uq6TUjFsRwuq0z6OASS41RDaN/7SlJl/inDp5BaTIt4vFqhiTH4kvO434xOjrCA==
X-Received: by 2002:a50:a584:: with SMTP id a4-v6mr1085420edc.289.1533070840591;
        Tue, 31 Jul 2018 14:00:40 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:39 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/14] staging:rtl8192u: Remove commented out code - Style
Date:   Tue, 31 Jul 2018 21:59:59 +0100
Message-Id: <20180731210005.17452-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of structures have been commented out of code. Obviously they
are not used and as a result have been removed from the code.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 025810c93160..a4b8b577cf79 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -25,7 +25,6 @@ enum direction_value {
 	DIR_BI_DIR		= 3,		// 0x11	// Bi-Direction
 };
 
-
 /*
  * TS Info field in WMM TSPEC Element.
  * Ref:
@@ -70,9 +69,6 @@ struct tspec_body {
 	u16	medium_time;
 };
 
-//typedef struct _TCLASS{
-// TODO
-//} TCLASS, *PTCLASS;
 typedef union _QOS_TCLAS {
 
 	struct _TYPE_GENERAL {
@@ -124,21 +120,6 @@ typedef union _QOS_TCLAS {
 	} TYPE2_8021Q;
 } QOS_TCLAS, *PQOS_TCLAS;
 
-//typedef struct _U_APSD{
-//- TriggerEnable [4]
-//- MaxSPLength
-//- HighestAcBuffered
-//} U_APSD, *PU_APSD;
-
-//joseph TODO:
-//	UAPSD function should be implemented by 2 data structure
-//	"Qos control field" and "Qos info field"
-//typedef struct _QOS_UAPSD{
-//	u8			bTriggerEnable[4];
-//	u8			MaxSPLength;
-//	u8			HighestBufAC;
-//} QOS_UAPSD, *PQOS_APSD;
-
 //----------------------------------------------------------------------------
 //      802.11 Management frame Status Code field
 //----------------------------------------------------------------------------
-- 
2.18.0

