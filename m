Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA91C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049A12077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olRfk2JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049A12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeICWqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:46:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44450 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeICWqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:46:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so1464993wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Bct5SbOjy7xziMbTawQsZcEIBPqJmsaDL9OXgWZ2EA=;
        b=olRfk2JEC1d2ctoNLFsk4qIg285WGJTSY4PqzqRYgejYtQ2IIY5Eicldf+4VWW3BQa
         u+I/fyhd4QlZAzANJFGDdm2eMlRFjpfBOAVgXs382lV0BNlx/s4yI8+eI2fJ7gbauxsm
         0kpwCnf6Tpuhyr28meait/XhhrHXOdmAS4GbXeGq7PplahddwkbAtfyc8gc41uWFbBXJ
         QGrsYkq5+yhSHyKBaFMJEA/bEewMYIBaYpeeYSDSglPMH0DMQwbSwNv31McaGdCsJbkh
         hGOks8caCi+MIlB5MswUk09rPa7kuR579RQw4L53NhUMojYGlz5WuarL/8jEISBjk5Uj
         CuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Bct5SbOjy7xziMbTawQsZcEIBPqJmsaDL9OXgWZ2EA=;
        b=cqcJvKCDV5Tib5nagJL2zA4KbUxrqg5CN6fEa3tS3GdbavvI+A1p7Rc1af3wd8aG5N
         xw8Fel5paVMTeYQmq3x8ZrN4fj82sdqZP8HQDPWXK3h157POfYowsP5WGA0f4qqX85nW
         uf/hK4RJpIzsewOC4HtP0ZjEsoAAbaUiimiAU4S+Zix49B08idutw5BMOoBlpxWUBKO6
         R4zkCUpaz99vrcLDz9kxvI5MjHYbPDCZodxGlWms+n1Ai3lZKkJSyHG3xOLzcLfE6f2c
         Fwn0vvPm3jJvM4MbnJsJ7G84uWGfsFDf1zocXe1DT3TmkHeZ852bdwf+6X5OqrbiEPih
         3stg==
X-Gm-Message-State: APzg51Ak8aMdpxzhPuqMbTGZa6yRr6GkXdBCzAjjVt9dKrS8D5EmQHh8
        lCHxH647y4bjAL3dW0qrGUQ=
X-Google-Smtp-Source: ANB0VdbPi+G1YUb8siMedydljvp3L3lSW2PFHYmzqTzWd+ky43GhSZGHkwXJgWVS8yoMHikbkUKQ3A==
X-Received: by 2002:adf:9464:: with SMTP id 91-v6mr19745231wrq.231.1535999097407;
        Mon, 03 Sep 2018 11:24:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v46-v6sm24201349wrc.63.2018.09.03.11.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:24:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: fix comparsions to true
Date:   Mon,  3 Sep 2018 20:24:43 +0200
Message-Id: <20180903182445.1969-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903182445.1969-1-straube.linux@gmail.com>
References: <20180903182445.1969-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(x) instead of if(x == true).

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 8f87db11f87e..20d7bba2cfd4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -113,9 +113,9 @@ u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int ratelen
 	if (pmlmeinfo->HT_enable)
 		network_type = WIRELESS_11_24N;
 
-	if ((cckratesonly_included(rate, ratelen)) == true)
+	if (cckratesonly_included(rate, ratelen))
 		network_type |= WIRELESS_11B;
-	else if ((cckrates_included(rate, ratelen)) == true)
+	else if (cckrates_included(rate, ratelen))
 		network_type |= WIRELESS_11BG;
 	else
 		network_type |= WIRELESS_11G;
@@ -1426,9 +1426,9 @@ void update_wireless_mode(struct adapter *padapter)
 	if (pmlmeinfo->HT_enable)
 		network_type = WIRELESS_11_24N;
 
-	if ((cckratesonly_included(rate, ratelen)) == true)
+	if (cckratesonly_included(rate, ratelen))
 		network_type |= WIRELESS_11B;
-	else if ((cckrates_included(rate, ratelen)) == true)
+	else if (cckrates_included(rate, ratelen))
 		network_type |= WIRELESS_11BG;
 	else
 		network_type |= WIRELESS_11G;
-- 
2.18.0

