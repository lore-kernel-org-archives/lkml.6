Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75131ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3007420856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji05qaor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3007420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeGUNu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37252 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeGUNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so9016041pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BS7jONlcC15l+eBl52Jh0dWrkwF8GT1KK+12jUOAAcY=;
        b=Ji05qaorGjfRqVtz04abldUtRsPEFdInWYxCfWPgzwwZ8/Zu8q3ZgSxC/2zGfryuke
         CDNr5QJ9kmHqEM27bpEvL5bAJUPc4c+/UKGijZU2KyQLWx9E5dsydygJlqRHVWkJVo6J
         Txju2mi1JItvWeQ22hfakwrukDuF8G/zyEA6iJ1Cfy8FZVDkEHMuEX7trmSuRu6izPbB
         x5QHhMRSF0/RMquaSk3kHi+36OfKXVnG+kI9opNLe0viuq8MwdH43uufKg/Lib41QrBc
         6arNDOtpkB9TRzCA+wZpjYnvcPKkEb87Rr5IGIIRqetNnwCQto1Q8k/BwfQGXvQL44zq
         7T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BS7jONlcC15l+eBl52Jh0dWrkwF8GT1KK+12jUOAAcY=;
        b=ZCQrinVP532a4ny526b66h21lYKcmX1gcsli3m6aUZ9gKEnaJETWtaQuCCDrVsPXht
         WTC0LvzM/zH2L9o7p45aCBs+J3ZW8XqwG4anXdbkpfSApBonb5UnQDwi3a5h83FJu784
         SvzXiJWN+gBVLNZXET7fGBjmwy/mtmde6il/5QHs/IC/p9+RHqaV5XHSd0p298YQMRRW
         +QCHKM/Dd9SIu++wEBA4DXCWKKesnjvWbJmEuzdde4zA2r2ZTykjRiyO5f/DqqGVT2oB
         meEPiUDBtkJoWXyEH9DZjt3IZ1J5ROkFXNTPRhwhSrSd5MGVS7baMWy5MiwjPatvpG09
         LK3w==
X-Gm-Message-State: AOUpUlHPuK8kW+mQ+hLDibQeZhVRsab3loff8b4R6C2axR9EwqALYhOX
        F5wE6PNiuMWXqdsZ/yjIky0=
X-Google-Smtp-Source: AAOMgpeK12hn20wz/7w1JteIRFpbXelgTLmecuuDXs0N6yxO8hTdnUrzEoaWUJwVDZraZNcl0hY3MQ==
X-Received: by 2002:a63:4e22:: with SMTP id c34-v6mr5609674pgb.6.1532177864985;
        Sat, 21 Jul 2018 05:57:44 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:44 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/14] staging: gasket: gasket_get_device drop check for NULL pci_dev
Date:   Sat, 21 Jul 2018 05:56:52 -0700
Message-Id: <20180721125713.88501-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The pci_dev field of a struct gasket_dev can never be NULL, there's no
need to check for this in gasket_get_device().

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index e82f8ce39c9fd..8265d543623d7 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -2026,9 +2026,7 @@ const struct gasket_driver_desc *gasket_get_driver_desc(struct gasket_dev *dev)
  */
 struct device *gasket_get_device(struct gasket_dev *dev)
 {
-	if (dev->pci_dev)
-		return &dev->pci_dev->dev;
-	return NULL;
+	return &dev->pci_dev->dev;
 }
 
 /**
-- 
2.18.0.233.g985f88cf7e-goog

