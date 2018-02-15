Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224nHBu2D29FkNPBhxeIrLW6EoKgZxbX38XUHXc9Zl8xhmBuq9XbXBIP4W7YmUtn6sfqAemD
ARC-Seal: i=1; a=rsa-sha256; t=1518709208; cv=none;
        d=google.com; s=arc-20160816;
        b=ehdef9E9QxfPgFvG/oYaspBHHxK/+567Tho3Jh1hdOXyHyg57kkn3TylgpUyOrc41F
         tDRkmxI7kk5cPFXw822eddXc21NLHREUSApaRuGDoNrlhi3kiiSbZcF+ApuKeaCDs4YF
         y9kdTJ225Ds/EmpHu+FSgPOmbhgO+bwO6NLXIOmMi54bEO4/33PQds4275/UKOWhwOWs
         IM8tybXt5FkL4ImId75kB8CxPQEk3yDmrWvggQRw1c77As9R/AkzmnbmgPv6OOcb0aet
         ImNrEMtGjGrWAwbutHzHR/1z2jXvwkLzBsvVcjlaX3LaunRBq1ArPo6IHF3pnnj25zOu
         P1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KWAt648QBbR3zieAPJlGJNp7QzjQcQCxyoP25UO47sA=;
        b=Vv55FyRVuC7NQbFj3wRWbmRK6gw4P6Veweib5Iw71F3MujvB9Xl5zeTGYNixY4on07
         Zf8TbKdBK8ntb0htj0KFZIrZ5dr2gYiFpog0kWbyItaLJkLTt5juAkFUBH8ke03Wf5Wh
         Ocapff2tTzTXJxBO0bHEAnJ5GlS0xYqFWIN4sQYMXWvLftUw3uQwE8KGTM5lakt69hZv
         XXWZJTNXp+NkhIWw34W1OFV2uhFYzEYSSJbt+ooPxqSeT8mVX7LVyDZ6gjobW5CyERv5
         zDJOSDDAu6fFoMpnGkAnMIMWsvcrIKwjgVz157tLMR5RK5f6Anjwve5dHUxJJQdwJpA0
         ElbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.15 008/202] watchdog: gpio_wdt: set WDOG_HW_RUNNING in gpio_wdt_stop
Date: Thu, 15 Feb 2018 16:15:08 +0100
Message-Id: <20180215151713.242766975@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481432327285756?=
X-GMAIL-MSGID: =?utf-8?q?1592482027561542087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

commit bc137dfdbec27c0ec5731a89002daded4a4aa1ea upstream.

The first patch above (https://patchwork.kernel.org/patch/9970181/)
makes the oops go away, but it just papers over the problem. The real
problem is that the watchdog core clears WDOG_HW_RUNNING in
watchdog_stop, and the gpio driver fails to set it in its stop
function when it doesn't actually stop it. This means that the core
doesn't know that it now has responsibility for petting the device, in
turn causing the device to reset the system (I hadn't noticed this
because the board I'm working on has that reset logic disabled).

How about this (other drivers may of course have the same problem, I
haven't checked). One might say that ->stop should return an error
when the device can't be stopped, but OTOH this brings parity between
a device without a ->stop method and a GPIO wd that has always-running
set. IOW, I think ->stop should only return an error when an actual
attempt to stop the hardware failed.

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

The watchdog framework clears WDOG_HW_RUNNING before calling
->stop. If the driver is unable to stop the device, it is supposed to
set that bit again so that the watchdog core takes care of sending
heart-beats while the device is not open from user-space. Update the
gpio_wdt driver to honour that contract (and get rid of the redundant
clearing of WDOG_HW_RUNNING).

Fixes: 3c10bbde10 ("watchdog: core: Clear WDOG_HW_RUNNING before calling the stop function")
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/gpio_wdt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -80,7 +80,8 @@ static int gpio_wdt_stop(struct watchdog
 
 	if (!priv->always_running) {
 		gpio_wdt_disable(priv);
-		clear_bit(WDOG_HW_RUNNING, &wdd->status);
+	} else {
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
 	return 0;
