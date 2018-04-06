Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49s0eVzRBmaoN5zsVT6s10X8c5wlCX0Kl/7UHKz+ECO46VLnt/AiG3irVnQvUbYjNwV0JRe
ARC-Seal: i=1; a=rsa-sha256; t=1523021600; cv=none;
        d=google.com; s=arc-20160816;
        b=laB8PKoJahepI+T8+fxBqAkIw7vxWbULQXCGoS5xsUevaTGjSjxr+hBdgo1lrZc0rR
         7v2oBwkuZQ05P3nchK4S5TxLJIjOaLgagYPpsdfwN6DvoStxDbuP1MeznY5Gb7WUfJHz
         Ldte2q8iotSa+K6lzxvKgHGZ0zBjPgT477+U+bs1z1HIsw4LHabzdQSxnfY/C6l2KwuM
         sQ/SrzrpKKKHbX2VBbnSvdpxD9t2+ZGE04MxLG/pSUpD1kXWWZd3QFwPlO2X5e47FfQw
         gU51zP0myVD24q81s5IWmpaIFHi1aArabcDclUrQAS3zXShtdhliy7DBDVUQQzdprCNg
         lwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y+uZInbBzrW0rU9aNBiOe0wXQ8B+yIk/1RiFUEFT4jY=;
        b=ZNT0Gqkt4UeR4kgU4OZT70129fpc0ivsJ/wuYUt0Dlw7kc+F7GzuDpkHfGmMraVt6X
         52uncd4QGxRugZ3uaWR/BpqJRu4hVVB4qJ/9+26oBdd9zB7k+SWD0CnmlVNRwcVOG1mP
         RXZ+OmIVAIxrN21kbcK5VYXLkNs9/jBiNS/u5YEZdkC3+QUbSnaxqVmqr94Ryja4o97G
         7iraSaOMMlc2Dq1WZkHHSuIT69FZXVZQEzUHHnVTYpfYbJEGr4KScR0nPMIaBWAIZ52s
         ywmNeVxxFW81larHV9k1p8TgfqO/g5Q5Z0pg6Y8mTTDA9ZXNHKG1QBgUnACApLlk4579
         LAgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>,
	David Howells <dhowells@redhat.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 022/102] frv: declare jiffies to be located in the .data section
Date: Fri,  6 Apr 2018 15:23:03 +0200
Message-Id: <20180406084334.731628831@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003687627223663?=
X-GMAIL-MSGID: =?utf-8?q?1597003897235117272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 60b0a8c3d2480f3b57282b47b7cae7ee71c48635 upstream.

Commit 7c30f352c852 ("jiffies.h: declare jiffies and jiffies_64 with
____cacheline_aligned_in_smp") removed a section specification from the
jiffies declaration that caused conflicts on some platforms.

Unfortunately this change broke the build for frv:

  kernel/built-in.o: In function `__do_softirq': (.text+0x6460): relocation truncated to fit: R_FRV_GPREL12 against symbol
      `jiffies' defined in *ABS* section in .tmp_vmlinux1
  kernel/built-in.o: In function `__do_softirq': (.text+0x6574): relocation truncated to fit: R_FRV_GPREL12 against symbol
      `jiffies' defined in *ABS* section in .tmp_vmlinux1
  kernel/built-in.o: In function `pwq_activate_delayed_work': workqueue.c:(.text+0x15b9c): relocation truncated to fit: R_FRV_GPREL12 against
      symbol `jiffies' defined in *ABS* section in .tmp_vmlinux1
  ...

Add __jiffy_arch_data to the declaration of jiffies and use it on frv to
include the section specification.  For all other platforms
__jiffy_arch_data (currently) has no effect.

Fixes: 7c30f352c852 ("jiffies.h: declare jiffies and jiffies_64 with ____cacheline_aligned_in_smp")
Link: http://lkml.kernel.org/r/20170516221333.177280-1-mka@chromium.org
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/frv/include/asm/timex.h |    6 ++++++
 include/linux/jiffies.h      |    6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- a/arch/frv/include/asm/timex.h
+++ b/arch/frv/include/asm/timex.h
@@ -16,5 +16,11 @@ static inline cycles_t get_cycles(void)
 #define vxtime_lock()		do {} while (0)
 #define vxtime_unlock()		do {} while (0)
 
+/* This attribute is used in include/linux/jiffies.h alongside with
+ * __cacheline_aligned_in_smp. It is assumed that __cacheline_aligned_in_smp
+ * for frv does not contain another section specification.
+ */
+#define __jiffy_arch_data	__attribute__((__section__(".data")))
+
 #endif
 
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -64,13 +64,17 @@ extern int register_refined_jiffies(long
 /* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
 #define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
 
+#ifndef __jiffy_arch_data
+#define __jiffy_arch_data
+#endif
+
 /*
  * The 64-bit value is not atomic - you MUST NOT read it
  * without sampling the sequence number in jiffies_lock.
  * get_jiffies_64() will do this for you as appropriate.
  */
 extern u64 __cacheline_aligned_in_smp jiffies_64;
-extern unsigned long volatile __cacheline_aligned_in_smp jiffies;
+extern unsigned long volatile __cacheline_aligned_in_smp __jiffy_arch_data jiffies;
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void);
