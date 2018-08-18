Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B6C41536
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9B12184F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LdbaQBlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9B12184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeHRQYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:24:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34075 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:24:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id h1-v6so5981185eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MsP5XEX80h3V1E1JTLseW+1xxbWnnezrvkrmyDUenmw=;
        b=LdbaQBlvpCblJU9PqM59Zre7RjrSRt4h/VOevExvSQTCJd2GTKkVPI30Xz9rnfGuQv
         DpidolYclIxsFhcCTMeEhH61GpbgbclFIB46yuH2bfPX66d2cxg0NPW/hBAdA938u9ub
         XT1HzvKmsbTzNIdW0XAHskC/RHzUmHY7ayp14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MsP5XEX80h3V1E1JTLseW+1xxbWnnezrvkrmyDUenmw=;
        b=kISF6JuEVTp33RZ5FIo/F4WAxd56rEvrExfK3VLQtj+NmMxJPiX9Nv/mvUvPzxajWC
         NHz1lZLL4wj6mE7/Y2WDNvqWdiC21jyqf5dWLd2WREhKbSqWzVDH2dx4uFUwWDb+JCs9
         qNSYCvaD7lUdMolWeuw6aibMFGbctUMewQQ/L0RD9syE0oYXB/1m9sbgY7H+FoA+2UZh
         50Y53NoJe7wTeJQRn3osslmnLCNW4f3OusJlr7YLQbQbJAYB5lAKRS5+ejzr8lTcl/tF
         J1glsltUPUkXFKKEdK9QruhwSP40lLSoXJJ8garwRU1koxR4DjBgbG/TJ1/a/Vt1v4an
         avBw==
X-Gm-Message-State: AOUpUlFlvZHeWz03yS5sqm0nq0GGXci+6Z0ZMIX7deB7sMj3BkRUzDx6
        RDAL8XSZ4zxoTD/gPd5pSsa5Qw==
X-Google-Smtp-Source: AA+uWPzKYxgTIDQqN5IrfiV0Pvf6zbOFlfoWLGr23nVMQbZqVheur/6Q9Gz604KMJWDMpgmAY9mxuw==
X-Received: by 2002:a50:b266:: with SMTP id o93-v6mr47136999edd.173.1534598189209;
        Sat, 18 Aug 2018 06:16:29 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id r11-v6sm2821403edp.60.2018.08.18.06.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:16:28 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] lib/bitmap.c: remove wrong documentation
Date:   Sat, 18 Aug 2018 15:16:17 +0200
Message-Id: <20180818131623.8755-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This promise is violated in a number of places, e.g. already in the
second function below this paragraph. Since I don't think anybody relies
on this being true, and since actually honouring it would hurt
performance and code size in various places, just remove the paragraph.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/bitmap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 58f9750e49c6..1f73b2e52186 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -35,11 +35,6 @@
  * carefully filter out these unused bits from impacting their
  * results.
  *
- * These operations actually hold to a slightly stronger rule:
- * if you don't input any bitmaps to these ops that have some
- * unused bits set, then they won't output any set unused bits
- * in output bitmaps.
- *
  * The byte ordering of bitmaps is more natural on little
  * endian architectures.  See the big-endian headers
  * include/asm-ppc64/bitops.h and include/asm-s390/bitops.h
-- 
2.16.4

