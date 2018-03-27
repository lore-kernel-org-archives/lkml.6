Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48gyzt3fxmTmc6cM7DVMpCYmQ89tDOXgXNgjy1FnMznedeRKti4h7/7mQduYTMsEjqNTyxk
ARC-Seal: i=1; a=rsa-sha256; t=1522168941; cv=none;
        d=google.com; s=arc-20160816;
        b=v3OBeCvAw6UvfN5t+hHdw1YpBuHsA094Dc+M8Y3szHRCAUvHqUcWr1vA9PKajzxWuf
         Cbf1WGfNFYi49BAH66XcmmcpItwHZhtz7bSF17QXra3G4PDaEK1nvIEXpNQVUgjpQJCz
         UydxymqoRHWI6qC8PtlVNqdtzggFDPfhKUarueSN1Pf1bfAUFxnHJys2+rVIvGsAWePq
         s/XkkaXBC2YGgQSWBdIFN+f/UdP8ku3bAs2yn7uNLYA4wDWpIijsLYQkCq6bhGP3ur7x
         iNmM37yxmcWB+o62r3WfHSmbxYAvNthHkucULbsWaPey5clcFBjopa16yRNKthOEhH+5
         Uaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=57gBCyflZR5udfwQscPVvdhSue56uBWXZPVpFWnsuyU=;
        b=1H+wGVUdsbIlERq7bi2CPrZFSqGsKYDvuCqLkKU697lESPnGE2csrEaWx9GQpCvkVc
         sJosciweenBTL66xCfGG1iXQiITR9iOLD4CPYfBZ5F8QrWjMjidwnIcoR6BdAyso2BtQ
         6hyrE6+bwyeiUMWXREIdbUA1EuzGAFFxKJSwB3KYX/JWNx73lzejg4i5nT8Dc6sCEg4i
         PpjYKzmbQRVk3e7A2Cm6aSpcANSOMsyMhJj0PQ5PLhzh8ctdcw+T98mfKbMSGZpC63Pk
         MZ+1igKZf+/HeztdKECfeSvHb78N8CjTuvHu8zXzgv6QW5CLLRc0n9sqnzMvg95fZ+eL
         9fow==
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
Subject: [PATCH 4.15 087/105] posix-timers: Protect posix clock array access against speculation
Date: Tue, 27 Mar 2018 18:28:07 +0200
Message-Id: <20180327162803.562069125@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109511321861911?=
X-GMAIL-MSGID: =?utf-8?q?1596109820104170228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
