Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224cyIa1R3pYr2YDQ7HEoELW97L2sT9X9Ft+9qDzEDEH8Map3uiR6f/nYm3HIWBVPRT7k3ca
ARC-Seal: i=1; a=rsa-sha256; t=1518708009; cv=none;
        d=google.com; s=arc-20160816;
        b=KGJHIHdHdotLiAJRiC9jYhvtRyfNpBF3wNtPG7V2XStYqol2ZSF5Ggzm2Fry437frz
         evQ3QP6ftUXsLbuhNZlIvtNk29d+y6tcxP4kflF5QduAwgV7ZN7KUSFW6x+l23e5aGbr
         fLw/Zf9CUgVmV8DnwFAlwkonhibM39UAZj2CVq0YR98+FOFkUjBFuRsnOjRh968JyiuP
         iZBC9BegOXNpzeEqDsT2hb/Eku7bn50XnsLL/QOwaz7t6VrtazrItV0kKhWzv3kMCuIE
         kQVM+SaAvEwhZVPKXAWRTa8S1DN/l747q+RUr8mK5Le06v56iGnuDx7EgLaI/120F3FN
         F/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zVB4ee3564HfytxsNAPN7Z6OHDH7fKulCeNTOsUYJY8=;
        b=kK7+28o6APj7keLjHocmKgTEBd8hw3IoY7cyeEnSCh8EPPJ580O7DNbak1IwEW+44O
         /18rGeUo2gd+zGA+1SrQFVj85GSqg4WeTFauN3feZLaZpMV3mPcbS6AtA6Ipq8f91UcM
         /rk4b8JqhZL3j1kYZIXevZFWDigtNmzIlBRxC6SIFqZpOUOnLN6IE+PD4QGPkeEzbIhb
         zVhr2DkIsQKF6AVkPlhV66FeqwFIGgNQpBnjiMFg2zdwSnd32uRUT+4PsZI5yBW/GWdJ
         16YMgL6pMeikeJ6ZyzjeXuq2Hl2x9lrA2ngGuab3xx3oGHG8SJo4pFpIpCoXkSpGExxX
         ZLGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3.18 41/45] xtensa: fix futex_atomic_cmpxchg_inatomic
Date: Thu, 15 Feb 2018 16:17:32 +0100
Message-Id: <20180215144124.632460323@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480769217450134?=
X-GMAIL-MSGID: =?utf-8?q?1592480769217450134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -109,7 +109,6 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 			      u32 oldval, u32 newval)
 {
 	int ret = 0;
-	u32 prev;
 
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
@@ -120,26 +119,24 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 
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
 
