Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A31EC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004A0206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rT0OWUcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004A0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeLCOcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:32:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47632 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeLCOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:32:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181203143133euoutp02a64501f1ac72bca8effd2dec1c292410~s2R2PwYs90826308263euoutp02F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 14:31:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181203143133euoutp02a64501f1ac72bca8effd2dec1c292410~s2R2PwYs90826308263euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543847493;
        bh=w+BlRpdqKvggRP/1B2UEMzjpnXHjefN/rpyWfn4V+gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rT0OWUcAqUdu2dodcB0waa/I6EzrtZo+KS4c8QqhqfJb3lzN/B09USE5v54EDHojF
         TBR5l/qpk8DEVIUMU2vOE22hMpJBLFA/EHrAAgDiaspSRCJBIWMDrNyESiwL4gXIxo
         8d6hAe2HRo0ssMszsydce0TfiIRu7Slm74dMRR4Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181203143131eucas1p2e077f58c737b03353390c0706b87bfaf~s2R1B1hEV0831808318eucas1p2Q;
        Mon,  3 Dec 2018 14:31:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 46.54.04806.34E350C5; Mon,  3
        Dec 2018 14:31:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181203143131eucas1p217f22ac6d19682a54a57658a06980914~s2R0LbfDP0453504535eucas1p2a;
        Mon,  3 Dec 2018 14:31:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203143131eusmtrp1be9a8eaf8582b45c1a0bdd8701131085~s2R0JW2oO1676416764eusmtrp13;
        Mon,  3 Dec 2018 14:31:31 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-27-5c053e43e466
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.F8.04128.24E350C5; Mon,  3
        Dec 2018 14:31:30 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181203143130eusmtip24e3123475b3b18edc668ea7611719663~s2RzO-rpo0554705547eusmtip2N;
        Mon,  3 Dec 2018 14:31:29 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 2/5] devfreq: add support for suspend/resume of a devfreq
 device
Date:   Mon,  3 Dec 2018 15:31:12 +0100
Message-Id: <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUyMcRz3e17ueYrj6Qq/pZXdxtRWMf74bYysxsNf2JQReeRxtbrKPUph
        ymtK7iyNRm9K63aVdCXn1Fk57ri4XpDQizKGMpTSSnPXc/jv8/28fX/77kfjsnHSm45NOMSr
        Erh4ucSdaHg0YQ8MXUtGLp/8sBQ13/ZHtfk1JLpTO0airtGPJCo2PyPRqbIaCWo9r0SawS84
        sttvUejpySEKvc7wQVfzmjCkH3xJok5jgQSNXDADlG83Yaja3EOh8q52DL05oZWgnicPHR22
        DhKdaTJT6GzlNxINtfUSIZBtuNdAslVFVYC9ltFOsBc1PwBb1vgJY/W6LAl7v7CKYutupLPT
        jyi2+Wsjxta/yCRYdb0OsNrKcYod0ftumbvTfc1+Pj42hVcFr93rHmMdOE0laRan9o2ZQAbQ
        e2cDmobMKmgrwrKBOy1jtAAaJ+uAOIwCWFdrJcRhBMC7JbkOxW0mkdnaSYlCBYBvKp9g/yKd
        ulOks1fCBEGD7qAz4MWUAdhh8Hd6cMaKQ+P3XMwpeDLb4a/e6ZlWglkCP1nNuBNLmU3QVNxP
        idt8YfezrBnejdkM87TFuLMIMuU01F2vJkRTGPx9pVQiYk/42VLvCvtA26Ucl0eAT8/pXJ5j
        MPOxweVZDR9Y2mcejTP+sMYYLNLrYU2pDRNvNBe+GvZw0rgD5jZcwUVaCs+dlYnuZbA+pw0T
        8QJYUXXZVc5Cdc5N160KAbS9VWMXgd/V/8tKANCBhXyyoFTwwsoE/nCQwCmF5ARFUHSiUg8c
        39E2bflpAKapfS2AoYF8jjQkioiUkVyKkKZsAZDG5V7SpIMOSrqfSzvCqxKjVMnxvNACFtGE
        fKH06Kz+XTJGwR3i43g+iVf9VTHazTsDZIVviG7KmUpNNAxsHdUIjYrgL/ODfIby7evfhbv5
        HZ5ouTsmORDRbP2a9dt6zB7iwzWtSg314rZEqMNmP/coG/6wJ3BdepppPDXaotyc11HwTR08
        Lypy0fu4/m6j50jMxgClZX659oyurze7NQaLzOQSuyvtx3fnKQK37YjTRAzICSGGWxGAqwTu
        D8jwsoqKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7pOdqwxBsv2W1kc3KppsXHGelaL
        7Ru/sVpc//Kc1WL+kXOsFs2L17NZnOnOteh//JrZ4vz5DewWZ5vesFvcapCxmDVlL5PFpsfX
        WC0u75rDZvG59wijxYzz+5gs1h65y26x9PpFJovbjSvYLO6eOgo04/QlVovWvUfYLdpWf2C1
        eHPhHouDhMe23dtYPdbMW8PoMbvhIovHhP5PjB6L97xk8ti0qpPNY//cNewem5fUe/w7xu5x
        8N0eJo8tV9tZPPq2rGL0WLH6O7vH501yAXxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6
        hsbmsVZGpkr6djYpqTmZZalF+nYJehknHrWwF/QrVNz/to+xgXGTVBcjJ4eEgIlE+5nL7F2M
        XBxCAksZJZ62nWWDSIhJTNq3nR3CFpb4c62LDaLoE6NE96e7zF2MHBxsAnoSO1YVgsRFBJYz
        Stz/ORtsErPAA2aJjuebWEG6hQWCJZbvvQM2lUVAVeLliSPMIDavgKfEvvkPoDbISdw81wkW
        5xTwkpiyYj6YLQRU07J3BfMERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiN227Gf
        W3Ywdr0LPsQowMGoxMPrEM8SI8SaWFZcmXuIUYKDWUmEt6AQKMSbklhZlVqUH19UmpNafIjR
        FOioicxSosn5wGSSVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qB
        MXDvgedBu46w5mqKy89TF7pgm8jE22IuU+S36cAac+eDEa8tBW64y64W9nITsj201neO/usn
        YjwPWdqFQzIFI0Xdlkwpb35ttJm33qGqeJGX3M3dM0zXLtgQrFF40eP0iz+37zO/Wroy4/OS
        jGW6jw4cvz9bZ73mLY1/we0H7/7IPvaRzXtFvRJLcUaioRZzUXEiAEuEnMXuAgAA
