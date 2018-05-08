Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqo/ND5nE0/8uf9e4rN4dpxf5hjvTVS1IrKsnGjV07ZdmqOwc7Dg6wv9G/H4S97zggrkA4Y
ARC-Seal: i=1; a=rsa-sha256; t=1525767269; cv=none;
        d=google.com; s=arc-20160816;
        b=xHp1kvPOwEaAWVEeVSpf5GgMtKbPMjxaWubvxhjaiHUuPf76pMexYV1V+ozYeG6DqH
         FGcFAHJoHz1rZeZJR18VoM3XCaYhOymIOu55EAu5IMj7ouwfTUKuiJla9RS8oPKXt4GB
         MlvzcHrxdLsz5r8HVO0IFo21zs3P6RHwYgviQhoDAelGgeW6n5kbaMtVxWf3GfB2AqUw
         SOJpr4rKs5vxhxL8ccB4ZbLEScvyCvOiuRnstUdTlpac+1XqQspBbeMvDTl85OEEa+Kg
         +XCLDazE5BJTV7fwpAr2lvankajkdXVCkILYBoqM+cwHopzBcROXub8VyLe8Bp0WjGjB
         x6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=E4nxAE1Ew0+eDFXoDjvDsDrFM7rj9+GXaX+2A0V9GSA=;
        b=v/iqbd0vEEy8FyE4Xc2kVBtKqMpk7aAl8MTgqqMWBuhq1Se/mhS+DRPSLETb8iFLNd
         4vIKwp6qpycSxH4nT3av6sXMRzMXPsuf1byESrBQVDqurHSz/7jFySlu6c6IYoLK2gC7
         TsEPcSiPG7w87hx0PZwgZN9LukV+cr5UHqFO/dIity++5BWUxDj+e63Get4jpbbjw9ZD
         gtneHnEp5RCLkz4WFZgeS2RXPNPmVZumYVLm9hyITtTInqIlLrNS3qTrjgCLBDXkbf1B
         yk+brQYulf6RMvyB2f141YzdaaabrO+nn8ah3Aab/AOmkBGS+tiroxOEvXdRBNPUSA4j
         kVug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gR1GG9QW;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gR1GG9QW;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 05/43] ACPI / button: make module loadable when booted in non-ACPI mode
Date: Tue,  8 May 2018 10:10:24 +0200
Message-Id: <20180508074004.906269422@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882761919859892?=
X-GMAIL-MSGID: =?utf-8?q?1599882940764519623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit ac1e55b1fdb27c1b07a0a6fe519f1291ff1e7d40 upstream.

Modules such as nouveau.ko and i915.ko have a link time dependency on
acpi_lid_open(), and due to its use of acpi_bus_register_driver(),
the button.ko module that provides it is only loadable when booted in
ACPI mode. However, the ACPI button driver can be built into the core
kernel as well, in which case the dependency can always be satisfied,
and the dependent modules can be loaded regardless of whether the
system was booted in ACPI mode or not.

So let's fix this asymmetry by making the ACPI button driver loadable
as a module even if not booted in ACPI mode, so it can provide the
acpi_lid_open() symbol in the same way as when built into the kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[ rjw: Minor adjustments of comments, whitespace and names. ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/button.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -595,4 +595,26 @@ module_param_call(lid_init_state,
 		  NULL, 0644);
 MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
 
-module_acpi_driver(acpi_button_driver);
+static int acpi_button_register_driver(struct acpi_driver *driver)
+{
+	/*
+	 * Modules such as nouveau.ko and i915.ko have a link time dependency
+	 * on acpi_lid_open(), and would therefore not be loadable on ACPI
+	 * capable kernels booted in non-ACPI mode if the return value of
+	 * acpi_bus_register_driver() is returned from here with ACPI disabled
+	 * when this driver is built as a module.
+	 */
+	if (acpi_disabled)
+		return 0;
+
+	return acpi_bus_register_driver(driver);
+}
+
+static void acpi_button_unregister_driver(struct acpi_driver *driver)
+{
+	if (!acpi_disabled)
+		acpi_bus_unregister_driver(driver);
+}
+
+module_driver(acpi_button_driver, acpi_button_register_driver,
+	       acpi_button_unregister_driver);
