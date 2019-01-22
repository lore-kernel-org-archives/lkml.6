Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3A9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588A3218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548149094;
	bh=pkOI/H7W1wMnCfOjPyihp+vGTd0TKHnCGrd+N94Ka98=;
	h=Subject:To:From:Date:List-ID:From;
	b=fLkC51tneBJKjmKIMGvFnVBt0zYnOR1F6NLzDyDqZOKDAMy5Vul3fVBgI3/J5GDaG
	 O4X3WYfEOskLc9Q62uzyYikspAUWl+/fWOFRTgw+qUePWd/cJ3f0J2/ED/MwVak08l
	 EhnGhss6We0cQsy5HVtruYJsA1R2avO4wHeawzfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfAVJYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbfAVJYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7D33218DE;
        Tue, 22 Jan 2019 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548149087;
        bh=pkOI/H7W1wMnCfOjPyihp+vGTd0TKHnCGrd+N94Ka98=;
        h=Subject:To:From:Date:From;
        b=O1s5Wj1Zurth3RR86dsrHa7ZlE3E4CzH+124+NwcYmPe0qHMS+0kzwopV3yUNFPQ0
         jJPvqTs9f4nR8kvI4ZHDvv0CwXhw2mbQWO+Oa/dlClB3RVzqQgHE5xJIcO5V+fJONq
         Ve5OxT+6BY0Pem8qaHFas9JQP9GCuh76gLScTx+0=
Subject: patch "tools/firmware/ihex2fw: Simplify next record offset calculation" added to driver-core-testing
To:     andrew.smirnov@gmail.com, akpm@linux-foundation.org,
        cphealy@gmail.com, dwmw2@infradead.org, gregkh@linuxfoundation.org,
        kyle@kernel.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 22 Jan 2019 10:24:41 +0100
Message-ID: <154814908160235@kroah.com>
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
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

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


