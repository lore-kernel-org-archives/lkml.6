Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/2iX2egXu4hUwo/gH/RjFZ68p90l4RR7f9ij0NDeFEcqITZ1GNpjEkSZpYB+VXB7OLIjjD
ARC-Seal: i=1; a=rsa-sha256; t=1523472973; cv=none;
        d=google.com; s=arc-20160816;
        b=iqOv8fwcwr2hFA+btxQEM6TnWCoFU+5yPnFAJ+CM64oZELa/4bG9kClHUAr/oN34pK
         +44qMesTNQdJfDI6nZqho1tYcE59S1SLx2IjckA+jeLx4XDPPLXcVwlfqfGfUG9oNC6o
         RpCqo389tKQw4Njx2wc/Qu2UixBNMCHzrdjZxnz+DN1+cC86HBzIAfDey8zwscipVNfu
         LgmOhuEwN8rVOmjFIk2FXfAfdF1PpcROKnQJ0x39cvDmtwPsSjzBPXbhrR8p2t4FNP31
         MQ9tLmXaDu7kYeOL6TYB+iWlDek3LB1nuBRZ+HNuscz7UwlYPTVDcd1UEMAk+IH/vg0I
         SVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R8I6tSqN3iKRDLx/EBJFGp6hauBJBOGxPV8MiNLddJg=;
        b=oyrP/9jtBFz+Y2av1JTiecweAFmvkAiEiMO922fC3/9QLhUA6PLttztNEc8XPYi4+b
         8MDmeKsYXVSs7HcG5L74m+9d6hn1trE2XZcW2MpnhlyuaYa7+yPUdx4RFj6lrRMzG6bV
         aeACTYnCFAA+7Pz+/RACs5vslKUdRJbl81h1bnAaDJ62YepHbaf5BUq5TkWpIad4gJGW
         WEM4YRH4M62S7pFBss6mqj7cXZprBNvTMrbv8p1wPcPL66jIk0hPaEx3LZ4VPkD8PEoe
         LN3kX/SIFaeTcQw7xVTEbtifw4kKJQoxV7MS/MMz8nxmm7vVJfvPmIWYPYbTYI9c1R95
         sxqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Petr Cvek <petr.cvek@tul.cz>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 066/310] [media] pxa_camera: fix module remove codepath for v4l2 clock
Date: Wed, 11 Apr 2018 20:33:25 +0200
Message-Id: <20180411183625.155746152@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477196464009666?=
X-GMAIL-MSGID: =?utf-8?q?1597477196464009666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Cvek <petr.cvek@tul.cz>


[ Upstream commit e3b4d10cc057522353c4a02f2f90dca6a52e006f ]

The conversion from soc_camera omitted a correct handling of the clock
gating for a sensor. When the pxa_camera driver module was removed it
tried to unregister clk, but this caused a similar warning:

  WARNING: CPU: 0 PID: 6740 at drivers/media/v4l2-core/v4l2-clk.c:278
  v4l2_clk_unregister(): Refusing to unregister ref-counted 0-0030 clock!

The clock was at time still refcounted by the sensor driver. Before
the removing of the pxa_camera the clock must be dropped by the sensor
driver. This should be triggered by v4l2_async_notifier_unregister() call
which removes sensor driver module too, calls unbind() function and then
tries to probe sensor driver again. Inside unbind() we can safely
unregister the v4l2 clock as the sensor driver got removed. The original
v4l2_clk_unregister() should be put inside test as the clock can be
already unregistered from unbind(). If there was not any bound sensor
the clock is still present.

The codepath is practically a copy from the old soc_camera. The bug was
tested with a pxa_camera+ov9640 combination during the conversion
of the ov9640 from the soc_camera.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/pxa_camera.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -2169,6 +2169,12 @@ static void pxa_camera_sensor_unbind(str
 	pxa_dma_stop_channels(pcdev);
 
 	pxa_camera_destroy_formats(pcdev);
+
+	if (pcdev->mclk_clk) {
+		v4l2_clk_unregister(pcdev->mclk_clk);
+		pcdev->mclk_clk = NULL;
+	}
+
 	video_unregister_device(&pcdev->vdev);
 	pcdev->sensor = NULL;
 
@@ -2495,7 +2501,13 @@ static int pxa_camera_remove(struct plat
 	dma_release_channel(pcdev->dma_chans[1]);
 	dma_release_channel(pcdev->dma_chans[2]);
 
-	v4l2_clk_unregister(pcdev->mclk_clk);
+	v4l2_async_notifier_unregister(&pcdev->notifier);
+
+	if (pcdev->mclk_clk) {
+		v4l2_clk_unregister(pcdev->mclk_clk);
+		pcdev->mclk_clk = NULL;
+	}
+
 	v4l2_device_unregister(&pcdev->v4l2_dev);
 
 	dev_info(&pdev->dev, "PXA Camera driver unloaded\n");
