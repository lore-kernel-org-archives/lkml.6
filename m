Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvAXqhxv8EzmQ9JrzP1nM+KoJzYCMg+fDJ4TJka+fb+TAVwEABPP4i39yXJeei/YV+m48kF
ARC-Seal: i=1; a=rsa-sha256; t=1521482969; cv=none;
        d=google.com; s=arc-20160816;
        b=TAFzRUncIk8fc4XQRtUJrArZsw4/6YU1t6KVz+qxjWag6tNqpqJ5T/XgATa7G+yljn
         xdQ3hb9ZRlJjqu0lnGkUR0lB5OX3CQlgW8+TL9w77da0AH3ISeB75sK+VMNuM20XQZMM
         C7u68CxKpBYpZM7pE14DIH98hLSgKq7whf2NVr2i+s5RJEBOgUkwbnNYrLJMVWihmYn/
         S5Ob8jMjt1HcVDtqFQCgwniRvQYROq1px1tZxQ+oSeMOmCH1Y7W76zwp4cUhiOC+1QPI
         vKltAFIeNkBzD5Ymxx27fhoYKjvWwl5L0P/4VfbOZ+9szh66a06uBqT+GUScYUCRBvth
         5icQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fm1E+w+wHRe2n45kdaUp1iqIIqdiBg8bvpVKSdKz19c=;
        b=uOQoy4f4MQX8olXWCSoDkMGGviP5WuyvR7+hUjAJpFXhjkifP8IR9Xd+W4TJD3vWJk
         tkbvmomQGDvQNbR6tVhUxS4BScsBVmO/UCLU4OAnXnPIjBQxNe8ubQjj6l7VfijYUABU
         GgYep7oKHTzRugfBXGC1MNNNIhpp3VOElV1lkp8f29GZ9QrU5+BrZ5yJNfecG4qqgiYo
         IEgfK2jUs93r9svRF/Gnet14DLjcsGDN3hMumRkKX+oEErk1g2stkVXYt0q+ofnqB9nC
         tbrvPE15wLqCQ+iJ0UEnQOw5pqQIWL/iPDI/+fRAHrMTMEXaRPX0YGutMwMqnipMKZ68
         WDMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Valtteri=20Heikkil=C3=A4?= <rnd@nic.fi>,
	Tomasz Kramkowski <tk@the-tk.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 02/68] HID: reject input outside logical range only if null state is set
Date: Mon, 19 Mar 2018 19:05:40 +0100
Message-Id: <20180319171828.227365869@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390526332956938?=
X-GMAIL-MSGID: =?utf-8?q?1595390526332956938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Valtteri Heikkil‰" <rnd@nic.fi>


[ Upstream commit 3f3752705dbd50b66b66ad7b4d54fe33d2f746ed ]

This patch fixes an issue in drivers/hid/hid-input.c where USB HID
control null state flag is not checked upon rejecting inputs outside
logical minimum-maximum range. The check should be made according to USB
HID specification 1.11, section 6.2.2.5, p.31. The fix will resolve
issues with some game controllers, such as:
https://bugzilla.kernel.org/show_bug.cgi?id=68621

[tk@the-tk.com: shortened and fixed spelling in commit message]
Signed-off-by: Valtteri Heikkil√§ <rnd@nic.fi>
Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-input.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1097,6 +1097,7 @@ void hidinput_hid_event(struct hid_devic
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
+	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
 	    (field->logical_minimum < field->logical_maximum) &&
 	    (value < field->logical_minimum ||
 	     value > field->logical_maximum)) {
