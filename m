Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x227zkcsk3IWUkNK/hYzvjptiNpkt3w9UkLF2B3YLH9TIBf3S3TlW1GOwXKAe5b3E9AimFymf
ARC-Seal: i=1; a=rsa-sha256; t=1518701251; cv=none;
        d=google.com; s=arc-20160816;
        b=mPx810WF7uIZvSVCJ3qSZaREXHov/VmiY/E9a/wlN7ArlnY9DPIbV3cLb17nBdL/1Z
         /MripMnvC5gh/URyT6WGuwH1r03EepkwrIGhZRQPwuXdyZpJqBJ6G5lS0Fz+l+N4/WWm
         0b2ceun9F0lr3Tfuv8HdD039JI2d+5GXsvO8/lezjAJFDVLLFuA1gI5G8Vn0kaFPoQAq
         BcrZv9WotvGNHpA1msmBWRMLPGMK+1cLovvVd8mPbABKhHrRMsCMgECAq9KvH9Q3ne2i
         /up9YQn6YyX18nbtqiKfhjzswngJWchvt/fGzNkA8x0qvQ/hq8lgneNNWRQlMfuGS6mv
         V22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=OPENJUlt8qtr74NWYjlIt12nuVQx0Xd/CzEjimXemuI=;
        b=ePTHcWGqhHZ5kuAUiGLFKNgDVjnM6cZBduadtbMgOWyE9Kilws0pz51cMyLyYw0gyc
         RUN/wni94CRPPyQ2gDJGXW7Cf0bMaaiNalOkba+fYBRxnNkUdeFcJBmK1shdkWJEAJk0
         n4WwHMd5lgijwSXUT0Ju7J2vF6l9yMPRMeKUAhKdQDOwI0WLM0dQDs8uj0oV3bthwXDF
         ZuMYVVPtDVDQo/Yaa9wEaagzM8GKbSPU8Sau7do22vnhii3Os4Qxu3cyjrmVAkglN2vI
         Sl3tGp88qey+YMJsoVlifbovMhozGADtk+Mzgr6//jq0uadPs4BuUJktGZnYzax9T56h
         P1VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Thu, 15 Feb 2018 14:27:30 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@kernel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    David Woodhouse <dwmw@amazon.co.uk>,
    Dan Williams <dan.j.williams@intel.com>,
    Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] posix-timers: Protect posix clock array access against
 speculation
Message-ID: <alpine.DEB.2.21.1802151424490.1296@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592473683460033132?=
X-GMAIL-MSGID: =?utf-8?q?1592473683460033132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The (clock) id argument of clockid_to_kclock() comes straight from user
space via various syscalls and is used as index into the posix_clocks
array.

Protect it against spectre v1 array out of bounds speculation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/time/posix-timers.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -50,6 +50,7 @@
 #include <linux/export.h>
 #include <linux/hashtable.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -1346,11 +1347,14 @@ static const struct k_clock * const posi
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
 {
+	clockid_t idx = id;
+
 	if (id < 0)
 		return (id & CLOCKFD_MASK) == CLOCKFD ?
 			&clock_posix_dynamic : &clock_posix_cpu;
 
 	if (id >= ARRAY_SIZE(posix_clocks) || !posix_clocks[id])
 		return NULL;
-	return posix_clocks[id];
+
+	return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
 }
