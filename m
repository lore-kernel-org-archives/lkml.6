Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E51EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128022083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128022083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934657AbeFROHL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:07:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932860AbeFROHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:07:07 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MfDvq-1fsbnv22xO-00OkyB; Mon, 18 Jun 2018 16:05:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Meelis Roos <mroos@linux.ee>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] powerpc: mac: fix rtc read functions
Date:   Mon, 18 Jun 2018 16:05:16 +0200
Message-Id: <20180618140518.2920804-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:qw0DyR+gpzEw843/ptQGa6wwShb3h3BNudQco/SiKzF5yUUk/IY
 qLziZsVSYqGEmXJhRnsl+nqnUSUXsPoJhZuK7yspQcug116WrWM5y1EHSKdSKC0aNmcr0UR
 tD5srfzkiG86sOFeQQnmXsscuB7Wi28ZopYvaISyXZJxxOLLvGkATk7F8eowWB+MHuf4j+x
 xaboq2b4YaX6JCbXeRKMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d1MntMH0Q9U=:LGB6oG6CgQZPSS4MEd5lMO
 doL8NURgPUXBDkYnarAjASTHF5fiFbYKxQFQFVUuuOzRWBPoFbCGrQNKmQmMiYZ03xje467QH
 sStwLQ1Uiv+NF0fJI/v4a2lZ/9WwtUGoqso25LN/aHdews4+9AOjrjeB2EZDDM2h4m/Jahi5p
 770MVfGIjwvgpLG50HfBqprm0yzrcV69jyIiaKrkGP7Lm1BCOLHcEbr+IXSuHHuo5AyKIGKgk
 9sITAvLijPcvHxvksNAc4LPwH4iKQZN7Rx3oUCsBSCrvzKx+gsJYOiNQqzWUNBuHgLb44+vK5
 nHJfEOtooeORShp7n2JWapfvT2U8AXdrF6CS4elvY8tYK8apjT83i2VBSV2dXOlht9W1kVpQY
 5GtGDEJPk6TVNBUIrK000UQSoCNA+mj3l9ghoIlG6YEBh2EvBLgblAHMSrE0Ra+pOeLCkbTTr
 +F+rle0/PdogRL0mZG1ncgl28pc0gHGctTsCZYHkLjTv7R0iGhTc6VuoJdunOoe3zBydOY3L5
 cvMdjzMogwRZOzTepY8iULGNXUcZHgyMmSvhawNERojkeawk1L/e5LQcKwsrwy5OK6g+Hn6aL
 +u/fYtTyxCiszjCJEchTJNcdiFWU+QKffFMhx9vJsZtsNI/Q8wfAQJy+5v8Yqym6QJQuRe9iq
 /cOo4D5t4YpW/68S7knD0Y6ji11qDQ8URgUsi1h1bYjEo43jpcOoh1VRxbN8YOwMHWJE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Mathieu pointed out, my conversion to time64_t was incorrect and resulted
in negative times to be read from the RTC. The problem is that during the
conversion from a byte array to a time64_t, the 'unsigned char' variable
holding the top byte gets turned into a negative signed 32-bit integer
before being assigned to the 64-bit variable for any times after 1972.

This changes the logic to cast to an unsigned 32-bit number first for
the Macintosh time and then convert that to the Unix time, which then gives
us a time in the documented 1904..2040 year range. I decided not to use
the longer 1970..2106 range that other drivers use, for consistency with
the literal interpretation of the register, but that could be easily
changed if we decide we want to support any Mac after 2040.

Just to be on the safe side, I'm also adding a WARN_ON that will trigger
if either the year 2040 has come and is observed by this driver, or we
run into an RTC that got set back to a pre-1970 date for some reason
(the two are indistinguishable).

The same code exists in arch/m68k/ and is patched in an identical way now
in a separate patch.

Fixes: 5bfd643583b2 ("powerpc: use time64_t in read_persistent_clock")
Reported-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/powermac/time.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 7c968e46736f..173a80630169 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -42,7 +42,11 @@
 #define DBG(x...)
 #endif
 
-/* Apparently the RTC stores seconds since 1 Jan 1904 */
+/*
+ * Offset between Unix time (1970-based) and Mac time (1904-based). Cuda and PMU
+ * times wrap in 2040. If we need to handle later times, the read_time functions
+ * need to be changed to interpret wrapped times as post-2040.
+ */
 #define RTC_OFFSET	2082844800
 
 /*
@@ -97,8 +101,11 @@ static time64_t cuda_get_time(void)
 	if (req.reply_len != 7)
 		printk(KERN_ERR "cuda_get_time: got %d byte reply\n",
 		       req.reply_len);
-	now = (req.reply[3] << 24) + (req.reply[4] << 16)
-		+ (req.reply[5] << 8) + req.reply[6];
+	now = (u32)((req.reply[3] << 24) + (req.reply[4] << 16) +
+		    (req.reply[5] << 8) + req.reply[6]);
+	/* it's either after year 2040, or the RTC has gone backwards */
+	WARN_ON(now < RTC_OFFSET);
+
 	return now - RTC_OFFSET;
 }
 
@@ -140,8 +147,12 @@ static time64_t pmu_get_time(void)
 	if (req.reply_len != 4)
 		printk(KERN_ERR "pmu_get_time: got %d byte reply from PMU\n",
 		       req.reply_len);
-	now = (req.reply[0] << 24) + (req.reply[1] << 16)
-		+ (req.reply[2] << 8) + req.reply[3];
+	now = (u32)((req.reply[0] << 24) + (req.reply[1] << 16)	+
+		    (req.reply[2] << 8) + req.reply[3]);
+
+	/* it's either after year 2040, or the RTC has gone backwards */
+	WARN_ON(now < RTC_OFFSET);
+
 	return now - RTC_OFFSET;
 }
 
-- 
2.9.0

