Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF11C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EF120685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/ELlh1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfBTIhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:37:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42806 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfBTIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:37:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so16903736lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kGc2Cd4sVzbxMZBKfCCn20jYLojVNMmuJ1uQuDd9OoY=;
        b=S/ELlh1GSFPyd7a01ReujYHYB4oUtNvQM0mjRFi9Fhn1yJOYorz4ubdoNxShRuzz0L
         siR0cTjoBvhn7SqR7m3q1T8zwR+VrOg+YKVqgkIj/RZZjRE0t93RYBSqlk/6JDHhl2lq
         SHVB3xQzXNv95hseKxtFWcqMOnv1Iq6oQ2ZNT1PHbeZkVSnaql9V/Vyrh0x9dsPfMixN
         bgixfG+bmLlfePSyWUWtN6lftgCkDVJRpka3I7AKliwWuCvxc83QQ2PbizTpBMnsWN85
         ogoW0KLRTgLQR31KN7QBqoLO45mk265MQFFn3lnWULx4U44rF3pHbS5DPDJ188xfxgRT
         t+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kGc2Cd4sVzbxMZBKfCCn20jYLojVNMmuJ1uQuDd9OoY=;
        b=cYH+HnF8OsEk2y0Zi8ij5T1KGRg+UPeKDWBQ4aX1eu5T84LKwfVIrpb5Xt9xqVy34W
         m9/aGW3cUBAQjbJwYghqgOTeSvGMrWk+DKpQRFU770duSvDx4vJcQKqjFv05uq41LV6p
         I2wLkfGTUqwYcoXIQBHt8gr5eK7rHyPddHOXGv+LmYtBczKgWSfKfR4dtoQw+bgJYzYo
         +qyLNE53mFNiu+AqGZQzJyjs2doc7YuywhMuV8PYqw8qmKVa6peubQnmbOB4EPBSNMDO
         G/bV+LauUkTVsPzbEZ+JJi/cyYDK4nQ2O79vep/XdKMjbcSLJ/dDaBcWidZG/t8y1AoI
         S6Kg==
X-Gm-Message-State: AHQUAuanUkd+/5tARDnxHNZjgrBDSmrRNdgmeOnFZhWaEie4zjKI28kC
        2HX4Y0ubI29LdOMCV1sEBLg=
X-Google-Smtp-Source: AHgI3IZ5NOJaWVXJMgq+CIFGv6+YWf4lAVNtVCfEPA33BaiGZRHekC7nKU9Wl8EhjAE2erUzbgBIZA==
X-Received: by 2002:ac2:4243:: with SMTP id m3mr19062128lfl.5.1550651830605;
        Wed, 20 Feb 2019 00:37:10 -0800 (PST)
Received: from localhost ([188.162.52.148])
        by smtp.gmail.com with ESMTPSA id q15sm1982118lje.89.2019.02.20.00.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 00:37:09 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 0/5] lib: rework bitmap_parselist and tests
Date:   Wed, 20 Feb 2019 11:36:59 +0300
Message-Id: <20190220083705.14050-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_parselist has been evolved from a pretty simple idea for long and
now lacks for refactoring. It is not structured, has nested loops and a
set of opaque-named variables. All this leads to extremely hard
understanding of the code. Once during the optimization of it I missed a
scenario which leads to kernel hangup. Tetsuo Handa spotted this and found
it simpler to rewrite the code instead fixing it. (Though, that attempt
had some flaws.)
https://lkml.org/lkml/2018/4/1/93 

Things are more complicated than they may be because bitmap_parselist()
is part of user interface, and its behavior should not change.

In this patchset 
 - __bitmap_parselist() is reworked (patches 2 and 3);
 - time measurement in test_bitmap_parselist switched to ktime_get
   (patch 4);
 - new tests introduced (patch 5), and
 - bitmap_parselist_user() testing enabled with the same testset as
   bitmap_parselist() (patch 6).

Patch 1 is a fix and may be applied separately.

V1: https://lkml.org/lkml/2018/12/23/50
v2: - use PTR_ERR() and ERR_PTR() where appropriate;
    - fix parser logic (last byte of string handling);
    - tests for bitmap_parselist_user() in patch 5.

Yury Norov (4):
  bitmap_parselist: don't calculate length of the input string
  bitmap_parselist: move non-parser logic to helpers
  bitmap_parselist: rework input string parser
  lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
  lib/test_bitmap: add testcases for bitmap_parselist
  lib/test_bitmap: add tests for bitmap_parselist_user

 lib/bitmap.c      | 293 ++++++++++++++++++++++++++++++----------------
 lib/test_bitmap.c |  67 +++++++++--
 2 files changed, 245 insertions(+), 115 deletions(-)

-- 
2.17.1

