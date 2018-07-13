Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8055ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB89208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="sudOSFu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB89208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeGMJDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:03:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40316 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbeGMJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so4790630pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9UPgCz6mZo/gxq+gky8+iGIL7r/BsjwIOVVAtPdduZU=;
        b=sudOSFu+iPbvmfmVsR6CboCibaBXyd1Q0XQ5tCqJDqVJGqThBzcUQdQERbTbVqjhgb
         XqvB+yd3flPd9508/STdYDRDs/LFYLFDtv06YA7qczXWY1diePGVL732Caodrl3EMDlu
         8fQ5adQwCu7Y+usyW348C9dtE4eOjY/rouOeE/tU4biyd1wXAP2huWAe/cqDpQClSEx+
         BDjbXlm9hg5VOz2YChDy5vN+F6MfGTq1/82rMRp+0AlhL+b5VkNT+qaZm1N+4fIeWUZX
         BPlSKRdfuWyYuEaNy//l+j9BBOqwbrgbVG/KPvAPKkXYxpqTy/zeX1/k1Ol3tNf3519L
         Hkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UPgCz6mZo/gxq+gky8+iGIL7r/BsjwIOVVAtPdduZU=;
        b=S3TDnEdmHPn8SBP0VWR14eGRqbC5tV+42wThEucqCCRDtfQPZM/FKRShzYXg/p4jUO
         J9FXu5+M4ASC9xs1BlbL9OMq7DrW23bTXqm3ew4NnLH4Hq0PQga2CBtZdTBxNb5MCCkt
         5rahKXC0VCY+caHvXy8wniGUuoWwONQjqHWmHUNgQoALEYcS4xU+k5EkAp3sd4306kNK
         7+VbhCpYXkDcjF9vA/XbwodvVdQ7yEG9wmTwpGtZB9rvFRYNocnwtXYptuhiUn8rYQwK
         hK0TZeiDNnibEosoxhdokrC+QOn6S5IAIIS3mAiCw30sXXv0jIgWsuohq0pfD9Va4m0d
         Sv2A==
X-Gm-Message-State: AOUpUlGYTM6bSg1tm4rZPm9qjIyjDz9IRACsxDm7Iz5uuTcQ3gQAYt5q
        BNyyD3Wus1FE7h1kKNJUhm0N9Q==
X-Google-Smtp-Source: AAOMgpdsZrkKH/SNjeAaiZTAQEJtqAYahuc7Ns0MvTNbnZIoxUGJD1EOxWdImePr570MfSlrl834vQ==
X-Received: by 2002:a63:107:: with SMTP id 7-v6mr5177447pgb.289.1531471783133;
        Fri, 13 Jul 2018 01:49:43 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d18-v6sm569357pgo.74.2018.07.13.01.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:49:41 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 08/10] lightnvm: pblk: mark expected switch fall-through
Date:   Fri, 13 Jul 2018 10:48:43 +0200
Message-Id: <20180713084845.19511-9-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index b829460fe827..00984b486fea 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -264,6 +264,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 	switch (type) {
 	case PBLK_WRITE:
 		kfree(((struct pblk_c_ctx *)nvm_rq_to_pdu(rqd))->lun_bitmap);
+		/* fall through */
 	case PBLK_WRITE_INT:
 		pool = &pblk->w_rq_pool;
 		break;
-- 
2.11.0

