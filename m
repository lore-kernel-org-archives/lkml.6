Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01FBECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A8A20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTbMPfVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A8A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeGVXtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:49:10 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46213 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGVXtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:49:10 -0400
Received: by mail-yw0-f194.google.com with SMTP id e23-v6so6208766ywe.13;
        Sun, 22 Jul 2018 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsGY5Xm7ad3vCnkvV8VamiJD2mq8jlETWmIgK5C+DK4=;
        b=JTbMPfVNjIHxByWruG4iK+9Bzb527YebkanHgHVzIzaqHgfsE9doA2tlUwnS4qYJOd
         JD9d+S2/EcYD0z1DMV4w2Qmlh8VdmC9WZI8QTQlhnWQjeYJbNan6IFGmG7bKQ1Dk84NG
         0btbDo3Dtq0JC1bTU3S/rP/mVtv+o0ZQYqFHa5PuzJk9sOPHuCCYLImhwyrwfJmzLyDF
         4mrvVmTgVKjo4irrXLijoyan2aILPTzlR75lE3kjWu7e+xE6fyvWJSw+JxpldRmczJSz
         UpOdY7CbKVSzkfTYXy/5UZSID3UqDMEGQHQaNXQxUyqqfI1m0Py+4/ymIGCK9jtkrNgB
         +enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsGY5Xm7ad3vCnkvV8VamiJD2mq8jlETWmIgK5C+DK4=;
        b=etc18owZTZ7tNex+aAvT5tNq7USXCkvHS/mIfb7ikqKCbjBjnYWg0wfBGja9cZV7U0
         VVmeUCJesPgjDSUofbqctCZTBH525tXA/XHivgWOSUIP1W6yJtrBeLEwEi1cZfg243bJ
         jSWpUxwQf6pMlO/MpZj6b4OPqZLFzkdogrfbVc9KES+LgLitlObwEATynqHj6nJVChz/
         ap5pOa1rHE/xxRh8aS8krW2IxiRzJfR0K6wZQpliSZeRzUsadsd7TJhS7zfyYBU0Mu1S
         OJYR5CPIIWjVV2IdJs1XTS3CQM5FRTlrBS9o84/7WKJt/7jCPU6UoKYdElhQQZuZ2GiZ
         szSw==
X-Gm-Message-State: AOUpUlGxwqlZnK3vEaClCIn4hF/i1M8nm86nVEe+AFGhK9qx/B9xLvmJ
        gLsTPDPeWobdN2R2KSIYYJ0=
X-Google-Smtp-Source: AAOMgpdEMMg0A4i0ksQBcG+zWaQXJV0dgNIBkiqLF+jKx21ILsUJwRtuI8fJNUTLUP2hyHGjCV8BCw==
X-Received: by 2002:a0d:cd06:: with SMTP id p6-v6mr5314989ywd.44.1532299851762;
        Sun, 22 Jul 2018 15:50:51 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id 134-v6sm3829153ywq.66.2018.07.22.15.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:50:51 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 04/11] iio: 104-quad-8: Update license boilerplate
Date:   Sun, 22 Jul 2018 18:50:45 -0400
Message-Id: <0dbd90bb4f6e92d263e9e41e12a1662eed16c52c.1532298882.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the boilerplate license text by making use of a
SPDX license identifier line.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index 92be8d0f7735..72b6352e09f0 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IIO driver for the ACCES 104-QUAD-8
  * Copyright (C) 2016 William Breathitt Gray
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
  * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
  */
 #include <linux/bitops.h>
-- 
2.18.0