X-CMS-MailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch prepares devfreq device for handling suspend/resume
functionality.  The new fields will store needed information during this
process.  Devfreq framework handles opp-suspend DT entry and there is no
need of modyfications in the drivers code.  It uses atomic variables to
make sure no race condition affects the process.

The patch is based on earlier work by Tobias Jakobi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++++++++++++++++--------
 include/linux/devfreq.h   |  7 +++++++
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a9fd61b..36bed24 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 			"Couldn't update frequency transition information.\n");
 
 	devfreq->previous_freq = new_freq;
+
+	if (devfreq->suspend_freq)
+		devfreq->resume_freq = cur_freq;
+
 	return err;
 }
 
@@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
+	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	atomic_set(&devfreq->suspend_count, 0);
+
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
@@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
+	int ret;
+
 	if (!devfreq)
 		return -EINVAL;
 
-	if (!devfreq->governor)
-		return 0;
+	if (devfreq->governor) {
+		ret = devfreq->governor->event_handler(devfreq,
+					DEVFREQ_GOV_SUSPEND, NULL);
+		if (ret)
+			return ret;
+	}
+
+	if (devfreq->suspend_freq) {
+		if (atomic_inc_return(&devfreq->suspend_count) > 1)
+			return 0;
+
+		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
+		if (ret)
+			return ret;
+	}
 
-	return devfreq->governor->event_handler(devfreq,
-				DEVFREQ_GOV_SUSPEND, NULL);
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_suspend_device);
 
@@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
  */
 int devfreq_resume_device(struct devfreq *devfreq)
 {
+	int ret;
+
 	if (!devfreq)
 		return -EINVAL;
 
-	if (!devfreq->governor)
-		return 0;
+	if (devfreq->resume_freq) {
+		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
+			return 0;
 
-	return devfreq->governor->event_handler(devfreq,
-				DEVFREQ_GOV_RESUME, NULL);
+		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
+		if (ret)
+			return ret;
+	}
+
+	if (devfreq->governor) {
+		ret = devfreq->governor->event_handler(devfreq,
+					DEVFREQ_GOV_RESUME, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_resume_device);
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index e4963b0..d985199 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -131,6 +131,9 @@ struct devfreq_dev_profile {
  * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
  * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
  * @stop_polling:	 devfreq polling status of a device.
+ * @suspend_freq:	 frequency of a device set during suspend phase.
+ * @resume_freq:	 frequency of a device set in resume phase.
+ * @suspend_count:	 suspend requests counter for a device.
  * @total_trans:	Number of devfreq transitions
  * @trans_table:	Statistics of devfreq transitions
  * @time_in_state:	Statistics of devfreq states
@@ -167,6 +170,10 @@ struct devfreq {
 	unsigned long scaling_max_freq;
 	bool stop_polling;
 
+	unsigned long suspend_freq;
+	unsigned long resume_freq;
+	atomic_t suspend_count;
+
 	/* information for device frequency transition */
 	unsigned int total_trans;
 	unsigned int *trans_table;
-- 
2.7.4

