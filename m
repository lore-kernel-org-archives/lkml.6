Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB28C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E2D206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fmOB+oZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E2D206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeIGMlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:41:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35320 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbeIGMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:41:35 -0400
Received: by mail-lf1-f66.google.com with SMTP id q13-v6so11334984lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nxJTla9Dxev2n+8jU9NwZekV4JNoZtIDzPw29/PUFJw=;
        b=fmOB+oZHd+f7P1TnG/NGvglTt/Izh5FpYYzocXSGXJS2I6c+38Oyv6eLdsP2VEGWNi
         SEZ03GSLh1EDR06daN7EylWcH46SivQiyjG2VJvBfiNjuA1qdVfjGGxm46+z5ll/wJs3
         cbhkfPN6xs1yHmZG107JGNKD2Yh1oLl6O9EFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nxJTla9Dxev2n+8jU9NwZekV4JNoZtIDzPw29/PUFJw=;
        b=KDbPlB1egyZ8gH59IMUKbExrjcFzFHXP+XfIkkaa8xPARJx4CZRSPLWWGvlrthT8TF
         wDdxzJVp4KZAS6hgzHB+C9lWdevUdAabCh83idwd9M3l5jIKLsPnv9XmtR/bs5bbClIN
         sTaWZFgM4Oc57m/b4/dNiMwgT93ahj1EaOS5t8FVITtW3x8J8ySJQcEVac2ToWIKNnD+
         jKRZ02C0+YTF7W4rTO+CzD0ygbI1ZgoocZndNdjeGXbp4CjcjiLTPWvJ5cphXL2rgYec
         VZ9o3MwX+/iSFanihohf0lUrs2aOlbGuYhnFfFUSi+XtqAnEsCW9Kyvi8d7Mydjo5/6N
         4FBQ==
X-Gm-Message-State: APzg51B4hLy3oEVhVrGpolNFIikzCFz4bh4dxLUud6mO9dLj0Q8uRzNm
        Y40eoAuHCVy/YlmgeZlS9GkotA==
X-Google-Smtp-Source: ANB0Vda5T4SphaRTXZw5MFjRwTPqeeBtbwR8HpRoQ1AxGKyzPOP+awsHtwi23/5TZ/k/LuDt4gYqOA==
X-Received: by 2002:a19:c94a:: with SMTP id z71-v6mr4151069lff.34.1536307309497;
        Fri, 07 Sep 2018 01:01:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y65-v6sm1162779lfa.97.2018.09.07.01.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 01:01:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] android: binder: use kstrdup instead of open-coding it
Date:   Fri,  7 Sep 2018 10:01:46 +0200
Message-Id: <20180907080146.28998-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/android/binder.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d58763b6b009..2abcf4501d9a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5667,12 +5667,11 @@ static int __init binder_init(void)
 	 * Copy the module_parameter string, because we don't want to
 	 * tokenize it in-place.
 	 */
-	device_names = kzalloc(strlen(binder_devices_param) + 1, GFP_KERNEL);
+	device_names = kstrdup(binder_devices_param, GFP_KERNEL);
 	if (!device_names) {
 		ret = -ENOMEM;
 		goto err_alloc_device_names_failed;
 	}
-	strcpy(device_names, binder_devices_param);
 
 	device_tmp = device_names;
 	while ((device_name = strsep(&device_tmp, ","))) {
-- 
2.16.4

