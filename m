Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4++rt6J3oI25PgB8+xVsH1jit1sc6OFstCSArDl0fbCHc9U4gUVdGDBtQuyFIK2w8wsDdlB
ARC-Seal: i=1; a=rsa-sha256; t=1523399198; cv=none;
        d=google.com; s=arc-20160816;
        b=0T04mtNmxfxSo1Mvfpi+BLFZJVclrWza9RllC/9AdWAnmWKh93An078BiGafGvE1IH
         ynbwcfkbschiQtZ0WhMa7MIrjpnfq7GMSoTaHeNpPKxnhlnmorEmbaPm2Vxro3qYN0gT
         gydxIGDg+IucTDkbkToei/Ppnz0i+YWaa/PsxvrE4IUa7RfbMhDW3GA5aYuDdM2Zi8Ec
         uPK7NInu37OAKknnMugfBX5bEqpySIBQgfBeJoA5tizglVoDzGVTwuNV3bT0PTqSbRQX
         dBQrr2tdhhtkD1vQEMyt7LV/7QJJ4nSV/g6MEl54EVDUi18oSj4UiUQOWyJZhE3s07bX
         TldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iRMQ+SOjkgZjt7o885AXoJxSKsNyS4enJTs3EgCiaRc=;
        b=evXKV3kMz/LoULgLKKQsqMogez+eWAj5EMr792kbyd5cN8YJkCo2kP16n8I4w7DYu8
         IGYpsDuCLEb5XOZ8m5Ia+HEmU0vXA0/n0PxhdzMClD1GT5559ihiyDy4Hy/oUfXvzwtS
         o0LEM+Q2yWRqMD4hSedV+UacNWlKVP1tX9QC/r++X+6fxmKshIyatTQDum4Y4moKtiKf
         pH5LOwd10e62dRRlOW6FbDZl5358cAiUjrzSS2jgu6EnEHsqyX35URy8j7/wz7cL4q8U
         FErmILy+OjEDuTsKWgW7fkZWamRyDxiSeX8SMstaW0VBYkdT8IVYsV4wgjd7LJU/KiHZ
         GlGg==
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
Subject: [PATCH 4.15 022/168] watchdog: dw_wdt: add stop watchdog operation
Date: Wed, 11 Apr 2018 00:22:44 +0200
Message-Id: <20180410212801.146104435@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399838237859694?=
X-GMAIL-MSGID: =?utf-8?q?1597399838237859694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
