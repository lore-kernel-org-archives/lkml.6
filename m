Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225WBqovecGBJeNFAUgH65c23XNCMwY7kTD8t4kBnzFgr4jmYpt9pXase6OfEOQzYzXM5RMD
ARC-Seal: i=1; a=rsa-sha256; t=1518708542; cv=none;
        d=google.com; s=arc-20160816;
        b=pHlybKg29cCfryPAJnhuEdRl3dw1sFlRsQMPBvBofRgaawtT6XRd+EuwSzh4kXl8Ac
         FehKzD1NNKlGXnPn2EG9sBy8Vu6TxJIdoSR1DldjfWDXjuKXy6kwWM5DF6MDXuIAEPjJ
         Ukximh1opONsNAeek4siW8+rSnxgEWRHLyQjd+tfeCz8Bh9br24B2eD3nnRe9FJW63Lo
         WuDHu2ir4OGxt20+xVCWGCtBDTcIonc1CwtLyMqWUKTn0prbQEZu8IPzsJdcl0vyzr0V
         7IVP1y0fVsU9hPWTTwRpULUCt1KoT+hBzRSsOoh49f7sPIQYyY71oKslgbcEcdQUj9vQ
         lqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rX4TrAITbric8WLnOHAyXG2oeUwM/qMus53sohZJrM8=;
        b=ls/FmpAjP1Aj8KpwgZrjEfzDG6Jj3Uiro8eKWrKa6ytI7VBeB3gYSCZaDQpwuAgWQy
         3Z3reN7aGqDHbV9jqjrDAZWNXEiNvKJIF9d5sJqUY+O0qjZoXveaEc7IJC5PYos2b+Rq
         U04xila3hL8wfwTt9Dd/ifP7JbUwo3f14zZu11jdyVwpuOrZ/yv1t64NpV+5eHQ0RaxT
         yWxGyrs++brNGzeigtQYr7heGprVw9sBSiWzvs5A+GMV3aIYPTe5AsC7gS/BThuVZQpN
         X3pdxNS0DQ5ws3pB5V4WR0adK/96ulfqRmmAu0wp3XgdtwwgqaCgR2M4hMURq36wtKjY
         uT3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 79/88] clocksource/drivers/stm32: Fix kernel panic with multiple timers
Date: Thu, 15 Feb 2018 16:17:46 +0100
Message-Id: <20180215151233.379185763@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481328881100726?=
X-GMAIL-MSGID: =?utf-8?q?1592481328881100726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit e0aeca3d8cbaea514eb98df1149faa918f9ec42d upstream.

The current code hides a couple of bugs:

 - The global variable 'clock_event_ddata' is overwritten each time the
   init function is invoked.

This is fixed with a kmemdup() instead of assigning the global variable. That
prevents a memory corruption when several timers are defined in the DT.

 - The clockevent's event_handler is NULL if the time framework does
   not select the clockevent when registering it, this is fine but the init
   code generates in any case an interrupt leading to dereference this
   NULL pointer.

The stm32 timer works with shadow registers, a mechanism to cache the
registers. When a change is done in one buffered register, we need to
artificially generate an event to force the timer to copy the content
of the register to the shadowed register.

The auto-reload register (ARR) is one of the shadowed register as well as
the prescaler register (PSC), so in order to force the copy, we issue an
event which in turn leads to an interrupt and the NULL dereference.

This is fixed by inverting two lines where we clear the status register
before enabling the update event interrupt.

As this kernel crash is resulting from the combination of these two bugs,
the fixes are grouped into a single patch.

Tested-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1515418139-23276-11-git-send-email-daniel.lezcano@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/timer-stm32.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -106,6 +106,10 @@ static int __init stm32_clockevent_init(
 	unsigned long rate, max_delta;
 	int irq, ret, bits, prescaler = 1;
 
+	data = kmemdup(&clock_event_ddata, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
@@ -156,8 +160,8 @@ static int __init stm32_clockevent_init(
 
 	writel_relaxed(prescaler - 1, data->base + TIM_PSC);
 	writel_relaxed(TIM_EGR_UG, data->base + TIM_EGR);
-	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
 	writel_relaxed(0, data->base + TIM_SR);
+	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
 
 	data->periodic_top = DIV_ROUND_CLOSEST(rate, prescaler * HZ);
 
@@ -184,6 +188,7 @@ err_iomap:
 err_clk_enable:
 	clk_put(clk);
 err_clk_get:
+	kfree(data);
 	return ret;
 }
 
