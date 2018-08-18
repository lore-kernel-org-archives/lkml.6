Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A54C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9552176D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Hujycri0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9552176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeHRQYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:24:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43313 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeHRQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:24:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id j21-v6so5958986edp.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=smZlwRjCau1h1UsulivlHO6z6gJHSARLxtQ/GIkK74Q=;
        b=Hujycri0SFG7ScwgGzysu78pjnajbGjD0C9oRLzpkKN8ZapElLETJvvHRudMwnmqBp
         oHMnOOgvrGK3c7AXaXaNzCv5vd6MQT4Kvel/s6JS0s/tT18XS0Ln6u+GFhLIJ+nX6RJZ
         UkBZDfZrPgl5rp3EGbC3saLQxdpZ6HtmDMNek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=smZlwRjCau1h1UsulivlHO6z6gJHSARLxtQ/GIkK74Q=;
        b=sni03qK4+jMCY1q93AJdPqF5/ZTJZ7cYy4wfneSVK86c8661WAtnuZy5kixTp9SgEU
         P1lqMfucHpYWU1U5bHSxQQdb6pJ2dSr4LEEY2Zoy9S8xlOcP47eZ0/6sctMPDc86QrxE
         qHvXPt40YO0bIwoe8FDzSl807xDwA7kZVjzpQGVvrWr0H7DCJSXUT8wHBUQBzV/YxDBr
         yz2bWn/GKBUGX5tUjILshOP4hgzGDcyaF4bXnsLjvmlMX+Hn/s0r7bCx8E/RQm6nhT4I
         SxHcIVJSuX88pBZszLPZ17ywD4uJm8SvBzj7SvGBumyjM7KHIu1GcQ2LolNouooFqQi+
         feig==
X-Gm-Message-State: AOUpUlFS29s9Ry/kk6pG7NtJ1pRrkvQE7gv7r0U2SNEJMudB4OUn/wRk
        UTWYFdut45+CAEX8usLgvLVFwGwL3EjT1A==
X-Google-Smtp-Source: AA+uWPzmQkqyjyxcg7MjLV17X2yBHieR6gfVDRCl7/UeH7tggVkpkBw/YDFKrA+0BVFvDI7h7o/aFg==
X-Received: by 2002:a50:b1f3:: with SMTP id n48-v6mr46276029edd.197.1534598188173;
        Sat, 18 Aug 2018 06:16:28 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id r11-v6sm2821403edp.60.2018.08.18.06.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:16:27 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] assorted minor bitmap patches
Date:   Sat, 18 Aug 2018 15:16:16 +0200
Message-Id: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent LKML thread had me look into bitmap.{h,c} again, and I
stumbled on/rediscovered a few things.

Rasmus Villemoes (7):
  lib/bitmap.c: remove wrong documentation
  linux/bitmap.h: handle constant zero-size bitmaps correctly
  linux/bitmap.h: remove redundant uses of small_const_nbits()
  linux/bitmap.h: fix type of nbits in bitmap_shift_right()
  linux/bitmap.h: relax comment on compile-time constant nbits
  lib/bitmap.c: fix remaining space computation in
    bitmap_print_to_pagebuf
  lib/bitmap.c: simplify bitmap_print_to_pagebuf

 include/linux/bitmap.h | 37 +++++++++++++++----------------------
 lib/bitmap.c           | 21 +++++++--------------
 2 files changed, 22 insertions(+), 36 deletions(-)

-- 
2.16.4

