Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 03:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A47C205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 03:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nin1SMbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A47C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeGUETf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 00:19:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46570 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeGUETe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 00:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Qp2jh889yvdk+j4ZAqNBNaX/aSFM2S+2qivQ5jXdfQ=; b=nin1SMbBCky2YF4GRn148KzczV
        oCD8Orat0zZ23eeo0m6zfx0fwp5AJozTn32AZA5yjuLCA19BDK4lqrwOk522MBdHmEqPH+I3TkVhq
        ujKyvNhM6TelqzKcqOOOsunI3jL49T9SIRmdtimbbn2kAxeewhCrGyMoq/MExIRUNzJSQQaJuNxm3
        EQFYqnKhDR5ePSNxgSyMw9DyOp63Nj8btzMOU8Kv9lzlDHtebjYqE3kKbQXFDwm43rs3GWvh2svEC
        FlGfmgRYQDI/0w73sUcQxUaTjdPJOqckTC3RDx10cuGCx0VWYwPUuTz3yPtYdkRDBgsS5rt4BzKYO
        mY5Nn1Hg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgiZG-0001OC-2G; Sat, 21 Jul 2018 03:28:28 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/h8300: modify ffs(), fls() etc. functions to return int
Message-ID: <1cdcd8e1-b12c-31cb-1188-c062dae3e461@infradead.org>
Date:   Fri, 20 Jul 2018 20:28:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
printk format build warning.  This is due to hexagon's ffs() being
coded as returning long instead of int.

Fix the printk format warning by changing all of hexagon's ffx() and
flx() functions to return int instead of long.  The variables that
they return are already int instead of long.

../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]


There are no ffx() or flx() allmodconfig build errors after making this
change.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/hexagon/include/asm/bitops.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20180717.orig/arch/hexagon/include/asm/bitops.h
+++ linux-next-20180717/arch/hexagon/include/asm/bitops.h
@@ -194,7 +194,7 @@ static inline int __test_bit(int nr, con
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
-static inline long ffz(int x)
+static inline int ffz(int x)
 {
 	int r;
 
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline long fls(int x)
+static inline int fls(int x)
 {
 	int r;
 
@@ -232,7 +232,7 @@ static inline long fls(int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline long ffs(int x)
+static inline int ffs(int x)
 {
 	int r;
 
@@ -254,7 +254,7 @@ static inline long ffs(int x)
  * bits_per_long assumed to be 32
  * numbering starts at 0 I think (instead of 1 like ffs)
  */
-static inline unsigned long __ffs(unsigned long word)
+static inline int __ffs(unsigned long word)
 {
 	int num;
 
@@ -272,7 +272,7 @@ static inline unsigned long __ffs(unsign
  * Undefined if no set bit exists, so code should check against 0 first.
  * bits_per_long assumed to be 32
  */
-static inline unsigned long __fls(unsigned long word)
+static inline int __fls(unsigned long word)
 {
 	int num;
 


