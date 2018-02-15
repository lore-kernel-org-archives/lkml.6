Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x225x1MfSbfuqvb28HzCjjJYbkEbbDpJAvcsWqBQFKNghVxDJd4i+JZPrW9P8/EFDhuyyw/ns
ARC-Seal: i=1; a=rsa-sha256; t=1518711712; cv=none;
        d=google.com; s=arc-20160816;
        b=NWGEAUkooBSXmf+4Jxa1+VB5bYA5+xejMgRDnzTrGu/oMv3Nofde8UqasyBu2aiIz7
         u6KppuoR6YcuA18hvc8KoO1o0LP3ZqdHFdhKFYlzdUNlzTLTi9Pug8n0Cb59U5yRELH4
         ArUZwqnhUSo3w84d76Xh/wHbleNRlm7ef9AKdpeKhHndapBjKpQIUuxjzkDM8tHwKF8x
         UdqeQNdF6zQ0euRDwTg302hvRrxr1hT6pTtqr9M3wL5BbInoKye9ucP/Npc+in/5DbmJ
         yePqW6tslu6AR0K8pMw2FYOvZ0e8oCPwHg5xAjFMqBdNT3Krl7Urnay1HQhwr3i1PKuN
         G6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=XmN7b1vhhw6/i//srF1HbLL0kiiMGPlsDSDRKPOESoU=;
        b=S64JFAN6n9ZquGD3XWt0Mdo3QOVzQUTt1K/SlPsZLxw8k3dir09oLvyh/By/2ks4/g
         o9qb5KlN+HjV/lsjwqi6hfijssemG8o/Xdr6idGHiCem4ubZq9EjfamcpYwOk/mOqVv/
         r0okIok2E3TVzPHFrZSUbkJB9t/oq+DixftPklcudlQVKTz7naSkia3qfFtF/zNU1a8F
         lNDx3R8HfgBfjOTyX7+OP1kKiV9R4mW4vK9AAHhWg16TwKavTOjKU0nt+JseNs3yL1LJ
         41doKV5WaioVAja84TOTSkR3YQkaIa/6b//K4a8s9nOCRlOCY2MKbDFWK3/wuwEpSnUN
         OAkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Thu, 15 Feb 2018 17:21:55 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dan Williams <dan.j.williams@intel.com>
cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
    LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    David Woodhouse <dwmw@amazon.co.uk>, Greg KH <gregkh@linuxfoundation.org>,
    Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V2] posix-timers: Protect posix clock array access against
 speculation
In-Reply-To: <alpine.DEB.2.21.1802151550330.1296@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1802151718320.1296@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1802151424490.1296@nanos.tec.linutronix.de> <45f8dece-e235-0831-4fe5-89ee7d27b959@prevas.dk> <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com> <alpine.DEB.2.21.1802151550330.1296@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592473683460033132?=
X-GMAIL-MSGID: =?utf-8?q?1592484653117536662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The clockid argument of clockid_to_kclock() comes straight from user space
via various syscalls and is used as index into the posix_clocks array.

Protect it against spectre v1 array out of bounds speculation. Remove the
redundant check for !posix_clock[id] as this is another source for
speculation and does not provide any advantage over the return
posix_clock[id] path which returns NULL in that case anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---

V2: Remove the redundant !posix_clocks[id] check.

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
