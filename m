Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD0C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371D020652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371D020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJHSUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:20:04 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:47164 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeJHSUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:20:04 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id kz8p1y00D3XaVaC01z8pPY; Mon, 08 Oct 2018 13:08:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TP7-00052p-7D; Mon, 08 Oct 2018 13:08:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TP7-0006gQ-5Z; Mon, 08 Oct 2018 13:08:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Tobin C . Harding" <me@tobin.cc>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] doc: printk-formats: Remove bogus kobject references for device nodes
Date:   Mon,  8 Oct 2018 13:08:48 +0200
Message-Id: <20181008110848.25648-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When converting from text to rst, the kobjects section and its sole
subsection about device tree nodes were coalesced into a single section,
yielding an inconsistent result.

Remove all references to kobjects, as
  1. Device tree object pointers are not compatible to kobject pointers
     (the former may embed the latter, though), and
  2. there are no printk formats defined for kobject types.

Update the vsprintf() source code comments to match the above.

Fixes: b3ed23213eab1e08 ("doc: convert printk-formats.txt to rst")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/core-api/printk-formats.rst |  6 +++---
 lib/vsprintf.c                            | 20 +++++++++-----------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index d39798c2558500d5..ff48b55040ef5acf 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -376,15 +376,15 @@ correctness of the format string and va_list arguments.
 
 Passed by reference.
 
-kobjects
---------
+Device tree nodes
+-----------------
 
 ::
 
 	%pOF[fnpPcCF]
 
 
-For printing kobject based structs (device nodes). Default behaviour is
+For printing device tree node structures. Default behaviour is
 equivalent to %pOFf.
 
 	- f - device node full_name
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a3dc15c89c217b79..9a8876bfa1e06592 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1840,17 +1840,15 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
  *       p page flags (see struct page) given as pointer to unsigned long
  *       g gfp flags (GFP_* and __GFP_*) given as pointer to gfp_t
  *       v vma flags (VM_*) given as pointer to unsigned long
- * - 'O' For a kobject based struct. Must be one of the following:
- *       - 'OF[fnpPcCF]'  For a device tree object
- *                        Without any optional arguments prints the full_name
- *                        f device node full_name
- *                        n device node name
- *                        p device node phandle
- *                        P device node path spec (name + @unit)
- *                        F device node flags
- *                        c major compatible string
- *                        C full compatible string
- *
+ * - 'OF[fnpPcCF]'  For a device tree object
+ *                  Without any optional arguments prints the full_name
+ *                  f device node full_name
+ *                  n device node name
+ *                  p device node phandle
+ *                  P device node path spec (name + @unit)
+ *                  F device node flags
+ *                  c major compatible string
+ *                  C full compatible string
  * - 'x' For printing the address. Equivalent to "%lx".
  *
  * ** When making changes please also update:
-- 
2.17.1

