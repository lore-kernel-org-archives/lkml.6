Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824DBC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509DB2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548403166;
	bh=nU25izb75dV/nXvtKcWmIReyo8rle7zA/B3cRSBCjrQ=;
	h=Subject:To:From:Date:List-ID:From;
	b=cyUXggMIuEz0NLuGru7nbskhhPlKUwh53NBmBfdLC3YvfzhVRTSqqnXhYibUOfIJK
	 D0MoYTqRO7w6j8lQU5SPbezQ93ZYR/Agh8q93g5ENYHXau7byxlXNjWW/4kH0J+U/f
	 g87OMci5BW2z7ntM32NWQCpBDmdUangsawzUimjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfAYH7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbfAYH7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:59:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C21720820;
        Fri, 25 Jan 2019 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548403161;
        bh=nU25izb75dV/nXvtKcWmIReyo8rle7zA/B3cRSBCjrQ=;
        h=Subject:To:From:Date:From;
        b=Hgcgwm+Kz9PPcNR/Fd8TdmdfCdKfmmLq5sQE00AfBkK2kmNjiCavWhQ0o72nwLNaJ
         zKE5uefAxN5w2DR4mT5ESAET4Xyi+J2oSylxMOGM92t9oNUtJRrWJa1n2ciH0cxVgD
         joHTZVhwC5SH7oq61hqjxhAOMqMpcaKRDQBMUNhE=
Subject: patch "tools/firmware/ihex2fw: Simplify next record offset calculation" added to driver-core-next
To:     andrew.smirnov@gmail.com, akpm@linux-foundation.org,
        cphealy@gmail.com, dwmw2@infradead.org, gregkh@linuxfoundation.org,
        kyle@kernel.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 25 Jan 2019 08:58:43 +0100
Message-ID: <1548403123241122@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    tools/firmware/ihex2fw: Simplify next record offset calculation

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 2ef8179bb7a6817de3fc9407ab55aa357f2d1e4d Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 20 Dec 2018 23:28:40 -0800
Subject: tools/firmware/ihex2fw: Simplify next record offset calculation

We can convert original expression for 'writelen" to use ALIGN as
follows:

    (p->len + 9) & ~3 => (p->len + 6 + 3) & ~3 => ALIGN(p->len + 6, 4)

Now, subsituting "p->len + 6" with "p->len + sizeof(p->addr) +
sizeof(p->len)" we end up with the same expression as used by kernel
couterpart in linux/ihex.h:

    ALIGN(p->len + sizeof(p->addr) + sizeof(p->len), 4)

That is a full size of the record, aligned to 4 bytes. No functional
change intended.

Cc: Chris Healy <cphealy@gmail.com>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/firmware/ihex2fw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/firmware/ihex2fw.c b/tools/firmware/ihex2fw.c
index b58dd061e978..e081cef730d8 100644
--- a/tools/firmware/ihex2fw.c
+++ b/tools/firmware/ihex2fw.c
@@ -24,6 +24,10 @@
 #include <getopt.h>
 
 
+#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))
+
 struct ihex_binrec {
 	struct ihex_binrec *next; /* not part of the real data structure */
         uint32_t addr;
@@ -259,13 +263,18 @@ static void file_record(struct ihex_binrec *record)
 	*p = record;
 }
 
+static uint16_t ihex_binrec_size(struct ihex_binrec *p)
+{
+	return p->len + sizeof(p->addr) + sizeof(p->len);
+}
+
 static int output_records(int outfd)
 {
 	unsigned char zeroes[6] = {0, 0, 0, 0, 0, 0};
 	struct ihex_binrec *p = records;
 
 	while (p) {
-		uint16_t writelen = (p->len + 9) & ~3;
+		uint16_t writelen = ALIGN(ihex_binrec_size(p), 4);
 
 		p->addr = htonl(p->addr);
 		p->len = htons(p->len);
-- 
2.20.1


