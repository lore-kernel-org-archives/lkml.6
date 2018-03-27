Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4957sJ9alkPn4OqsOm6AV1ymSfdIGtAyKl7kzX3aHhmlDAb2323TZjm7yBHl6Kfk9xf9Jh7
ARC-Seal: i=1; a=rsa-sha256; t=1522168646; cv=none;
        d=google.com; s=arc-20160816;
        b=PTJB0gg0vT91RtyNBPCon0Y5GFJYXBHFEKNYHor7tP49AmDuyemBurTqSjTGyCOGLc
         b+1vGi8J4EpNhPcA1lmDcaj429mIbiCmObz0k+N2FHr8aOU65R6k5dn3vMgAbkOm9Ppa
         m+l3lyhAtVMwaR1WNgg7oC7F89dLhR7OXlXep+NQGZ202iTEapU/LQtStpiUnkg2T6v1
         HoaFb+oVQuxSdqSLSeKTr0M3bTqM2qtqut6ovhyma7m0yfPYnsRrpHpfOBrBQ+tPpinL
         p0NZyCZ4/5enE9Epi8N1nbLy07rsR1WTXzq8r/ZsrZcpKPj939MauV+gHezMhmPW5J4/
         iKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tbnF4iUm2syYaw/IgRCr/gtrCeglyjrgUnAZBtNYmB4=;
        b=kh62fE0ycSt4U+U8iiN+/017Le77yysN+nh8QtW7o2tleNI0E2FRzs1Fprjk8w/hxl
         saACIDbHcjWQ5lRnbWFkZABikc1vxULS7+j03dL6xTt34ZRIh+iZKRNu7X0jaB/IoHEH
         0ILn4r0hBwoigcTYGy+cVkKFrChnm2S4Qfy6iiGBXSFDunOfxCsx6nm7ONJZPXjArAmx
         wznDoc5DVyR1ANMILijLAF+C70shnEOnkUCp0r0Ic0TtcpIhBkEQUqtsDQXBi+7cmyXk
         CBP2yu4VME6ysiD6GI2cJf4mlwJEGP2Z2Bq/Rd0ZwHQ5HD62yYfFGSEWhQR4WH7ET4Sk
         SDsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.14 082/101] posix-timers: Protect posix clock array access against speculation
Date: Tue, 27 Mar 2018 18:27:54 +0200
Message-Id: <20180327162755.088982907@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109511321861911?=
X-GMAIL-MSGID: =?utf-8?q?1596109511321861911?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 19b558db12f9f4e45a22012bae7b4783e62224da upstream.

The clockid argument of clockid_to_kclock() comes straight from user space
via various syscalls and is used as index into the posix_clocks array.

Protect it against spectre v1 array out of bounds speculation. Remove the
redundant check for !posix_clock[id] as this is another source for
speculation and does not provide any advantage over the return
posix_clock[id] path which returns NULL in that case anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1802151718320.1296@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/posix-timers.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -50,6 +50,7 @@
 #include <linux/export.h>
 #include <linux/hashtable.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -1346,11 +1347,15 @@ static const struct k_clock * const posi
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
 {
-	if (id < 0)
+	clockid_t idx = id;
+
+	if (id < 0) {
 		return (id & CLOCKFD_MASK) == CLOCKFD ?
 			&clock_posix_dynamic : &clock_posix_cpu;
+	}
 
-	if (id >= ARRAY_SIZE(posix_clocks) || !posix_clocks[id])
+	if (id >= ARRAY_SIZE(posix_clocks))
 		return NULL;
-	return posix_clocks[id];
+
+	return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
 }
