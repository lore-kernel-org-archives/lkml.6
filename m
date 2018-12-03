Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C16C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9B6206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ah868BTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9B6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeLCOcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:32:53 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47673 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeLCOcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:32:51 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181203143136euoutp0298daf1c3110cc17895efea2a66bb2684~s2R5DSYYe0635506355euoutp02Y
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 14:31:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181203143136euoutp0298daf1c3110cc17895efea2a66bb2684~s2R5DSYYe0635506355euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543847496;
        bh=XyvB6qv76N9Eb6Xx/D6063pygN/u38E8+8VRq5JHg5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ah868BTSvoo0irHk7DciKVwngz+IMP5oFUMA902KptpR0xIbd2xGP/NLJkLp0W9Ng
         XxV8LpIXZzm4Fd6TcyWah6UT5ydbf4hTuyPovIbZB9+WiOjxWLoDxI6x2e3rH1RzIc
         YH6bj7MESiiUoYfwfMdOVcYs8xfSeVzjh7FIQ8v4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181203143135eucas1p2b77246d452e31c5ea4880efc1eb8cb47~s2R38ALYu0427604276eucas1p2f;
        Mon,  3 Dec 2018 14:31:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 42.D1.04294.64E350C5; Mon,  3
        Dec 2018 14:31:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427~s2R3NEGvv1908319083eucas1p1b;
        Mon,  3 Dec 2018 14:31:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203143134eusmtrp1afaec282fc3abdf73a40e467b3ccbbe1~s2R28KDKp1680116801eusmtrp1B;
        Mon,  3 Dec 2018 14:31:34 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-5a-5c053e465c42
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C4.43.04284.54E350C5; Mon,  3
        Dec 2018 14:31:33 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181203143132eusmtip2d0a4832f588c8ce344b70e4187a65528~s2R1-I8w60555005550eusmtip29;
        Mon,  3 Dec 2018 14:31:32 +0000 (GMT)
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
Subject: [PATCH v2 4/5] drivers: power: suspend: call devfreq suspend/resume
Date:   Mon,  3 Dec 2018 15:31:14 +0100
Message-Id: <1543847475-7600-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO/exex0tbsvyV0bBoIdClhFxKHtBxDUior+sDF110dRN3dXM
        HuSy1CxTzGqupoaVa64snTaWWk7Tyty06P3AMJBe5ousEGu3a/Xf53zO9/fgcFhSPUjPYHfr
        UwSDXpugUSiputYfngXrVtKRiz70hOKm2iB8w1RF45s3vtH42XAvjUtbPDTOLK9S4IfHdTi/
        5xOJvd7rDO44/JnBLzNmYnNRA4Gre57S+LHrvAIP5bUgbPI2EvhqyxsGX3rWReBXRqsCv3lw
        19ej/RGNjza0MDirsp/GnzvfUquBr7tVR/P2Ejviz2V0UXxB/iDiy+s/EHy17ZiCv22xM3zN
        xUP8WCvDN/XVE7zjSTbFn3TYEG+tHGH4oepZmyZtVYbtEhJ27xEMC1dGK2Pziq6QSUbl3ncl
        gRmogc1FfixwS+BV/ktGYjVnRfDt4ZZcpPTxMILWWgspH4YQHBnNpHMR86fCHCHrCgTFd4+S
        /wqcRg+Ri1hWwYWA05YsNfXnyhE8cgZJGZK7R4JroPBPZgq3AcYa0qUMxc0Bj7edkFjFhUPV
        L3kh4GbBC88xUmI/bj0UWUtJ2V9h4Wu3Xua1kGmsUMg8BT62OcZrZ0L7qROUzCJ05NjGMwcg
        +75zPLMcmtu6aGkdkguCKtdCWa8B4+BhJGngJsHzL5MlTfqwsO4sKWsV5GSp5fR8cJzoJGSe
        BhX2M+PNeShrOk7Ij2NBYB05jQrQbPP/YWUI2VCAkCrqYgRxsV5ICxG1OjFVHxOyM1FXjXw/
        sX2sbdiJXKM73IhjkWaianUUFammtXvEdJ0bAUtq/FVJyT6l2qVN3ycYEqMMqQmC6EaBLKUJ
        UO2f0L1NzcVoU4R4QUgSDH9vCdZvRgZiV80N3RjnH5/zc2l/2DJLVnRfXKJbl/apOX7b93vZ
        p83XitZttpZONVd6O2Zfbk0eOR9aM7qUM02/5e/opJoDU2LC05701/68vyj4worgpjum22dr
        rK+XKOfl9EbYOwNWxW4/uF7btyBvQ/GZxvcnB9SRBQPN7vrusF5XGZU8YHq3X0OJsdrQYNIg
        an8DW304jIUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7qudqwxBrt2WVoc3KppsXHGelaL
        7Ru/sVpc//Kc1WL+kXOsFs2L17NZnOnOteh//JrZ4vz5DewWZ5vesFvcapCxmDVlL5PFpsfX
        WC0u75rDZvG59wijxYzz+5gs1h65y26x9PpFJovbjSvYLO6eOgo04/QlVovWvUfYLdpWf2C1
        eHPhHouDhMe23dtYPdbMW8PoMbvhIovHhP5PjB6L97xk8ti0qpPNY//cNewem5fUe/w7xu5x
        8N0eJo8tV9tZPPq2rGL0WLH6O7vH501yAXxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6
        hsbmsVZGpkr6djYpqTmZZalF+nYJehm9U1YyFzRyVTycJ93AuJeji5GdQ0LARGJWRBcjF4eQ
        wFJGia+X/zJ2MXIChcUkJu3bzg5hC0v8udbFBlH0iVFi35JtzF2MHBxsAnoSO1YVgsRFBJYz
        Stz/OZsdxGEWeMAs0fF8EytIkbCAj8S/vZUgg1gEVCXOnT/NBGLzCnhKrP9/C2qBnMTNc53M
        IDangJfElBXzwWwhoJqWvSuYJzDyLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYqduO
        /dy8g/HSxuBDjAIcjEo8vA7xLDFCrIllxZW5hxglOJiVRHgLCoFCvCmJlVWpRfnxRaU5qcWH
        GE2BjprILCWanA9MInkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODil
        GhgDz74wc+3btujlCQcOnhUZZf1CHXvaMgUXdrT4L18reb1uHnd+mlBav0BsBKuhRXbTe/ud
        Kzs1v1n2Xfn1NDu6wafcneO/U8+5R9puxn3T1W99a9t689dym1OrArWrQ1IVwz66v4yqfHJw
        62ZJCcd3R25cYWwrSDmdsfbRZ1+ZCdZtIlIzvyixFGckGmoxFxUnAgAqUMvi6gIAAA==
X-CMS-MailID: 20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devfreq framework supports suspend of its devices.
Call the the devfreq interface and allow devfreq devices preserve/restore
their states during suspend/resume.

The patch is based on earlier work by Tobias Jakobi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/base/power/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a690fd4..0992e67 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -32,6 +32,7 @@
 #include <trace/events/power.h>
 #include <linux/cpufreq.h>
 #include <linux/cpuidle.h>
+#include <linux/devfreq.h>
 #include <linux/timer.h>
 
 #include "../base.h"
@@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
 	dpm_show_time(starttime, state, 0, NULL);
 
 	cpufreq_resume();
+	devfreq_resume();
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }
 
@@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
 	might_sleep();
 
+	devfreq_suspend();
 	cpufreq_suspend();
 
 	mutex_lock(&dpm_list_mtx);
-- 
2.7.4

