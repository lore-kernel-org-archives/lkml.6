Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+PbbQKK3MNw4cSnpin/FNRAr/Hq19CWzr33vi4UyeTG083v28/r+daGoDYTdI0TtwjNoKS
ARC-Seal: i=1; a=rsa-sha256; t=1524405448; cv=none;
        d=google.com; s=arc-20160816;
        b=ThkkqghimmOrByc/I9PxRVb380rh+Dd/+TmC3ry4FsYUy2+k+8TWWES3trvWo+vtis
         65xcG3Q31J/2Ev3zs3KyQ/voohhj/bIr0XhgGMCo7XqCCLQ/NXai7uyshfm8PaLz9lXZ
         4elhADq1auU01UH4i84EKQYlnxcR3s+fSTJ08VvkWQXzthIHpk2QZbfMTqLIGd7pNIVY
         8Y1fNY5oQ+fDy4PIpvl+a7XFyDql0knjP17X7yBCnuWv9YFMqX7SlrBqHGs8cETg11kF
         v+Gykaoubpst1zorMe1PnUSDq2n0MkXFlb2xJrJp6X5kn3TcR18xPHoLTbceg+/9VRgW
         1mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dBe4lfii0w1rBIw6yguX6g8wuYPPQ4gZCB11X0ngEFc=;
        b=T9oKXypX75/rKQqH4PxlzUJ/mRcSOdRpoJdfjxe35UVWYRbVI6UdzS4BFlEoPGbAqc
         ++ZVTLxJxCPnW1M+O7AJ81t4A+3Q7GEixfYp6mGYZ/hJ1aR1wTZUY8+vu3ljjlSKlT7n
         7RpXTlIHcl8TuaSSLXEsozRqZDtY59AlvtjzfVxkNj+Rr//q+EEwimtVqTPVFswLT9iu
         ZXj0FZW6F3EXAC7VHhmVMEHxKSOdWRTVNt9cC9/VC3QQxxnXZQpVCE5Q7EvW7JDSXrr2
         S1BOSu+nl3kry9s3NZYx9OUrqMbg9UrhLX8PRpGlNI102NcR1v6C4w8uE/GIJ+gO5IxJ
         VayQ==
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
Subject: [PATCH 4.16 070/196] HID: Fix hid_report_len usage
Date: Sun, 22 Apr 2018 15:51:30 +0200
Message-Id: <20180422135107.879534374@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454967735799453?=
X-GMAIL-MSGID: =?utf-8?q?1598454967735799453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit 3064a03b94e60388f0955fcc29f3e8a978d28f75 upstream.

Follow the change of return type u32 of hid_report_len,
fix all the types of variables those get the return value of
hid_report_len to u32, and all other code already uses u32.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-input.c      |    3 ++-
 drivers/hid/hid-multitouch.c |    5 +++--
 drivers/hid/hid-rmi.c        |    4 ++--
 drivers/hid/wacom_sys.c      |    4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1368,7 +1368,8 @@ static void hidinput_led_worker(struct w
 					      led_work);
 	struct hid_field *field;
 	struct hid_report *report;
-	int len, ret;
+	int ret;
+	u32 len;
 	__u8 *buf;
 
 	field = hidinput_get_led_field(hid);
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -370,7 +370,8 @@ static const struct attribute_group mt_a
 static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	int ret, size = hid_report_len(report);
+	int ret;
+	u32 size = hid_report_len(report);
 	u8 *buf;
 
 	/*
@@ -1183,7 +1184,7 @@ static void mt_set_input_mode(struct hid
 	struct hid_report_enum *re;
 	struct mt_class *cls = &td->mtclass;
 	char *buf;
-	int report_len;
+	u32 report_len;
 
 	if (td->inputmode < 0)
 		return;
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -89,8 +89,8 @@ struct rmi_data {
 	u8 *writeReport;
 	u8 *readReport;
 
-	int input_report_size;
-	int output_report_size;
+	u32 input_report_size;
+	u32 output_report_size;
 
 	unsigned long flags;
 
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -219,7 +219,7 @@ static void wacom_feature_mapping(struct
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	u8 *data;
 	int ret;
-	int n;
+	u32 n;
 
 	switch (equivalent_usage) {
 	case HID_DG_CONTACTMAX:
@@ -519,7 +519,7 @@ static int wacom_set_device_mode(struct
 	u8 *rep_data;
 	struct hid_report *r;
 	struct hid_report_enum *re;
-	int length;
+	u32 length;
 	int error = -ENOMEM, limit = 0;
 
 	if (wacom_wac->mode_report < 0)
