Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/T/yOprLjm9n3YwRZRTonPqN3KrztVmpkY8HS+aB0xWhFBUfrQOKolhQJg5Ts4mcca8ckI
ARC-Seal: i=1; a=rsa-sha256; t=1523473176; cv=none;
        d=google.com; s=arc-20160816;
        b=MKyRWPznicNFulAlfBLQmncMLzN60Viinwc2QNNUTMV1Tn2pcDKYhr/OdETx1oi2//
         Kz90qlM/JQbbap12sFunRrMWLaRgv812SAKCeZzdvrU0w19iZ8Qohq3pKnrij3I+pYny
         Iez3MUUaOf1O/S7sFYHrf/uaqzrZAUZz0rFGAHbWh6RHgMNmaer63ThJFnh0l/nSBcQW
         JeBzzLCanCCzM+McyDYshYctCkLZl/l572EkCYphnRkhm6Nh5gNx76+goHb3nY/Ag9s0
         8Cfbp9vMMYUgJ8+RzJJL26NNMVEEjGwdrQ3SABgFVigluff1WYXhmydJnyW+UorGjfOX
         nFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VQEIH7eXAP0KzRe3L2ApzmCIjv5A+rB5kRds3VCbBe8=;
        b=IgcdtwNGfUFQoWrK5eOgEGXGQWEQarNJJNTq2sHoJdG/UUjhnjM9rsuNtwAd5IdLAc
         WI0eC5lEpgik74FAOF9IPeOPsRqhlSdXvx7SK88boi+YsS/BbmXegqh5HLBvgLNOXwSq
         KPxuqT2YLHwF4YuH/CQD3d6SEDqULT+sJq1H32NB9zRY/w0f4kK5aXEZRKvdUuNnQD9z
         wNQwOj6aRMmUOtt6vhLysiyXNltk0NisFrawzHv9gW265n6r+y8D5aLPpUwkWgMRYX1D
         vJru4O31TuuE3FM4OfRz+a2DH1tLU4ArFgxNxzDTp/YolsTm36V/BukPXo4Dr9s3C9Or
         fO1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee.jones@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 155/310] backlight: Report error on failure
Date: Wed, 11 Apr 2018 20:34:54 +0200
Message-Id: <20180411183629.085307545@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477409262467395?=
X-GMAIL-MSGID: =?utf-8?q?1597477409262467395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


[ Upstream commit 7e715c2d9c27c23f3187454157c58cf292ed103e ]

It is possible to update the backlight power and the brightness using
the sysfs and on writing it either returns the count or if the callback
function does not exist then returns the error code 'ENXIO'.

We have a situation where the userspace client is writing to the sysfs
to update the power and since the callback function exists the client
receives the return value as count and considers the operation to be
successful. That is correct as the write to the sysfs was successful.
But there is no way to know if the actual operation was done or not.

backlight_update_status() returns the error code if it fails. Pass that
to the userspace client who is trying to update the power so that the
client knows that the operation failed.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/backlight/backlight.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -134,7 +134,7 @@ static ssize_t bl_power_store(struct dev
 {
 	int rc;
 	struct backlight_device *bd = to_backlight_device(dev);
-	unsigned long power;
+	unsigned long power, old_power;
 
 	rc = kstrtoul(buf, 0, &power);
 	if (rc)
@@ -145,10 +145,16 @@ static ssize_t bl_power_store(struct dev
 	if (bd->ops) {
 		pr_debug("set power to %lu\n", power);
 		if (bd->props.power != power) {
+			old_power = bd->props.power;
 			bd->props.power = power;
-			backlight_update_status(bd);
+			rc = backlight_update_status(bd);
+			if (rc)
+				bd->props.power = old_power;
+			else
+				rc = count;
+		} else {
+			rc = count;
 		}
-		rc = count;
 	}
 	mutex_unlock(&bd->ops_lock);
 
@@ -176,8 +182,7 @@ int backlight_device_set_brightness(stru
 		else {
 			pr_debug("set brightness to %lu\n", brightness);
 			bd->props.brightness = brightness;
-			backlight_update_status(bd);
-			rc = 0;
+			rc = backlight_update_status(bd);
 		}
 	}
 	mutex_unlock(&bd->ops_lock);
