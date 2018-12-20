Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE4C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF91621741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qbfQtYy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbeLTKXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:23:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44105 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLTKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:23:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220102301euoutp02946de47b5a5910b4504eeb5369660c25~yA2tHY7wr2917329173euoutp02Q;
        Thu, 20 Dec 2018 10:23:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220102301euoutp02946de47b5a5910b4504eeb5369660c25~yA2tHY7wr2917329173euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545301381;
        bh=CBPDEPRhCP+eGDy87/DSZ8I0za3vfuRv7qu8KqplgR8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=qbfQtYy0HYqJlG3+IoKG69DlmOZ7axWTW9X4f9ET2XXOMVEikElh4VB0kWmXXQYpi
         iA3qqjg2/Mgwqt6PSbYYEPB2a7jDNSNBu69ttEztC3RP/agFjck/F59Fl93dasHyro
         KxWByT8tMhjE7GPq7RYARxHBC6xiaK+yaGVRDtCw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220102300eucas1p1da6fd45b5f00a847189cd3aa25ac8528~yA2sqlKFc1464414644eucas1p1S;
        Thu, 20 Dec 2018 10:23:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3C.A2.04294.48D6B1C5; Thu, 20
        Dec 2018 10:23:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220102300eucas1p210735c7753688a52a73ccf026884dd11~yA2r_0frK0421304213eucas1p2E;
        Thu, 20 Dec 2018 10:23:00 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-7c-5c1b6d842770
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.49.04284.48D6B1C5; Thu, 20
        Dec 2018 10:23:00 +0000 (GMT)
Received: from AMDC3748.DIGITAL.local ([106.120.43.17]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PK100480669SP10@eusync3.samsung.com>;
        Thu, 20 Dec 2018 10:23:00 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH v4 3/3] driver core: add probe_err_ptr helper
Date:   Thu, 20 Dec 2018 11:22:47 +0100
Message-id: <20181220102247.4911-4-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181220102247.4911-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7djPc7otudIxBmevaFjcWneO1eLlhMOM
        FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
        kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
        o2NiBZfYKno3fmFqYDzC2sXIySEhYCJx7NZrIJuLQ0hgBaPEusWP2CGcz4wSXxduYoepun12
        AVRiGaPE/NbvLBDOfyDn1SKwWWwCmhJ/N99kA7FFBIwl+s/OAutgFpjHLPHy1R0mkISwgK3E
        u4kPwIpYBFQljjX8YgSxeQXMJbrmPWKBWCcvsXrDAeYuRg4OTgELiZ8rweZICGxhk/j7cg0L
        SFxCwEVi4l5LiHJhiVfHt0BdKiPR2XGQCcKul2iaeYUZoreDUeLE4uVsEAlricPHL4IdzSzA
        JzFp23RmiJm8Eh1tQhAlHhI3Zq5jgniym1GiZfEe9gmMkgsYGVYxiqeWFuempxYb5aWW6xUn
        5haX5qXrJefnbmIExvDpf8e/7GDc9SfpEKMAB6MSD++MKKkYIdbEsuLK3EOMEhzMSiK8j7Ok
        Y4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUwcjHfLHhj
        sPd2vDjvwzXnTgp7B7A4lWTltkebsiVNSTBZo3pf/XeJWnKH2iqu3VpPN8U8nOjiek7i+q+5
        fze4aPyyY99WZbni0JOnwosnyHU9XpBxV+BxwLraxFVXuIoC1POWMnR9u5a826J7ovKGguRV
        hS57vyV9DrMQF/1/ZKXrnsWtPQHmSizFGYmGWsxFxYkAWcn2It0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t/xq7otudIxBmePc1jcWneO1eLlhMOM
        FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
        kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
        o2NiBZfYKno3fmFqYDzC2sXIySEhYCJx++wCdhBbSGAJo8S250A2F5DdyCRxcsI8sCI2AU2J
        v5tvsoHYIgLGEv1nZ4EVMQssYpbYu24fWJGwgK3Eu4kPwIpYBFQljjX8YgSxeQXMJbrmPWKB
        2CYvsXrDAeYuRg4OTgELiZ8roRabS/y5M51tAiPPAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ
        +bmbGIHBt+3Yz807GC9tDD7EKMDBqMTDOyNKKkaINbGsuDL3EKMEB7OSCO/jLOkYId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYxZvgwG2Te3fHpyNnyb
        1cSFj8+kx96J2HZr1axJbCIaNb3PH086zSqqapdq8n+t2IbPRfJNRlv0rHhVOXXF+wtZtih+
        vVYyJbplwbklouUe9osOdV0wf3M4lsetLcE9UOh0X8m8W/3vnwoei9WQ0FvyMWG+48K6fMO6
        etuGKc1WyhsPq16Nuq7EUpyRaKjFXFScCAD12L3MOgIAAA==
X-CMS-MailID: 20181220102300eucas1p210735c7753688a52a73ccf026884dd11
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102300eucas1p210735c7753688a52a73ccf026884dd11
References: <20181220102247.4911-1-a.hajda@samsung.com>
        <CGME20181220102300eucas1p210735c7753688a52a73ccf026884dd11@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

probe_err is useful in multiple contexts where error is encoded in pointer.
Adding helper performing conversion to error value should simplify code
further.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 2d3a1cc6f5da..50632414c363 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1594,6 +1594,8 @@ do {									\
 extern __printf(3, 4)
 int probe_err(const struct device *dev, int err, const char *fmt, ...);
 
+#define probe_err_ptr(dev, ptr, args...) probe_err(dev, PTR_ERR(ptr), args)
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.17.1

