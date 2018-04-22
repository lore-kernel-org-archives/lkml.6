Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx484+ZIwKanD/qu2bBYadzzXo00e8enX57CwOG9akiJyGknltHGFYRDz328z6rnnWDzI2O3Y
ARC-Seal: i=1; a=rsa-sha256; t=1524405713; cv=none;
        d=google.com; s=arc-20160816;
        b=kWH3rD+uc6sO6i3e/M0iu1Kbnq7q6ZiMXNHAX2wXdfEje2j5cG54aw6ZFlrbJ5KNDE
         y+c5hoZjrO3MZol7Xq3n2jQ0CL/0cNIy5gbdENuCC041206SGOCOC6Qv4iHLCHZVf6hZ
         SuzoNZ2exxDd50Nx6pFsGhJcy/ye097t6WuEbhdsfE8GkNBWvysdQt+GuAJfUXCmvt/U
         EwmgN0uZ96qJqvu4QzVdo0UrUur7KNeS6EgIHti2QywGxySZPIcXaLQs9fyYwn4dcej4
         QZbuXlRns3KA0fldFQ4rMorDDI3A42oHQYe+iZb15JzonlrIZfXT8X+/qeHaTNbhNM9u
         nlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p0D1rjqOJRZZ+ApmpcVTNalcGcCH5oaw2wc2ettG4hU=;
        b=PVwxjHHW1vujDUfI9zqYqnhoH7Qh1tpmL6rYKCwbfZIH83er1kQmpl4GGZh18QkJVo
         SWcbx5PQzHhTupquVptnaTJnBaqJaAcF5IWa8m7vc1hEX55NQKzcXYQU4b+OkaAQNprY
         WleboOD42/dWNgYbaEr2JMjmjNxDJcZFDuxu2dA4OH/D0SQHNU2VSgndpJTaQTHuwRCZ
         4qSKRzl540ZS7fad2ZxEQKS41H6D0BjfS/kze1PdkVaHoKGbyJMZ+dxGjSyZj6dNgs5V
         YkXEVQBfIFZEbr5y8YS6lhK9xA6zePILSQAJHyPsm5g3/WY1ELMSKWfnFu9RrhPxQ8IL
         FYMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aaron Ma <aaron.ma@canonical.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.16 168/196] HID: i2c-hid: Fix resume issue on Raydium touchscreen device
Date: Sun, 22 Apr 2018 15:53:08 +0200
Message-Id: <20180422135112.959254195@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455245586597242?=
X-GMAIL-MSGID: =?utf-8?q?1598455245586597242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit 3e83eda467050f13fa69d888993458b76e733de9 upstream.

When Rayd touchscreen resumed from S3, it issues too many errors like:
i2c_hid i2c-RAYD0001:00: i2c_hid_get_input: incomplete report (58/5442)

And all the report data are corrupted, touchscreen is unresponsive.

Fix this by re-sending report description command after resume.
Add device ID as a quirk.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-ids.h         |    3 +++
 drivers/hid/i2c-hid/i2c-hid.c |   13 +++++++++++++
 2 files changed, 16 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -519,6 +519,9 @@
 #define I2C_VENDOR_ID_HANTICK		0x0911
 #define I2C_PRODUCT_ID_HANTICK_5288	0x5288
 
+#define I2C_VENDOR_ID_RAYD		0x2386
+#define I2C_PRODUCT_ID_RAYD_3118	0x3118
+
 #define USB_VENDOR_ID_HANWANG		0x0b57
 #define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
 #define USB_DEVICE_ID_HANWANG_TABLET_LAST	0x8fff
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -47,6 +47,7 @@
 /* quirks to control the device */
 #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
 #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
+#define I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -171,6 +172,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
+	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
+		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ 0, 0 }
 };
 
@@ -1220,6 +1223,16 @@ static int i2c_hid_resume(struct device
 	if (ret)
 		return ret;
 
+	/* RAYDIUM device (2386:3118) need to re-send report descr cmd
+	 * after resume, after this it will be back normal.
+	 * otherwise it issues too many incomplete reports.
+	 */
+	if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
+		ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
+		if (!ret)
+			return ret;
+	}
+
 	if (hid->driver && hid->driver->reset_resume) {
 		ret = hid->driver->reset_resume(hid);
 		return ret;
