Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/t4PYXrXqsXXyjIBZCbPOi7ysskHyOjYdyA6RpWANWS0HUJQd5sZWIvXUXqGGJSNDc8/aC
ARC-Seal: i=1; a=rsa-sha256; t=1522168633; cv=none;
        d=google.com; s=arc-20160816;
        b=Iw2fy6W9LEmQSJLhuEckxvsHwzPuD++kHtwBU/G448Z/BQqHtVrZrj+U/ERtblc3UC
         9u+Rt/6q7X9tEhVJcxbXZ0Y1hKUmE7IPT6r/o0GI2xE+n5iBgS8F4o8r9eygKE+LfcRq
         13iH9v5D2DxQxV9rdr3q/QegkQ4MZajJi2838nmLv4K+uT+QtIgfOXSaNycR/LjRdG8k
         a6f9pD+vnD1Nw3SB9mY5L2K3CrIMrnH9/cgKQ54WNrytndGSKdDmz5tGUoU6/3e407o8
         rT+EQVYLAr5VphYc4vuoV1A3dcILjIHHo+ppr1mnHzsZ0NMjl81386F4FiZ4f9QWPfaC
         vDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3SVFXDrX1cX2x4qakPL3TbfpZ8oiRO24KWfpY4gTZ+0=;
        b=0+n3eJMgbP16hmusgFLCBJ9HHIJjKu5+lgaSnccHE/AR/IgYQub3CimPQuGLotl9wX
         Pg6I//lYs7GZlE89ADQaFtgBwxODgzn10HDnf+qcUYtyUwBDFaS678ZGJeceEKep2WPO
         k/bM/E5Vw5WDPnEmc3knaA4y86Txgfc3kaJgpETtoETvB27OlAsp0nXG9Iz399IYd0xL
         bEOAVNi/37B7PPQah5FtWFrA8qQVG5veluGLsx4c9HnZiR/pecO4NI9mtjm5/tCk53LX
         8rIGTkK1uoPbuVobUib4ISb80JCld2cF3VcMGEby+8dnunreZ/7Q/qXGWoHFZoKbAsLv
         Q7lA==
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
Subject: [PATCH 4.14 060/101] ACPI / watchdog: Fix off-by-one error at resource assignment
Date: Tue, 27 Mar 2018 18:27:32 +0200
Message-Id: <20180327162753.678058048@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109157701548644?=
X-GMAIL-MSGID: =?utf-8?q?1596109497093837852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
