Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49FbkZF2qifb5NQUlAE5jNm7YunyznRtGkeO9WHQyAPiuyRyo7Un5dM2VIzNMnaErZFcB9X
ARC-Seal: i=1; a=rsa-sha256; t=1523399663; cv=none;
        d=google.com; s=arc-20160816;
        b=X9K8ma4b1oLrnrjcU1qlyFd+AJSnlMzavItDEHnP/nM7NWI9rUJtoHrC8b7Kv6f95h
         ZHxrrNvyu6AwwoaVYWjZ3LiKL21ldsUtdVjnH66TzIOGq8+ip5IPM+at3NOli9MxKozU
         A4ZmqgmhC1wYjw9yHgfLw4SnbcHedATcAfcHNCJ8cSNOL3qgxOoKEYA9NeOnhrljaa9m
         fajrxwJGrMeJONEG7H7kRH1sHhQiEp3dnwbLQvME+94zY4jKi1TW3tnNVnPF3dXAT3WN
         jcgfsWKwoiBHTbqczC0sGM7S6uAJ4NGBsZix+jvN14uWd8aGXEm+z4yJOSB9vIDVYXES
         r0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e/n4KpbMjiaIR+HEeOR+c07AgdKRCQEzSXtCBpmogLU=;
        b=blm1f5TaZ2hbkcg7Nu2YGEN5puO8EgeCh+kCo8AMISy9YimFajMcZScUSeTbxRNesr
         +hO5igvDlN1OZyZfBShUpdzDp/QpAAJXxh8wmVf9Cqs/e7LvP9D0EKFYjCthf0E21W3X
         6EpjJj2e8vr0ULNJi0su1/TeqBS3U9J8sJzezuVixIfZ7R04cytAl+4TD05UK951CdFj
         b1q9gYbaDmyLJ8G7W7ujzjRdIlEUEhDbDNB5byndVi7abU6wZ8Iqm0/InXzD/Bk7KPT9
         5v2qjyrSvWHkKLLfrdYvL2/N6KEwoTqbESRFKesZoCpovlbQ3V2xWB+tGCxS9ljFxZOk
         N5RA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 019/138] watchdog: dw_wdt: add stop watchdog operation
Date: Wed, 11 Apr 2018 00:23:29 +0200
Message-Id: <20180410212904.317032823@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399838237859694?=
X-GMAIL-MSGID: =?utf-8?q?1597400324936861693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>


[ Upstream commit 1bfe8889380890efe4943d125124f5a7b48571b0 ]

The only way of stopping the watchdog is by resetting it.
Add the watchdog op for stopping the device and reset if
a reset line is provided.

At same time WDOG_HW_RUNNING should be remove from dw_wdt_start.
As commented by Guenter Roeck:
dw_wdt sets WDOG_HW_RUNNING in its open function. Result is
that the kref_get() in watchdog_open() won't be executed. But then
kref_put() in close will be called since the watchdog now does stop.
This causes the imbalance.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/dw_wdt.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -127,14 +127,27 @@ static int dw_wdt_start(struct watchdog_
 
 	dw_wdt_set_timeout(wdd, wdd->timeout);
 
-	set_bit(WDOG_HW_RUNNING, &wdd->status);
-
 	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
 	       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 
 	return 0;
 }
 
+static int dw_wdt_stop(struct watchdog_device *wdd)
+{
+	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
+
+	if (!dw_wdt->rst) {
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+		return 0;
+	}
+
+	reset_control_assert(dw_wdt->rst);
+	reset_control_deassert(dw_wdt->rst);
+
+	return 0;
+}
+
 static int dw_wdt_restart(struct watchdog_device *wdd,
 			  unsigned long action, void *data)
 {
@@ -173,6 +186,7 @@ static const struct watchdog_info dw_wdt
 static const struct watchdog_ops dw_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= dw_wdt_start,
+	.stop		= dw_wdt_stop,
 	.ping		= dw_wdt_ping,
 	.set_timeout	= dw_wdt_set_timeout,
 	.get_timeleft	= dw_wdt_get_timeleft,
