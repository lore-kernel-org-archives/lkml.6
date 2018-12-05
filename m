Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF2BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4FF20661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="icpBkkbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4FF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeLELGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:06:31 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43989 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbeLELG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:06:28 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181205110627euoutp0190bd169380277990c271e1d0acadaf27~taxWDKJNH1413014130euoutp01x
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 11:06:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181205110627euoutp0190bd169380277990c271e1d0acadaf27~taxWDKJNH1413014130euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544007987;
        bh=yHjclQEFD6YZMbzKTlG0nEejpZttIshoVnBmSaCyCpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icpBkkbubKm4TJhBdTOuLvJ+N+TLIYo8MZrLUTyq9nP4PNucGCgbHG0QLDhEOt2Qw
         tYksgS1KobVT90ysC66DNz6qQncqdajcQq9BYDWzwqqrtYqx03kZ9q2PM5QWonZq99
         Bbd6MKi4fyNJ93szGUgUmaegKgDukQKHsmKfOYCk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205110626eucas1p12f47ff506e871191f7e95525ce7223d4~taxU7tiPy1455014550eucas1p1L;
        Wed,  5 Dec 2018 11:06:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 95.2A.04294.131B70C5; Wed,  5
        Dec 2018 11:06:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f~taxUHzZjp1456514565eucas1p1J;
        Wed,  5 Dec 2018 11:06:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181205110625eusmtrp208d0f5609fa2e5dc3de577ee1b203e92~taxT3Lheq2749027490eusmtrp2l;
        Wed,  5 Dec 2018 11:06:25 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-33-5c07b131f44b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 49.72.04128.031B70C5; Wed,  5
        Dec 2018 11:06:24 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110624eusmtip14ac0690a7b5fafe9097feabf419f624b~taxS63r1P2535525355eusmtip1V;
        Wed,  5 Dec 2018 11:06:24 +0000 (GMT)
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
Subject: [PATCH v3 5/5] arm: dts: exynos4: opp-suspend in DMC and leftbus
Date:   Wed,  5 Dec 2018 12:05:56 +0100
Message-Id: <1544007956-28889-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRTHe3Z3X1xNbjPrkFI0CDNQ0/zwQBpFfrgZUVGfSqhVN62c2a6z
        N6OV5GtpSG+omWDhmlPbUjNNUzOtTOeyfCsrsJBcRepFEYbm9a769jv/8z/n/xx4GEIzSS5n
        jiYk8YYEXbyWUilr2qYdQaE2OmZd/WQ4bq4OxLbblSR+bJskcZ84QuK7rV0kTi2ppPCbbD3O
        HXYR2OF4SOPOSz9oPGjyx/nXGxTYPtxL4p66QgpPXG1F+LajUYHLW4dofL/PqcAfLpopPPT6
        xdyOjrckvtzQSuO0st8k/tH9SbkJuJr6GpKzFlkRV2ByKrlrueOIK3n6XcHZLZkU9+yOleYe
        3bvAzbTRXPOvpwqu6n26ksupsiDOXDZFcxP2FTu996oiDvPxR5N5Q8jGA6q4rm92MvHSwtMD
        UyO0CfUxWciLATYcCsQCMgupGA1rRvD9wQdCLkQEtnGrp5hAcKt8eM7GzI9kpW2W9VIEs6n1
        9L+JvOkpJJkoNhhqLSeliCVsCYK3tYGSh2BfElA3lqeQGj7sVsjKF0mJlexq6PhdTEmsZqPB
        4Sqk5fetgIGuTEJiL3YbZM9WUNIiYB8wMF3sQrIpCh6WFpIy+8Boe5Vn2B9mn9xVyCxAZ4aF
        kjkF0l/Vejwb4Hm7c/4ygg2EyroQWd4MbnGGkA/2hv6fiyWZmMO8mlseWQ0ZaRrZvQaqrnR7
        gpZCqfWmZzkHOT3l86xhixCITYHX0Mr8/1nFCFnQMt4o6GN5ISyBPxUs6PSCMSE2+NAJvR3N
        /caOmXaxFtW5D7YglkHaRWq4TsVoSF2ycEbfgoAhtEvU5gg6RqM+rDtzljec2G8wxvNCC/Jj
        lNpl6nMLvuzTsLG6JP44zyfyhr9dBeO13ISM5vXGr66+T4t8U/tvqCZCPoedfJcd3Zu/s2fL
        r7zuxo/Puga2ZVw8G7W9uiLZe2nZdL14nj03ZJh64j06OhhGCnuKQ6ojAkwFyb2r3FFu2m3b
        PRY5FtqSFNl4ZMfAoSbCJTqPUV+czVvHNzFpubO7goxFvk0BXrt3+N0bsVWmBGmVQpwudC1h
        EHR/AAgrDuyJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7oGG9ljDBautLQ4uFXTYuOM9awW
        2zd+Y7W4/uU5q8X8I+dYLZoXr2ezONOda9H/+DWzxfnzG9gtzja9Ybe41SBjMWvKXiaLTY+v
        sVpc3jWHzeJz7xFGixnn9zFZrD1yl91i6fWLTBa3G1ewWdw9dRRoxulLrBate4+wW7St/sBq
        8ebCPRYHCY9tu7exeqyZt4bRY3bDRRaPCf2fGD0W73nJ5LFpVSebx/65a9g9Ni+p9/h3jN3j
        4Ls9TB5brrazePRtWcXosWL1d3aPz5vkAvii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DLOPd3EWtDEXXHz+3P2BsbrHF2MHBwSAiYSXW2OXYxc
        HEICSxklvl2dy9jFyAkUF5OYtG87O4QtLPHnWhcbRNEnRom/85tYQJrZBPQkdqwqBImLCCxn
        lLj/czY7iMMs8IBZouP5JlaQbmEBT4muWV/AbBYBVYnTHxawgdi8Al4S51/PgdogJ3HzXCcz
        iM0p4C3R/X8dWI0QUM3U/uVMExj5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM123H
        fm7Zwdj1LvgQowAHoxIPr8QUthgh1sSy4srcQ4wSHMxKIrwrbNhjhHhTEiurUovy44tKc1KL
        DzGaAh01kVlKNDkfmErySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFw
        SjUwbtwSuK249MfnR/ckU76LMm+dsEr9+ha3NVm37Le3f/cVbHAqa928ONvjsF3TKwWrN1+d
        xXgbrDsmc98ufWTGGObzqH/TYpfuN8fWLv22rmrv9irDOXav256mSd0NsHm5p+3L7hUTHi4I
        rjs6+9h1E8sb8csL21pdvmtdVl4R/7ZMsHj6W9U91kosxRmJhlrMRcWJAOagR8jtAgAA
X-CMS-MailID: 20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the state for devfreq device while entring suspend/resume process.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 2 ++
 arch/arm/boot/dts/exynos4412.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b6091c2..4429b72 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -298,6 +298,7 @@
 			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 				opp-microvolt = <1150000>;
+				opp-suspend;
 			};
 		};
 
@@ -367,6 +368,7 @@
 			};
 			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
+				opp-suspend;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 51f72f0..908c0c4 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -432,6 +432,7 @@
 			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 				opp-microvolt = <1050000>;
+				opp-suspend;
 			};
 		};
 
@@ -520,6 +521,7 @@
 			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 				opp-microvolt = <1000000>;
+				opp-suspend;
 			};
 		};
 
-- 
2.7.4

