Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8352C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E8B2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ukCMbb6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfA0Uc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:32:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50816 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA0Uc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:32:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so11851768wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 12:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D8JT6hyWHXwusno3V05RF2t12TrCsleWDgqZTAqYmd8=;
        b=ukCMbb6GtV86dnO3O5Hs2/WPvXVZ18nbYaNDVzgEMa1NGJih1NDKQp5xeENHigXclM
         pCm6G7iek0xr464gYC2yCWYY+gJkEONBo+2eXrEm5ERBK/PfOZMaWErLFNwOX28/iUvN
         V3fk2oZwDc39jg2LgSCTwV6Ztrc98ByZn97Wid+dV+adrsfe+Ds0dgdtO7ULSVJjV6F/
         njZozhHvGAp5r27/RVr07tcv+1JWoi0BN0qhbHtG79psAROpkWDuma+B7/nbOSw2koem
         ZO9Z9PhbNQiBOiFLaov7mjD05XPEdU6NfywuL6uBaFFRPPrIcMH29fOT9psiubPDHmps
         s7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D8JT6hyWHXwusno3V05RF2t12TrCsleWDgqZTAqYmd8=;
        b=eiidGDDx9p+8fTQ5S1NIKiZhrx+d0sAEppgWOlNVBoP0mEp3njxmKW7UKXWRkPDaU3
         lzqkmS8rw53nz7QR0dABL0LgBrkADaiN7OR25c7yC5Si/1rOvw4kyWBeDPSi1YBQzsww
         B97ouDzbp6rwZIXxfSTzvUPRK2HX86AssRVcL9hAPFj6mv91rVxiKSwzNJh2+vWq7bOB
         DVLgzz366jR0kOvrFlJ9kKZ/uE5veinBdmPQO+RrHfpbbqTx7cY+QFOyQ1ZyURlPrZLm
         rUlub5ssXq96UU8Trs9pgx1C/sL2KgJI2EX4RrnQgdv4U9lL/h+Vx5uJzbJzgPaDZgFQ
         xppw==
X-Gm-Message-State: AJcUukfcpTi/ihY5oV7aoQrXhBvldYHE/XBFGhP6EJUYm+QSbM0KfgW2
        gHsfDULUY1jmH8t5uMDhDaSrQ5Bf5gZ+3g==
X-Google-Smtp-Source: ALg8bN6aK6vOa87pSC7oZhJpQOIixbVul8fAewD4fKxyaVrAHK9E4O4io+ZIJ1CQLNBZWoOwsngDMw==
X-Received: by 2002:a1c:a6c2:: with SMTP id p185mr13117275wme.133.1548621174505;
        Sun, 27 Jan 2019 12:32:54 -0800 (PST)
Received: from winie.fritz.box (i59F4FF78.versanet.de. [89.244.255.120])
        by smtp.gmail.com with ESMTPSA id k128sm100195726wmd.37.2019.01.27.12.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 12:32:53 -0800 (PST)
From:   Florian La Roche <florian.laroche@googlemail.com>
X-Google-Original-From: Florian La Roche <Florian.LaRoche@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Florian La Roche <Florian.LaRoche@gmail.com>
Subject: [PATCH v2 1/1] int_sqrt() adjustments
Date:   Sun, 27 Jan 2019 21:32:39 +0100
Message-Id: <20190127203239.973-1-Florian.LaRoche@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __attribute_const__ and use normal ints for the right param of "<<".

Signed-off-by: Florian La Roche <Florian.LaRoche@gmail.com>
---
 include/linux/kernel.h | 4 ++--
 lib/int_sqrt.c         | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e250a7..df03a3cca309 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -513,10 +513,10 @@ extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
 
-unsigned long int_sqrt(unsigned long);
+__attribute_const__ unsigned long int_sqrt(unsigned long);
 
 #if BITS_PER_LONG < 64
-u32 int_sqrt64(u64 x);
+__attribute_const__ u32 int_sqrt64(u64 x);
 #else
 static inline u32 int_sqrt64(u64 x)
 {
diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 30e0f9770f88..fd249238fd31 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -16,14 +16,14 @@
  *
  * Computes: floor(sqrt(x))
  */
-unsigned long int_sqrt(unsigned long x)
+__attribute_const__ unsigned long int_sqrt(unsigned long x)
 {
 	unsigned long b, m, y = 0;
 
 	if (x <= 1)
 		return x;
 
-	m = 1UL << (__fls(x) & ~1UL);
+	m = 1UL << (__fls(x) & ~1);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
@@ -45,14 +45,14 @@ EXPORT_SYMBOL(int_sqrt);
  * is expected.
  * @x: 64bit integer of which to calculate the sqrt
  */
-u32 int_sqrt64(u64 x)
+__attribute_const__ u32 int_sqrt64(u64 x)
 {
 	u64 b, m, y = 0;
 
 	if (x <= ULONG_MAX)
 		return int_sqrt((unsigned long) x);
 
-	m = 1ULL << ((fls64(x) - 1) & ~1ULL);
+	m = 1ULL << ((fls64(x) - 1) & ~1);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
-- 
2.17.1

