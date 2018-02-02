Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224MV2JL2h1o0vVGrBufPPLTev2fLpR2bpMfjsFKLM2lvx7TZ+efIyQ/Hj3yEcwTTDuuIiqH
ARC-Seal: i=1; a=rsa-sha256; t=1517591228; cv=none;
        d=google.com; s=arc-20160816;
        b=FzGQvMoFdW9CRavrkPSJRbzvD8h9cNqlzZ+tyw+o0ZsQCfxKp4sUYEBJoB5olsrkxs
         LCTblmISQ+uyDVjQ7E5tRZUbOTHkujHL94/xm2paw8EHS+M9yhPtH/2mj4HablG9Hwo6
         /oBVsZs5/j0lV2hUvV1c/5DlwZLqCqokILkrOvElwbc5/DKZna57xfHnBH5xjCQsMreK
         NVCpEy89592EQwNffesryOxinwli53c7UyuXBFGozeVe70eCpn+3Ke48cCE5JfmDo41p
         KSqlAPP9TvZdUhuNYqCR5AINTuaf0qNx4eJHW8TaQ4WD0ZvzmdMckzCLGhtrEFwjv9b3
         nCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XdiWZ+m4ySFt9SVnLEkwxZCbK0SBRW3shFR6WCqoOFs=;
        b=kafT8/vKfKn1eKG70lKq2qJrpGvo/J+2ac24cPaklhlW1oFSEnYycPojESaPsN3wkT
         eBV6bBLZT6RFK1ufuugMtLSbJ1PPInbjRjaug/hOzE91a1LPGYAGY3IMOwiurIU8AFYp
         jDF/QZcfsz3TaBG/kpnhV+PLhElyqbp0oX7fx2b+AicKY6P/yenOL/LjNGWc4X26a+7x
         hMe/PgmUNlPfHYyRm9jvPi4wyrv/NVaMPv75pWVG24MCD4tZcNlmdD6ArVBPuYdVUU8f
         /8F2f/4Ztgxi+JzW9Yugz+dqZNeu+HFtzJ+atG1jiQdvegsKw2eToJUpkk/kOcSkiFak
         Rlvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dave Jones <davej@codemonkey.org.uk>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Ozkan Sezer <sezeroz@gmail.com>
Subject: [PATCH 4.14 001/156] futex: Fix OWNER_DEAD fixup
Date: Fri,  2 Feb 2018 17:56:22 +0100
Message-Id: <20180202140840.309210764@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309740904584915?=
X-GMAIL-MSGID: =?utf-8?q?1591309740904584915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit a97cb0e7b3f4c6297fd857055ae8e895f402f501 upstream.

Both Geert and DaveJ reported that the recent futex commit:

  c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")

introduced a problem with setting OWNER_DEAD. We set the bit on an
uninitialized variable and then entirely optimize it away as a
dead-store.

Move the setting of the bit to where it is more useful.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")
Link: http://lkml.kernel.org/r/20180122103947.GD2228@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ozkan Sezer <sezeroz@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/futex.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2311,9 +2311,6 @@ static int fixup_pi_state_owner(u32 __us
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	oldowner = pi_state->owner;
-	/* Owner died? */
-	if (!pi_state->owner)
-		newtid |= FUTEX_OWNER_DIED;
 
 	/*
 	 * We are here because either:
@@ -2374,6 +2371,9 @@ retry:
 	}
 
 	newtid = task_pid_vnr(newowner) | FUTEX_WAITERS;
+	/* Owner died? */
+	if (!pi_state->owner)
+		newtid |= FUTEX_OWNER_DIED;
 
 	if (get_futex_value_locked(&uval, uaddr))
 		goto handle_fault;
