Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Ed3Dwjjzpyk0ZhGZZ85yNpwDYSJwjUUzTpMndDbfAZKdkxVzCIfYUA+0Q2x22QquGMAhn
ARC-Seal: i=1; a=rsa-sha256; t=1524405659; cv=none;
        d=google.com; s=arc-20160816;
        b=a+upbcPSxA4JuxbF5ljT8eJuXJwu1qVJEUvd//wSDjzRRHxArgrFmLUc8UkS973B+8
         9vVU+0qI2p8A9BhxEAUXMporcxRNnD+VAE3sXFH0inwYoV4U0XrxGdP366dd8yEhQlC+
         FIHxa0MennAcWwh22dSSsTjnc2Sz9+dXHZ6xrlbv5NCL7YDOsRAwwCyMnrcWeLa2IXyD
         C0QBWxasGmh5c0nvIxU00Sqggm6quCq1QbMAep7pKt/BsarAH+h/BQZDP2r+Wjj3L0zr
         rmO72BF8KiaJ/n0bG6vGnaTpkg7BZrubmRMTM/rdOzoCpJrPVMfKm94htU7x1iZn7iFW
         JShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oWWJJ2vC+pHbaTNDtt33Y7OC7o2JKQJ5aDo8iKuBIg0=;
        b=yret5soUnBuA0si0HVEneNjlkBDV7OLBIUkvBPBrLBDfngQyHktzdyXbmvQRdjiqDM
         8r2OnV9Hrz2m4n/Rd7SrQyDNgBN9KLat2lfO+SDHJoMs/rPBFsB37whSXHdf7utAMASz
         3rxW50/IqDxjOtX43Vs/pfnMiUEewQbEzfejpR/y6qnXGIBSZyT9jhS9vRh5e+D2OHS6
         kTimcmtEgW3lQ1uaHQYVnejn2aKowOCk3tTbO0fO2ZoDw0m/gAQRVwzigZhX7sus9oUB
         YRoflTOVg0VduQxFFa8gBi7iykOvEpmupjDd/apNfPG/QZAwY9+WmKZdakN376B/PJAw
         Aazg==
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
Subject: [PATCH 4.16 147/196] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Sun, 22 Apr 2018 15:52:47 +0200
Message-Id: <20180422135111.846062645@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455189066394572?=
X-GMAIL-MSGID: =?utf-8?q?1598455189066394572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -637,6 +637,9 @@ static int imx_thermal_probe(struct plat
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
 
+	data->irq_enabled = true;
+	data->mode = THERMAL_DEVICE_ENABLED;
+
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
@@ -649,9 +652,6 @@ static int imx_thermal_probe(struct plat
 		return ret;
 	}
 
-	data->irq_enabled = true;
-	data->mode = THERMAL_DEVICE_ENABLED;
-
 	return 0;
 }
 
