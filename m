Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A825EC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B9F214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="stmSg/u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B9F214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbeKVEhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:37:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38161 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732909AbeKVEhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:37:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121180210euoutp018db0e6de377c964693d861275fa9bd34~pNaUTTZ1f0775807758euoutp01P
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:02:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121180210euoutp018db0e6de377c964693d861275fa9bd34~pNaUTTZ1f0775807758euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542823330;
        bh=qggsqlasb+ZB/6Cp6CuX0fwsS0GDjW2gfsWln0LyFq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stmSg/u8/MwLYZ94mB+HHc3qazwZKIi2j+7ePahihmVLuV/c4AamikfAFt/5boTrE
         +/IbR43wKwHcY1SYQ15Qk9kkQSY2OPsIyN6E44Le2TB54sJumuWIhabEBgaVMZbEOM
         ZwEC12PxIAZ2gvcwl+VtlBxpKOarmZubkV3gumYA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181121180209eucas1p1d853ab615626002510a03881fe6e14f1~pNaTNlI7j1762417624eucas1p1g;
        Wed, 21 Nov 2018 18:02:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7C.89.04294.0AD95FB5; Wed, 21
        Nov 2018 18:02:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3~pNaSP_TVv3115931159eucas1p1Z;
        Wed, 21 Nov 2018 18:02:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181121180207eusmtrp161dc8d370b03e6455a15ba273a48071f~pNaSAW94I2594725947eusmtrp1r;
        Wed, 21 Nov 2018 18:02:07 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-ca-5bf59da057ad
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7F.7C.04128.F9D95FB5; Wed, 21
        Nov 2018 18:02:07 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180207eusmtip27d65ca12b1f53f0fe3942e0c93d2b410~pNaRI7Dnc1642316423eusmtip2Q;
        Wed, 21 Nov 2018 18:02:07 +0000 (GMT)
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
Subject: [PATCH 6/6] arm: dts: exynos4: set opp-suspend for DMC and leftbus
Date:   Wed, 21 Nov 2018 19:01:41 +0100
Message-Id: <1542823301-23563-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHe8/d5eQ4pV40DAaBJmlF4AtKF/LDIQn8EESa5KqDhc5qJ68F
        zcprlpZdvDvzNufKXLpsaqGtLG15CdMsQzDS0sLczATTNo/Wt9/zf/7/53l4eRlc9pv0YE7G
        nuVVsYoYOSUhjC/me7ZoSmbDtw5dCkTtTT6oIb+eRI8afpFo0DZOojLzGxJdqqin0OsrSpQz
        Nomjnp4HNLJcnKLRsHoDKrzZhiHD2DsSvTUVU8h61QxQfs8TDN0zj9CoarAPQx9StBQa6Xpu
        n9HdT6LUNjON0uqmSTTV+4nYDTlji5Hk9KV6wBWp+wguN2cGcBWtXzHOoMukuKclepp7WHmB
        W3xBc+0/WjGucSCd4K416gCnrZujOavBK9QlTBJ0nI85Gc+r/HdGSk5Mv79Hn06XJrb036LV
        QCfJAk4MZHfAm2PTVBaQMDJWC+A3QykpFjYAh7umgFhYAUx5PIyvRp5dz8PERg2A+vwC6l9k
        8m6DPc8wFOsHm3VnHAF3tgLA/mYfhwdnX+LQ9PMG5mi4sSFwXD28zAS7CU6UzZAOlrL74Pfy
        eVLc5gXfv8lc3uxk91t1ucsnQbaWgebPHbRoCoY2TdMKu8FvnY0rvAF252UTIgvQkqGjRD4P
        0181r3gC4bPOvuWjcdYH1pv8RXkPnL82QDlkyLrAoe+uDhm34w3jHVyUpTAjTSa6vWFjdi8m
        8jpYo7+9MpyDqQWrz1sK4PwdC50LNhb+X6YBQAfW83GCMooXtsfyCX6CQinExUb5HTulNAD7
        f+xe7LQ1A9PC0Q7AMkDuLPU+NBsuIxXxQpKyA0AGl7tLM8LskvS4IimZV506ooqL4YUO4MkQ
        8vXSc2tGw2VslOIsH83zp3nVahdjnDzU4PKE7+D+ytD7wepjIRa/4qbD1eGjkREFXxKEtKnQ
        oqq91vKA0fagW1maxInKuj8Tc3Fuk9ElCckRj1qdJdRC8sfbA2Vq7YEDPt5N5ocXq50t+UNr
        dikkeUuqd0SGxlOVYO7VGhm2PM9U23swzdbf4OW01nXph9aXDwjY5T42GyUnhBOKbZtxlaD4
        C+a3bymLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7rz536NNrg618ri4FZNi40z1rNa
        bN/4jdXi+pfnrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+
        xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOr
        xZsL91gcJDy27d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaP
        g+/2MHlsudrO4tG3ZRWjx4rV39k9Pm+SC+CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv4cHMte0E7b8XuS1PZGxhXcXUxcnJICJhIHJ44mamL
        kYtDSGApo8SDlcuYIRJiEpP2bWeHsIUl/lzrYoMo+sQosf7vFaAiDg42AT2JHasKQeIiAssZ
        Je7/nM0O4jALPGCW6Hi+iRWkW1jAW+J5wy0mEJtFQFXixfxPYHFeAS+Jtwt/skJskJO4ea4T
        bDMnUP3nVRMYQWwhoJor8xayTmDkW8DIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwYrcd
        +7llB2PXu+BDjAIcjEo8vBqRX6OFWBPLiitzDzFKcDArifB2RAGFeFMSK6tSi/Lji0pzUosP
        MZoCHTWRWUo0OR+YTPJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBK
        NTCenSfwj03pQd+0j9nbGg9+VFv/8fbEidXvXk1/e8Vusj3L3NKOSckvQ9Y2XGFbujJ6l1JU
        j5mW5dozzA7ZTl7aJitmx+axtv3etXN60M/ejk+yVtlNuwqEb7cUPni+fqXGcduJ4Xs+inKG
        rH/PUGN9332+sHylW9DsUKnTR1iTK9ST+QJ37xVRYinOSDTUYi4qTgQAzHcrO+4CAAA=
X-CMS-MailID: 20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the state for devfreq device while entring suspend/resume process.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
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

