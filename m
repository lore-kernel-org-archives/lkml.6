Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452C6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED08F224C5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ijvGxj9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED08F224C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeGCTzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:55:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34542 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbeGCTzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:55:02 -0400
Received: by mail-pg0-f65.google.com with SMTP id y5-v6so1438084pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=v6ZpNerl9EQJMOOMYOxMbHrmgDCVLx18mqFWGIweoXw=;
        b=ijvGxj9s9Dl4jRKHyZluqzir7cb2WLfHYFEf/+7QjWZo71IUdgVHERXw1P7SCTAIaw
         4gRAnB9UvMCGpFM4ntI82mhea060AR/cMJG14hwtTsC0rh7h0QLTyB5zsuojxK9NWeYe
         wcJ49Vf3g3nEpi+H+E5swfLDOnEZMV1Kl1I98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=v6ZpNerl9EQJMOOMYOxMbHrmgDCVLx18mqFWGIweoXw=;
        b=LQuKJ1ExUdaHmVG2aDDyi8h3cj7vyz/4mxx8fGwS8bnghnMRKrfQBCh8fr6iFFyhG7
         aIyjDFhVSyJtBDEiZ6jJT9w/YoJPmh5UuBxf/UC/mMe81pEbBA7+8XcPgkGolyd9zSqq
         c1fPRegYAwZEy4hAjYyBWh6adnepyPeqqTJigc8EsNHjQ/f17v0I7FPRDfAA2DOcgteA
         kYyg/SMbz8fsq4NCLlRqr6uccD4lO3ASIzVowpeODGF6nGUgjHiMVj5Km1ubaFzo22BN
         H4pVotwIAFr/oQY3sWzDxuBYd8oFb3gUdgR3u9wMt/vCpvritZmGLaGcqbxlqy52xBNK
         a2vw==
X-Gm-Message-State: APt69E1GH798HPrOXvbpOsC8/h6lltbRnSoZMyIX42kPl5TAzttKexwQ
        pF7Bu+MdFaKYOYVY3sX+ZG/E0w==
X-Google-Smtp-Source: AAOMgpdEIiSK/DiLP//nlJRAm+Mw8xja6ha8nIJJbur1N33PSiGS7gg4y7eEQHfqs3SlyKpkLhONYA==
X-Received: by 2002:a65:4acd:: with SMTP id c13-v6mr21968686pgu.436.1530647701682;
        Tue, 03 Jul 2018 12:55:01 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a25-v6sm3202754pgv.51.2018.07.03.12.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 12:55:00 -0700 (PDT)
Date:   Tue, 3 Jul 2018 12:54:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH] RAID/s390: Remove VLA usage
Message-ID: <20180703195459.GA11107@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this moves
the "$#" replacement from being an argument to being inside the function,
which avoids generating VLAs.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Resend due to typo in To/Cc
---
 lib/raid6/s390vx.uc | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/lib/raid6/s390vx.uc b/lib/raid6/s390vx.uc
index 140fa8bb5c23..914ebe98fc21 100644
--- a/lib/raid6/s390vx.uc
+++ b/lib/raid6/s390vx.uc
@@ -55,22 +55,24 @@ static inline void XOR(int x, int y, int z)
 	asm volatile ("VX %0,%1,%2" : : "i" (x), "i" (y), "i" (z));
 }
 
