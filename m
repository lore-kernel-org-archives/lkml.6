Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA55EC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998602133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SW6hBBTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998602133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbeK1Elp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:41:45 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42673 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1Elp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:41:45 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so19731349edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6QrUJpPCjln4OZuzT2t6SLO6BBepUVtyafXp2P9uQCs=;
        b=SW6hBBTaFRoJHTarjpynRDTmRZXr98KMwrjFUwr8j/t2A4ExQJx+S7gUvz1e0S48XL
         tC8628YVh+pZJnB3HfH24l2uARpx325k/mCoLg2SArVrNbDsgDf5MDYZLeN2/MRc7f8/
         OxTEMIIwT1g16ivSj5FhomuO2ufV7mpkMZmds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6QrUJpPCjln4OZuzT2t6SLO6BBepUVtyafXp2P9uQCs=;
        b=sEpPrVXrLMyZTUzKBA8Rhd9HnMsPKtmhPh8PG3cshyGLKMi4e7u6ow/JEKbzxg4rE5
         e6qQe8YM45vJJyRdQF7Myj0dpetwRw23PTEdBFbbZmV7nkoHQq+pNeS3mYUcnVxWGnOc
         s5EMHKzSceuxiJ9RvFeR6GUSlPAM44/vF4wq+GLf5BYpuS3Xga46jyEwajGB3SWjynb8
         NLthxtP/Zy5HDMqH85gITQ1cjVeT8yKmIMxEApPwvCPww/RpViVPne0R8Lbuv0EQzIka
         by9mdYOApANDoXCKDSwpmj0P/ggA93GY/XkcevKuekDJWNWsFnueEd8x6Q4JBClJ7c/9
         D3mA==
X-Gm-Message-State: AA+aEWY6izuGuXDD37FPc5KR9NqFMQNEAycqgZJiOKmAvCKmGX95Y4ak
        pOZNuHSJhDAAYbFVyyMCerfMPj/ACo4=
X-Google-Smtp-Source: AFSGD/VgBDXh2l8QOf2XzFqop014a+3xfUXfI/got74cGvJ6uelmz9wB8q7nIXMXVLW5Cl+7JIPpxQ==
X-Received: by 2002:a50:9849:: with SMTP id h9mr26210355edb.36.1543340583791;
        Tue, 27 Nov 2018 09:43:03 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f523:5d63:a56a:3d76])
        by smtp.gmail.com with ESMTPSA id u33sm1212459edm.88.2018.11.27.09.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:43:02 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rui Sun <sunrui26@huawei.com>
Subject: [PATCH] arm64/lib: improve CRC32 performance for deep pipelines
Date:   Tue, 27 Nov 2018 18:42:55 +0100
Message-Id: <20181127174255.24372-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the performance of the crc32() asm routines by getting rid of
most of the branches and small sized loads on the common path.

Instead, use a branchless code path involving overlapping 16 byte
loads to process the first (length % 32) bytes, and process the
remainder using a loop that processes 32 bytes at a time.

Tested using the following test program:

  #include <stdlib.h>

  extern void crc32_le(unsigned short, char const*, int);

  int main(void)
  {
    static const char buf[4096];

    srand(20181126);

    for (int i = 0; i < 100 * 1000 * 1000; i++)
      crc32_le(0, buf, rand() % 1024);

    return 0;
  }

On Cortex-A53 and Cortex-A57, the performance regresses but only very
slightly. On Cortex-A72 however, the performance improves from

  $ time ./crc32

  real  0m10.149s
  user  0m10.149s
  sys   0m0.000s

to

  $ time ./crc32

  real  0m7.915s
  user  0m7.915s
  sys   0m0.000s

Cc: Rui Sun <sunrui26@huawei.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Cortex-A57 tcrypt results after the patch.

I ran Rui's code [0] as well. On Cortex-A57, performance regresses a bit
more (but not dramatically). On Cortex-A72, it executes at

$ time ./crc32 

real	0m9.625s
user	0m9.625s
sys	0m0.000s

Rui, can you please benchmark this code on your system as well?

[0] https://lore.kernel.org/lkml/1542612560-10089-1-git-send-email-sunrui26@huawei.com/

 arch/arm64/lib/crc32.S | 54 ++++++++++++++++++--
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S
index 5bc1e85b4e1c..f132f2a7522e 100644
--- a/arch/arm64/lib/crc32.S
+++ b/arch/arm64/lib/crc32.S
@@ -15,15 +15,59 @@
 	.cpu		generic+crc
 
 	.macro		__crc32, c
-0:	subs		x2, x2, #16
-	b.mi		8f
-	ldp		x3, x4, [x1], #16
+	cmp		x2, #16
+	b.lt		8f			// less than 16 bytes
+
+	and		x7, x2, #0x1f
+	and		x2, x2, #~0x1f
+	cbz		x7, 32f			// multiple of 32 bytes
+
+	and		x8, x7, #0xf
+	ldp		x3, x4, [x1]
+	add		x8, x8, x1
+	add		x1, x1, x7
+	ldp		x5, x6, [x8]
 CPU_BE(	rev		x3, x3		)
 CPU_BE(	rev		x4, x4		)
