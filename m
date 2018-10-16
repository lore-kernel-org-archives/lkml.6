Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA52C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5BB205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PTNnIF58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5BB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJPWre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57142 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJPWrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145641euoutp01c35e96fd4cd49f5310397ce393d3d4f5~eHqGLUYor0427704277euoutp01Z
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016145641euoutp01c35e96fd4cd49f5310397ce393d3d4f5~eHqGLUYor0427704277euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701801;
        bh=rzIY2soOD1M1UDKrc+X0WCeYTqj8P76+NMfULbIsJ2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTNnIF58IJnjSRSzGNNCPwbFv+TUW5KygfYRjiYWlLzIvNmSsuX1nLUcnzr5FXTkR
         N2YvUZEYLsEQifDWYFXW2EOnbFaLaqXpfC51/hfdSrxi1JJVxif0hhnRp/8UazfayJ
         5rtfFvRZ1JY8s/G6ec/XMMUny4RQdWBePEoVTwMU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016145640eucas1p162bf0e36a8d7db602c3d928789ee413e~eHqFbtohL2235322353eucas1p1w;
        Tue, 16 Oct 2018 14:56:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.21.04806.82CF5CB5; Tue, 16
        Oct 2018 15:56:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181016145640eucas1p10d60eaf07c6a4b0c539e46053d2ea7de~eHqEkMsUc2218322183eucas1p19;
        Tue, 16 Oct 2018 14:56:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181016145639eusmtrp165f659ddab39bdb22db15bef7fecbfd1~eHqEVGxf61176711767eusmtrp1r;
        Tue, 16 Oct 2018 14:56:39 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-74-5bc5fc2822e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A9.D9.04284.72CF5CB5; Tue, 16
        Oct 2018 15:56:39 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145639eusmtip2f891a136be7dc57e6b00280b180c6454~eHqDz4e8d2832928329eusmtip2K;
        Tue, 16 Oct 2018 14:56:39 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 01/11] thermal: remove unused function parameter
Date:   Tue, 16 Oct 2018 16:56:12 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRiA+Xa2s7PR9HSU/PAaC1OTZmLSgVIMgw74o/oRRAq19KSS22xH
        l2bRfui8YJqK5nUqmpPhBc1MRU2dOsW8dZlTC4k0S9GkaaVI5Tyr/j3v814/+DCEaOQ5Y7Hy
        BFopl8aJUSG3fXh78rj37lD4ibItX7KluJlHLvalA1JrcSMrByd4ZOUbE4+cU7uSrR/3oFpT
        yyVfd5WjpOXhICCfzExzyLSeQT65+CEHDRFRDdoGQHWWvudTNd1fOFSrPhOl3pm6Uepp7QOq
        JqeAR/Wvd3OonDY9oCyt7heFV4Vnoui4WBWt9Au+Loyp0Nbx45eESU3arxw1SBVkAQEG8ZNQ
        U6xBs4AQI/B6ABcaSgAbbAL4TVdkCywA7vTp+FkA22/pmiZYrwPQULqB/utYa57mWYtQXAI7
        9Let3hEvA9DSW8O3Bgg+CuCcrp1jXe6Ah8Dvb9cRK3NxT/jis57PHuUOZycy970AD4Nz5iqE
        9b18+Ox5spVFuAr26DQc1p+Dk+OfeCw7wBVjm22OKxwryOayzMDxDD3K8j2YPtphqzkNDUb2
        aAT3gc1dfqw+C18aelD2wXbQvHbQqpE9zG9/jLBaBDM0BFvtDduyp2zHHIK6hiLbcAoWNtbs
        M4FrATRlXH4EPEr/76oCQA+c6ERGFk0zAXL6joSRyphEebQkUiFrBXufaOyXcasD9O7eGAA4
        BsQHRD9nBsMJnlTFJMsGAMQQsaMo+tVQOCGKkibfpZWKa8rEOJoZAC4YV+wkqtO2hBN4tDSB
        vkXT8bTyb5aDCZzVwK9iJLd6Y0pWvKJwPtV4JTHIZ3mYkXiojKlEVX29cMRlFuF6rW0GBkqa
        5IdXy1uWXexlnZFbeXkBufkpXipBhOP90KGd+YW0iDX77UtHj4Q5O7oVDqtWz+cPrdoFJ9Vm
        ocH9N9PNG6bfS55+/lVmSZDhQonR31cx/0OdEkoYxFwmRup/DFEy0j81dQVFQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4PV31P0ejDf7v1bPYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFrcaZCw2PQYyFrYtYbG4vGsOm8Xn3iOMFkuvX2SyaN17hN3iycM+
        NgdejzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo/FfZNZPQ6+28Pk0bdlFaPH501y
        AVxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlz
        5y1jL3jKVbFu3numBsYWzi5GDg4JAROJXReFuhg5OYQEljJKnD3qCmJLCIhJTNq3nR3CFpb4
        c62LrYuRC6jmE6PE5a3HWEB62QT0JHasKgSJiwjMZ5Q4uukyWBGzwGVGie5pe8C6hQUcJL5d
        fccMYrMIqErsf7EKLM4r4CUxuX8mI8QGOYmb5zrBajgFvCVu3VjADLJACKjm4mLGCYx8CxgZ
        VjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRGxrZjPzfvYLy0MfgQowAHoxIP74/rR6KFWBPL
        iitzDzFKcDArifCmXzoaLcSbklhZlVqUH19UmpNafIjRFOimicxSosn5wKjNK4k3NDU0t7A0
        NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXA6H9k99fDdnI/3zVdurLkG/unvmcX
        vzqzJjKK+elcvGRV+5xlw8+oKd8kLteVPgyWWhqXNUvF8Ev4pbhj92Tz5r4PmcZgcfnp/C+Z
        YZ+05h5vWe9S3RAo3mz94k2B9/p1TB2zWrTPVnWW1wSHTl/UcjvQJZnxvf+D3SG+GddTE48U
        Gkx6bVgkosRSnJFoqMVcVJwIAPcXyrCiAgAA
Message-Id: <20181016145640eucas1p10d60eaf07c6a4b0c539e46053d2ea7de~eHqEkMsUc2218322183eucas1p19@eucas1p1.samsung.com>
X-CMS-MailID: 20181016145640eucas1p10d60eaf07c6a4b0c539e46053d2ea7de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145640eucas1p10d60eaf07c6a4b0c539e46053d2ea7de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145640eucas1p10d60eaf07c6a4b0c539e46053d2ea7de
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145640eucas1p10d60eaf07c6a4b0c539e46053d2ea7de@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean unused parameter from internal framework function.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/thermal/thermal_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab9823..2c6d72a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -313,9 +313,7 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-static void handle_non_critical_trips(struct thermal_zone_device *tz,
-				      int trip,
-				      enum thermal_trip_type trip_type)
+static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 {
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
@@ -416,7 +414,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, type);
 	else
-		handle_non_critical_trips(tz, trip, type);
+		handle_non_critical_trips(tz, trip);
 	/*
 	 * Alright, we handled this trip successfully.
 	 * So, start monitoring again.
-- 
2.7.4

