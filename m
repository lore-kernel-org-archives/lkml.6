Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227qlBPYvwfMPqk3Rq24aSOTFJRl+oFkx2vFFjyzp++Kgp+MoUNKZCWOclt/ZiVNfkIBluOP
ARC-Seal: i=1; a=rsa-sha256; t=1517591020; cv=none;
        d=google.com; s=arc-20160816;
        b=lUJ0voMMY0rAjmRrcApVu1YvBrhG6jdiZcfik8EMFIL4z5HzzPXp74JYyjYjBbvMz3
         3VVKief0gXmMlwRVbowgAYubBhonIUKQ9gTJHZ/es+e+XruFdQH5G1H/EeFb6b7RNldc
         sStBA9px+Gr6RcDglSGDTHEqWHG60BczpfNO989vOHsI1NR5VMChIIoCxt4HGuyTwbe6
         DUNlfxs1jb1cTrkh0qCY3esQei6lB1xT0GvDMJp1qEQo0pr/WTookahXlKqmDZdMzmGx
         linrEZ/a2zZoXkdRHLfdldsQHHQiDbIg8LElb2Gme+XQwQIVUtdnriub4844VzcguiCT
         H1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ecAQxkUcbzvXCANCsw5eSbCrypJ27GBAxLPE8gVxEww=;
        b=wYoGTLYuBcliVeX+UAXUOOYIqwsaFDM8aYIBiFDmxZXNG78cip3DRERlCRfCNTG5S6
         ghXz0DoCRs7IO9yVecRSLPp6o9a4qt2LNIS09IdJNaROlYFemVpJf4g7CVjTDwrCRGdE
         mQErq1qJDUkLy3iSsYQC5zLwQHChOtdtBJR9G7sriaYn7yjMoY9iYwbBL4io8Z9YtVxc
         d9aDDrmfbgl5H0xPNP/V3u0PASU/WCthgVCuZNpQrCqDDhF+KwEfjjjuHWIy8Two8UND
         MQKw7uA6xsZy20pQWF9XQTXu84d4jT52M2A1jCxfmFdr6flhOnyP0WiMe7heVbmshT1z
         YYMw==
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
Subject: [PATCH 4.9 25/86] ACPI / bus: Leave modalias empty for devices which are not present
Date: Fri,  2 Feb 2018 17:57:45 +0100
Message-Id: <20180202140824.942482889@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309403407129442?=
X-GMAIL-MSGID: =?utf-8?q?1591309521896965766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/acpi/device_sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 7b2c48fde4e2..201c7ceb7052 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -146,6 +146,10 @@ static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
 	int count;
 	struct acpi_hardware_id *id;
 
+	/* Avoid unnecessarily loading modules for non present devices. */
+	if (!acpi_device_is_present(acpi_dev))
+		return 0;
+
 	/*
 	 * Since we skip ACPI_DT_NAMESPACE_HID from the modalias below, 0 should
 	 * be returned if ACPI_DT_NAMESPACE_HID is the only ACPI/PNP ID in the
-- 
2.16.1
