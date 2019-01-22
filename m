Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A476C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A0A218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548149104;
	bh=0eBPhqV+QY8H/+vRW93zrXRI0S+oLIFcI56mTmyrljw=;
	h=Subject:To:From:Date:List-ID:From;
	b=G1cXt3gOjs+FkdIwR6X2Djow9wYl2mVwTkdSB0wg6Gv7TI3ZFTSQtFIiHt5Thhtmo
	 /jQdP4xhpKotgGccxJiiWXfxN1XFh3TjVOGu6zZ4XIHjaJw3FY0T5fCY6lVdCBLVad
	 j6A4izoryo4wA2Php+e9noMpuWCYX1PClCAsITSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfAVJYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfAVJYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B11218D9;
        Tue, 22 Jan 2019 09:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548149090;
        bh=0eBPhqV+QY8H/+vRW93zrXRI0S+oLIFcI56mTmyrljw=;
        h=Subject:To:From:Date:From;
        b=W2WR/nR2I4TrLzcSosSbcLZTaKDqJSWPypYS2Oxz8qZDzXeruWr5fY9YJ2liCl3/R
         z2OPh/z5wpnbp31OYDIXbnbJ6pM0HHu/cxdI8HMlwDbojKynk+EOEdOYwF8gqz6kX7
         CTzF7lJCpFJ6NtqOzmKL9SsIa/kENxhClB+hgl1Q=
Subject: patch "ihex: Simplify next record offset calculation" added to driver-core-testing
To:     andrew.smirnov@gmail.com, akpm@linux-foundation.org,
        cphealy@gmail.com, dwmw2@infradead.org, gregkh@linuxfoundation.org,
        kyle@kernel.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 22 Jan 2019 10:24:40 +0100
Message-ID: <1548149080187105@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    ihex: Simplify next record offset calculation

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 9fb4ab4d3dd665a62da9c176a89e7c7feaf5d9e4 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 20 Dec 2018 23:28:39 -0800
Subject: ihex: Simplify next record offset calculation

Next record calucaltion can be reduced to a much more tivial ALIGN
operation as follows:

1. Splitting 5 into 2 + 3 we get

   next = ((be16_to_cpu(rec->len) + 2 + 3) & ~3) - 2            (1)

2. Using ALIGN macro we reduce (1) to:

   ALIGN(be16_to_cpu(rec->len) + 2, 4) - 2                      (2)

3. Subsituting 'next' in original next record calucation we get:

   (void *)&rec->data[ALIGN(be16_to_cpu(rec->len) + 2, 4) - 2]  (3)

4. Converting array index to pointer arithmetic we convert (3) into:

   (void *)rec + sizeof(*rec) +
   	 ALIGN(be16_to_cpu(rec->len) + 2, 4) - 2		(4)

5. Subsituting sizeof(*rec) with its value, 6, and substracting 2,
   in (4) we get:

   (void *)rec + ALIGN(be16_to_cpu(rec->len) + 2, 4) + 4        (5)

6. Since ALIGN(X, 4) + 4 == ALIGN(X + 4, 4), (5) can be converted to:

   (void *)rec + ALIGN(be16_to_cpu(rec->len) + 6, 4)            (6)

5. Subsituting 6 in (6) to sizeof(*rec) we get:

   (void *)rec + ALIGN(be16_to_cpu(rec->len) + sizeof(*rec), 4) (7)

Using expression (7) should make it more clear that next record is
located by adding full size of the current record (payload + auxiliary
data) aligned to 4 bytes, to the location of the current one. No
functional change intended.

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
 include/linux/ihex.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/ihex.h b/include/linux/ihex.h
index 9130f307a420..98cb5ce0b0a0 100644
--- a/include/linux/ihex.h
+++ b/include/linux/ihex.h
@@ -21,14 +21,18 @@ struct ihex_binrec {
 	uint8_t data[0];
 } __attribute__((packed));
 
+static inline uint16_t ihex_binrec_size(const struct ihex_binrec *p)
+{
+	return be16_to_cpu(p->len) + sizeof(*p);
+}
+
 /* Find the next record, taking into account the 4-byte alignment */
 static inline const struct ihex_binrec *
 __ihex_next_binrec(const struct ihex_binrec *rec)
 {
-	int next = ((be16_to_cpu(rec->len) + 5) & ~3) - 2;
-	rec = (void *)&rec->data[next];
+	const void *p = rec;
 
-	return rec;
+	return p + ALIGN(ihex_binrec_size(rec), 4);
 }
 
 static inline const struct ihex_binrec *
-- 
2.20.1


