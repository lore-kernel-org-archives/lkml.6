Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Xr15Vc7XitW4hTJMwSEhp28xa3JZDaNjHsLimU02UstL6iSvnJeLqRZ9tl+YyCQvpqiIB
ARC-Seal: i=1; a=rsa-sha256; t=1524406681; cv=none;
        d=google.com; s=arc-20160816;
        b=XEQpVAueUJbbJv4Psgg8egSNtVTt1DzkPaXzXWPE8aSBhyKsmYsVlatS7zq0t2PNe8
         pmbd31XmbZ61NObPfyalO/k98KWNQgDi2knKGdD2/FuOAGtgZSH7Cf9hcuLARlYy8v5U
         3upIu+skr03QsuUCCim0v8gFwSFaWEIb17VZarQ3RZC/33tvCJ1KVC/L7VfJo3UNWVuZ
         UoqFNvovaqVCh2deOP/5Jt7wfO3l15LkgHMFF8d98hDjEEItOMz9Ai7bVdl2wL1NTrAH
         YmzY+CbL3749Y1NBk4ZfszNqIVwWiyXrjnO2oKhwvCiMAig8/4JiOLOfr1qUJxpWuoFV
         nXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XG26shWtzGNpXzVgzRvbQYIdAmxNPUeJ0AYiXJCEC1c=;
        b=ov7yi8sDncArJWhGkzZ4oCBYP3ERgP5px1xhVUyY6RRZXiSFZ+9de5mYmV/vq8U6GD
         d/xZzDqbqC+m9eEQMs/FDb2NnFrgGC3YKaLOg7bFQCtbTFt32WDPdvqDw2DCjDNv7qib
         rAH+o7V32o7MlQv9/NYH4MnvUm8EzYhGh1A0drxrcLwy0btjyFg+OoTLqWkJe4IntfHK
         2dP9FsmaThK77vYoajXWCMMih6xuaOUySRZQS2Tvm0FlUahJO7GdDCUyT8Lot8he276N
         BRlTkamM0QogSDCz56uC1kLpvs4bhovEbmh9R0nHvB+xFK5BDwlTVF+8tqM/3Ip1AD8u
         QnoA==
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
Subject: [PATCH 4.4 63/97] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Sun, 22 Apr 2018 15:53:41 +0200
Message-Id: <20180422135308.741318759@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455189066394572?=
X-GMAIL-MSGID: =?utf-8?q?1598456260331060610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -589,6 +589,9 @@ static int imx_thermal_probe(struct plat
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
 
+	data->irq_enabled = true;
+	data->mode = THERMAL_DEVICE_ENABLED;
+
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
@@ -600,9 +603,6 @@ static int imx_thermal_probe(struct plat
 		return ret;
 	}
 
-	data->irq_enabled = true;
-	data->mode = THERMAL_DEVICE_ENABLED;
-
 	return 0;
 }
 
