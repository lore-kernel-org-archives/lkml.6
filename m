Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4E5C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FFA20893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR7ePoep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FFA20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbeG2Ann (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:43:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44546 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731528AbeG2AnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:43:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so8702504wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gntd5pvlF7xcaMQM2QoUHVJwEXKCwJCUaf7ecd4NaBU=;
        b=IR7ePoepMQRamiMXJ8albSmdGNg752M/kE7rpNZFEk55vPrgMGsTG7dDmI9ehxuruE
         3lLgd9ZVl7qnBzWpE41Jxp1Ty9RItuuXPcfaREUX+xn/BCTiUPz0ajEaajX32gD0MhWe
         xPLHgonSq4WC98aCIHoSf7OZqApnD5HC3DbrHN61iWpewY4wTIt2wbq2/PgJ/MXbqrlA
         NDjfke1S4kU0NyaLD2FtaFBXxRJxeC1n8Pn+U0mpxddJKQAVPV6/ttjYKcOINi9UAlED
         MxnW2R7SZgS5EiqRVyXeyx5BX61QEV4THZcXwjpSypZTOYMdo1W0JkdpT39QBfyoBEcB
         JJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gntd5pvlF7xcaMQM2QoUHVJwEXKCwJCUaf7ecd4NaBU=;
        b=Mfz92aYg7O/ckirNzidc0fc8dNmFSS0FFUwnBEK+mv7um1PCmyxgU1l7uifZ9U9gbJ
         /SUK811rTAeiot8j4ZwblzjfkSbxKXgG7mMxIbgD5U/uyzipxcHbSamcITgETR59HK+C
         DRBBvtL1MVVA8RV4asGHBAOHvexUNuhfdSVyJp0p7IVbP4dITa3JxzoeeG+WD6rqX+eY
         FRRDSSB7SM/DgrsoE8AuFLfHtMGQ/POaePnDUQeujAyjT5snYxS6te8XzbHAl6AAS/lU
         LE7IBIFjZNXzIsrNMzS5+hiM+Hr/S0/F20I/hC+abk8pXrPXHR1YHp23sYZDKjIa13fJ
         E+CA==
X-Gm-Message-State: AOUpUlEQFQ4RiKzdd/sILYciCdbBFMpW0LgUr6H9b/oZi9srrzTA77E8
        NgGDRfz2gk4XvgiIKY5KWO3kJf7K
X-Google-Smtp-Source: AAOMgpeOUpTWk5Tgd356nbWCdN7I6s57KCFcymFyLkB3yhVW0jn97VJoa/2hu9bmNXE/TVUfYjJLvw==
X-Received: by 2002:a5d:4643:: with SMTP id j3-v6mr10773118wrs.52.1532819704932;
        Sat, 28 Jul 2018 16:15:04 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8909745wmb.25.2018.07.28.16.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:15:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 04/08] staging:rtl8192u: Remove unused  union AC_PARAM - Style
Date:   Sun, 29 Jul 2018 00:14:48 +0100
Message-Id: <20180728231452.20107-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728231452.20107-1-johnfwhitmore@gmail.com>
References: <20180728231452.20107-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union ACM_PARAM is never actually used in code so removed. This
is a coding style change which should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 901b85139d3b..43edb830ad5d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -36,21 +36,6 @@ typedef	union _ECW {
 	} f;	// Field
 } ECW, *PECW;
 
-//
-// AC Parameters Record Format.
-// Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
-//
-typedef	union _AC_PARAM {
-	u32	longData;
-	u8	charData[4];
-
-	struct {
-		union aci_aifsn	AciAifsn;
-		ECW		Ecw;
-		u16		TXOPLimit;
-	} f;	// Field
-} AC_PARAM, *PAC_PARAM;
-
 //
 // Direction Field Values.
 // Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
-- 
2.18.0

