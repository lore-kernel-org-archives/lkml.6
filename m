Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtIGBFg9fQy1WLShD27iz996uRuHOklEgNRXiSpI6cr30i963JCuXuF8ZdaCBnaGkFqkRyh
ARC-Seal: i=1; a=rsa-sha256; t=1520451840; cv=none;
        d=google.com; s=arc-20160816;
        b=Zz+n5TXySuLXH+X8wh+RMWu8Ykm7a3Vu4RUD5iI1Z4sR8QkElLRdK22hs6SEjFD5LE
         bxN1q452lInlNW0UeomRbHQfCZ8zJzHgl4X2tnKSbV7IMv2e548YamGkKp0RzNMp0S7E
         vDVKlC0KqpL9Fpb0HGgSKO4gSB4QaeqDOYtcZdhE8GwnwEU2iH4A2AYzpe+8ScWMsB1U
         LMoqR26DzapV38/HbxN83D8zFvryoIV4Y4DcSzMt6eRQlXGNDNVcOHUlJ4sNBGj/MkgI
         zMl0KVOAGBwydouHsyRT953Q24c25imrTkFnJKpg8ezQb4FF9UWQZeDP52XV+NmBsmdv
         3N3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RGmiv+QIlplgw+O0oozvYQrntPwTurgfQwHOUMUZ1dw=;
        b=fGBQ4P3ZKiPOlqDrEdIEatOINvq0T+iKUDE8jmNWYe9bczU90aLSojgZCjkczXEZZh
         SNGy2ueGIPXZwytFU9+NsRBdIk+rMN3UrlgzXRebYH/+898cai4msI201x8VjurWyMX5
         m/qPxMrbR9X6yLMpOZRNX/fTKrxqiQ8Qt7FwMR3v6WKwEraMo91zlX5RSVuc4tlSV3KD
         fToNfyGViEVWX8fXicmN5aUxd4TYQQO2Tw/qGPPNo+Ivzy5+TIwHiDlSAQiUTAIC8RKS
         RlZQtRmHIEBESeUDek3KkPcwXm77Iwky9G323IlG3t8ouLKq4RMNfl5KdBYMWHHXxscx
         SfMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.15 118/122] ACPI / bus: Parse tables as term_list for Dell XPS 9570 and Precision M5530
Date: Wed,  7 Mar 2018 11:38:50 -0800
Message-Id: <20180307191746.723771136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309308611933489?=
X-GMAIL-MSGID: =?utf-8?q?1594309308611933489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Heng Feng <kai.heng.feng@canonical.com>

commit 36904703aeeeb6cd31993f1353c8325006229f9a upstream.

The i2c touchpad on Dell XPS 9570 and Precision M5530 doesn't work out
of box.

The touchpad relies on its _INI method to update its _HID value from
XXXX0000 to SYNA2393.

Also, the _STA relies on value of I2CN to report correct status.

Set acpi_gbl_parse_table_as_term_list so the value of I2CN can be
correctly set up, and _INI can get run. The ACPI table in this machine
is designed to get parsed this way.

Also, change the quirk table to a more generic name.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198515
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/bus.c |   38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -66,10 +66,37 @@ static int set_copy_dsdt(const struct dm
 	return 0;
 }
 #endif
+static int set_gbl_term_list(const struct dmi_system_id *id)
+{
+	acpi_gbl_parse_table_as_term_list = 1;
+	return 0;
+}
 
-static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
+static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
+	/*
+	 * Touchpad on Dell XPS 9570/Precision M5530 doesn't work under I2C
+	 * mode.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=198515
+	 */
+	{
+		.callback = set_gbl_term_list,
+		.ident = "Dell Precision M5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision M5530"),
+		},
+	},
+	{
+		.callback = set_gbl_term_list,
+		.ident = "Dell XPS 15 9570",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
+		},
+	},
 	/*
 	 * Invoke DSDT corruption work-around on all Toshiba Satellite.
+	 * DSDT will be copied to memory.
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
 	 */
 	{
@@ -83,7 +110,7 @@ static const struct dmi_system_id dsdt_d
 	{}
 };
 #else
-static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
+static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
 	{}
 };
 #endif
@@ -1001,11 +1028,8 @@ void __init acpi_early_init(void)
 
 	acpi_permanent_mmap = true;
 
-	/*
-	 * If the machine falls into the DMI check table,
-	 * DSDT will be copied to memory
-	 */
-	dmi_check_system(dsdt_dmi_table);
+	/* Check machine-specific quirks */
+	dmi_check_system(acpi_quirks_dmi_table);
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
