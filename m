Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43158C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC81421736
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRQqsst7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC81421736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeHGX3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32843 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeHGX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so184973wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CrX6159SX/s/j9BSFHQ3Z71JtAPx2FeAsQVZX2znOIo=;
        b=HRQqsst7XmoJArVM6QF2QmU1neFha7NDX1HCJ4eMytATAzAXMtuMaouMuKj34hymtO
         toGw2bxHoIxTf1Ep+L9hXBDiGd9Y25APqPO4KO0zdkq1BZ6JKOgNlLQ0HqevRFWRtzSb
         YfiQxfcB8yV+j1GusJEWqfwAbBxdPzX7ZomyykWAltLN6T/maE9e6/CBH+DrnvaerEBs
         owOx0zQ2+c3H7C48GJ0zxMNNP1IOk7ffvXfPG/SZ2JJDr9NlxbI4xBiiVfAd6POs0DkY
         bJCVBIKEbFyxB8PtxUgIDU+qCgEe10BCn+U4hsMbMmSHV5XrqvFEba9r6iuuh3gibXi/
         q90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CrX6159SX/s/j9BSFHQ3Z71JtAPx2FeAsQVZX2znOIo=;
        b=NGYTkKiEBrdzIrmwUgT2E9TlMS89TY0DYb5NWjY8FrDo1KOzCVuxlil5w2/gHQaWuR
         ZRpxwnRAq8P6eZ5LINLswZRUmWdh2HmqsvdqNo61Pklx6O1b2TEJA4iZvJw78ws8DPRi
         UcSMFWIkVINppAcfI+HD4CbT5eeewgjk74wOGhx92buk6w0gAKKk2rPungrFoDBP12fe
         19aIYJo8vgP9W+EIHazPI0InvCyFXxLr6c6DH2lFbFdum7jkCnYKxlWp589Y4LDq8ZXq
         7OhaUtQb3oza4LPN3xkifEzIzKu0LPpCOC/BbHjtDfQ6oRioHV4zJKTozFLJf436BneH
         bzSQ==
X-Gm-Message-State: AOUpUlG5YrCBV5hK3VqWFpLTZz1U3F8dZLaSukACP7maqOr5VNi/KtSE
        LLKOJ0xj3L6uq3OwTo18uAR324Ep
X-Google-Smtp-Source: AA+uWPx08seCMe21p48nVTFxNWLKkXQ0YGvTr2fBZTvkAoKJGuZCdi2XQejy6XVqqppVCoNTO0mA5w==
X-Received: by 2002:a1c:a6cc:: with SMTP id p195-v6mr60009wme.76.1533676398448;
        Tue, 07 Aug 2018 14:13:18 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:17 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/17] staging:rtl8192u: Rename dot11d_update_country_ie() parameters - Style
Date:   Tue,  7 Aug 2018 22:12:50 +0100
Message-Id: <20180807211255.29343-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dot11d_update_country_ie() uses parameter names which
cause a checkpatch issue de to the use of CamelCase naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index b065781601f1..84c46f5b5a30 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -52,9 +52,9 @@ struct rt_dot11d_info {
 void dot11d_init(struct ieee80211_device *dev);
 void dot11d_reset(struct ieee80211_device *dev);
 void dot11d_update_country_ie(struct ieee80211_device *dev,
-			      u8 *pTaddr,
-			      u16 CoutryIeLen,
-			      u8 *pCoutryIe);
+			      u8 *addr,
+			      u16 coutry_ie_len,
+			      u8 *coutry_ie);
 u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel);
 void DOT11D_ScanComplete(struct ieee80211_device *dev);
 int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
-- 
2.18.0

