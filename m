Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C1CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC1E2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZbkHzNOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC1E2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeJQXvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:51:10 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:12977 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:51:10 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181017155448epoutp04eb40f9fed910036d58e937c00b28fdca~ecGH1aG5w0269102691epoutp04j;
        Wed, 17 Oct 2018 15:54:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181017155448epoutp04eb40f9fed910036d58e937c00b28fdca~ecGH1aG5w0269102691epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791688;
        bh=dhe+bkWFIacRqoxR5vBYCjnNquU4LvLJTXdac2+zIdQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ZbkHzNOci8wOT4Vblgk+0BLoZDE95nhic9OUsosUe6Lg7c+jehnA/I2t09Unjl2tT
         vDOeqC/t4a5tAa6qnf/f/8u0YO8IKUlnAw/2F3iXplfl4u7Ia7I/F8HNgsOeTCipDD
         XaNRsGUkBoNAbozltA+jV/NzlYorqLE8IZ95gKBk=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155447epcas2p3cf3d552600e8c4879fbc4cebf1b738c8~ecGHIS7qO2404124041epcas2p32;
        Wed, 17 Oct 2018 15:54:47 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.EF.04077.74B57CB5; Thu, 18 Oct 2018 00:54:47 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181017155447epcas2p2db761f6575de357b65eb5e39b709fead~ecGGfdRXC1848918489epcas2p22;
        Wed, 17 Oct 2018 15:54:47 +0000 (GMT)
X-AuditID: b6c32a46-475ff70000000fed-05-5bc75b475139
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 89.44.03633.64B57CB5; Thu, 18 Oct
        2018 00:54:47 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:46 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Amit kucheria <amit.kucheria@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH v2 15/17] thermal: uniphier: enable+check sensor after its
 setup is finished
Date:   Wed, 17 Oct 2018 17:52:41 +0200
Message-id: <1539791563-5959-16-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+7azc46jyWGKfjkSWhgpaaldPl1X0jzQhaAIdKGNPKjkVDYn
        6j95CVNho8jyfsFL2DKcY+myCeJl89IkXZlWJposK1vhKM1Max7973nf9/fwvC+8JFdYwPMh
        k1LSGUWKLFmM87H2Xv8jgVFSi/SAaTgY5ec0cFBbWSsP2Z0WgJ6o+zFU+2qch7pzbQCtz37l
        oaGOPA66VVGPoca5GQLZOqtw5FT3AVTleEeguRkNjuYN3kjfPIGj3501GOr64AQnhXTedzNO
        V0xbcfpZxRRBP317iG4wfebQem0RTr8fN+G0Ot+B0xqDFtAd4zVceqB0CaMtEx0c2qn3vSiI
        4R+NZ5KTMhjF/uPX+InLZh2WVsTPtGpsRA6wksXAjYTUQdjeo+MWAz4ppIwAaqrLCbZYAnDt
        tYO7RQ2VVWwOdACamhyblhUAG/PHMBeFU+Hw7m0tKAYk6UmdhYaWjQgu1Y/Bj05/l/agYuH8
        SAnPpTHKD06UfNqwCigazht+ADbMFw6a720wbv/7I+t1uCsLUqUEVHetEiwUAe3GnxirPeAX
        i2GzL4J2bRvYNAC4sNKEsUUrgC0vzByWksBeyyiPXc8dFvb+JVxbQ0oACwuELELDl/UdOHtl
        JYDlkzXcO2BHHdimBV5MmlKewChD0kKClDK5UpWSEHQ9Va4HG98RcMYIGkfO9QCKBOLtAqOX
        WSrkyTKUWfIeAEmu2FOQvcsiFQriZVnZjCI1TqFKZpQ9QERiYm/BjKhaKqQSZOnMDYZJYxRb
        Uw7p5pMD+guyH4aOo9xpQcvjfX7f/CrH4pZqt+0E0bbY0kGfxrqFC6GB0fKwRd1Nz6uXIs+3
        z3o839v9Z1TvPxWpGnVvkB+O8nVT29/cX8SJiF9xl+2te9byBq6MNPNO90ngUExzcN7Qg8zO
        klOS3cNNfTWPwpYlx5AmXLiqOCGaHLaqpGJMmSgLDuAqlLJ/uIxkDRkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jQV336OPRBk8PsVg0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsErowfxzawFHRyVZztu8zewHiWo4uRk0NCwETi1IxZ7CC2kMA6RonrN7i7GLmA7F+M
        Ess7djOBJNgErCQmtq9i7GLk4BAR8JbYsoYDpIZZ4CiLxNoZ39hAaoQF4iRenJvCCmKzCKhK
        3JjynAXE5hXwkHix5QMjxDI5iZPHJoPVcALFz/1fwAax2F3i5I6X7BMYeRYwMqxilEwtKM5N
        zy02KjDKSy3XK07MLS7NS9dLzs/dxAgM/22Htfp3MD5eEn+IUYCDUYmHd4fYsWgh1sSy4src
        Q4wSHMxKIrxVisejhXhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgtgsky
        cXBKNTAWHYyMFMyYfSLH7ZLcHMYqj0zX0LDwZ+sDq0/Mt5qzzvP5m129W5M5bbf0S5pmXuz3
        ipwhI290OP7N/wmtcq526xKkb/nan7NrsOTwX73ktvYsqYzChbVXBZZyljfvMbn69vp8nwyr
        vBm2+12mu/d+m9e3y2mZ4X3lJ+KFhy2TgyZdL3o0f7cSS3FGoqEWc1FxIgBejN1oewIAAA==
X-CMS-MailID: 20181017155447epcas2p2db761f6575de357b65eb5e39b709fead
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181017155447epcas2p2db761f6575de357b65eb5e39b709fead
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155447epcas2p2db761f6575de357b65eb5e39b709fead@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sensor after checking trip points (unipher_tm_enable_sensor()
enables IRQ so we need to toggle sensor before calling it) and check
sensor after doing chipset specific enable sensor operation.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/uniphier_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index ed3a920..9ccc1fc 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -307,9 +307,6 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
-	thermal_zone_set_mode(tdev->tz_dev, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(tdev->tz_dev);
-
 	/* get trip points */
 	trips = of_thermal_get_trip_points(tdev->tz_dev);
 	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
@@ -332,8 +329,12 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	thermal_zone_set_mode(tdev->tz_dev, THERMAL_DEVICE_ENABLED);
+
 	uniphier_tm_enable_sensor(tdev);
 
+	thermal_zone_device_check(tdev->tz_dev);
+
 	return 0;
 }
 
-- 
1.9.1

