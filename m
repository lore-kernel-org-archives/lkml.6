Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2251HWi9MmdzelgHrJlyw0z9szARTXjKghmP3BFoAgagzWN8bLtuB6f72v+ulABIkYD5X9Os
ARC-Seal: i=1; a=rsa-sha256; t=1517590907; cv=none;
        d=google.com; s=arc-20160816;
        b=M3x90MBYWgUwfK2kwMxnKkIp1wH06TFCl6bRp9zNzgmB8EjowVxhEN8H5NS9Q7fqRH
         BLNaB0qG6IOqono+mVDwgNu+OrqBVLEn2MhFSKqyzSG2ZARhftx6WoATJEoCkHnyky/P
         my9vHJZFkwS4INpN78BCM2DFzIuaUmG37z0bGOml5POpPpqcT23TrJO1mzQmKziPDdJ8
         G4fq7JUX1VReTK9OjH/GZhlg7e0yPBr8GadHOKWo37ljwiJQTUxdYVbGqpSh8BbEkFg9
         jrOcqVUCRPZbtzN1V+RLkIOfxpJgJc7obDYuDu5n050T8W4Gtipl7mhgdWe4C/xPZlmh
         5zKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=anY1jnHIeEaO+IJrGw+9F/nHCEDh2Ld/qMQhNr6AvUI=;
        b=gSsI8Y50mxRIUlJ1+uvgu0rAE6cTwPekBd6ojfcvR+FDXLi8PsJdM0H+je7g83w5fV
         zJZUC/GWRjTg94VPMErs1599qEEucKJtkDebh2boBwoIMfBA8r5bquxdQPrTe5YJoamo
         xfigN4DQDYbQWFs2dmfXCqyndtoZ4lFQ3xkkckMhsIDHyZafsAzHjnqARgJkRAROlnfx
         C8VUO6P4AizGhEizR0QeH/f9iVoDNpTjfNcmv4yUvgUg3/i0S+fHYKlBpg2ghLy1K7g6
         7oha1JcvQ5ft9+TEN9Quaq9COL5h4wbbUwUUTYbkSVmrY4u78/0V+u7H7hsfW2ELAYTC
         JIiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 27/67] ACPI / bus: Leave modalias empty for devices which are not present
Date: Fri,  2 Feb 2018 17:57:56 +0100
Message-Id: <20180202140818.525948379@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309403407129442?=
X-GMAIL-MSGID: =?utf-8?q?1591309403407129442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 10809bb976648ac58194a629e3d7af99e7400297 ]

Most Bay and Cherry Trail devices use a generic DSDT with all possible
peripheral devices present in the DSDT, with their _STA returning 0x00 or
0x0f based on AML variables which describe what is actually present on
the board.

Since ACPI device objects with a 0x00 status (not present) still get an
entry under /sys/bus/acpi/devices, and those entry had an acpi:PNPID
modalias, userspace would end up loading modules for non present hardware.

This commit fixes this by leaving the modalias empty for non present
devices. This results in 10 modules less being loaded with a generic
distro kernel config on my Cherry Trail test-device (a GPD pocket).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/device_sysfs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -146,6 +146,10 @@ static int create_pnp_modalias(struct ac
 	int count;
 	struct acpi_hardware_id *id;
 
+	/* Avoid unnecessarily loading modules for non present devices. */
+	if (!acpi_device_is_present(acpi_dev))
+		return 0;
+
 	/*
 	 * Since we skip ACPI_DT_NAMESPACE_HID from the modalias below, 0 should
 	 * be returned if ACPI_DT_NAMESPACE_HID is the only ACPI/PNP ID in the
