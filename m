Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225kjH1o/V1dRKdCOrqhbDx0Ztiz70awJUx/C5NrfsCYasojRWz/aMMtJ0SjVw96xXxfeezU
ARC-Seal: i=1; a=rsa-sha256; t=1518709037; cv=none;
        d=google.com; s=arc-20160816;
        b=nWrBt2gx540EqMQnPNZfGIOwzW9AXGaBO/ODhIA1WkBDjfXEgocOJnEkBSvWV4reKA
         RVaoCkDT9K+KETziR7YLofTy7CyUGfwbBEVg/sl46q6t4oLQS1C934oApkKxPxQmmhnl
         DrWFVsh1kaeyPibl4xfroXfa0CrvMrbfM6VSMav51/Ks5YEmuZRRIKsPlwdURIJU+Ikm
         Riv5+QlbVuiiJmeSLw8ckrUH0a6g/Hm+wU1mruCC8CriY8JL+x9BKzYbS5vrz8EcD+br
         3gn9qFHvbvLeNPZhnAXyJn7CdX5b3B/4vnDqW7A4GKTw+b5fW6GldJjCNggvnjk0UOMv
         ZYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xBTtj752HXy3c3v1EjlwGknHvG0EjvYfSTBSrVFjodg=;
        b=VyVBSjePeWhwYc3CRpfk9iZu6Vw/YIF1pW3Z9dsMU1ko89lVkTUPspWOBR7/uC39L9
         OU0WH02FhPyrJYzy0Xz/+KWhGpK95Mjkluplv0/dFtYYfQI+h/V7gLsfZvWzaYbML+iD
         qutrDWUVUj0CUAYiHncHFWeJYeqCE+RC7IurLCoNRUtLBAn7bb14dUEXur29OGswjM9Q
         N/tbTIQMNDV1fE8FOF03UIVA0Ead9kYsJL6dAg67o1LVe7sX/ipVYWUcgOKRKKUXvg4N
         tvvAXk+iH1ezs06wsFIKf9UcBpHvKp4ON+nLAqcgMpwoW5CjpnR6ZEvMc8+dULHWZjaG
         Tw7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.14 169/195] xtensa: fix futex_atomic_cmpxchg_inatomic
Date: Thu, 15 Feb 2018 16:17:40 +0100
Message-Id: <20180215151714.463920081@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480769217450134?=
X-GMAIL-MSGID: =?utf-8?q?1592481847650490602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit ca47480921587ae30417dd234a9f79af188e3666 upstream.

Return 0 if the operation was successful, not the userspace memory
value. Check that userspace value equals passed oldval, not itself.
Don't update *uval if the value wasn't read from userspace memory.

This fixes process hang due to infinite loop in futex_lock_pi.
It also fixes a bunch of glibc tests nptl/tst-mutexpi*.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/include/asm/futex.h |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -92,7 +92,6 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 			      u32 oldval, u32 newval)
 {
 	int ret = 0;
-	u32 prev;
 
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
@@ -103,26 +102,24 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 
 	__asm__ __volatile__ (
 	"	# futex_atomic_cmpxchg_inatomic\n"
-	"1:	l32i	%1, %3, 0\n"
-	"	mov	%0, %5\n"
-	"	wsr	%1, scompare1\n"
-	"2:	s32c1i	%0, %3, 0\n"
-	"3:\n"
+	"	wsr	%5, scompare1\n"
+	"1:	s32c1i	%1, %4, 0\n"
+	"	s32i	%1, %6, 0\n"
+	"2:\n"
 	"	.section .fixup,\"ax\"\n"
 	"	.align 4\n"
-	"4:	.long	3b\n"
-	"5:	l32r	%1, 4b\n"
-	"	movi	%0, %6\n"
+	"3:	.long	2b\n"
+	"4:	l32r	%1, 3b\n"
+	"	movi	%0, %7\n"
 	"	jx	%1\n"
 	"	.previous\n"
 	"	.section __ex_table,\"a\"\n"
-	"	.long 1b,5b,2b,5b\n"
+	"	.long 1b,4b\n"
 	"	.previous\n"
-	: "+r" (ret), "=&r" (prev), "+m" (*uaddr)
-	: "r" (uaddr), "r" (oldval), "r" (newval), "I" (-EFAULT)
+	: "+r" (ret), "+r" (newval), "+m" (*uaddr), "+m" (*uval)
+	: "r" (uaddr), "r" (oldval), "r" (uval), "I" (-EFAULT)
 	: "memory");
 
-	*uval = prev;
 	return ret;
 }
 
