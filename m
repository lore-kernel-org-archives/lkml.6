Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+gWRyGsbFW/mg4qidu8GE5DYL0cClZg1dY81IJWeiqk0M83CsUxxocPybKmbTAEMqmo/1G
ARC-Seal: i=1; a=rsa-sha256; t=1523473491; cv=none;
        d=google.com; s=arc-20160816;
        b=f1fZf6Yu5csglcOYE/CHoFlKAki6+wDH6cOWqQd7TCHMi5prK4R7z57qCBVdtyivF9
         yOnm/NgX6E9iB7aAjgn39D8Ys3TJoPdpUilqL3/jm8MoXJH2R8B7pnX+RKGK0HtiMsz6
         9ALzeUIn7/KvdYONWp345Yoq+Ao0mg0MefVl8nTAxEdo6j2Ez5i8hSPO7kQRQqFDJ6qk
         QKDDyY7P2YHRSyk+xoUGWcGvqXuq/P4DctOsLCL6iNozdTXz/B06GJa/GJIRostIcSVu
         XVbhdYjGzc+IeKxDr+zw0OHpsKJEYqTPwsmmglIPZOfabE68VwiB3c0xvsWjHwh/9j6h
         hfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IIGZj5kYD6h2M2KvdbDSIvKFKRmHrehdRfUUicMBA5o=;
        b=ymJTXNG/6YdEaL9pIGqWBBYLZ2ga931qUUozGFJJ4Tie9VIQuNJDmfzsPLtdEvTNkw
         1M4nVsI3woxIkPyEvMaNjcNwyJVcQES+cCFH3jSwX53KvISYQmrzp1BiKV9TuNZWG2xM
         dWSN0cTevbmqk+2kpcxK1pq4P8Oh4r62CxA1QFJJb7QnsnvLkPcX/BfPJUjDqmZW8rjb
         GEqeOvgBpolCDlwlWGq8voksIEDBCD1IC5/wK37NsM9nxuTQal32QUUhX+58KxNlz/pQ
         6vsLj1d6uxbIoEmCX0k2yFyIrhye+FJ5uE01Jva8cD7WjiOFu8XDFUvYajQ2fNAcY5Hw
         YonA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Bastien Nocera <hadess@hadess.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 267/310] Input: goodix - disable IRQs while suspended
Date: Wed, 11 Apr 2018 20:36:46 +0200
Message-Id: <20180411183634.142056912@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477740127183883?=
X-GMAIL-MSGID: =?utf-8?q?1597477740127183883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit faec44b6838312484d63e82286087cf2d5ebb891 ]

We should not try to do any i2c transfers before the controller is
resumed (which happens before our resume method gets called).

So we need to disable our IRQ while suspended to enforce this. The
code paths for devices with GPIOs for the int and reset pins already
disable the IRQ the through goodix_free_irq().

This commit also disables the IRQ while suspended for devices without
GPIOs for the int and reset pins.

This fixes the i2c bus sometimes getting stuck after a suspend/resume
causing the touchscreen to sometimes not work after a suspend/resume.
This has been tested on a GPD pocked device.

BugLink: https://github.com/nexus511/gpd-ubuntu-packages/issues/10
BugLink: https://www.reddit.com/r/GPDPocket/comments/7niut2/fix_for_broken_touch_after_resume_all_linux/
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/goodix.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -778,8 +778,10 @@ static int __maybe_unused goodix_suspend
 	int error;
 
 	/* We need gpio pins to suspend/resume */
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		disable_irq(client->irq);
 		return 0;
+	}
 
 	wait_for_completion(&ts->firmware_loading_complete);
 
@@ -819,8 +821,10 @@ static int __maybe_unused goodix_resume(
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 	int error;
 
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		enable_irq(client->irq);
 		return 0;
+	}
 
 	/*
 	 * Exit sleep mode by outputting HIGH level to INT pin
