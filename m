Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpz6w7ZUz9u1deyOX8eckdFbjnkcxof/wMRpOOj52Lfni88NgF9YcI4rw0cbKEEakwSQ8Ax
ARC-Seal: i=1; a=rsa-sha256; t=1525767222; cv=none;
        d=google.com; s=arc-20160816;
        b=XgZ/kvduOzuLZ8HZ8YbF3FSADsjAWG+vRcEa/AmQmryQ74MdN7jxwd1+SVEthHxEun
         tunUFUH87/nZphoH6jgpIrxKaWnYaetuFUbInU3GZoVytdqIYasOIhSB2nMs5V4mVP0K
         yyMkzXUkyJUgKEcgN3QJI+3kEyanUNmvinnJ8VDpqSZCwqpWXnlowTMhXrsA1Up3U8Jt
         Q6IMDYGBTpQwQBOaQHVNUh2Xr92YLnN1uD90jxDZLacKeh3vh2mMXH9rHLnZtYC0VmJk
         EpDMps8N0exnwMmvdI8OBSalXNijlRl0zwQXQ2GN6U8fyvsKjeCjcza2DB3i8jWZa7lw
         pXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QSL6x+uq/wHtyF9xjxYOufmDWl4W1hGOdYgBCjHRfR4=;
        b=u3hvMkvJqQ/4oeKuUOPY7rUQFHxVmQk8Yy/l5ID0kk9ghicL1HMQ+N8Jj4wDEG2YDO
         YyjXz1Hf6Q4EtROIZ64IBx1zxGdp6RBlkQmCoWk8HFvxozcTt4R4mf/AT7MC1jPRBbdE
         W4xn0drZIXEhXe7OeL2Vvb4PnmDNniYZN4xbhz8Yv7oF7c/xjC9msLIKvEbokvcSyDqu
         idtJNDc6WL70A+9i8VHg3sLc/XLpiY9wujlJizqGp3Rll6HXuT/HHUerd4v/c+QCt82x
         iF0qOKFRn6dGL3nMUPDeC0ueDqFLt6pHVuoXoaFgsJrph+Ilg3hIb2j5sCwZGc9ziNVW
         EdGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Igt8QuY0;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Igt8QuY0;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	len.brown@intel.com,
	rjw@rjwysocki.net,
	diego.viola@gmail.com,
	rui.zhang@intel.com
Subject: [PATCH 4.16 51/52] clocksource: Consistent de-rate when marking unstable
Date: Tue,  8 May 2018 10:10:49 +0200
Message-Id: <20180508073935.333431008@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882891119865062?=
X-GMAIL-MSGID: =?utf-8?q?1599882891119865062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit cd2af07d823e5287cd6c91d54337348c2a873462 upstream.

When a registered clocksource gets marked unstable the watchdog_kthread
will de-rate and re-select the clocksource. Ensure it also de-rates
when getting called on an unregistered clocksource.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: diego.viola@gmail.com
Cc: rui.zhang@intel.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180430100344.594904898@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/clocksource.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -152,12 +152,19 @@ static void __clocksource_unstable(struc
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
 	cs->flags |= CLOCK_SOURCE_UNSTABLE;
 
-	if (list_empty(&cs->list))
+	/*
+	 * If the clocksource is registered clocksource_watchdog_kthread() will
+	 * re-rate and re-select.
+	 */
+	if (list_empty(&cs->list)) {
+		cs->rating = 0;
 		return;
+	}
 
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
+	/* kick clocksource_watchdog_kthread() */
 	if (finished_booting)
 		schedule_work(&watchdog_work);
 }
