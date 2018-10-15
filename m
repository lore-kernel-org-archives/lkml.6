Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49AEC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF542083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XZTCprIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF542083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeJOVdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:33:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56461 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:33:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181015134830euoutp01ce0c4354ca3bdee8f7d6d72e09570eb0~dzFRVzneN1678016780euoutp01W
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:48:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181015134830euoutp01ce0c4354ca3bdee8f7d6d72e09570eb0~dzFRVzneN1678016780euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539611310;
        bh=o+UJwnEGSVj5nDvDcq/nUsBmyU8g+sKDDuEq8AWJp0k=;
        h=To:Cc:From:Subject:Date:References:From;
        b=XZTCprIkQ3wFr6uJDb/uNVlYIZFrmyley8KYOAfTB52LWT1X3DsT3sxYTJ0SlTRkg
         dhNS9pVV9XZfnKP8NYKjaCyStd0PT4cKxUT1LHzY4p2AF0c3CE8E9y0pQD9AT+8KlB
         6e7eu4jKCWYk13UHSDlOAi75UTaWLs+M9zesN3eA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181015134829eucas1p2966e79f9a8bffc21e110a7ac3c333261~dzFQujqeJ0728507285eucas1p22;
        Mon, 15 Oct 2018 13:48:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 13.0F.04441.DAA94CB5; Mon, 15
        Oct 2018 14:48:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11~dzFPt-ZL_1531815318eucas1p1t;
        Mon, 15 Oct 2018 13:48:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181015134828eusmtrp2158118e35eae721c4662dba60302fccb~dzFPtBNnD0288802888eusmtrp2b;
        Mon, 15 Oct 2018 13:48:28 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-ac-5bc49aad836b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.BB.04128.CAA94CB5; Mon, 15
        Oct 2018 14:48:28 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181015134828eusmtip1ede1a4b2699a704378ad1a3e0003e65b~dzFPYHdlW0055300553eusmtip1m;
        Mon, 15 Oct 2018 13:48:28 +0000 (GMT)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ARM: EXYNOS: remove no longer needed s3c_pm_check_*() calls
