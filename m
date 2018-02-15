Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031964AbeBONBZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:01:25 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:49401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030638AbeBONBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:01:23 -0500
From: Lukas Senger <lukas@fridolin.com>
To: giometti@enneenne.com
Cc: linux-kernel@vger.kernel.org, Lukas Senger <lukas@fridolin.com>
Subject: [PATCH 1/2] pps-gpio: Avoid flooding syslog
Date: Thu, 15 Feb 2018 13:59:20 +0100
Message-Id: <20180215125921.29494-2-lukas@fridolin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215125921.29494-1-lukas@fridolin.com>
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
 <20180215125921.29494-1-lukas@fridolin.com>
X-Provags-ID: V03:K0:1kCE4OQajyXRpMvzpTBsidbO4eQtik+bWXl7YQdvh58FPeyTLCk
 3EWsxlbk/X6+PxTUjiEtKgqlX5+oKLLKnSXNHw9LLIstiuODX72Dt1X4uoSa6y2XlYx7Xq2
 WbAy3ZIfZJwIigAKTyJ7Kv2ThgYV/DyFTq/Dn0yz0I+WDHQ+Pt1PFizyX8kWUJEm6KBfLJY
 tnOfPyVwfvuth35l0Lf2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wbns7rzIPIk=:X7QMzjjifxbRBJqXlc0Cl4
 v3GoSrV8+BTPh7W4AZoXC+vGWJi8a2ZUJUP9kVWRro4jwvPuoTAAYDxoeAc/PO3gDBU1cYyor
 zNXyIXPyS7woGgctCo6SKvlZPN0HQT2xCACMuYy7mCOF96R+JyvwHI58b9e7BKp0iX5Hl/WNz
 M6fEsUFv7VR7l2WraXIu8mk+K+X1YPMiO89iti8ua0BFDpiHQlgkKKQ/AEbNDhNP8Z5ddrUrg
 pWWaz8Bzj3nXeCdJyCvDf7ENg40Usqsz9A5Rflgbpx+V8NNcKGjDHdPokqxFX4nfKJ8l942Vx
 SBYnjI+fk7H2UtW17Gp150ZZs8f8atns2nEgzIxbHsLBWEq2eAe8R8gGiPjydupwk73EPb3fx
 k9jGPmkn3UJDimfjD5WpvHayO/7fuI6AqowyHwmexOAQBddcmxvodMLp8V+UbzIzkcWeyNuNI
 z5pg11uQYZz7YEIaMTVBV6b5SqQXbKfVqIkOwY8pMj5GKX1utHklTau1COcFMEvAhb8Sg/xrc
 amAum3CO6GvxM+4pthriN36lk59z12uZXU4WjbgYwp0gAbhT+Ru0jDhLWKQfbudGVZkJqVetl
 1XQPiipGyghNyj6N9psktu7op2RITEjIsKdvCaekR5X7YrusbyWNiSD4YYuGryOQRK48aqUpa
 yV1WTy5AbjLFJIAjD/tBKz0vVx0Ahs/PYcgc3uwXXDD10JDpAzpb4abuGyt4y/LIsZYWb/yVI
 sDdmgvutKJO4F49hOBUFgwSEtnrjj9XvQC14ng==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/pps/clients/pps-gpio.c | 1 +
 include/linux/pps-gpio.h       | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index dd7624f1d23f..35c3b14fc9b9 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -196,6 +196,7 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	data->info.owner = THIS_MODULE;
 	snprintf(data->info.name, PPS_MAX_NAME_LEN - 1, "%s.%d",
 		 pdev->name, pdev->id);
+	data->info.echo = pps_gpio_echo;
 
 	/* register PPS source */
 	pps_default_params = PPS_CAPTUREASSERT | PPS_OFFSETASSERT;
diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
index 0035abe41b9a..67f50e8dcd11 100644
--- a/include/linux/pps-gpio.h
+++ b/include/linux/pps-gpio.h
@@ -29,4 +29,6 @@ struct pps_gpio_platform_data {
 	const char *gpio_label;
 };
 
+static void pps_gpio_echo(struct pps_device *pps, int event, void *data){}
+
 #endif
-- 
2.16.1
