Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224LWqnbYd3NzU6D8Awx2XDn7XyVGx7auguaSYLrw5tufonVJ65oHRltHIGJEDiULXhFrSHJ
ARC-Seal: i=1; a=rsa-sha256; t=1517591365; cv=none;
        d=google.com; s=arc-20160816;
        b=fHpbJRhOAHhNBYcLkL5GHLyuI3BwBCQP0xZmRoyI+gmHh7ONdb7C8nfaPbXXSOVEUV
         GFWkaCbSfQNOr9106dbkslaDEBWdD8RnXtdzBkRDaxfVPGPjCH9X+LxO9tzZkIkH/hRD
         dQng2Z1mBDFPH+KbGkixLfRU5XSwvgitm4x6DrTi/9/PCe4eifjFCUYbKGNGiONAHvPL
         5CGgn5WO1kDekA0eSDskFqdjAm4hmV0+67VxNIi3Tf7O4XSSUO5F+fVo6J1W0HT7FFmE
         JKU87OY6pUFYfoMM0nUdHrAz2YfcNUYWKBAWOq6VyQJnHo3pov/Q73O+qfnd4ObNnyPB
         25vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cVTxaWPiT1zXyRxPdKpC5YpnQ6nTJcISHOpgJerucC0=;
        b=QUZBZVFaik+7hN4bgP402PB1shBP+oIMPP3YrCaFrJcF8Dg7rVq3p0b2h35dCkVY9e
         FiljnO46Oed0mFzz4YpKIYims+4dIl1zID0re/HPXstqffGorxbQwVgawgBbapTmE+ec
         7l4Fkfu1kRHjAkTjHF7/mqyBXqqjfQMhIP/Ad0HibtYBsAshcle95rI3YfhCg/zKrTU4
         u6asJTG/ZjkwsiC2S8UrmiY5mBu0QDjjnMgOTBsYRho4TiWHrIJl8+3SfWRHtujQrcTG
         QUFAG9AZEW2iM09laDnhrXjc6AdwTxWqqux9QlhT6BXRJmpOJEMhvatEjKwYaKAw0pxu
         Nx1g==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 054/156] ACPI / bus: Leave modalias empty for devices which are not present
Date: Fri,  2 Feb 2018 17:57:15 +0100
Message-Id: <20180202140842.725279573@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309403407129442?=
X-GMAIL-MSGID: =?utf-8?q?1591309884191262204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
