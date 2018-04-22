Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx484/jPwJgl/vGyEbdoKKeb16gfLfx19P3wUM5iuTwShGhJukjQTtT0A6rWZNtfy8FvYKA/3
ARC-Seal: i=1; a=rsa-sha256; t=1524406416; cv=none;
        d=google.com; s=arc-20160816;
        b=q21n7hetPfzkld3DuMs1yGECR5UwcWrZ6/twvXL/iZkZ59rbzSO0OKMBkLYLFVfeKB
         lNWahMQX6nLacVP7hbxt1XxvYfHyGMnfl2eKSXa9fiFwC0WbUWG83IMEywXe4J5jzNka
         8Jb+KZoPkJUdhX8huXzCn3IhN3Q5rn4TFWwPiyvx5E25KTX2PP4tE04yq1DWLsPEooLp
         mZMmEk0dmFcpc4LH2Yfo1P9XtY9cuwyV2gAIk62b6W1qruw1hy5MsX4Il1Kvpuct6bUQ
         dSS3cKWrzxK7uERYARU35eOK9Chas3Myp/42G/02NONcmZ8ApGlyR5GDnq6Z7OAPColk
         RMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c+4iLz8nd29WjlmEWXRHKKLp9MhZphD10+By3fjAjiU=;
        b=UusyY4hR99OPi/ZqW7Nxz2pczQuepjrn2flPfvJoQPAnXkmK3BTicV2/0u+6lV/t0Q
         RYeh7Z/lLahR+Po+FcfckKvV4ClkRKX7ab1aZPlcMccUmkvHFyhVNso2h5ZgP7vq1YJO
         tvBdP65F6JwU/VVqKVYduh3B051pSovK7xZA3YmYD1VFeG3X5npOCabQxG1XBDhOJMrM
         TfHBIDfk6JQUghB0LWuz8KyRCVGNdoOvKwegyJyTZBpx1SIIOZx3H3pij4wak16qIccd
         wfct2aZGZD+9/fd9D40v+qlenRCHrQ6KGy8MB7H2wCKjrjZ9xE3KLEv0vGm7TjL1hITe
         26MQ==
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
Subject: [PATCH 4.9 28/95] HID: Fix hid_report_len usage
Date: Sun, 22 Apr 2018 15:52:57 +0200
Message-Id: <20180422135211.597987696@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454967735799453?=
X-GMAIL-MSGID: =?utf-8?q?1598455982517045987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/hid/wacom_sys.c      |    2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1279,7 +1279,8 @@ static void hidinput_led_worker(struct w
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
@@ -315,7 +315,8 @@ static struct attribute_group mt_attribu
 static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	int ret, size = hid_report_len(report);
+	int ret;
+	u32 size = hid_report_len(report);
 	u8 *buf;
 
 	/*
@@ -919,7 +920,7 @@ static void mt_set_input_mode(struct hid
 	struct hid_report_enum *re;
 	struct mt_class *cls = &td->mtclass;
 	char *buf;
-	int report_len;
+	u32 report_len;
 
 	if (td->inputmode < 0)
 		return;
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -110,8 +110,8 @@ struct rmi_data {
 	u8 *writeReport;
 	u8 *readReport;
 
-	int input_report_size;
-	int output_report_size;
+	u32 input_report_size;
+	u32 output_report_size;
 
 	unsigned long flags;
 
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -351,7 +351,7 @@ static int wacom_set_device_mode(struct
 	u8 *rep_data;
 	struct hid_report *r;
 	struct hid_report_enum *re;
-	int length;
+	u32 length;
 	int error = -ENOMEM, limit = 0;
 
 	if (wacom_wac->mode_report < 0)
