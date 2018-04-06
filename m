Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx483lo5O0wVsKMUqTFld6NhOAKx5EoFMycoldzMxEwuMKbY9xdFqjlHohlqGANcWwosPpT9l
ARC-Seal: i=1; a=rsa-sha256; t=1523021597; cv=none;
        d=google.com; s=arc-20160816;
        b=S3o8dVE7GB723yZwSJW53MAdt8ARtEtBki1qXIi8LRaFLTbmyyDLXufTxHsjCY8Yi9
         BMRTEMrJ2aIqAriH5t2VdqpqjWuPXItXi6dgKnwMfjLNVEmCWXdP7KoKNVlVwDa2r7BU
         3K+2bWKHR8wyiz0RI3R3a05eaFHOil/anB05INYayeRMgqm0X62VUdXfEBW5Pyi7fpzt
         zdF+cMgmZuGnpGZsVixGSdeI9B9R1bv/4aOh8Bo5t3du7I8YCS0SJYKMCxj896ihGIV6
         bstjMvGZ7CNOpXfeWbcC+mks87MxqrJ+zLs7dCDw1lcgsGSKmsreQKrQC3v10GK/3S7/
         7znQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AfYYSxMPe+oOi4q7gsBML3eVKhfy/STrMxWRLRzy9Qs=;
        b=hRmG8cO6s0KgW/TMg2vw1IJfPV4vwWUv3/Nw0rCip/kI951aoHZ4sNsUZIkM6Id49X
         1bZUBuwe08P8djAe1aab4eVCge1hiGHep+qMq8zhQjprB5bGww5ifkvQBdeYAN+rzFfE
         MVSTTP1y+CdIWMWERPn6Hdcq4jnkS4obKdUacxLnJJ1UjwOZaEYo/f9q1cQcR9UoW6ug
         HOpquHwGnDx6aZ1TsM9Vp8IoAegsoDbRT650+zAz0jQKaeuM0RxFqwY2UZkOdZhEOvpt
         XbRBTmBbCjZqc2nLpbCLlZA673OpvgyjT82CktMEo2nmy+1FV2GhGWBkzzfAiSRjZqyi
         9O6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Grant Grundler <grundler@chromium.org>,
	Michael Davidson <md@google.com>,
	Greg Hackmann <ghackmann@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 021/102] jiffies.h: declare jiffies and jiffies_64 with ____cacheline_aligned_in_smp
Date: Fri,  6 Apr 2018 15:23:02 +0200
Message-Id: <20180406084334.615818639@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003685413855358?=
X-GMAIL-MSGID: =?utf-8?q?1597003894442604436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 7c30f352c852bae2715ad65ac4a38ca9af7d7696 upstream.

jiffies_64 is defined in kernel/time/timer.c with
____cacheline_aligned_in_smp, however this macro is not part of the
declaration of jiffies and jiffies_64 in jiffies.h.

As a result clang generates the following warning:

  kernel/time/timer.c:57:26: error: section does not match previous declaration [-Werror,-Wsection]
  __visible u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
                           ^
  include/linux/cache.h:39:36: note: expanded from macro '__cacheline_aligned_in_smp'
                                     ^
  include/linux/cache.h:34:4: note: expanded from macro '__cacheline_aligned'
                   __section__(".data..cacheline_aligned")))
                   ^
  include/linux/jiffies.h:77:12: note: previous attribute is here
  extern u64 __jiffy_data jiffies_64;
             ^
  include/linux/jiffies.h:70:38: note: expanded from macro '__jiffy_data'

Link: http://lkml.kernel.org/r/20170403190200.70273-1-mka@chromium.org
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Michael Davidson <md@google.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/jiffies.h |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_JIFFIES_H
 #define _LINUX_JIFFIES_H
 
+#include <linux/cache.h>
 #include <linux/math64.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -63,19 +64,13 @@ extern int register_refined_jiffies(long
 /* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
 #define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
 
-/* some arch's have a small-data section that can be accessed register-relative
- * but that can only take up to, say, 4-byte variables. jiffies being part of
- * an 8-byte variable may not be correctly accessed unless we force the issue
- */
-#define __jiffy_data  __attribute__((section(".data")))
-
 /*
  * The 64-bit value is not atomic - you MUST NOT read it
  * without sampling the sequence number in jiffies_lock.
  * get_jiffies_64() will do this for you as appropriate.
  */
-extern u64 __jiffy_data jiffies_64;
-extern unsigned long volatile __jiffy_data jiffies;
+extern u64 __cacheline_aligned_in_smp jiffies_64;
+extern unsigned long volatile __cacheline_aligned_in_smp jiffies;
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void);
