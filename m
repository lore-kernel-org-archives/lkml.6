Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49buMNj06gDnPX+WEUAKnMp0OBkr7CtuP2URUw+PbmgZiwRFwpAyKC1XupFinVYlUXTUTI5
ARC-Seal: i=1; a=rsa-sha256; t=1524405954; cv=none;
        d=google.com; s=arc-20160816;
        b=ibMat9pru+sCtwpZIwrlAzmdSl4Y2Ge4ZJS6taG6p7c4oEJs3WR4iDEWPqgdwW6zA9
         xzuDNwtdimQ++k1ZNDjaYbmdmfm4Gk+la9D51/yLqXe1J7LCfE0sr/jYpKFcU+LZxvkQ
         iwKSHrKA/OuZn0lUa3oJ3+gI//jyoyhillmAw0WzNaaMxlnwnf8MEftnU7gpLKgml2G3
         OPz9aijPYsgTpRW2FcRb8e7pjM07MkUQH6Fk6DL2eLWXHZDrzXY3Am5yVpIzbcVt0rw+
         OjX/mlksk1aXnkHw5NYs9nLbF+QsOW7Xda/IMOM6itnaLEE0ajkYPJO5j1BpPKasAJWo
         8EhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wQDjYE0QNK7E/wbJ+EsGaij8OixwR5Nw7WmKbhwDiFE=;
        b=dA74QOoZuc9KSYf/RULe5YIqUJzDPuI9sM9qfy3RiQhs8TeiEIi7jQfJmZEK/SRka2
         R0iXHpvUpRpaxRfln+4GaU92j2aleyYuF1VFpGaHqbMAos4/z9SLwPBV911HTNLZOfj1
         nEUlNKaFxkSUqJ1aNW0ZWLsBHRUio/tgeRFrXbxUXRzI8we/f2C3atXr+mah8C7uNUcX
         2BmaeLfn42gSHQV16TdwM2YBJKTA/J328bPFzlbEfVC8Cd25UrgNUAg9O8TgfOrnOHjJ
         Jk9IbFLU7wZ5S6pgvJqbdxtZh+hMpdZKppg0t35rWpYO7fTi3OouTu7SwMq8NppNqyvy
         UOFg==
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
Subject: [PATCH 4.14 059/164] HID: core: Fix size as type u32
Date: Sun, 22 Apr 2018 15:52:06 +0200
Message-Id: <20180422135137.867278750@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454970676531115?=
X-GMAIL-MSGID: =?utf-8?q?1598455498427090524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit 6de0b13cc0b4ba10e98a9263d7a83b940720b77a upstream.

When size is negative, calling memset will make segment fault.
Declare the size as type u32 to keep memset safe.

size in struct hid_report is unsigned, fix return type of
hid_report_len to u32.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-core.c |   10 +++++-----
 include/linux/hid.h    |    6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1390,7 +1390,7 @@ u8 *hid_alloc_report_buf(struct hid_repo
 	 * of implement() working on 8 byte chunks
 	 */
 
-	int len = hid_report_len(report) + 7;
+	u32 len = hid_report_len(report) + 7;
 
 	return kmalloc(len, flags);
 }
@@ -1455,7 +1455,7 @@ void __hid_request(struct hid_device *hi
 {
 	char *buf;
 	int ret;
-	int len;
+	u32 len;
 
 	buf = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
@@ -1481,14 +1481,14 @@ out:
 }
 EXPORT_SYMBOL_GPL(__hid_request);
 
-int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		int interrupt)
 {
 	struct hid_report_enum *report_enum = hid->report_enum + type;
 	struct hid_report *report;
 	struct hid_driver *hdrv;
 	unsigned int a;
-	int rsize, csize = size;
+	u32 rsize, csize = size;
 	u8 *cdata = data;
 	int ret = 0;
 
@@ -1546,7 +1546,7 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
  *
  * This is data entry for lower layers.
  */
-int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int interrupt)
+int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -839,7 +839,7 @@ extern int hidinput_connect(struct hid_d
 extern void hidinput_disconnect(struct hid_device *);
 
 int hid_set_field(struct hid_field *, unsigned, __s32);
-int hid_input_report(struct hid_device *, int type, u8 *, int, int);
+int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
 int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field);
 struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
@@ -1086,13 +1086,13 @@ static inline void hid_hw_wait(struct hi
  *
  * @report: the report we want to know the length
  */
-static inline int hid_report_len(struct hid_report *report)
+static inline u32 hid_report_len(struct hid_report *report)
 {
 	/* equivalent to DIV_ROUND_UP(report->size, 8) + !!(report->id > 0) */
 	return ((report->size - 1) >> 3) + 1 + (report->id > 0);
 }
 
-int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		int interrupt);
 
 /* HID quirks API */
