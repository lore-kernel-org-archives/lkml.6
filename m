Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227u87OgZU0QiVdhoL3r3hz1jUWVhWXeQNnmQuiUO96SUpgaceMmGDCeaAXAtIE7t2nkmLvv
ARC-Seal: i=1; a=rsa-sha256; t=1517591713; cv=none;
        d=google.com; s=arc-20160816;
        b=bWVU0kWCfcQLJe+9Oi3WEObYiwHt94cauRZtyk/7T+52Of8MWf7mHiPCmlt/RaYb1G
         8QfhbixpKxiO9LZFZTDZXyLsHlQqIt53eUptAmn1dIW8CPsV/TQUbqD9X+v7bP99xoC+
         WBRqF2a/8MoUJ3zQ27gzyK4pbVLIjV49qDUOYZrgT2bQco5NLsHHLBwyETYWDMbxmZJk
         e/tBqv2skYaOd3Whg5nIeLi2jI6WweOJ1h5Jp5b5HgnzciFeP/uPx4zGyXuykJzw6Lvu
         /Bga+xWlrihIOfaHs2sHhr114cWLLyy0ctDxcfj0UODGFwIachX+VXUSeKYGfX9irRGG
         CTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=McUAG05b4hKbKkaFeN8P85amwNZagFL9MDOGFbhNfl0=;
        b=ebr1ay1anVNkgEseKJjVMBIhM9hHFKFbLrhQdvPbGPfgjmYJRN42zJy/3IuJfSVW4e
         7fbDNY0TQl2fllGDo1oWtg6ZXhef0yTZ5nf6H4k10irS/ZCV5HbKnw4coB7wcjbC9V46
         SpxBf9LhM4rzw3o8qoPcewuAWBevilp5lDYEHKbJtp1Ke+LXZu3cKP94Dbfvjavq/pr4
         yahIrOizhjFG/AkY5mvTqu6AQO7R55ndS44zBI/N3TaTyi2u9/54/nFb5ETW9sK4CIgT
         AnuTWGzNNHkYa2+fTCWlK40Y+xNeqtnR98E8ZR/bASjCb/7ChBSQm/LsZt69Dps+bHme
         z5vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.15 04/55] gpio: Fix kernel stack leak to userspace
Date: Fri,  2 Feb 2018 17:58:22 +0100
Message-Id: <20180202140826.450879851@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309489818363187?=
X-GMAIL-MSGID: =?utf-8?q?1591310248037182945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 24bd3efc9d1efb5f756a7c6f807a36ddb6adc671 upstream.

The GPIO event descriptor was leaking kernel stack to
userspace because we don't zero the variable before
use. Ooops. Fix this.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -732,6 +732,9 @@ static irqreturn_t lineevent_irq_thread(
 	struct gpioevent_data ge;
 	int ret, level;
 
+	/* Do not leak kernel stack to userspace */
+	memset(&ge, 0, sizeof(ge));
+
 	ge.timestamp = ktime_get_real_ns();
 	level = gpiod_get_value_cansleep(le->desc);
 
