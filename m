Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48p+DEYe0XKDKx0JMLAMM+9lTqMzjdOLaGQRojxSjtsgdvLDLl/w0wJMnLjVIfLHpQevf5Z
ARC-Seal: i=1; a=rsa-sha256; t=1524406853; cv=none;
        d=google.com; s=arc-20160816;
        b=re+zydXoFcpVuJjd4NRwSizsGmnOihFqjKnho3ae/UXHLB4r85HmRLUpHl1bZbRAIO
         +KVWCb+Uv3NHJkVImD0zi8tcf1MD8bw7ujOR7z0GssOoSpBuBS5wHdMUrof3chdQw7tl
         w5LZ154sPjqjampEQ3biMJTaVyTlCDriyA8eep5c1/x5YkfWx/gNSp47KRblXkp/3kUT
         BTaoHmB/+54ikjU3IKOlnmeJn1h8q1vtaX3XQ0Eu+qAp+gvkpCbViKfc3S+3oJxWxZ6b
         O505yFln9aMPd8pdx3IqaGT3LdkdcHGvgrzTf6v+YAc7iGZ6HZhy/VvNvAvUnT8CY+00
         5uVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=flSyDaNxi1YtA8hUv/DmPHTePSWNr2fUQ6y7tPQCRuY=;
        b=LhJbZCrrzchSG0YGPJmwLYYNQ9saE9aWBtrPXvfMmTG5KEJMXbXtgrNxckcoeeXrfh
         k+9JW70zQ+2ZoG8jMWwJHu0ywlqdaz+uqD2a2AKlh+Q9ZRCMKw6g2GzhLuaXTd0RiZqk
         jo9uS9Gc49pGSdNn6FbaRhNqY7e2DVqxWHkP0L3yz9BcXbMV/qG/tOvJf+hfDgycsyFA
         jhSlcIFpyH7qfeyqNXR2Z/LpXio5DspYQHn4/jON1NjXseRuJMtam+wm+/mEJ/p6odM2
         Mww9ij1qIjhYcDnBKOFwyZkbOjgYN8blO3CYWlG/1aG6+ET2YkHqR46LnQUG+ndgNKzN
         z9Bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikhail Lappo <mikhail.lappo@esrlabs.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3.18 29/52] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Sun, 22 Apr 2018 15:54:02 +0200
Message-Id: <20180422135316.792329610@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455189066394572?=
X-GMAIL-MSGID: =?utf-8?q?1598456441437950425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Lappo <mikhail.lappo@esrlabs.com>

commit cf1ba1d73a33944d8c1a75370a35434bf146b8a7 upstream.

When device boots with T > T_trip_1 and requests interrupt,
the race condition takes place. The interrupt comes before
THERMAL_DEVICE_ENABLED is set. This leads to an attempt to
reading sensor value from irq and disabling the sensor, based on
the data->mode field, which expected to be THERMAL_DEVICE_ENABLED,
but still stays as THERMAL_DEVICE_DISABLED. Afher this issue
sensor is never re-enabled, as the driver state is wrong.

Fix this problem by setting the 'data' members prior to
requesting the interrupts.

Fixes: 37713a1e8e4c ("thermal: imx: implement thermal alarm interrupt handling")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mikhail Lappo <mikhail.lappo@esrlabs.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/imx_thermal.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -493,6 +493,9 @@ static int imx_thermal_probe(struct plat
 	if (data->irq < 0)
 		return data->irq;
 
+	data->irq_enabled = true;
+	data->mode = THERMAL_DEVICE_ENABLED;
+
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
@@ -576,9 +579,6 @@ static int imx_thermal_probe(struct plat
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
 
-	data->irq_enabled = true;
-	data->mode = THERMAL_DEVICE_ENABLED;
-
 	return 0;
 }
 
