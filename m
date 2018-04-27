Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoTTXrBxjHPGWwQPSX+MTfhvDJrQWhzJA1MDIkTypflfCPGEb2jNx0+oy+/zaxYNojVokyv
ARC-Seal: i=1; a=rsa-sha256; t=1524838374; cv=none;
        d=google.com; s=arc-20160816;
        b=fz/mo9ziQ2M3CQZQ+4FJo9lI9AMscNgNsJTfSuLKzHmeHh3LqbAQVP+p+Gaw0DHGIM
         VobxV55rr1iWyddf0DEbj5b2UCpIkp2E+JNVyLgy8idzM+O/SQCAN7Q5bNgUf/EZdonO
         R/EOf/G4NMzr7YY7E+EgSNF2z9gU+NYuuSRUZioesFemRr6mrNxiiohVhPbrlzS9oeef
         sICsImIERFt1G+EF3tZlpTRExdAtVwkA4mSPBYQ50MohNXPWIGiwY7l7vhxG1mjJanGz
         3iTZa7BO3miT8W78w8oNvl5hNq0YytQjyeQSZBJszM0S4TtGfnQp7bpekJ44du0wt9XT
         EP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=O7soOWFjB1Kznz5aPuU/MCCV+ELgOlnbd70euLByPsg=;
        b=nddU3zKPCHAU1eYtkj26PghxfmdgIBxDbrzYOUIc3lWel0XG8ZbTT+ngiB/pFJYO0e
         IDW/p3UNjBoHBwnjeOisoRDSXeY48IR0PxFtFnMGx5nYhVSuaFm61yaPrJ2f5rl9y7Mj
         4ZY4m+zJcOpgatyG7N1H9PZMQE7ui+k+cz/o17nXpOBFI9BcQ2V5seU9cnGHhv6hgzO2
         GrMrVZ0IYvaP03GYJBkBOkfERWBvq3nNUNyZmnc1wBLpzJaF8F2ful4xL6y1NSM8PP47
         Np+8wEhemuEFCMUb0Fy8ff4f/eKUXhxgulS6/XT/G+Zz23tATvCCBIoBHgOwIN/Q5Ny8
         +kXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145AD21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 81/81] ACPI / video: Only default only_lcd to true on Win8-ready _desktops_
Date: Fri, 27 Apr 2018 15:59:23 +0200
Message-Id: <20180427135747.914946966@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908468508385714?=
X-GMAIL-MSGID: =?utf-8?q?1598908923828824958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 53fa1f6e8a5958da698a31edf366ffe90596b490 upstream.

Commit 5928c281524f (ACPI / video: Default lcd_only to true on Win8-ready
and newer machines) made only_lcd default to true on all machines where
acpi_osi_is_win8() returns true, including laptops.

The purpose of this is to avoid the bogus / non-working acpi backlight
interface which many newer BIOS-es define on desktop machines.

But this is causing a regression on some laptops, specifically on the
Dell XPS 13 2013 model, which does not have the LCD flag set for its
fully functional ACPI backlight interface.

Rather then DMI quirking our way out of this, this commits changes the
logic for setting only_lcd to true, to only do this on machines with
a desktop (or server) dmi chassis-type.

Note that we cannot simply only check the chassis-type and not register
the backlight interface based on that as there are some laptops and
tablets which have their chassis-type set to "3" aka desktop. Hopefully
the combination of checking the LCD flag, but only on devices with
a desktop(ish) chassis-type will avoid the needs for DMI quirks for this,
or at least limit the amount of DMI quirks which we need to a minimum.

Fixes: 5928c281524f (ACPI / video: Default lcd_only to true on Win8-ready and newer machines)
Reported-and-tested-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpi_video.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2123,6 +2123,25 @@ static int __init intel_opregion_present
 	return opregion;
 }
 
+static bool dmi_is_desktop(void)
+{
+	const char *chassis_type;
+
+	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
+	if (!chassis_type)
+		return false;
+
+	if (!strcmp(chassis_type, "3") || /*  3: Desktop */
+	    !strcmp(chassis_type, "4") || /*  4: Low Profile Desktop */
+	    !strcmp(chassis_type, "5") || /*  5: Pizza Box */
+	    !strcmp(chassis_type, "6") || /*  6: Mini Tower */
+	    !strcmp(chassis_type, "7") || /*  7: Tower */
+	    !strcmp(chassis_type, "11"))  /* 11: Main Server Chassis */
+		return true;
+
+	return false;
+}
+
 int acpi_video_register(void)
 {
 	int ret = 0;
@@ -2143,8 +2162,12 @@ int acpi_video_register(void)
 	 * win8 ready (where we also prefer the native backlight driver, so
 	 * normally the acpi_video code should not register there anyways).
 	 */
-	if (only_lcd == -1)
-		only_lcd = acpi_osi_is_win8();
+	if (only_lcd == -1) {
+		if (dmi_is_desktop() && acpi_osi_is_win8())
+			only_lcd = true;
+		else
+			only_lcd = false;
+	}
 
 	dmi_check_system(video_dmi_table);
 
