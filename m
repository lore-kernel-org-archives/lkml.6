Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJNXARWejKN9bdyv5Y2mUkrxWhSwD6urJbYk8OM8O++oh+w1SB/eCLQ9jumS1uokQSpaSU
ARC-Seal: i=1; a=rsa-sha256; t=1525767210; cv=none;
        d=google.com; s=arc-20160816;
        b=I+UhN9ZW/ORupCx5ADHsV6AjEUDM3LCq/bvv8VOOqJaZt/30jZuuAm6iwlgTy9qLOW
         5OKQq2932laP4X0+Fgq48P7W7wG+IT5ikqYgC9QfBy5hVjwqa0W1jG8XUEidHQFLMhGL
         nr9+f6KGag3qi7OxyvbOg6cOq25HP4okC20oR7OVvj7iSjDWOQCw21LKTkoyO/7cxYZT
         2agtCwkFh+00hezS6e5NW1SwrgKKkiYHrOxMKxLZlnaxfYEYlZ/ceTJWReWOOlOkuwfo
         55zXkdr/BWkLyft44N6Xe5gTL+YLvTejzYglzcrd49eOKmsNa/aRnvflv1tZf7P8mhmT
         BJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ALqAkj7BDOHNIJRRs+d9+rmjYjUv4/AbG1LRQiDbDfk=;
        b=Cl34wtNb/tiCQahzvn7bKFUKb0E2Nv7hKOyakVX26IkhIZbW3swDu68+GmVOVaNirK
         JbhYVRIpuVfBSLEp45V7s8JQFOZeaJHd4Gnh3prWzLxVHvmOGBkRkLvQhoq2EH4Tog94
         PXmhhXIGP7dTfRLYILrDWs93kHlZHkUzY9vNuSZV2DJ5jdHgkkH9J6YxyWVclUPCVzoQ
         2ZYDVORJod+Ubq3JF7jC/l1DRAs9SlvN+x07dB8XChCCBFeFAExm7BWCXWlAZOb5o++j
         QGTlmNr7oH2E0YTFdlBtcU/t18FhWLSdi0RpkaK7+L/RIz9kEjPc2i2oMiV4t3F6cXpQ
         VxGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fj4p/IpU;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fj4p/IpU;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Diego Viola <diego.viola@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	len.brown@intel.com,
	rjw@rjwysocki.net,
	rui.zhang@intel.com
Subject: [PATCH 4.16 47/52] x86/tsc: Fix mark_tsc_unstable()
Date: Tue,  8 May 2018 10:10:45 +0200
Message-Id: <20180508073934.750997010@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882878667268725?=
X-GMAIL-MSGID: =?utf-8?q?1599882878667268725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit e3b4f79025e0a4eb7e2a2c7d24dadfa1e38893b0 upstream.

mark_tsc_unstable() also needs to affect tsc_early, Now that
clocksource_mark_unstable() can be used on a clocksource irrespective of
its registration state, use it on both tsc_early and tsc.

This does however require cs->list to be initialized empty, otherwise it
cannot tell the registation state before registation.

Fixes: aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Diego Viola <diego.viola@gmail.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: rui.zhang@intel.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180430100344.533326547@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tsc.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1067,6 +1067,7 @@ static struct clocksource clocksource_ts
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
 	.tick_stable		= tsc_cs_tick_stable,
+	.list			= LIST_HEAD_INIT(clocksource_tsc_early.list),
 };
 
 /*
@@ -1086,6 +1087,7 @@ static struct clocksource clocksource_ts
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
 	.tick_stable		= tsc_cs_tick_stable,
+	.list			= LIST_HEAD_INIT(clocksource_tsc.list),
 };
 
 void mark_tsc_unstable(char *reason)
@@ -1098,13 +1100,9 @@ void mark_tsc_unstable(char *reason)
 		clear_sched_clock_stable();
 	disable_sched_clock_irqtime();
 	pr_info("Marking TSC unstable due to %s\n", reason);
-	/* Change only the rating, when not registered */
-	if (clocksource_tsc.mult) {
-		clocksource_mark_unstable(&clocksource_tsc);
-	} else {
-		clocksource_tsc.flags |= CLOCK_SOURCE_UNSTABLE;
-		clocksource_tsc.rating = 0;
-	}
+
+	clocksource_mark_unstable(&clocksource_tsc_early);
+	clocksource_mark_unstable(&clocksource_tsc);
 }
 
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