+CPU_BE(	rev		x5, x5		)
+CPU_BE(	rev		x6, x6		)
+
+	tst		x7, #8
+	crc32\c\()x	w8, w0, x3
+	csel		x3, x3, x4, eq
+	csel		w0, w0, w8, eq
+	tst		x7, #4
+	lsr		x4, x3, #32
+	crc32\c\()w	w8, w0, w3
+	csel		x3, x3, x4, eq
+	csel		w0, w0, w8, eq
+	tst		x7, #2
+	lsr		w4, w3, #16
+	crc32\c\()h	w8, w0, w3
+	csel		w3, w3, w4, eq
+	csel		w0, w0, w8, eq
+	tst		x7, #1
+	crc32\c\()b	w8, w0, w3
+	csel		w0, w0, w8, eq
+	tst		x7, #16
+	crc32\c\()x	w8, w0, x5
+	crc32\c\()x	w8, w8, x6
+	csel		w0, w0, w8, eq
+	cbz		x2, 0f
+
+32:	ldp		x3, x4, [x1], #32
+	sub		x2, x2, #32
+	ldp		x5, x6, [x1, #-16]
+CPU_BE(	rev		x3, x3		)
+CPU_BE(	rev		x4, x4		)
+CPU_BE(	rev		x5, x5		)
+CPU_BE(	rev		x6, x6		)
 	crc32\c\()x	w0, w0, x3
 	crc32\c\()x	w0, w0, x4
-	b.ne		0b
-	ret
+	crc32\c\()x	w0, w0, x5
+	crc32\c\()x	w0, w0, x6
+	cbnz		x2, 32b
+0:	ret
 
 8:	tbz		x2, #3, 4f
 	ldr		x3, [x1], #8
-- 
2.19.1


BEFORE testing speed of async crc32c (crc32c-generic)
tcrypt: test  0 (   16 byte blocks,   16 bytes per update,   1 updates): 35416299 opers/sec, 566660784 bytes/sec
tcrypt: test  1 (   64 byte blocks,   16 bytes per update,   4 updates): 5342888 opers/sec, 341944832 bytes/sec
tcrypt: test  2 (   64 byte blocks,   64 bytes per update,   1 updates): 30056634 opers/sec, 1923624576 bytes/sec
tcrypt: test  3 (  256 byte blocks,   16 bytes per update,  16 updates): 1543567 opers/sec, 395153152 bytes/sec
tcrypt: test  4 (  256 byte blocks,   64 bytes per update,   4 updates): 4865198 opers/sec, 1245490688 bytes/sec
tcrypt: test  5 (  256 byte blocks,  256 bytes per update,   1 updates): 12709474 opers/sec, 3253625344 bytes/sec
tcrypt: test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates): 401746 opers/sec, 411387904 bytes/sec
tcrypt: test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates): 2576764 opers/sec, 2638606336 bytes/sec
tcrypt: test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates): 4464109 opers/sec, 4571247616 bytes/sec
tcrypt: test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates): 202236 opers/sec, 414179328 bytes/sec
tcrypt: test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates): 1344017 opers/sec, 2752546816 bytes/sec
tcrypt: test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates): 2000544 opers/sec, 4097114112 bytes/sec
tcrypt: test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates): 2395890 opers/sec, 4906782720 bytes/sec
tcrypt: test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates): 101569 opers/sec, 416026624 bytes/sec
tcrypt: test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates): 687876 opers/sec, 2817540096 bytes/sec
tcrypt: test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates): 1029042 opers/sec, 4214956032 bytes/sec
tcrypt: test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates): 1206227 opers/sec, 4940705792 bytes/sec
tcrypt: test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates):  50842 opers/sec, 416497664 bytes/sec
tcrypt: test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates): 347779 opers/sec, 2849005568 bytes/sec
tcrypt: test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates): 525054 opers/sec, 4301242368 bytes/sec
tcrypt: test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates): 600919 opers/sec, 4922728448 bytes/sec
tcrypt: test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates): 606954 opers/sec, 4972167168 bytes/sec

AFTER testing speed of async crc32c (crc32c-generic)
tcrypt: test  0 (   16 byte blocks,   16 bytes per update,   1 updates): 30535173 opers/sec, 488562768 bytes/sec
tcrypt: test  1 (   64 byte blocks,   16 bytes per update,   4 updates): 4798401 opers/sec, 307097664 bytes/sec
tcrypt: test  2 (   64 byte blocks,   64 bytes per update,   1 updates): 30061075 opers/sec, 1923908800 bytes/sec
tcrypt: test  3 (  256 byte blocks,   16 bytes per update,  16 updates): 1359905 opers/sec, 348135680 bytes/sec
tcrypt: test  4 (  256 byte blocks,   64 bytes per update,   4 updates): 4862043 opers/sec, 1244683008 bytes/sec
tcrypt: test  5 (  256 byte blocks,  256 bytes per update,   1 updates): 14375092 opers/sec, 3680023552 bytes/sec
tcrypt: test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates): 351936 opers/sec, 360382464 bytes/sec
tcrypt: test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates): 2665564 opers/sec, 2729537536 bytes/sec
tcrypt: test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates): 4467924 opers/sec, 4575154176 bytes/sec
tcrypt: test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates): 177021 opers/sec, 362539008 bytes/sec
tcrypt: test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates): 1414689 opers/sec, 2897283072 bytes/sec
tcrypt: test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates): 1995413 opers/sec, 4086605824 bytes/sec
tcrypt: test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates): 2393630 opers/sec, 4902154240 bytes/sec
tcrypt: test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates):  88758 opers/sec, 363552768 bytes/sec
tcrypt: test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates): 731752 opers/sec, 2997256192 bytes/sec
tcrypt: test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates): 1030393 opers/sec, 4220489728 bytes/sec
tcrypt: test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates): 1205718 opers/sec, 4938620928 bytes/sec
tcrypt: test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates):  44450 opers/sec, 364134400 bytes/sec
tcrypt: test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates): 373236 opers/sec, 3057549312 bytes/sec
tcrypt: test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates): 524905 opers/sec, 4300021760 bytes/sec
tcrypt: test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates): 601242 opers/sec, 4925374464 bytes/sec
tcrypt: test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates): 606769 opers/sec, 4970651648 bytes/sec
