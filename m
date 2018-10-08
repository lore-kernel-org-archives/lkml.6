Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12999C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACA42087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACA42087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeJHSQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:16:19 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:52844 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbeJHSQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:16:18 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id kz561y0023XaVaC01z56XV; Mon, 08 Oct 2018 13:05:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TLV-000517-VB; Mon, 08 Oct 2018 13:05:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TLV-0006dR-U3; Mon, 08 Oct 2018 13:05:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] lib/vsprintf: Hash printed address for netdev bits fallback
Date:   Mon,  8 Oct 2018 13:05:04 +0200
Message-Id: <20181008110504.25449-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008110504.25449-1-geert+renesas@glider.be>
References: <20181008110504.25449-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handler for "%pN" falls back to printing the raw pointer value when
using a different format than the (sole supported) special format
"%pNF", potentially leaking sensitive information regarding the kernel
layout in memory.

Avoid this leak by printing the hashed address instead.
Note that there are no in-tree users of the fallback.

Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/vsprintf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 1fb36260a44289e8..a3dc15c89c217b79 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1424,7 +1424,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 }
 
 static noinline_for_stack
-char *netdev_bits(char *buf, char *end, const void *addr, const char *fmt)
+char *netdev_bits(char *buf, char *end, const void *addr,
+		  struct printf_spec spec,  const char *fmt)
 {
 	unsigned long long num;
 	int size;
@@ -1435,9 +1436,7 @@ char *netdev_bits(char *buf, char *end, const void *addr, const char *fmt)
 		size = sizeof(netdev_features_t);
 		break;
 	default:
-		num = (unsigned long)addr;
-		size = sizeof(unsigned long);
-		break;
+		return ptr_to_id(buf, end, addr, spec);
 	}
 
 	return special_hex_number(buf, end, num, size);
@@ -1952,7 +1951,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 			break;
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
-		return netdev_bits(buf, end, ptr, fmt);
+		return netdev_bits(buf, end, ptr, spec, fmt);
 	case 'a':
 		return address_val(buf, end, ptr, fmt);
 	case 'd':
-- 
2.17.1

