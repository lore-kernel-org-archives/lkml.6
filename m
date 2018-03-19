Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv0jzxGYgIyjkhX6e2/FtcRMdtR4Qj28eFQEVZbCKi6sLK0ahF4EzkiTR/thU0Uneh+RwQk
ARC-Seal: i=1; a=rsa-sha256; t=1521483320; cv=none;
        d=google.com; s=arc-20160816;
        b=lmvhHcS+QZT/7guik7rpVKAk8mwEDBpkUl6zaTajrspw9BVLSmWbwzEuHGQhhCkMT6
         VqPxAXkrzPW9Bbd2R3DeZyRgkE+d0YMbZAr4b0kMlJjKrDlqPU/rPrRGE3Hw//ICrY9/
         Dna9o+cGG2/hGfDjVjSNQrAj/6U5+Me+fmXkspkoio4hk7byUsq6aM8KL0REJpJ4HfAo
         jurT8FTs9h4spgj6lVNYMclIQ+dG13WjfTI+AqAE7EqyxiG7E4vsXMjp3Y8AJlat4gl7
         0u5xR6yj9p0OmiCV7QIMs2/gfE1KSbqp+2J7Z0N7zOe+9W3KrP5D6zAF8hYQYPINdPxf
         xz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J5OPQMTGwzzyCfI5qMMw+fGdsB8sOJ1Wj99wQ0eC6wY=;
        b=fnORWyaFMtwJYwrsKn0F1oNXPSimQT98+dzKJBrxZctDuwjmoFIflzSZoBvVgCOcZ7
         la/5QARSxKNFZyXORqIFCELLToDds+mocI1cbP7nTSqyy/Cm8kQ0NmLC6hEwuZ0ntVoA
         kmdjQ5bHA8V151qBrJflo6yLOPgMvHOADyKjdm9k/g7eJwpVOXcc0cQ9GrryokYjN0qS
         02cG3et6MliohCsZzJ/TnqBwMZJ6Jl0hqb4RNes5GhXkdD4WuJs+sXYDBwXcuB0eFoDX
         ESPfNILSX+dPr1Qv3aNxV/3trixg3oMx1civviZvP4vFcK9VX4BIhkPZPrDw/J1Uu52n
         BAZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 081/134] HID: elo: clear BTN_LEFT mapping
Date: Mon, 19 Mar 2018 19:06:04 +0100
Message-Id: <20180319171900.997357947@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390684316858028?=
X-GMAIL-MSGID: =?utf-8?q?1595390894167512089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>


[ Upstream commit 9abd04af951e5734c9d5cfee9b49790844b734cf ]

ELO devices have one Button usage in GenDesk field, which makes hid-input map
it to BTN_LEFT; that confuses userspace, which then considers the device to be
a mouse/touchpad instead of touchscreen.

Fix that by unmapping BTN_LEFT and keeping only BTN_TOUCH in place.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-elo.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -42,6 +42,12 @@ static int elo_input_configured(struct h
 {
 	struct input_dev *input = hidinput->input;
 
+	/*
+	 * ELO devices have one Button usage in GenDesk field, which makes
+	 * hid-input map it to BTN_LEFT; that confuses userspace, which then
+	 * considers the device to be a mouse/touchpad instead of touchscreen.
+	 */
+	clear_bit(BTN_LEFT, input->keybit);
 	set_bit(BTN_TOUCH, input->keybit);
 	set_bit(ABS_PRESSURE, input->absbit);
 	input_set_abs_params(input, ABS_PRESSURE, 0, 256, 0, 0);
