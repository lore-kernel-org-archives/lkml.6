Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7012C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E85219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjK8Cq2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E85219DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeHFJSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:18:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39601 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeHFJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:18:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so6416168pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rV29wB3A1SpQtPd5Lf0CcOZw/DBq0z4Y+1VwoR46G8w=;
        b=KjK8Cq2boe4x5toDzZOqjJCTfTcKWmK//zUbHHnBl2ubQ+bJQikMKdy+QtTf6UsbFg
         BtYw6BjUyeqz65e+/h5n1sGg6GlXnIcRIznUPdlBOkkvP8kJVIRJMGLcbJe9xeMogiBt
         JsyhNBCdZNe5EXuoIfjOQFVSXhSvc2WiWWZFYSMF2Q+zyOvMJccTP4SZskVcbsGGaBHq
         Y7aNSLjh9LxYNa/+hQ6z9WqbTVDT4IxUxtY60b6U5duiTKQBmKUYiwiawyHORJT4eOHn
         bgzqU0eLLSuJDii+ge2WZ2PKkN0dPESm1FP/NtqtcqD+rhVR+ImsIi+MGt8SaJ0TniSA
         wghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rV29wB3A1SpQtPd5Lf0CcOZw/DBq0z4Y+1VwoR46G8w=;
        b=eQn1SHOOpASUuoSg9rm23FBjBrLm8mhIB15Le4+04+M4f+DQBu7pRwl6USxJa6yK0l
         RPDSziL81AjL/xpjMyG+vjnB7amqjkECvC8XB1JCLddv2WSjpAGz0VWTkxJ+165b81yU
         SUawLTm+hLxvZRqgs24+LcbU6OG+axCuYfHmJ70ipNxOBoE1hgtk5NV0hwsWxzGGln7v
         /Dw0RT/a/sx/X5NbRg6f/hZe5osjdOfwdE7u46q/1LS2eqBTfxvVix1cLXW4qYxdhGcZ
         /yhz0EkwCaYktRZzhWTpCJhjOjOWboUXli37XhvpyWK4GZwDLhlUhyS348V+kog3Wahs
         n8Ug==
X-Gm-Message-State: AOUpUlEit9kVUhmeqClYXdDFLZ/JZPE0Wi5ppKS4iZxmKQCY7qgClwWs
        0Pj6+AncuwxrIUDPtN5QPK8=
X-Google-Smtp-Source: AAOMgpcJ3qLhhfMXbKoNSMLbVTYhEWa+9wEVEG64uNbhhBANNV1clWBwuZr3eA7aD6vsZEpIvjqsHQ==
X-Received: by 2002:a62:e511:: with SMTP id n17-v6mr16018647pff.210.1533539463760;
        Mon, 06 Aug 2018 00:11:03 -0700 (PDT)
Received: from parths.sibshivalik.com ([219.65.63.222])
        by smtp.gmail.com with ESMTPSA id g28-v6sm24769269pfe.41.2018.08.06.00.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 00:11:03 -0700 (PDT)
From:   Parth Y Shah <sparth1292@gmail.com>
To:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Parth Y Shah <sparth1292@gmail.com>
Subject: [PATCH] misc: lkdtm: fixed static variable initialization
Date:   Mon,  6 Aug 2018 12:40:57 +0530
Message-Id: <1533539457-7001-1-git-send-email-sparth1292@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved "ERROR: do not initialise statics to 0"

Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
---
 drivers/misc/lkdtm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 9725aed..d8157b8 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -18,7 +18,7 @@
  * hardened usercopy checks by added "unconst" to all the const copies,
  * and making sure "cache_size" isn't optimized into a const.
  */
-static volatile size_t unconst = 0;
+static volatile size_t unconst;
 static volatile size_t cache_size = 1024;
 static struct kmem_cache *whitelist_cache;
 
-- 
2.7.4

