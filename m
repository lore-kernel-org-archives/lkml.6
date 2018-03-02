Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsPDYmskoexLRKqT9NFBkfjqHW1ul8EsuJSw1Uwix9bm/j7wHTlmraz0nNXmdS5dThC3Abb
ARC-Seal: i=1; a=rsa-sha256; t=1519981043; cv=none;
        d=google.com; s=arc-20160816;
        b=aQBKDjMBQjHmhPF3etJT//h3OdUhO2wrkZKTlDXKYiXU044spiH/L5ugQlD6kQGZ9s
         iDvucx4Ipix3/RETF/8fpelA4oR9YQD93ppIPLnSzkATsYdUFAc7Ouksnj5WWlgcDHgD
         8RxSZDfXH+TyJ0BdzagP3kNf9sjhvaHzd1Q9E84iz3LGSf8SaXIitOzM1VVLA/fGcysp
         cBAIdMQWXUaio3F+QoJ4QDF9xP6bIYMh4i/QboSjGYQc4avWFbUt+T4yP08gFbQ0MoqV
         N1e/MAu92UvZBX+UmBbA7OnKxOvn2tS95K9W3JQkbsUHaVz/MmReUI9JfRHR+ENZa4/J
         N/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PGEqqXItbC9IU0zDTPdL1NU0sheZGr2vna5ShnXUgXY=;
        b=RjEyW20do9FWq+RvhGn/ekLsJrtG5XIZsOXtQCjJN+67EDnzxFS0dwpFXhtJps2Kia
         7VGXkeiovonENtygj8kIyIyXofvdsvhNj6WzY4PL/4yhkK31Uv9SFRyr0z22YrF427h7
         c2kAzvD/JkXhjJBxrK5fR0RUkYXBIql0Q44+RYZHONi75lNi8x1ruSkMjp20dQtFM754
         TvhvfIiLzclSU+dYBUP+udQ5+40P5gGia9NbcROpDcav5jVJrl8vNBFfwq6jTnk2CPvB
         AuPrhy3ZbueO1tKpXoeMZrsttQxutb2kCuxyiuP4CWzy3bnRUWzM9LFjoRRoG5ZIrDJx
         54Eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dmitry Torokhov <dtor@chromium.org>,
	Joe Perches <joe@perches.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 32/56] genirq: Guard handle_bad_irq log messages
Date: Fri,  2 Mar 2018 09:51:18 +0100
Message-Id: <20180302084451.205385572@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815642898421195?=
X-GMAIL-MSGID: =?utf-8?q?1593815642898421195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>


[ Upstream commit 11bca0a83f83f6093d816295668e74ef24595944 ]

An interrupt storm on a bad interrupt will cause the kernel
log to be clogged.

[   60.089234] ->handle_irq():  ffffffffbe2f803f,
[   60.090455] 0xffffffffbf2af380
[   60.090510] handle_bad_irq+0x0/0x2e5
[   60.090522] ->irq_data.chip(): ffffffffbf2af380,
[   60.090553]    IRQ_NOPROBE set
[   60.090584] ->handle_irq():  ffffffffbe2f803f,
[   60.090590] handle_bad_irq+0x0/0x2e5
[   60.090596] ->irq_data.chip(): ffffffffbf2af380,
[   60.090602] 0xffffffffbf2af380
[   60.090608] ->action():           (null)
[   60.090779] handle_bad_irq+0x0/0x2e5

This was seen when running an upstream kernel on Acer Chromebook R11.  The
system was unstable as result.

Guard the log message with __printk_ratelimit to reduce the impact.  This
won't prevent the interrupt storm from happening, but at least the system
remains stable.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Joe Perches <joe@perches.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=197953
Link: https://lkml.kernel.org/r/1512234784-21038-1-git-send-email-linux@roeck-us.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/debug.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/irq/debug.h
+++ b/kernel/irq/debug.h
@@ -11,6 +11,11 @@
 
 static inline void print_irq_desc(unsigned int irq, struct irq_desc *desc)
 {
+	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 5);
+
+	if (!__ratelimit(&ratelimit))
+		return;
+
 	printk("irq %d, desc: %p, depth: %d, count: %d, unhandled: %d\n",
 		irq, desc, desc->depth, desc->irq_count, desc->irqs_unhandled);
 	printk("->handle_irq():  %p, ", desc->handle_irq);
