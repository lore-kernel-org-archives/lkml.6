Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB657C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBDB20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm6vo+5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbeLSVIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:08:44 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39085 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeLSVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:08:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so20429258otl.6;
        Wed, 19 Dec 2018 13:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xZOVkHNZuDx9b+ZJOP0AovVF6XB9OamR4l+O3qRxWmk=;
        b=Jm6vo+5o27fOhKAJ4mrPH37TJo+DML8zyRVR8mzG7NuydRD7LzVielwIRVXt5b6DuH
         SNKsBZFKoUHV+4p/X2uNanIcpFnBWK09HADLCrvAODbClAkhWa1YIpgy0UQW6Ld2GJEw
         Db5czVyTR5KCyEnVsKxtaLkFdvXB91QuVd/iL9U6zLU0gVA1xozhTQ1ujy98mFbUlKTg
         J6Z9RMpmEimz3/sysD4B2TS19f6VEaulq25O6FX/uQNf4gyIurk9Z99DIQ1n0dnIcm7W
         5QfKSxLnNoLPEKaOWNDByl5MYkeW5iKtp0cruS++b8q5/7gWi9o412k/THyCIJgsFHIo
         H7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xZOVkHNZuDx9b+ZJOP0AovVF6XB9OamR4l+O3qRxWmk=;
        b=TZJ+BPTUKkbo1bkY18eRe0f64+GGWUhQP7Ggaa2Q3aJ9GDxn3U8LRo3RKVP6Z31/i7
         FhipU55pvIiApBxghQoeYWT8hKKc43YPHUIBLYxHy8r0Phx25F9nJwQzO9E99rqVS67S
         X7xntLevgZFXFif2QYo48AD1ZOLTEjjxQoo9RXvBY90wrSb6Gy8IXJwrQXIQ3GCDh0J4
         8t+Zw1fTenfFLuAL13WuHzizJlhk5II15e+y8U2exfsJ/gS5bSOtLdnsUwYdEiv/GjEz
         g2dpilMIlunTgCWxED/fQmUysJkOCvkI1T+6ud54Q7LRHmDH9IyyGSp4D9VJQ7NBdNFE
         Bs1Q==
X-Gm-Message-State: AA+aEWZ0OxYuinPFshjSqm627LQ534YZ97fTGS2fB2LgO3XfJDxWWnLv
        DLWodvIk6Sq8s7Var8+Qzv0=
X-Google-Smtp-Source: AFSGD/XVOSRncE3bzt/gnqp6EbbBKSwnmOEqnWlLdcCM2F/Kohj0RM8e+tWkfr710dDBlAIsFZQCjQ==
X-Received: by 2002:a9d:6c3:: with SMTP id 61mr17221498otx.314.1545253722728;
        Wed, 19 Dec 2018 13:08:42 -0800 (PST)
Received: from localhost.localdomain (172-3-172-117.lightspeed.tukrga.sbcglobal.net. [172.3.172.117])
        by smtp.googlemail.com with ESMTPSA id o2sm12273268otj.2.2018.12.19.13.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 13:08:42 -0800 (PST)
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Subject: [PATCH] Staging: iio: adis16240: fixed a SPDX identifier tag mistake
Date:   Wed, 19 Dec 2018 13:07:31 -0800
Message-Id: <1545253651-13891-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style mistake by adding the SPDX identifier tag to the
first line of the code.

Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 24e525f..2c40189 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADIS16240 Programmable Impact Sensor and Recorder driver
  *
  * Copyright 2010 Analog Devices Inc.
  *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/interrupt.h>
-- 
2.7.4

