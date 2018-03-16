Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtRMK24WbRFNO2JuUyeoOUwL7RfwTOMMDy5KApYGGaj2j7CXlf1zeC4K+cm7OG4byxzQJnO
ARC-Seal: i=1; a=rsa-sha256; t=1521214841; cv=none;
        d=google.com; s=arc-20160816;
        b=UxtWBYb8guJwj4Eg9p6DsiqNWRMQyVMF7vO3PEFgcs83iSgElecmUGD61Iky4eLIOy
         Kn/FtByG3SRqwCis+O3+SUGpun2/anvdMX5gcDTVU8UQrNdc5fY8Boji3lmJOoLADySt
         1mzjlKXKbzsxmr16XOFV4QieaSxwQttkBfbT0Zf1cNGdqbR3nNwcwccZ5A+Pq3qiJjgG
         G+I3Vu5kN9ugYTtXv8fDxK9wZJ+m/FA8/IiejkNL5QStlSF+3q1yGqa9a/qWXXGoAkkQ
         fUCzidT/nB1mBBBD3o3NAULy9BuGTYWZsALyCQVk9/vrPXfefv88lufO6FaINa9wrssg
         4tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JJQGoN0/omvaMsAjiwTb1Q3rYcxLwG9IgVN4/9tftmc=;
        b=jAvJfBaRrqxHZVktfM8uIPvtSXItD/DUzeKEa1/sF+CMaM11kSHVebNkABUBrwKZJq
         7YF/xVWZtlnj5fXkVCMdGtJq4IaCa8cBkmTIeJhwuc84PuEd7rpwJ2fsFWvZtsuS0zzw
         j9TeDK+UTaBgdMj8J1WMgdp1EoCoVXjmqcHU166uXhOb1qhRIocLv9VfxVK1Qos0RI6B
         A59Dr52VfgInEniRjad0/xGhamsySCU+Qe9iv2jKs94mqOq9cviBUKumUvJNn7btpQI7
         QBagDwq4RUzxEWD+HI0rx15OaWmR9GftsV4feYwPAQYGQDw2LtHuySRp7lZyl8OvB2Sp
         4i6A==
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
Subject: [PATCH 4.15 036/128] HID: elo: clear BTN_LEFT mapping
Date: Fri, 16 Mar 2018 16:22:57 +0100
Message-Id: <20180316152338.468166408@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109126338282477?=
X-GMAIL-MSGID: =?utf-8?q?1595109373560474248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
