Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48STuboVLUqfT4JWaI3Z4m1Av9qs44mcaDEyCsmCajTvuCNKHXs1sW74WeBWrXfWMhLYwy/
ARC-Seal: i=1; a=rsa-sha256; t=1522168309; cv=none;
        d=google.com; s=arc-20160816;
        b=q9U174wlJEV5jeOS2ovN6TQ+KO1jyM2n9SRzl/Uur6howfbaPdfHJMqbu+iJ0HLXx5
         Ju1RUjuPuwTNOW3YczaFN9cTQap1A7d4Cmqm/i1bRlcq64ICUsyfMTbnKOhiblR6t/Um
         8E7BWmO0vQK3HBtQ1xH30HD4DUGNTset57p9iiEdDntCFDcFAqns8Oh1EHuh8CzP053P
         YOYJrpSDY5ExNrHBLmqSLTxk8orK+AzzMOut+e3Iq744Le6qavchsaAUdQIWTVMj+APX
         6kN4nQ5kdzbxtIiCwHJh/m1vfFE3p6Q1QFVRjaZwLCa77HLrBeoLYgK953Mx8KZ/f90o
         h3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PKANTlOIUy9vDUKzDCN7OvymnNV6h9Onohsm/O/WnTA=;
        b=Db6pXYesfN+6KbC306bBxITA1lJET89zZqYxxv7EWcY9yB2gXajXlJPluSso1VjesM
         fyBK8SAAR4Ex5yc8XO0huvlawl6Mpu4jBFRkRMdKsjTcyZ5k4GXUvhW9j1DRkBzHv0R0
         D0b7/cL7MNy/vrrh+JTWvY/VUgByecI8kh9VujuR8PGWpynmygvaDZ3XrtroKMzCRlpk
         K6P3FaqPF5UZoVd4fsg1p9nvwDOu/+rWY1IDCuN0aGSDo5Hy1moaKjasooeD8Hxs/DZ3
         f7gvibZpnZkGENrtpGnOqnZMpwyNYTY+3yRfvxpeJE43m9kqfmM7h0trcNFEO6Z7YkQ8
         wnlw==
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
Subject: [PATCH 4.9 33/67] ACPI / watchdog: Fix off-by-one error at resource assignment
Date: Tue, 27 Mar 2018 18:27:25 +0200
Message-Id: <20180327162728.825261393@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109157701548644?=
X-GMAIL-MSGID: =?utf-8?q?1596109157701548644?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
