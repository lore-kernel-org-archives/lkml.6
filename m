Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65DBC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B4C208C2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HURns/it"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B4C208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934332AbeGDMAF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:00:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35690 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932733AbeGDMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:00:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id h40-v6so5072023wrh.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GDAnIncNCG+/9QWSTO6abEgwmOl0ZpRXDrwUlub/8vQ=;
        b=HURns/itMPyAyxkEyv564ip4fg7c4Cqm4KGMSn+aTqjAJRqnajSvNLMhjpgEXQfXJ+
         quulMLtlK8ZraXyH5fHChrpv2HsB+albmW/TKpMvs2nHyGRnvJP/L5Wkv7V2JAbIXiH3
         OmdQpdPeayxbVQFM7ME3SO/uHoj/QD5tFbB+X9KkGj/snsx1OYWDRNJ9DI0xa+hLH/gB
         zz1YvVB+sinYk/Yn0yu6YMxjY0fhm3+1FGTe/W0Xto//EwCgERBKVqS9qNc/ebma4hRT
         gKzWFeWpXObovoOHlFLodZ7jc565MrGiDnESrCN7Pm25SXhKIq77ozx65/U5P6M16hcS
         A11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GDAnIncNCG+/9QWSTO6abEgwmOl0ZpRXDrwUlub/8vQ=;
        b=nw1ArxaGBxbTPuzOt01G9UZGq/1By0aT29fBNYOI+swzmMjNug9tgYskzwa38obzN4
         /VLrBIIKKrrWGqIYb7VKb8YHSHj+Z63w/pyaTQn7YIpmQ38xfwg9e2sRH1TNbXHzlE9f
         nJsA7+qVsk3aaMtVOfgST6JypQ5qixS0fiQBkm1Go64LDs06a769G3XrZoaPGckvlkwr
         4ilHnPUaQMp0s26gUzZ8I/UGUqAGsAz9E8DhrU+NGXk33ICoa7sodx1S0W7AZydfhZOo
         AXj3BP8IMm49k3pLRRgIL9GgGl7OYU+hjaOr8tiE9fhnR2X2NkM2ZSPki+oTNZWU9KFT
         pIaw==
X-Gm-Message-State: APt69E0xFEhNQ2AqzEGW8DinJlc4c6E2lz1S2W/po3qHDkCBz+h3enrQ
        XjtDz1pRXrITU1yFMhH2ik5OmXqt
X-Google-Smtp-Source: AAOMgpe/dxRJErha4oxvHTUGc3YYMOCHkQxcyqPltNM3mmL1rx5Cz+mFTTJpqjEhR4CaTvcG4gygPA==
X-Received: by 2002:adf:e491:: with SMTP id i17-v6mr1467405wrm.145.1530705599436;
        Wed, 04 Jul 2018 04:59:59 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6893985wmw.9.2018.07.04.04.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 04:59:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 3/5] staging: rtl8192u: Remove unused variable.
Date:   Wed,  4 Jul 2018 12:59:23 +0100
Message-Id: <20180704115925.28024-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704115925.28024-1-johnfwhitmore@gmail.com>
References: <20180704115925.28024-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the unused variable from previously removed loop.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 327557176625..abf55877331e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -761,8 +761,6 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
  */
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
-	u8					i;
-
 	if (!pOperateMCS) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR,
 				"pOperateMCS can't be null in %s\n",
-- 
2.17.1

