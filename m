Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08BAECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD7320864
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLAeW5bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD7320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeGUUUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44345 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeGUUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so14116840wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fxw17ARgbEFa890TcDiJBOvzHWS5FqFhXIhXmLxkqks=;
        b=MLAeW5bngot3Mfy2EobjBdgz/A7DsJOvRgSBcX2EP0yBgeCjl2jFuU8PrDsgXJbr+z
         890ftDAwjXl7kOFhGh+QET5MJXu/BNj7EoYYmySjZ3WJkmsqK04VdV6Ug7dbE2exHHCM
         dFZZ0Bq32IcTtC207k0BSn9hqzbae2LS0Z9noyHPnt2AFjCHfI6w7gQMJvrX8foRrvRY
         7+ihh8ayxu5AqPhBk2pFuGjdPd32sTlScT4Gro8Z/QO43rQWnO6aVGXIm6CL/jgC9LsK
         97IJYQlYTSZm12T2daLEONCh5aEx+4AqSbsJP6bcX7t5OqdvULb1AVvKbqygEdzGkZk5
         6J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fxw17ARgbEFa890TcDiJBOvzHWS5FqFhXIhXmLxkqks=;
        b=GsiuwYtk76bkFcMPeyWUqasa1dOgO2ROnq6OFySWquxx2gVolYTvaFQjin4kC9sjJ5
         Efs4SglWwrndxVYWMuPdjsbVX5ajkW6JtLejZ+2C45y0dxuoqAaAv+b17/zwSQgUdpeh
         t1rsxViH2DXT5uzT/2jbpPxL4L44ckFtIiqTQ4PaAXEyMUnN5QqKVgsNAyz9l0jOjwqa
         8BhmthmbOLXnFcLbpZBP0BtvhGkSHsw5te6yMGr/Bdyi5HTYCzf7A/ZcVuKim3MC/lp/
         uu6nerbFLMd+riLMqrAmDENfEJF8Z6if6bmaxXCY/dgn1ajnSRYW4oOsOEZ06yhq4ERP
         Y5EA==
X-Gm-Message-State: AOUpUlGUdQWsWPYte+1EE+n8GqC5+OOIXwsRRj8jKaavuQRQXO84rgq7
        Nc4git/k8exIB128NG2AkobPzlUf
X-Google-Smtp-Source: AAOMgpebOFkfi7ZigKvpoy43rZ0mpZVWrHwLax/cbfHlu/qe3WaS9dFxJr4p4h4aeG6lCyCsRegLfg==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr4481431wrc.119.1532201177955;
        Sat, 21 Jul 2018 12:26:17 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:17 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 01/10] staging:rtl8192u: Rename TClasProc > t_clas_proc - Style
Date:   Sat, 21 Jul 2018 20:25:43 +0100
Message-Id: <20180721192552.5378-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721192552.5378-1-johnfwhitmore@gmail.com>
References: <20180721192552.5378-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the struct TS_COMMON_INFO member variable TClasProc to
t_clas_proc. This change clears the checkpatch issue with
CamelCase variable names. There should be no impact on
runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 3bf48a04a68e..a183198afb31 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -22,7 +22,7 @@ struct ts_common_info {
 	u8				addr[6];
 	TSPEC_BODY			t_spec;
 	QOS_TCLAS			t_class[TCLAS_NUM];
-	u8				TClasProc;
+	u8				t_clas_proc;
 	u8				TClasNum;
 };
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index b5fede650b81..8b2bb0a69b01 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -106,7 +106,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
 	memset(&pTsCommonInfo->t_class, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
-	pTsCommonInfo->TClasProc = 0;
+	pTsCommonInfo->t_clas_proc = 0;
 	pTsCommonInfo->TClasNum = 0;
 }
 
@@ -281,7 +281,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 	for(count = 0; count < TCLAS_Num; count++)
 		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
 
-	pTsCommonInfo->TClasProc = TCLAS_Proc;
+	pTsCommonInfo->t_clas_proc = TCLAS_Proc;
 	pTsCommonInfo->TClasNum = TCLAS_Num;
 }
 
-- 
2.18.0

