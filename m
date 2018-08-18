Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD3C04AB9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A071F2184F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Xm0fv4r0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A071F2184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHRQYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:24:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39255 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeHRQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:24:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so5975151edi.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D7oXOxxmQ9KS+RC9cc76gsLhDweYQpKJU+2dWhr84Tk=;
        b=Xm0fv4r0OjBDk4CDWcCcC4kadgGs0r/iPRUy3MzRjPpY3bfHqD4Ru17J+6FOWgtGAQ
         M4T2rveCoL9j8MlcnMvMXZB//Gus2ZH9z/5y9tOZEOx8XIe+A+rQgeQPx//MjIy2XY+O
         eUNYmk6sUBadB364CIy18D3PjvO2niTfQyKDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D7oXOxxmQ9KS+RC9cc76gsLhDweYQpKJU+2dWhr84Tk=;
        b=keoSvigJ7E0i3dz6YGaqz88GCFh7rGOZioVgFvNeYjVlruXItEb8Qhh9bFbTcaH45K
         mc407Ns0JwhVmppeuz8adKVqy9zu7IZaKzmBJ5GY38E7V4UHyxqoWThnamlY4kHbEJl5
         wxzVBZrK14mzjf1eCE35sc600o6HOcgT6oZfrhB+Esvcv2Z5kPTrH8LZrBysev2LXkcN
         0hKQkttcOErlGElZJK5MRKzrnxSLKMWNPvyLJlZ6zg1OSy6ZHPHPVOWgqExKgTlq7F8k
         xAV9k6oGPDuUL67UlsNkenmwyep58NCzC4gc/mYw3uljepNkjWurQC9lPOLANeoq+YlW
         VvLQ==
X-Gm-Message-State: AOUpUlFoRh5QMBNLPtHJ6DFCSySoaKhbQDV7vw3a6mudIIV+P/du89mH
        GV3eRSQocBX3o/levKhNYqdl3w==
X-Google-Smtp-Source: AA+uWPzRE8INV8KxRIrIk2qdsB8uazdbXl+FJVGApGpYisDgojbM1pIqzlzQWPVNqY1I9CYPrt3E+Q==
X-Received: by 2002:a50:976d:: with SMTP id d42-v6mr47306928edb.153.1534598193256;
        Sat, 18 Aug 2018 06:16:33 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id r11-v6sm2821403edp.60.2018.08.18.06.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:16:32 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] linux/bitmap.h: relax comment on compile-time constant nbits
Date:   Sat, 18 Aug 2018 15:16:21 +0200
Message-Id: <20180818131623.8755-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not clear what's so horrible about emitting a function call to
handle a run-time sized bitmap. Moreover, gcc also emits a function call
for a compile-time-constant-but-huge nbits, so the comment isn't even
accurate.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/bitmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index e34c361f4a92..3f0cac3aedca 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -28,8 +28,8 @@
  * The available bitmap operations and their rough meaning in the
  * case that the bitmap is a single unsigned long are thus:
  *
- * Note that nbits should be always a compile time evaluable constant.
- * Otherwise many inlines will generate horrible code.
+ * The generated code is more efficient when nbits is known at
+ * compile-time and at most BITS_PER_LONG.
  *
  * ::
  *
-- 
2.16.4

