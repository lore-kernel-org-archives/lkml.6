Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuy+yIX8XZGgSRESPIDQQ3u2+igciaIMQTbql1rr/CWRLbaXwCVZ/EvwaiWqa2NYMl3uzoN
ARC-Seal: i=1; a=rsa-sha256; t=1519981442; cv=none;
        d=google.com; s=arc-20160816;
        b=aXB0U7QA8R2Lr7g/TuNreNLS+y75WP/7DjCeP2LhXmN0yqYXncRatyEdGQ5lIrtc/d
         5QaS7Jky0bPavm5xocH6cC0NIKGoaV7r1zsK9Ai26uD6T5j4uqF/7U+6NlK9M2RS+QqU
         Kpkcp2hJEMOtRHaDtDhuW4qzJgXmFPC2txyuNQMVdW6h/019I9pNPRwSpRo2DST1kbIE
         MwkmNn66jqCwsJaYH7ncEMgltMH8kYJQ2LBBy457VDa/Q2Akwah/XTI+SV1nVwf5II99
         33+3i4/KdEnCf65MopqaMLT997WjyB9KlaiuonsayRKfrve9igCi9TWy5dVTBWBBpa2G
         +puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dHsPxu5UztxB85QZH8MK9NJ6jNoeR3rIfh/9f/opN1Q=;
        b=anY6y9/+FK+Cd90x23vduC9E3IFPzZT4IsNDE07ZFgeTSt74Yx6Mg3roZVUSB4bwK+
         5m6u+Q2XswrQdI+lBj4sIJDCSi6A2G0MtWx4hC7WvQlEs2zIJSJ7iJVdtjhYDIcqhsfz
         zhZnA2Y0flUCKUl5U045W8xDpHBNOKW53VTExz0twNfaDnKxa5URZXvmO9QCLlLV6Z2Y
         ETJYLcBOjxAeVtSWueUHxb8ObkZSBrNXh5zM4Kfm9qHuU3isa4NMxDMsK2LIYsAMcz5c
         9gSSFt3q847gdh+9nuKg0KUyrzeVDpBins90dc27HSLzt5uKSlWTr/luboq62ZM3lDSG
         GTxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 091/115] leds: core: Fix regression caused by commit 2b83ff96f51d
Date: Fri,  2 Mar 2018 09:51:34 +0100
Message-Id: <20180302084507.532380207@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816060624964724?=
X-GMAIL-MSGID: =?utf-8?q?1593816060624964724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacek Anaszewski <jacek.anaszewski@gmail.com>


[ Upstream commit 7b6af2c53192f1766892ef40c8f48a413509ed72 ]

Commit 2b83ff96f51d ("led: core: Fix brightness setting when setting delay_off=0")
replaced del_timer_sync(&led_cdev->blink_timer) with led_stop_software_blink()
in led_blink_set(), which additionally clears LED_BLINK_SW flag as well as
zeroes blink_delay_on and blink_delay_off properties of the struct led_classdev.

Cleansing of the latter ones wasn't required to fix the original issue but
wasn't considered harmful. It nonetheless turned out to be so in case when
pointer to one or both props is passed to led_blink_set() like in the
ledtrig-timer.c. In such cases zeroes are passed later in delay_on and/or
delay_off arguments to led_blink_setup(), which results either in stopping
the software blinking or setting blinking frequency always to 1Hz.

Avoid using led_stop_software_blink() and add a single call required
to clear LED_BLINK_SW flag, which was the only needed modification to
fix the original issue.

Fixes 2b83ff96f51d ("led: core: Fix brightness setting when setting delay_off=0")
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/led-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -187,8 +187,9 @@ void led_blink_set(struct led_classdev *
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	led_stop_software_blink(led_cdev);
+	del_timer_sync(&led_cdev->blink_timer);
 
+	clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
 	clear_bit(LED_BLINK_ONESHOT, &led_cdev->work_flags);
 	clear_bit(LED_BLINK_ONESHOT_STOP, &led_cdev->work_flags);
 
