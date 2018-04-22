Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4831BfClU/L0NUxbYDyQMizNkGRHNNnZHyiCPyOrL9N1KBYu80JWSMVWg4P0QuJE3BH50HV
ARC-Seal: i=1; a=rsa-sha256; t=1524406192; cv=none;
        d=google.com; s=arc-20160816;
        b=RjIym2cEkHOc4g2HIoqidaLOGMXPusWK6JiG3a1TQCvgYr552VhTV0+mLunfm0SZNn
         R6W89gGoHfQtqwu1Zi9PvbRdXYdAi8bT12ShReXDzoyXTB1sNkTQ60OdRHDNkRwxmnua
         qh3IVYJ3SVVdx0J2zEX/lUmQUeuyi0xoNnd4ArAZLQCd3MdVhM6zsNu55GA6EbtUCbqZ
         FsAjwIVydnfsO2KoaAL4kAQ5y4z+O0VmTrCqmFPodyvHg6Tjuu/NWDIPyAkWkTW6eeCw
         jE9byyv8J7ip6SgVTOmTzLfCW3ouOl6sy/Zv0dt3QYh0RQOUpjPVIm7kwzPRuQy5YbME
         Yc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IjwQ1BHcOYyp6D+QydOn+A/+7DhQfnv0QZVkKk4dl24=;
        b=vRCDUmxJxCKGgmSzgd8gSnYXyaTr8SfFqAbV5kExOJCENK44IG4ghQIvMkcxQRdQ/Y
         B7K4y4h7PL9tmbEjMBDaRuDzbDsdfMMTlSdSvoQb/jEhJC/0gn42G0zYgsu3r30lMl+o
         3eRF/Sgih7oEEoDFrw5neNZ0NCs09GzIMXS4FCW9YImhggMPd22A+u0xJnUi2OiqeUv6
         RZSTAVvR1QDD4NkeyiDkUmRpq5h7EBqhEqcTRk9zb9zJUxN6wHicDEvo9Vnx0tt+zbpl
         9xiW5UergWV4NMxY0Xi51Rw6qUWgRof46MkUN8+pVMtOQF2UI8OVGokiRgyAZ4aNK0xL
         gv/g==
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
Subject: [PATCH 4.14 111/164] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Sun, 22 Apr 2018 15:52:58 +0200
Message-Id: <20180422135139.959228024@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455189066394572?=
X-GMAIL-MSGID: =?utf-8?q?1598455747680598204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -601,6 +601,9 @@ static int imx_thermal_probe(struct plat
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
 
+	data->irq_enabled = true;
+	data->mode = THERMAL_DEVICE_ENABLED;
+
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
@@ -613,9 +616,6 @@ static int imx_thermal_probe(struct plat
 		return ret;
 	}
 
-	data->irq_enabled = true;
-	data->mode = THERMAL_DEVICE_ENABLED;
-
 	return 0;
 }
 