-static inline void LOAD_DATA(int x, int n, u8 *ptr)
+static inline void LOAD_DATA(int x, u8 *ptr)
 {
-	typedef struct { u8 _[16*n]; } addrtype;
+	typedef struct { u8 _[16 * $#]; } addrtype;
 	register addrtype *__ptr asm("1") = (addrtype *) ptr;
 
 	asm volatile ("VLM %2,%3,0,%r1"
-		      : : "m" (*__ptr), "a" (__ptr), "i" (x), "i" (x + n - 1));
+		      : : "m" (*__ptr), "a" (__ptr), "i" (x),
+			  "i" (x + $# - 1));
 }
 
-static inline void STORE_DATA(int x, int n, u8 *ptr)
+static inline void STORE_DATA(int x, u8 *ptr)
 {
-	typedef struct { u8 _[16*n]; } addrtype;
+	typedef struct { u8 _[16 * $#]; } addrtype;
 	register addrtype *__ptr asm("1") = (addrtype *) ptr;
 
 	asm volatile ("VSTM %2,%3,0,1"
-		      : "=m" (*__ptr) : "a" (__ptr), "i" (x), "i" (x + n - 1));
+		      : "=m" (*__ptr) : "a" (__ptr), "i" (x),
+			"i" (x + $# - 1));
 }
 
 static inline void COPY_VEC(int x, int y)
@@ -93,19 +95,19 @@ static void raid6_s390vx$#_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	q = dptr[z0 + 2];	/* RS syndrome */
 
 	for (d = 0; d < bytes; d += $#*NSIZE) {
-		LOAD_DATA(0,$#,&dptr[z0][d]);
+		LOAD_DATA(0,&dptr[z0][d]);
 		COPY_VEC(8+$$,0+$$);
 		for (z = z0 - 1; z >= 0; z--) {
 			MASK(16+$$,8+$$);
 			AND(16+$$,16+$$,25);
 			SHLBYTE(8+$$,8+$$);
 			XOR(8+$$,8+$$,16+$$);
-			LOAD_DATA(16,$#,&dptr[z][d]);
+			LOAD_DATA(16,&dptr[z][d]);
 			XOR(0+$$,0+$$,16+$$);
 			XOR(8+$$,8+$$,16+$$);
 		}
-		STORE_DATA(0,$#,&p[d]);
-		STORE_DATA(8,$#,&q[d]);
+		STORE_DATA(0,&p[d]);
+		STORE_DATA(8,&q[d]);
 	}
 	kernel_fpu_end(&vxstate, KERNEL_VXR);
 }
@@ -127,14 +129,14 @@ static void raid6_s390vx$#_xor_syndrome(int disks, int start, int stop,
 
 	for (d = 0; d < bytes; d += $#*NSIZE) {
 		/* P/Q data pages */
-		LOAD_DATA(0,$#,&dptr[z0][d]);
+		LOAD_DATA(0,&dptr[z0][d]);
 		COPY_VEC(8+$$,0+$$);
 		for (z = z0 - 1; z >= start; z--) {
 			MASK(16+$$,8+$$);
 			AND(16+$$,16+$$,25);
 			SHLBYTE(8+$$,8+$$);
 			XOR(8+$$,8+$$,16+$$);
-			LOAD_DATA(16,$#,&dptr[z][d]);
+			LOAD_DATA(16,&dptr[z][d]);
 			XOR(0+$$,0+$$,16+$$);
 			XOR(8+$$,8+$$,16+$$);
 		}
@@ -145,12 +147,12 @@ static void raid6_s390vx$#_xor_syndrome(int disks, int start, int stop,
 			SHLBYTE(8+$$,8+$$);
 			XOR(8+$$,8+$$,16+$$);
 		}
-		LOAD_DATA(16,$#,&p[d]);
+		LOAD_DATA(16,&p[d]);
 		XOR(16+$$,16+$$,0+$$);
-		STORE_DATA(16,$#,&p[d]);
-		LOAD_DATA(16,$#,&q[d]);
+		STORE_DATA(16,&p[d]);
+		LOAD_DATA(16,&q[d]);
 		XOR(16+$$,16+$$,8+$$);
-		STORE_DATA(16,$#,&q[d]);
+		STORE_DATA(16,&q[d]);
 	}
 	kernel_fpu_end(&vxstate, KERNEL_VXR);
 }
-- 
2.17.1


-- 
Kees Cook
Pixel Security
