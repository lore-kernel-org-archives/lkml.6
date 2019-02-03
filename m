Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C286C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E3420815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfBCOA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:00:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53376 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727741AbfBCNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:51 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0003tj-6P; Sun, 03 Feb 2019 13:49:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0006nZ-JX; Sun, 03 Feb 2019 14:49:39 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Chen Gang" <gang.chen@sunrus.com.cn>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Chen Gang" <gang.chen.5i5j@gmail.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.428739117@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 008/305] s390/timex: fix get_tod_clock_ext() inline
 assembly
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Gang <gang.chen@sunrus.com.cn>

commit e38f97813302065fbc9c9eab5c1a94dc021d71e2 upstream.

For C language, it treats array parameter as a pointer, so sizeof for an
array parameter is equal to sizeof for a pointer, which causes compiler
warning (with allmodconfig by gcc 5):

  ./arch/s390/include/asm/timex.h: In function 'get_tod_clock_ext':
  ./arch/s390/include/asm/timex.h:76:32: warning: 'sizeof' on array function parameter 'clk' will return size of 'char *' [-Wsizeof-array-argument]
    typedef struct { char _[sizeof(clk)]; } addrtype;
                                  ^
Can use macro CLOCK_STORE_SIZE instead of all related hard code numbers,
which also can avoid this warning. And also add a tab to CLOCK_TICK_RATE
definition to match coding styles.

[heiko.carstens@de.ibm.com]:
Chen's patch actually fixes a bug within the get_tod_clock_ext() inline assembly
where we incorrectly tell the compiler that only 8 bytes of memory get changed
instead of 16 bytes.
This would allow gcc to generate incorrect code. Right now this doesn't seem to
be the case.
Also slightly changed the patch a bit.
- renamed CLOCK_STORE_SIZE to STORE_CLOCK_EXT_SIZE
- changed get_tod_clock_ext() to receive a char pointer parameter

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/hypfs/hypfs_vm.c    |  2 +-
 arch/s390/include/asm/timex.h | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -231,7 +231,7 @@ failed:
 struct dbfs_d2fc_hdr {
 	u64	len;		/* Length of d2fc buffer without header */
 	u16	version;	/* Version of header */
-	char	tod_ext[16];	/* TOD clock for d2fc */
+	char	tod_ext[STORE_CLOCK_EXT_SIZE]; /* TOD clock for d2fc */
 	u64	count;		/* Number of VM guests in d2fc buffer */
 	char	reserved[30];
 } __attribute__ ((packed));
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -67,20 +67,22 @@ static inline void local_tick_enable(uns
 	set_clock_comparator(S390_lowcore.clock_comparator);
 }
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define CLOCK_TICK_RATE		1193180 /* Underlying HZ */
+#define STORE_CLOCK_EXT_SIZE	16	/* stcke writes 16 bytes */
 
 typedef unsigned long long cycles_t;
 
-static inline void get_tod_clock_ext(char clk[16])
+static inline void get_tod_clock_ext(char *clk)
 {
-	typedef struct { char _[sizeof(clk)]; } addrtype;
+	typedef struct { char _[STORE_CLOCK_EXT_SIZE]; } addrtype;
 
 	asm volatile("stcke %0" : "=Q" (*(addrtype *) clk) : : "cc");
 }
 
 static inline unsigned long long get_tod_clock(void)
 {
-	unsigned char clk[16];
+	unsigned char clk[STORE_CLOCK_EXT_SIZE];
+
 	get_tod_clock_ext(clk);
 	return *((unsigned long long *)&clk[1]);
 }

