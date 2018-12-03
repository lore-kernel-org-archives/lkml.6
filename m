Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED346C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5AE20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ljUXF7jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5AE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeLCOcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:32:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47695 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeLCOcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:32:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181203143137euoutp02ed087461a33e6d16327c076a1f538a43~s2R6o0Rwr0761407614euoutp02E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 14:31:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181203143137euoutp02ed087461a33e6d16327c076a1f538a43~s2R6o0Rwr0761407614euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543847498;
        bh=G8VKN1fu3uT4saAk4T2R+C4N9HJlxwCGvfKToQ8oqPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljUXF7jQLiCVFiWlEwcW3kqOoWomKOKfxhV7dl2bSC8orHsmjr9wxgLeq3byBWOsY
         oOiuI62Vf/7Zo56fb5/Ux84qZ5vSv2SJqKPa08UMqi22aJPN2+GVHHYU1ODgolBIkb
         SF8+vunZ1fi1q9/1Tr2kjuq4VnqLKLVmQVAQbNKU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181203143136eucas1p27e1fa616f1ed3a287db22893e1b36b54~s2R5knNjE1206312063eucas1p2B;
        Mon,  3 Dec 2018 14:31:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 26.D1.04294.84E350C5; Mon,  3
        Dec 2018 14:31:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1~s2R4r6PP_1712417124eucas1p1r;
        Mon,  3 Dec 2018 14:31:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203143135eusmtrp151383fb7c18e3a5f664d19aafedd3987~s2R4bIfko1680116801eusmtrp1I;
        Mon,  3 Dec 2018 14:31:35 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-66-5c053e484219
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.F8.04128.74E350C5; Mon,  3
        Dec 2018 14:31:35 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181203143134eusmtip2b70fc582bd265d68d5c9fca5d1b74e4f~s2R3d_Gsb0580205802eusmtip2x;
        Mon,  3 Dec 2018 14:31:34 +0000 (GMT)
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
Subject: [PATCH v2 5/5] arm: dts: exynos4: opp-suspend in DMC and leftbus
Date:   Mon,  3 Dec 2018 15:31:15 +0100
Message-Id: <1543847475-7600-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUzMcRzHfX9P9yt+7ec0fSZju4lqXPIw32GeN7+sP8zGjIbDb5fprtxP
        lGwqD5WnUjhKkkO36yydOu1UJpcQdwp5Wp7y7BhKYjH38zvz3+v7fr8/D/vsy5LqHnoYu864
        UTQZdUkaJphyXv3hGSfMoBPGV+8Ix5dro3D1kSoaX6jupfH9njc0LnN7aLzdUsXgm3sMOL/r
        A4m93nMqfCvbp8KPMofj4oMNBHZ0ddD4jusYg7v3uRE+4m0k8Fl3pwqfvt9G4MdZVgZ33mj2
        92htp/HOBrcK76r8TGPf7SfULBCcF520YD9uR0JJZhslFOR/RYKl/h0hOGx5jHCp1K4Szp/a
        Jvy+qhIuf6onhJp7OZSwv8aGBGvld5XQ7RixMGRZ8PS1YtK6TaIpZsaq4MR2Sx9KcQ1M++nr
        QJkoO2g3CmKBnwQXvEeRzGreiuCld6nCPQjKT0TuRsF+7kZQeuYN9a/A/raeVIwKBF/67bTy
        8FdYy3L8DssyvBbqbBvkglDegqC9LkrOkPw1ElxfCgnZGMLHQV9nLi3nKT4CmrPiZZnzy2+d
        DqQMGwEPPXmkzEH8AjhoLfs7GPjTLOxxvQhsNA/MdxpphYfA+5YalcLDobVobyAjwa1cG6Pw
        Vsi5XhfITIMrLW1/dyD5KKhyxcgI/GwofD1bwRB48HGwHCb9WOg0k4rMQe4utdIjEmr23iYU
        HgoV9sOB3gJ8ev4hcKlSBJbah0QBGln8f9YJhGwoTEyVDHpRmmAUN2slnUFKNeq1a5INDuT/
        i62/W3rqkKt/dRPiWaQZxM1aSSWoad0mKd3QhIAlNaFcyga/xK3VpW8RTckrTalJotSEwllK
        E8ZlDHi2XM3rdRvF9aKYIpr+uQQbNCwTTXnKhRRHpselueKXGK6sD517d/636PPNnFHS7/D5
        YrNKnvZmxJg9Zu3UpjFhxyP6X8/R5Z2pZcorteKBWJYzw6+u8lfXwrMHTYobneh50TCZqY8+
        PKWjcYz+5MmUsS9/tef3vVc/KMqtPjRqpvt5WlZZxrHFvRNXbE8I+7iwoj95kYaSEnWx0aRJ
        0v0BdNZyvocDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7rudqwxBms2yVkc3KppsXHGelaL
        7Ru/sVpc//Kc1WL+kXOsFs2L17NZnOnOteh//JrZ4vz5DewWZ5vesFvcapCxmDVlL5PFpsfX
        WC0u75rDZvG59wijxYzz+5gs1h65y26x9PpFJovbjSvYLO6eOgo04/QlVovWvUfYLdpWf2C1
        eHPhHouDhMe23dtYPdbMW8PoMbvhIovHhP5PjB6L97xk8ti0qpPNY//cNewem5fUe/w7xu5x
        8N0eJo8tV9tZPPq2rGL0WLH6O7vH501yAXxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6
        hsbmsVZGpkr6djYpqTmZZalF+nYJehmXFv9gLNjFXfHrzTXGBsYmzi5GTg4JAROJNS/2MHcx
        cnEICSxllFjwaSMjREJMYtK+7ewQtrDEn2tdbBBFnxgldnw5DFTEwcEmoCexY1UhSFxEYDmj
        xP2fs9lBHGaBB8wSHc83sYJ0Cwt4Svy428EK0sAioCpxtNEHJMwLFH6xbRPUMjmJm+c6mUFs
        TgEviSkr5oPZQkA1LXtXME9g5FvAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMF63Hfu5
        ZQdj17vgQ4wCHIxKPLwO8SwxQqyJZcWVuYcYJTiYlUR4CwqBQrwpiZVVqUX58UWlOanFhxhN
        gW6ayCwlmpwPTCV5JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4pRoY
        MwWurlb56nDYNS0v6MWUeK4Tf2JmLimJPyXocPRzUNSf1yJfBLatv3DpXsTUoj3nXwrFht7/
        oT3fhcvtlPLeBWld/PGfhX9ou52Pk7293/Da3qSl6SZPPzyJ1jNRmhZ7eVF5x3t326Nh3Zsf
        5mTUZOS4cXrnKLY4imrNVOuZFxCveUk1XPOCEktxRqKhFnNRcSIA7hsgUu0CAAA=
X-CMS-MailID: 20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the state for devfreq device while entring suspend/resume process.

The patch is based on earlier work by Tobias Jakobi.

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

