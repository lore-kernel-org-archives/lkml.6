Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx499IUsMSSxNbDYILJobxMTSM53RCKZLQJYjspLR2JRGyZpVLaoHKwgY612TGA3Kr7+cNx1H
ARC-Seal: i=1; a=rsa-sha256; t=1524652956; cv=none;
        d=google.com; s=arc-20160816;
        b=Kz8SU/TqTCkSaCfs3bW9dJbrgY0zDWPKXryJp47US51qvwwmOQuJZ9FoOcGPMXKiuh
         BWROsZfkvPMs614DIiSK34jCdFb93TGWIpHX0JxGmStJQfLzGlZSAtTdZ+bDJbJRk7Dn
         +Pz1+M5XxuqL+hI8BQ0lehoXaAXApu+to4JkVplSoZNm4ixx+bpSp9l0UHmCjwTp2cyC
         vacTxdRYVA9bunGpuBAB67MN5qWGaTOjQ8NHmycuGgCZXx90ByuuvO0hIKU2y7pBFDPj
         JaqqGimPeEjJW/2TLfdmKRHbCTIIoR8/wVgB7SOWUuuqnqQmVPx4Hrh22kTQ6rvS2wEr
         Uwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DPUxPyMgqA/DWGGY3b1byrAuT7dEs/fJsixrsP5fnek=;
        b=Z3sxlI3JXEA/sNhVcA4I/+f4mzpCYf4PVrkh86pllRu2YKSPFCCARZjTZ6xeqnW4YV
         HdQGPf6pAaHsT1qv6spI2wCVoJLFT1uQc+YkfHMQle/pxGkVGFa/e9ZwNh764fuc7s+T
         yIesO758fSr7F/pngGuuN44ogGtMsnh1TxOPJ4vMRTppN7/OeTqxB0E1survSjx+Uhl5
         gSSUY7s46T0lZCF5xKOFYWzNpxyWy133NUgkRG0XVJ3xIDK3zpJu/U0dchShby5IKTdU
         ybxekheZesds2IB/vZoIC4oSWA0dLiHRoTTIIe9thsPQEeY+sYqvRrzV4m8eA/oONcxj
         sROw==
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
Subject: [PATCH 4.14 131/183] ACPI / bus: Do not call _STA on battery devices with unmet dependencies
Date: Wed, 25 Apr 2018 12:35:51 +0200
Message-Id: <20180425103247.690503084@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714498670457277?=
X-GMAIL-MSGID: =?utf-8?q?1598714498670457277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 54ddce7062242036402242242c07c60c0b505f84 ]

The battery code uses acpi_device->dep_unmet to check for unmet deps and
if there are unmet deps it does not bind to the device to avoid errors
about missing OpRegions when calling ACPI methods on the device.

The missing OpRegions when there are unmet deps problem also applies to
the _STA method of some battery devices and calling it too early results
in errors like these:

[    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
               [GenericSerialBus] (20170831/evregion-166)
[    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
               (20170831/exfldio-299)
[    0.123618] ACPI Error: Method parse/execution failed
               \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)

This commit fixes these errors happening when acpi_get_bus_status gets
called by checking dep_unmet for battery devices and reporting a status
of 0 until all dependencies are met.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/bus.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -146,6 +146,12 @@ int acpi_bus_get_status(struct acpi_devi
 		return 0;
 	}
 
+	/* Battery devices must have their deps met before calling _STA */
+	if (acpi_device_is_battery(device) && device->dep_unmet) {
+		acpi_set_device_status(device, 0);
+		return 0;
+	}
+
 	status = acpi_bus_get_status_handle(device->handle, &sta);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
