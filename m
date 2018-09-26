Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F08EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DD521568
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOt3qjMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DD521568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeI0BcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:32:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38404 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeI0BcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:32:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id x8-v6so2899493eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fc7Da+BL8w9QbUp0hItgr7hP9lUpczleExsww3W7NJA=;
        b=EOt3qjMo3tnNeDy3yNJb0C7s08JUe8IXTNd40V/Lgz742wYRNienpDOIOl5biLcdoq
         cFnhJMDg4DaWzrUqBzOvQYheOa1z4t+wwqRVau1fQFcbrki0jEHjvgWQdLKzk48vVYXk
         joupfKWIhN05zUnY7j7XjZ5RvjqV8F889dfyQkNfltBBgftfBbqPJY7SP6HOem/HJtON
         x2PemrIQqveM6fZOu8JHC3HTb1sR4BxTNfCZMWB5fRqtO3wMvu/v+btAwJT8f7vEBIdP
         3TyxNISFp2cZNTo/Z/aapnui3sbxLwNvOTusKqERaBu3KsLSOXr4F6FKNSwiBcv8nocm
         yJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fc7Da+BL8w9QbUp0hItgr7hP9lUpczleExsww3W7NJA=;
        b=bVssGG2Y921REKSAirBiUGmdD3rKt15jhuZYXjEymI3oyrZ+3Mc+fbDO6JV95CHVXY
         50KNQoXpU2EmDizh7OBjxemQDIHIDDp3X6ysiWq18hG6Z7YFw08M8szbxpsiU4sbJBQq
         BgCEwNgrfYvJFHQADobDcwmFGjlwzJfNANJmhzhAc4jG/8QDmFfLUc/bDdl9h8zVnHZ0
         mF/W7254FdFaZOz1sGdrrelscGmSOnDqsaKWvexeuuAWbmYMHw+kk5yraR+VFnLnRbkY
         kk/OHM9sJfrEUrscDovtRRksokdKbAs/wI6GzphQ6O5uw0/VaEjntlgtMbNBT6Dnuy96
         /smA==
X-Gm-Message-State: ABuFfoiBbT3xEwYwZuk3MnQU7M5j88HZU1Q1QQXqdMo/eyG59MgdfS+Y
        pT7TCvomcshONLwz4L9INavgSBrA
X-Google-Smtp-Source: ACcGV63FmvEty5vUdLrrJLQxShUBGh3i+ZuK2ksiH4gjMnp0hCZ4LvQcpH2xid+Cg9gfb11abpBKGw==
X-Received: by 2002:a50:e185:: with SMTP id k5-v6mr12095034edl.195.1537989459610;
        Wed, 26 Sep 2018 12:17:39 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:38 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/13] staging:rtl8192u: Remove ASCap - Style
Date:   Wed, 26 Sep 2018 20:17:03 +0100
Message-Id: <20180926191704.16322-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused member variable ASCap from code.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 4 ----
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 204e4a5495a1..85a8716c6b05 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -53,10 +53,6 @@ struct ht_capability_ele {
 
 	//Supported MCS set
 	u8	MCS[16];
-
-	//Antenna Selection Capabilities
-	u8	ASCap;
-
 } __packed;
 
 /*
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 9188bd925262..4f6e9da465e2 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -542,8 +542,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 			pCapELE->MCS[i] = 0;
 	}
 
-	//Antenna Selection Capabilities
-	pCapELE->ASCap = 0;
 //add 2 to give space for element ID and len when construct frames
 	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)
 		*len = 30 + 2;
-- 
2.18.0