Date:   Mon, 15 Oct 2018 15:48:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt3vvdl1euU7Fk1nKKKPCFwSNih4gtMA/JArDkXXLy9R0yq5a
        RpAYvvEJpi6zmq8SY75QZ5i2nCt8jKloED5Si7C08IFY2dr1Jvnfd77zfb/zncOPxGSPCC8y
        RpPEajVMnFwsxdv7N4b9X+j6VEE5JZSiudxAKArnvmIKq7VJomiZGycUo12VYkW59ZVIYSrt
        RmckytFxG6ZsacgRK1tr7ikL2hqQcqVlXxgRIT0ZxcbFpLDawFPXpNEdbb0osWTXbbv+PpGG
        apxykRMJ9FGY/JUl4rGMfoagfdojF0kdeBXBqGWCEIoVBGN5NvG2Y2nTQgiOegRpxQGC6DuC
        LxUDGN9wpw/BxOb6lhujFxyih91bM8T0cSjOakA8dqNDYWp1aMuA0wegsOg1notI0oO+DIWD
        B3maol3hXcU8zmOM9oGOxUqMfxPoPAnYPxSIBFEKDJfmIyFdCAw2l0oE7AYLlrZ/2Bvsxsci
        wVyG4NvPWlwoDAgaB/tFguoEvLHYCD4F5ljB0BUo0GdBt96FeBpoF3i/6CoEcoGS9jJMoCnI
        zpQJaj9oqmsSb4/NNT7HBKyEt2NmiXC4K2DNaEZFyFe3Y03djjV1/zM8QVgD8mSTuXg1ywVr
        2FsBHBPPJWvUATcS4luQ49MM/LEsd6K1kesmRJNI7kzRzn0qGcGkcKnxJgQkJnen4KJJJaOi
        mNQ7rDbhqjY5juVMaA+Jyz2puqpmlYxWM0nsTZZNZLXbXRHp5JWGMqoj2s4F+YeGZWLeSQ/M
        nbuL8I9BzDIVWxt+d3993V6DlGmt1vkZfeI+pTcaomLV1IhIZn/q7SaeDdb0qLp/z1+o0cs+
        zywNmaRH8pf1Y1WTdr1XU2SP+2zvMWQMt5pnYTF76odP5SXzS19OZ5uZIrHI9A31+ZC10/pp
        ixznopngw5iWY/4Caxc0QDADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Xd01s45EG2y/ImmxccZ6Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyeLQ1L2MDuwel69dZPbYtKqTzWPzknqPvi2rGD0+b5IL
        YI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy9i+
        5QBjwSTuiv+LmlkbGJdwdjFyckgImEi8+3uctYuRi0NIYCmjxL/OdYxdjBxACRmJ4+vLIGqE
        Jf5c62KDqHnLKLGiawsjSEJEQFPi+t/vYM3MAq8YJfZMPA+WYBOwkpjYvgrMFhbwkbj35Swz
        iM0rYCdx6OwLsDiLgKpE/4SDLCC2qECExK2HHSwQNYISJ2c+AbOZBdQl/sy7xAxhy0tsfzuH
        eQIj/ywkZbOQlM1CUraAkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYExsO/Zzyw7GrnfB
        hxgFOBiVeHgFeI5EC7EmlhVX5h5ilOBgVhLhlQg5FC3Em5JYWZValB9fVJqTWnyI0RTo8InM
        UqLJ+cB4zSuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwGi042Hh
        +p+CvXv0Xqut3Wyw+5bJxWXObwSqhCQnbvnnseNAod9X5eN+/K6XvzYLCDk25dTcO/HrrPq9
        0w6Fs6P63+xoTpy4lpNd9UGTAbM42/m7BWevcgdPOC6quU0kUH6Hx8rMEwnzbMrFOFYfXqIb
        f3wR+2brD/ZS/+6ZHvO8cjwo95lScqcSS3FGoqEWc1FxIgC6z77MnwIAAA==
Message-Id: <20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11~dzFPt-ZL_1531815318eucas1p1t@eucas1p1.samsung.com>
X-CMS-MailID: 20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11
References: <CGME20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6862fdf2201a ("ARM: samsung: Limit SAMSUNG_PM_CHECK
config option to non-Exynos platforms") s3c_pm_check_*() calls
are redundant and can be removed.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/suspend.c |    7 -------
 1 file changed, 7 deletions(-)

Index: b/arch/arm/mach-exynos/suspend.c
===================================================================
--- a/arch/arm/mach-exynos/suspend.c	2018-10-09 15:58:35.495122851 +0200
+++ b/arch/arm/mach-exynos/suspend.c	2018-10-15 15:08:52.420184244 +0200
@@ -508,7 +508,6 @@ static int exynos_suspend_enter(suspend_
 	if (pm_data->pm_prepare)
 		pm_data->pm_prepare();
 	flush_cache_all();
-	s3c_pm_check_store();
 
 	ret = call_firmware_op(suspend);
 	if (ret == -ENOSYS)
@@ -523,8 +522,6 @@ static int exynos_suspend_enter(suspend_
 	S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
 			pmu_raw_readl(S5P_WAKEUP_STAT));
 
-	s3c_pm_check_restore();
-
 	S3C_PMDBG("%s: resuming the system...\n", __func__);
 
 	return 0;
@@ -548,8 +545,6 @@ static int exynos_suspend_prepare(void)
 		return ret;
 	}
 
-	s3c_pm_check_prepare();
-
 	return 0;
 }
 
@@ -557,8 +552,6 @@ static void exynos_suspend_finish(void)
 {
 	int ret;
 
-	s3c_pm_check_cleanup();
-
 	ret = regulator_suspend_finish();
 	if (ret)
 		pr_warn("Failed to resume regulators from suspend (%d)\n", ret);
