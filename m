Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvWHw6nqo+rnZZgzhSGcF2m2MoMkE1lE/3ZXpkLfPO5USCPjbEHXRKGjnUu9a2CfMLiI4V8
ARC-Seal: i=1; a=rsa-sha256; t=1521214605; cv=none;
        d=google.com; s=arc-20160816;
        b=j6aHuRf36ubFCws0Wo8PLH2KgMIGO73MiNUBi++KsLz60tCeTGDVk0CRWvAdrzIYNz
         y6qyBwGDcDOspmmh/DC6hCYjENegsciqKMFeNQM4zdSqHy0XiRfUQm9yDeb1bLoXl460
         EVDy7ErvQodLIyHdsdqfC5BigGTdZaRfN59mSwElziS2iX6OqhXI5O0w+HqPo2t6pGm/
         xJCBgfp8NCyflNpCFpa3ty1bCFiFw1xXp3s8ILdf3GVuvONRiDTPWlgT/a+qL2WhG/Y4
         FFrTXFtthDiViRXL9ZE6/7sRU8iu+dEFK+hNGHRUmlHH++5xlz2FHl7LaNO54WOxEd9i
         Jbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QataehqBUrzwCicyqz30p4R1lHjjgFQG35aUlhd9FEg=;
        b=kzwllcJVOiKyGrOxcxMk/jYRJi9/smokaZzbVwv2ZXDClT1HmHpNbBaYby+QySIFf+
         uLiuQwVQD9OMZm1TsbBTluSLqKrcBIOL7eQwmOJNZCXYKLINkkjYNorYSjeMD8FVRQAU
         Pp6rraYS+8r/ofpNqvacTC0D8yP7Erh2/9ONDsXXhCiCeDSnn9r3TIHZSSrqQhf6Wfbs
         R87IrE7qxIBAaF4xkS15qwfhVUk8+r1RpzVTeaUofcLHmlj5m+/Aq6a1urVAzwl5SWZ3
         qlq3vrKzfb3JXt5MpafEbTx+pypkuFqOO34ee5c/WZ542xD+WcShY1jcHx7Eh7vQ149w
         9iJA==
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
Subject: [PATCH 4.14 031/109] HID: elo: clear BTN_LEFT mapping
Date: Fri, 16 Mar 2018 16:23:00 +0100
Message-Id: <20180316152331.671172404@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109126338282477?=
X-GMAIL-MSGID: =?utf-8?q?1595109126338282477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
