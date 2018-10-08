Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F23C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022C720878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022C720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJHSQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:16:19 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:37260 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHSQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:16:18 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id kz561y00F3XaVaC06z56PH; Mon, 08 Oct 2018 13:05:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TLV-000511-Th; Mon, 08 Oct 2018 13:05:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TLV-0006dL-Sh; Mon, 08 Oct 2018 13:05:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] lib/vsprintf: Prepare for more general use of ptr_to_id()
Date:   Mon,  8 Oct 2018 13:05:02 +0200
Message-Id: <20181008110504.25449-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008110504.25449-1-geert+renesas@glider.be>
References: <20181008110504.25449-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Make the ptr argument const, to avoid adding casts in future
    callers,
  - Add a forward declaration, to avoid moving large blocks of code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/vsprintf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 095a677f89c02442..b5bf90731c5a5277 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -407,6 +407,9 @@ struct printf_spec {
 #define FIELD_WIDTH_MAX ((1 << 23) - 1)
 #define PRECISION_MAX ((1 << 15) - 1)
 
+static char *ptr_to_id(char *buf, char *end, const void *ptr,
+		       struct printf_spec spec);
+
 static noinline_for_stack
 char *number(char *buf, char *end, unsigned long long num,
 	     struct printf_spec spec)
@@ -1714,7 +1717,8 @@ static int __init initialize_ptr_random(void)
 early_initcall(initialize_ptr_random);
 
 /* Maps a pointer to a 32 bit unique identifier. */
-static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
+static char *ptr_to_id(char *buf, char *end, const void *ptr,
+		       struct printf_spec spec)
 {
 	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
 	unsigned long hashval;
-- 
2.17.1

