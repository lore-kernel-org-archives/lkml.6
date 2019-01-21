Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C11C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11712085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIqmRo9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfAUPgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:36:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34527 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfAUPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:34:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so10306182pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3La3nh4cjwvbMwHUC1cRjF+OA89huuotgfLD2qZLwAw=;
        b=DIqmRo9Huo5kG+Z98giREbRYAMIUnZT2vE3A7xv7TTDmq2ZiRCGdlkh+FwhMIgS3UQ
         cRlALKtPkAlxewKSR439P5Xmk2K203PQUINRveZnXMuXIuwavfIaMgd2YUDrEAvVItTM
         uqY7ajONUETjlXBYOpj+e/S4eTeuKjQFg+xiiUX4uRWzbs15VSAKOxzQdoINeDfuRtx1
         Lkk8FMuNj4qcFHM7e939JvSPha5uT/PX0xxWjBebtBtUvRkm2VOBPDkVXg+6oFbkT5UO
         L4efZrVauwn2QzMtalxvbOBDGtkPZWvbRsiSi6ozrJep5E3Xnrf5Nf8KTiJoXDK/jnla
         SeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3La3nh4cjwvbMwHUC1cRjF+OA89huuotgfLD2qZLwAw=;
        b=K6xLRweb0ii1Rek6YUWZ5BENOBxnSscXspieUcuqdl5E3PDrym5PDqe0rn886oKZc+
         CmNY0Jk22jZgoxna1Q4Kz7t8FOHLhIAj+RVDpE3nLx6+dvYAmwzVR3xsvl7MroYNoWxM
         9KzwudQ29Le5dtRi1CBa9hVqbyuci3AeGiTWgvK16DtJwgtyBDiDtdaUNM3LrDHe5TCm
         +umUjGt/DZEspVOXxd1HEDs8l7JqzT2VNQigl/xWOFmzO98xLhGsh+M/yT18A8grLIxk
         21WwyXKzhZQMvoDWGFT7XfDhzAMWvIL364WJW/W5k4dyDD0k8Hh1uLPkxkf+9sixxEB9
         UvzQ==
X-Gm-Message-State: AJcUukcQHjuq/V8dOZQwaYTbO2l+Mfr4ptHuQVwy/iI5KLlgbM5AZ0ZG
        +VTvS2jec8aCXOLYMYFv/Vs=
X-Google-Smtp-Source: ALg8bN4vzHkoGRS3IBqHnXOrBs8QXZhH9D3iLp3dOkt1tolS70IbeaO63IDlAgo1Sz3Pja/MXnZABg==
X-Received: by 2002:a63:b4c:: with SMTP id a12mr29026601pgl.131.1548084873500;
        Mon, 21 Jan 2019 07:34:33 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d16sm15512081pgj.21.2019.01.21.07.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:34:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clocksource: decrement reference count when device_register() fail
Date:   Mon, 21 Jan 2019 10:34:31 -0500
Message-Id: <20190121153431.24789-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() may fail, use put_device() giving up the refconut
to avoid refcount leak.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/time/clocksource.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3bcc19ceb073..0a830fedc7ef 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1183,8 +1183,11 @@ static int __init init_clocksource_sysfs(void)
 {
 	int error = subsys_system_register(&clocksource_subsys, NULL);
 
-	if (!error)
+	if (!error) {
 		error = device_register(&device_clocksource);
+		if (error)
+			put_device(&device_clocksource);
+	}
 
 	return error;
 }
-- 
2.17.0

