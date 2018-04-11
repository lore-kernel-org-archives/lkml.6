Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+d2Hsjfg8iMxoqUBGcNFMdA7Bk/l4oqWVBfNd/GGMikKMKmdOM/8eyS1xgajZDNJS4Rb5O
ARC-Seal: i=1; a=rsa-sha256; t=1523473164; cv=none;
        d=google.com; s=arc-20160816;
        b=s/f4KPj/Qso/kP5LyOxEM0jOY/iroZyDxkRD7lOHeeY3tj2u3TVX+5UFphnEW4CfcN
         ni4fYLEUIZUUgJxG0sEWEO3Sp6OVwS/qHSpZZZgo3HU+nG8BjlJAuHPvx4IkiT53QIiA
         DkTtU1OSBT7FMW8BwmAIyaoNHhNPxWRuf4flKf1+7zLA4AFB3L4JiWbt3nwrWeAH/aWv
         QstVVYb8PMRFCgjBVnTmiFX7O9koAHXs147T/E/iqw2PikSXsR+PPpQ47eGuiL3lu/n3
         7xAeYUxkFzndIuNYhxPc1sl65vGX77D+j0gGImmyqZzufW8K8BnNtn9j4CqUEHiECBOg
         dKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pw0L0D0Zt7XYPgtEzdnK0QmWVLxPwtIvQnksFIoL2/g=;
        b=JCCVXFnLYdNC33MrzPOWrmuozJMPAWuIFc8mWwmlGM32imoIdS9CQvKS08TIwjvf1M
         9BQGqp/SJstaUszsH6bN1XBlaqmi54BMdbpTsdZu3d3xplPjO76J0Ew3oVpC73AtWque
         6LytDN01WaKOCpZC0Sw+LNA+nlZDmDNzLBGJud0/i3IbeWNdkxRir8W70qk8YfmfKBZG
         6tWOrFcgHJfotAM2OTD45Evez/gaazokbu64X8scDNgxZ8/lsR/MxdDtv7XzooloAwPi
         QYyLlbh5PVlCSboWVcYaMQAcD79ofdT/abX+qeIChTuae1Vo6xoCkhn6BE+0g57fR6/v
         ZgkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 151/310] HID: i2c: Call acpi_device_fix_up_power for ACPI-enumerated devices
Date: Wed, 11 Apr 2018 20:34:50 +0200
Message-Id: <20180411183628.929142612@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477397213855661?=
X-GMAIL-MSGID: =?utf-8?q?1597477397213855661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit f3d3eab667de62572376abb1aa26316191c39929 ]

For ACPI devices which do not have a _PSC method, the ACPI subsys cannot
query their initial state at boot, so these devices are assumed to have
been put in D0 by the BIOS, but for touchscreens that is not always true.

This commit adds a call to acpi_device_fix_up_power to explicitly put
devices without a _PSC method into D0 state (for devices with a _PSC
method it is a nop). Note we only need to do this on probe, after a
resume the ACPI subsys knows the device is in D3 and will properly
put it in D0.

This fixes the SIS0817 i2c-hid touchscreen on a Peaq C1010 2-in-1
device failing to probe with a "hid_descr_cmd failed" error.

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/i2c-hid/i2c-hid.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -968,6 +968,15 @@ static int i2c_hid_acpi_pdata(struct i2c
 	return ret < 0 && ret != -ENXIO ? ret : 0;
 }
 
+static void i2c_hid_acpi_fix_up_power(struct device *dev)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	struct acpi_device *adev;
+
+	if (handle && acpi_bus_get_device(handle, &adev) == 0)
+		acpi_device_fix_up_power(adev);
+}
+
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
 	{"ACPI0C50", 0 },
 	{"PNP0C50", 0 },
@@ -980,6 +989,8 @@ static inline int i2c_hid_acpi_pdata(str
 {
 	return -ENODEV;
 }
+
+static inline void i2c_hid_acpi_fix_up_power(struct device *dev) {}
 #endif
 
 #ifdef CONFIG_OF
@@ -1082,6 +1093,8 @@ static int i2c_hid_probe(struct i2c_clie
 	if (ret < 0)
 		goto err;
 
+	i2c_hid_acpi_fix_up_power(&client->dev);
+
 	pm_runtime_get_noresume(&client->dev);
 	pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
