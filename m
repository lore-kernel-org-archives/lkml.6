Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48In4L///M4qwIl7HqvQaogXKUnPK1Rk5dCfr0MKJpLH4kyTINlGg1z4maZ7U5DTdZiuvFe
ARC-Seal: i=1; a=rsa-sha256; t=1524406400; cv=none;
        d=google.com; s=arc-20160816;
        b=ADqbImfb6IprprAKnppavNGuzDnxWRGYcK5mjASghSg+t+D/JaoFxtqZn58RTs+lRD
         PMfzuR3FvjBzZT4wqfhQ4Oz49Vsd8hzKWEm343lHByIUCEfLtHfA2o+dUnDegp3pShf9
         7VJnY8/9Icq2gk908Gp8/+id4iz2hpaSk1XsPbCiAYfGPeq1Jf0oswZb+oz6KAx1YiYX
         IdzwhPo2yx+Ms9GDud9R5kXVdGzaPlDYS4IwvqPS8smXCeNWQIvzS/lwgNFHrWV35Kyr
         vArvTRHB+FYHconxh5++fYC0ph3oj0OOyXIvcIHD9uCgKI5yK0pa2Q37Y7efImr/R2ez
         l+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Wwtzag7sYylI3sTCRkIrq14NnMfyr6W7sIunGQFBR8k=;
        b=szUkSkCz/qDE3JWQLEH6QOM8mJRzwI2UJOtkZHeKPnan3YAIiV0gpLO4HvaeyMEOBn
         xYtnWB9oaBbcQcSxMmBRqihO2fl7EixageodhDBBLDhIhWLdCZ95dOSiNDu+rbUw9lVA
         rgi440bj9ovzrV5zQHhZ5TvEW2NzOtMg5JWfptpqbAKqe4FjS6f5+xsDNsvA6B667/VG
         6xH1E30vGlQ3YPCmEk7Er1bZstnmlCvM/AUkRaVVI7IRvh6/ssqpEalp8XhGT/N8CDl4
         QzYUGKXpXUbhhamIiNfpyNMFvdNNW6bHvhTdxN/GgeLP27atoYagvukltUv9TfXOrzSE
         ckTw==
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
Subject: [PATCH 4.9 56/95] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Sun, 22 Apr 2018 15:53:25 +0200
Message-Id: <20180422135212.710583834@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455189066394572?=
X-GMAIL-MSGID: =?utf-8?q?1598455965759867398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -587,6 +587,9 @@ static int imx_thermal_probe(struct plat
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
 
+	data->irq_enabled = true;
+	data->mode = THERMAL_DEVICE_ENABLED;
+
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
@@ -598,9 +601,6 @@ static int imx_thermal_probe(struct plat
 		return ret;
 	}
 
-	data->irq_enabled = true;
-	data->mode = THERMAL_DEVICE_ENABLED;
-
 	return 0;
 }
 
