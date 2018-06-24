Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7702C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7543F24E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVz2Uhxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7543F24E8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeFXJ62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:58:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54626 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeFXJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:58:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id o13-v6so6137619wmf.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pL7GBmCPZw5g7w7WieuYv0Oxsr/S/QPxOgiKrTTSTd0=;
        b=UVz2UhxbJZ7Z7ckBvVXoRNg1U81FA6IOaZDk0kEcgPov3q233gZ4iU/TAaKUyhURsj
         NS7jUWYS3Zf/lbkubbJZWgO3S5AmJSgqzRPutg2R/H011RIgG3w+nYSADigIHwFyqykE
         yrEeGTiAqrjwF3wwpCvPSvglr17c1fYeQSUT70VI1zvZKjO1GT+f4Bph9PeoecbjlGPg
         nGxRXlqlojFdO4iHIXd1LSHbEqTf5EipPWRHN88whPRagioTJsJYM5FojtxrmUBX7vBP
         j06Mu/0r9rVrK90F09LurQfBsQyCuffzivq8R/l3z86/AW9egrZd+8hEQqa3rhtAQv7c
         TWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pL7GBmCPZw5g7w7WieuYv0Oxsr/S/QPxOgiKrTTSTd0=;
        b=keST5cuwEywDzdaboZBbzv5l35K8ESJIl9fpo6MCmr54pu5RoehwjwaI37tSAgQb1s
         ZwHDWsFlYDXHCv+B50kv8dIEUlUaM9Ie5qzGwlmYs+4U/uDIYWjKoaqR+05g0TxwZO0D
         zJdACdr9ZACii2sN9EdN9AUYFjoKs6XagHKG3C5nIKwPXkHx+jfdhuzHZmXJP8Lu6EGa
         ZRmGhZh2O3Do0qaB0Pi7OwZThv02gfIa6yPDcnffBrnJnFZjcxwjsyeTNlFIJmC//T26
         G2sw6D08hswZbGwMqz74cNO1aHbkddS8rFekES2Dt0pnXlCn+z9RhzV+eEWv/OKs9Bq6
         OSqg==
X-Gm-Message-State: APt69E12eYiGQ5gRTdQ+nfyUae1CET3IUgdsMIrpGgbBwHkA7cfNwH+y
        wS5tTSO/ApQioKYso3YguItldA==
X-Google-Smtp-Source: ADUXVKIBc7j/Lwl6hmF+Kw9leBhKbebcz/2ii83bR6Kvr5H457ViosHucYjFMhW43LrUerZ88pFIfQ==
X-Received: by 2002:a1c:4adb:: with SMTP id n88-v6mr6511211wmi.121.1529834303811;
        Sun, 24 Jun 2018 02:58:23 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4468328wmc.1.2018.06.24.02.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 02:58:23 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 8/8] staging: rtl8192u: Correction of spelling mistake in comment.
Date:   Sun, 24 Jun 2018 10:57:32 +0100
Message-Id: <20180624095732.12082-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624095732.12082-1-johnfwhitmore@gmail.com>
References: <20180624095732.12082-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple spelling correction.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 2643312625dd..e3b0403194a8 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -866,7 +866,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	/*
 	 * TODO: fill suggested rate adaptive rate index and give firmware info
 	 * using Tx command packet we also shall suggested the first start rate
-	 * set according to our singal strength
+	 * set according to our signal strength
 	 */
 	HT_PickMCSRate(ieee, pOperateMCS);
 
-- 
2.17.1

