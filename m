Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Q5orM0bRRpffdQOxb5EOkBeTaL1/gazVMjE+V4yIXxZcHmPxEaV5XzYMJiN+mGIRRA89o
ARC-Seal: i=1; a=rsa-sha256; t=1522168883; cv=none;
        d=google.com; s=arc-20160816;
        b=Jyq5g4GuqsmTsB/APjHNQs+vPWm8GLQS2ZMNqO6rypL3zmSnVDhhxRtnKEggrdIocj
         4MR9/8zN2HuGaCijYKWJ31B2L+PMeFyOCEBcqYnk/Tbuz8wYam+duyb1hJYFSHpOEfkE
         APbtytri8kJU8TxLL4xOsyS+snsdr3zMqyn37YacTwBpjI1BDFMK/ocvsC5CdVOFwaJL
         SOGe6RGups0lKkosiqEf35ibNf6nS7H7QpF5bW9lguNA1NX1yIc//L9XG5PUiaLVvnND
         39aSo50Iekt9MqDlPtJk2aMDYoB+9/hXyto/VthbfkbK9LhnQpvkiA8mzF76ym91jVzC
         m78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/814o5Xw1iUZeIrAQuNx4m/TEM9PpGUpQVjYySi0zrY=;
        b=xJAG54r0WR5vY/CO2r9BsIoZ0HN5rF0i+bntYR2FfTMIMuV3JWHtLC1ZiTzWl7YCRp
         l5/7oG2DkeqEDrZ0a23ZmGrfQ9nSzX8b5zEpAtONiC2LYAc6r3h8vedAOQvycSjpVY6y
         A9qJq/ueYTV+FxNQx2Mw3YXcSnxtLsJmMOrT1WUnn+xiI03l61kod6obv3NwnH+gGs7T
         1WENBgYHtSxTluMcJuU5uxh5F+dq7yr+3NBB7b5D37ka4ccQusFK9jWWssXHez7gex9U
         3BqwXpLyMQLXWBw1SozCtNpP8a3GLHTSL7b5d7rfmISXwaw8SwLbP2ViH9RqHPTKS1Eo
         SM8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.15 065/105] ACPI / watchdog: Fix off-by-one error at resource assignment
Date: Tue, 27 Mar 2018 18:27:45 +0200
Message-Id: <20180327162801.706198836@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109157701548644?=
X-GMAIL-MSGID: =?utf-8?q?1596109759041196250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit b1abf6fc49829d89660c961fafe3f90f3d843c55 upstream.

The resource allocation in WDAT watchdog has off-one-by error, it sets
one byte more than the actual end address.  This may eventually lead
to unexpected resource conflicts.

Fixes: 058dfc767008 (ACPI / watchdog: Add support for WDAT hardware watchdog)
Cc: 4.9+ <stable@vger.kernel.org> # 4.9+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpi_watchdog.c |    4 ++--
 drivers/watchdog/wdat_wdt.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -74,10 +74,10 @@ void __init acpi_watchdog_init(void)
 		res.start = gas->address;
 		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 			res.flags = IORESOURCE_MEM;
-			res.end = res.start + ALIGN(gas->access_width, 4);
+			res.end = res.start + ALIGN(gas->access_width, 4) - 1;
 		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 			res.flags = IORESOURCE_IO;
-			res.end = res.start + gas->access_width;
+			res.end = res.start + gas->access_width - 1;
 		} else {
 			pr_warn("Unsupported address space: %u\n",
 				gas->space_id);
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -392,7 +392,7 @@ static int wdat_wdt_probe(struct platfor
 
 		memset(&r, 0, sizeof(r));
 		r.start = gas->address;
-		r.end = r.start + gas->access_width;
+		r.end = r.start + gas->access_width - 1;
 		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 			r.flags = IORESOURCE_MEM;
 		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
