Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpFO8r8zSL709qhkASYgUWg9jE5w8oy6q8bd3k5EJ7dyUVUYRZC4jiHAD+uUb77yfpXtUj/
ARC-Seal: i=1; a=rsa-sha256; t=1524837940; cv=none;
        d=google.com; s=arc-20160816;
        b=1ItavdwEssf1sDPWCKYNE4yAfyd1BLsUolbLB60gxfHRohioqRkrN+PISOYEI9XyVO
         /4GY31E8NOnHCEWn+AtYFhDb6uG3ivyV1fs/p5I+cqHlzKi4t1+dWedYCovKivkq++Qh
         DgpHYhfizYGY+xYJ2npcxKgr0RY4GFBljHGOsETv9lw0tw3znfDi9PZze+LhQ/X7BQIU
         KRPE1OvMWvJ2wz982nW1vDEmPhjAalGp2nHhIdx1UMhgwqsXsbNgMAcpWBu5/zn0tOsp
         kbQ+3DAXOfQJik6/P1JsXk0DvnynnHV3ani+DnCbBS2yhDICid0M0fGxmd3EWt29UjIr
         9GNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=2l68avFnzBJA5vNU5fk+nFPo0bH0mxEt+tKWMCxvhmA=;
        b=AVYg0EMAb3DK40NVEvMM6OBL8uCcxxBwbrmQfY1203lGeySyI6if/cMMXUwfEhZma8
         c3V9L8jRWRnmjw4d9CdWWHwwe3RqNo0QljfPwU9LFxUVCBIeSd34W0HYtbi6kOUw9KrC
         5Ku2yoWwVd7v4uQKewqvFxMJNxuMLSHvkvph/yX1y+ybHW0kQ4z/qjzNtwf8+EBySJfc
         sVtVk4WUZbLNRxDnHez10ryGE9l6C3FMzsGtQawkOLQ48KkvvIGYVpWtSBV8BpQMgICy
         m8Yw9GuhFu9KJkARLOah/a3Yg7Y076UeozcWPNwTzsGXw/7gcrelblMvrE47omMI2uH2
         a7uA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B20321890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.9 74/74] ACPI / video: Only default only_lcd to true on Win8-ready _desktops_
Date: Fri, 27 Apr 2018 15:59:04 +0200
Message-Id: <20180427135713.017836247@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908468508385714?=
X-GMAIL-MSGID: =?utf-8?q?1598908468508385714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2069,6 +2069,25 @@ static int __init intel_opregion_present
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
@@ -2089,8 +2108,12 @@ int acpi_video_register(void)
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
 
