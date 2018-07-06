Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B10BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44B921C39
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44B921C39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeGFNr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:47:59 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:51107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbeGFNr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:47:58 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M250t-1gPHc73QUt-00u5NK; Fri, 06 Jul 2018 15:47:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] vsprintf: fix build warning
Date:   Fri,  6 Jul 2018 15:47:08 +0200
Message-Id: <20180706134724.563799-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:exFX8BkjFx9T5gFlSaeXLubJ36jutTdi6CjFVN55z46Flchw1jV
 +HBiBH4E+TwriMK9wd6dEApPzn0p9oQJ+IQLyG/KCXRLnIEnyM4XBa9nvql/OI8kpDzwQ+V
 hSs1PYOd3YPZWEN/WXMJeXaxg5NnIV5895Pmw5X53GwtGFzusdJna0Qf+G73hhG7Lest+Hp
 syaSyqJf1bb7+1V2HbLLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g+zjLP6kBBk=:qRTPbBj7qltEFi/6fnT1Sz
 oXlgLAWWbl9Btn6Iu2TmPY0YxjT7H1ybw4SUYVfMZt0fctycsQFqNmGrhPgKuyRkhS9XbcZo8
 IyF2uRxPQsoNiaSsJuWcQDECO4vQhOJz0QUjy1K3RcoV+iGLLZlvgSUzNIwf4/W+nqZEXHLwN
 2lrth3496ZnIYXhMkQ176qd+9zbzUfYellL3CmLmFIFEwK8IRlcsxHZYiNg/BgxV6lZqJY35h
 HiF2jssR3aXu5RM5QVdUl4biL/xmHFYvKkz6Occ+1U9voKa8zvSgGEGvHA5t/xUF/3A8s+4ov
 q29c9nxE+0x2dW7o4SLy8ZDKfPVlShbO0XZEOVLamxfQQ1XB//3/ZerQApNCmtHYQk4K0ESo9
 p0eLocxBf2v7dsk1FQL2Uj9HrmbFlqjU3PDG8iok4LV1ROwML+hkVSkxFnUAye/UW+nu1deHr
 3X5IfnQ3DCyhPVgAf0x2V+m4eM9Lj6COjHCKzeVlQ4b7y8VN5SqsnFJDFNet7wFy1Vl/juxcw
 3sQj8G3vezVXQKW1IKEZrwURekl9OmTaXLAffwgBxePpQYxA/K+O5qqLd7eqcVjHOqNTXu/AR
 HBAdnRS9zR/aEXr0tMsIfPnJKgRQdguKZtB2zQx47ySJkPT+RKHoH99jecowYbhewQSSUr2mi
 Iv9QTEbWaauzxXRyEfWCzFviIw7DNqoAQdBvI8Lj5qz4WRRWXnd0KkW/TvpAVI4YOOFs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The have_filled_random_ptr_key variable was recently removed,
but then reappeared with another patch, presumably after an
incorrect rebase:

lib/vsprintf.c:1668:13: error: 'have_filled_random_ptr_key' defined but not used [-Werror=unused-variable]

This removes it again.

Fixes: 85f4f12d5139 ("vsprintf: Replace memory barrier with static_key for random_ptr_key update")
Fixes: bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_hash")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/vsprintf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index cdc2c355dff5..5fe18ac4d37c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1665,7 +1665,6 @@ static int __init debug_boot_weak_hash_enable(char *str)
 }
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
 
-static bool have_filled_random_ptr_key __read_mostly;
 static siphash_key_t ptr_key __read_mostly;
 
 static void enable_ptr_key_workfn(struct work_struct *work)
-- 
2.9.0

