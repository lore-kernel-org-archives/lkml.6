Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZomqFxuJmw5ttKhMKLF5YMlVlhstXEOACbE/OsobbUtVKN7TGTKQKI7N3roXt6VquV+cogs
ARC-Seal: i=1; a=rsa-sha256; t=1525116465; cv=none;
        d=google.com; s=arc-20160816;
        b=qLq7fTtoLkxnHqG9XgsPxDu9GlJsBwoSEqtAZkQ0vzxQENMeTg6fbzF/W3nrTg2gkP
         Sneb8Rwm0m4upL4qcniPDouxE+ePX6g1w08/vxvhjuvRjPcI86KYKO7qXXlWpeMFLios
         ADbeewM19Vi77dSHonogSZ/szUIU51gaSzVkqDaiEymMgdoL/EEnznoWmOhGDUQs703J
         063l/Pw3Px/O9mb6TnM0s94EWTXskE3RO8HX1sGcS45Ir8NcG/1Axfs1HIR/W4i/4X/H
         PT879s2hTsLWAwiFSmLXcWWo7hVOoqKsUauEUNhoIx2CA0zOu6cmm5VSsw9FSHIIluOV
         bCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=5vURY7NeJWYWvIpPKK6l3Z8N12Wq1S+9oLIwmo///oc=;
        b=C5E3qAvMwnC/eLkvZ5YB5TWO+y4DkhaxtvHKK51OR1nhEl/6e5phKS0hhJRBjYRUet
         tAV0GsIYU0EVcV6cZ4ZjA5IUEtlZ74nF7Zgw6MgmlgLA9ddzleTrcGs3vOHy7g8k+MD6
         aJK63KQZqi3zH8dNOIVnSJHOYl1yHD57sIbiMD/v5PyEsj01ciKHUfMXbg4bVIKsjDkF
         Yug2pRJtEqSTfSdE4gOu1CV7MjSOsL1OPgxZRPYd/FtdI8RI38eySZU8HjlFWY7UmujT
         Th9Rc7EHq4HQQPhKimMG8mrQ5RUO68rQ6wOLJevDU8+lhXdvd9Gxrz5bSvgRKhHfIAG4
         9Vjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE41322DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Wan Kaike" <kaike.wan@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Marciniszyn Mike" <mike.marciniszyn@intel.com>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	linux-rdma@vger.kernel.org,
	"Dalessandro Dennis" <dennis.dalessandro@intel.com>,
	"Fleck John" <john.fleck@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	"Weiny Ira" <ira.weiny@intel.com>
Subject: [PATCH 4.14 88/91] tick/sched: Do not mess with an enqueued hrtimer
Date: Mon, 30 Apr 2018 12:25:10 -0700
Message-Id: <20180430184008.883885070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200604161832938?=
X-GMAIL-MSGID: =?utf-8?q?1599200522722151670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 1f71addd34f4c442bec7d7c749acc1beb58126f2 upstream.

Kaike reported that in tests rdma hrtimers occasionaly stopped working. He
did great debugging, which provided enough context to decode the problem.

CPU 3			     	      	     CPU 2

idle
start sched_timer expires = 712171000000
 queue->next = sched_timer
					    start rdmavt timer. expires = 712172915662
					    lock(baseof(CPU3))
tick_nohz_stop_tick()
tick = 716767000000			    timerqueue_add(tmr)

hrtimer_set_expires(sched_timer, tick);
  sched_timer->expires = 716767000000  <---- FAIL
					     if (tmr->expires < queue->next->expires)
hrtimer_start(sched_timer)		          queue->next = tmr;
lock(baseof(CPU3))
					     unlock(baseof(CPU3))
timerqueue_remove()
timerqueue_add()

ts->sched_timer is queued and queue->next is pointing to it, but then
ts->sched_timer.expires is modified.

This not only corrupts the ordering of the timerqueue RB tree, it also
makes CPU2 see the new expiry time of timerqueue->next->expires when
checking whether timerqueue->next needs to be updated. So CPU2 sees that
the rdma timer is earlier than timerqueue->next and sets the rdma timer as
new next.

Depending on whether it had also seen the new time at RB tree enqueue, it
might have queued the rdma timer at the wrong place and then after removing
the sched_timer the RB tree is completely hosed.

The problem was introduced with a commit which tried to solve inconsistency
between the hrtimer in the tick_sched data and the underlying hardware
clockevent. It split out hrtimer_set_expires() to store the new tick time
in both the NOHZ and the NOHZ + HIGHRES case, but missed the fact that in
the NOHZ + HIGHRES case the hrtimer might still be queued.

Use hrtimer_start(timer, tick...) for the NOHZ + HIGHRES case which sets
timer->expires after canceling the timer and move the hrtimer_set_expires()
invocation into the NOHZ only code path which is not affected as it merily
uses the hrtimer as next event storage so code pathes can be shared with
the NOHZ + HIGHRES case.

Fixes: d4af6d933ccf ("nohz: Fix spurious warning when hrtimer and clockevent get out of sync")
Reported-by: "Wan Kaike" <kaike.wan@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Cc: "Marciniszyn Mike" <mike.marciniszyn@intel.com>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: linux-rdma@vger.kernel.org
Cc: "Dalessandro Dennis" <dennis.dalessandro@intel.com>
Cc: "Fleck John" <john.fleck@intel.com>
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: "Weiny Ira" <ira.weiny@intel.com>
Cc: "linux-rdma@vger.kernel.org"
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1804241637390.1679@nanos.tec.linutronix.de
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1804242119210.1597@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/tick-sched.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -820,12 +820,13 @@ static ktime_t tick_nohz_stop_sched_tick
 		goto out;
 	}
 
-	hrtimer_set_expires(&ts->sched_timer, tick);
-
-	if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
-		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
-	else
+	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
+		hrtimer_start(&ts->sched_timer, tick, HRTIMER_MODE_ABS_PINNED);
+	} else {
+		hrtimer_set_expires(&ts->sched_timer, tick);
 		tick_program_event(tick, 1);
+	}
+
 out:
 	/*
 	 * Update the estimated sleep length until the next timer
