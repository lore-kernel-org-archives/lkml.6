Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8c1CJUcRi4DV+1A4gKhVWXW8bYaeLYRCDuYxLJeoLUSTmDUcgDrtdwOXdLn/VnfRHcN8k
ARC-Seal: i=1; a=rsa-sha256; t=1524652958; cv=none;
        d=google.com; s=arc-20160816;
        b=rxLs6UcOvLVD95UXOhdjEcXJMoWE4GBSXpPecjo8g5Y1HMOhzrCC0wcB3mzPDKnVdD
         UTviKG76q5N5T9Cqc1/xZyzhclxdcE/zA+JoRtpRQMRLax2kfLWcJT8K5tl76QE+9nba
         8Wzuh1xif0kpIYyrk0Zop91RTiFcBS+8hMObJtaqmjcIsntmejIMk86Urr53dcihDbjQ
         3ctscbNSBLQ8N2hzQ7l3nkhKjvmmmsfPPsV2tB3n7Tq51xuMExSdnxCepz4BARhccT45
         TxWQa4AHR7F4xVG8WGJeI0qWFm0Tsp8T3y+KFWoYDLDsKf64LRsDHStD8Wz9virSUqbl
         yk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lNNU0M25LbPQAq4hTwm8hvlnE8CeUfPuy4eEVWuV10U=;
        b=JF3BwWRum3369hAUkRtoVmM2UwarjNqS+zlbHBPaEAGTTtpn7hi+Ef5mNOEn7jtkIT
         VutNMhp8MdFDgQiR2bztfZm9CDNdstJ6IAsce1byxcV/ZBBT6U5Ssu4cWBu4ZY350ELP
         5JX8PqofJofyPNxQCsyjMpO8E6515IUS4MRHJNu2fAvOeOtJWqAALT7F7nkKuBAlBzPn
         MwK1E5+yEXaQs+VlzEp1HeMk9idLcIVaUU0XPKMnTH9h+khRPhgjU0WMOcw7Xl7nHgOI
         cAF8qHEz1A2W0ySDdSxNp6q7lD2V8x9Z4dbpIs35rXsVexP2oL99sLHQOIU59jNmjXQH
         oftQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 132/183] ACPI / scan: Use acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs
Date: Wed, 25 Apr 2018 12:35:52 +0200
Message-Id: <20180425103247.726638638@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714501370744239?=
X-GMAIL-MSGID: =?utf-8?q?1598714501370744239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 63347db0affadcbccd5613116ea8431c70139b3e ]

The acpi_get_bus_status wrapper for acpi_bus_get_status_handle has some
code to handle certain device quirks, in some cases we also need this
quirk handling for the initial _STA call.

Specifically on some devices calling _STA before all _DEP dependencies
are met results in errors like these:

[    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
               [GenericSerialBus] (20170831/evregion-166)
[    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
               (20170831/exfldio-299)
[    0.123618] ACPI Error: Method parse/execution failed
               \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)

acpi_get_bus_status already has code to avoid this, so by using it we
also silence these errors from the initial _STA call.

Note that in order for the acpi_get_bus_status handling for this to work,
we initialize dep_unmet to 1 until acpi_device_dep_initialize gets called,
this means that battery devices will be instantiated with an initial
status of 0. This is not a problem, acpi_bus_attach will get called soon
after the instantiation anyways and it will update the status as first
point of order.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/scan.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1568,6 +1568,8 @@ void acpi_init_device_object(struct acpi
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
 	acpi_init_coherency(device);
+	/* Assume there are unmet deps until acpi_device_dep_initialize() runs */
+	device->dep_unmet = 1;
 }
 
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1591,6 +1593,14 @@ static int acpi_add_single_object(struct
 	}
 
 	acpi_init_device_object(device, handle, type, sta);
+	/*
+	 * For ACPI_BUS_TYPE_DEVICE getting the status is delayed till here so
+	 * that we can call acpi_bus_get_status() and use its quirk handling.
+	 * Note this must be done before the get power-/wakeup_dev-flags calls.
+	 */
+	if (type == ACPI_BUS_TYPE_DEVICE)
+		acpi_bus_get_status(device);
+
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
 
@@ -1663,9 +1673,11 @@ static int acpi_bus_type_and_status(acpi
 			return -ENODEV;
 
 		*type = ACPI_BUS_TYPE_DEVICE;
-		status = acpi_bus_get_status_handle(handle, sta);
-		if (ACPI_FAILURE(status))
-			*sta = 0;
+		/*
+		 * acpi_add_single_object updates this once we've an acpi_device
+		 * so that acpi_bus_get_status' quirk handling can be used.
+		 */
+		*sta = 0;
 		break;
 	case ACPI_TYPE_PROCESSOR:
 		*type = ACPI_BUS_TYPE_PROCESSOR;
@@ -1763,6 +1775,8 @@ static void acpi_device_dep_initialize(s
 	acpi_status status;
 	int i;
 
+	adev->dep_unmet = 0;
+
 	if (!acpi_has_method(adev->handle, "_DEP"))
 		return;
 
