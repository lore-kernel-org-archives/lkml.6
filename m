Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A381AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AC12086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNnzF971"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AC12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbeKQJkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:40:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36654 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeKQJkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:40:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id z13-v6so26457703wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 15:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CouAVaqGMcOx3IjhpGkE85pmhWzUkfLlMsdM+zXdTQU=;
        b=oNnzF971VdC+Dq/g0s5z/fT2tpJPAAHbP1eGAEEyv4L/cjPcIIWkrmb/pLxQahDy8j
         zseCuzny8XKiyfjJT+AA7Ivn3IvYs4p9lW8FUX6pAkD+/l86XAF22RUHDf5EX00xuBQs
         MYJfikyO3Oou9ryDS3TTwUNooOWr37MhrnsYBmkn/uKZJZq+OPyRJepEP0R4TbkysnUD
         qW9CBgVMHuCfyVIM+T/6LxcR3BsIdXOAfizcgYtFynxnuZksGzw/NiRLRgVw/S5W7mHl
         1dwvM8KHhbtSSRSpb9HIiCHoczSp8KdiAizn+IXKl8lEfTXTwpMSeINVJ8XHSbRJiXkk
         xbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CouAVaqGMcOx3IjhpGkE85pmhWzUkfLlMsdM+zXdTQU=;
        b=NdiNF7Wex4LrT7uA2W51/EmBd0XspA7noEcEIKcKCagW23zoCmSqTcz5wuPi4zfq82
         l1fC82WPud2qlojkF062irnJ93+Whf7fsO9/Fsb+v5CqbZq7O5XM4NAegsuDU+CTLrUZ
         3mgrosePL1M1M8XxSG+c9VPeAoWYZ72t8J1grzckBhLo0C9oeyOinQQjqFUgl8Cebje5
         L1UjBFh/C82sHybuz/pZhbZoIod3SB6n8A1jw4/vWIzasY7uqBTP3aP93ntiFPV3v13M
         OhPG9pnZZh8Kxz7fSPrJLUGVjeso+MYVJP9wGs0Yeajtp4CCSQdmOEMnvtqRfE7Ub4RC
         InKA==
X-Gm-Message-State: AGRZ1gKOeQip4MbqnWqWbc3AycMJBtUCs8SWTLfwzhpePl6tlqaisqME
        QdH8EX4iw6e6JclMKcu21fc=
X-Google-Smtp-Source: AJdET5fCpZoKPINTPinpxUd9Dp1zCMs1Ut5aBM17ieD0J7caEKJdFzRixHAIIsGWFjt70JWfm+kNvQ==
X-Received: by 2002:adf:b6a8:: with SMTP id j40-v6mr10890046wre.55.1542410744537;
        Fri, 16 Nov 2018 15:25:44 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id 142-v6sm17212793wmt.19.2018.11.16.15.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 15:25:43 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ioannis Valasakis <code@wizofe.uk>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Jacob Feder <jacobsfeder@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     kbuild test robot <fengguang.wu@intel.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: Split line to stay in 80 characters.
Date:   Sat, 17 Nov 2018 00:24:49 +0100
Message-Id: <1542410691-25570-1-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The line is split up to stay in 80 characters-

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index c18bf31..805437f 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -485,7 +485,8 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 			 ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				>= words_to_write,
 			 fifo->write_queue_lock,
-			 (write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
+			 (write_timeout >= 0) ?
+				msecs_to_jiffies(write_timeout) :
 				MAX_SCHEDULE_TIMEOUT);
 		spin_unlock_irq(&fifo->write_queue_lock);
 
-- 
2.7.4

