Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBEBC676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D4E2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y95NNLQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D4E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJHUC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:02:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45218 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJHUCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:02:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008125049euoutp01af3fff127173199688547e65b3517604~box6QBgx81980719807euoutp01d;
        Mon,  8 Oct 2018 12:50:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008125049euoutp01af3fff127173199688547e65b3517604~box6QBgx81980719807euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539003049;
        bh=SqgyLIV0hBByoky6Htvls+J5HVFVLMXn1k+1uAPMkUU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Y95NNLQX/eQqg4PDgzWSAXFWrldox3r1ojhOqdjJINRL+XwLEw75jSOp9P4tt/NwG
         ls95SibDtKcAsSVaqVjMIvmXkJOrvtu9BC66aokjmPuNMp03j3BdfgMtZkwcuwJgj5
         SwGFS9l2kEnGz9gBzrpaQtSoFB+13gdCTYr4g/sM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008125048eucas1p1ad65ca804e9f28e996a4eb4cb42366d9~box5u6nex0610606106eucas1p1U;
        Mon,  8 Oct 2018 12:50:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.D2.04441.8A25BBB5; Mon,  8
        Oct 2018 13:50:48 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008125047eucas1p1bbd0c4759612b6df8fbe25f759e03130~box5AE1zW0610606106eucas1p1S;
        Mon,  8 Oct 2018 12:50:47 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-bb-5bbb52a8f29f
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9D.99.04284.7A25BBB5; Mon,  8
        Oct 2018 13:50:47 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGA006EA6BYW230@eusync1.samsung.com>;
        Mon, 08 Oct 2018 13:50:47 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 3/7] clocksource: Change CPU hotplug priority of exynos_mct
 driver
Date:   Mon, 08 Oct 2018 14:50:05 +0200
Message-id: <20181008125009.3721-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181008125009.3721-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7djP87orgnZHG0zokbXYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mha8amcseM9e8WQxZwPjC7YuRg4OCQETiYtnebsYuTiEBFYwSlzZNZEFwvnMKHFuTgtr
        FyMnWNGCfecZQWwhgWWMEqvOs0EUNTBJdP1YwA6SYBMwlOh628UGYosIZEt0Pn4A1sAssIhZ
        4sAxYRBbWCBEYn8jxCAWAVWJyS83M4PYvAI2EsvuHGODWCYvsXrDAbA4p4CtxJOuVWAXSQjs
        YJPY/WYhM8TZLhL32wUh6oUlXh3fwg5hy0h0dhxkgqhvZpRonzGLHcLpYZTYOmcH1AZricPH
        L7JCXMcnMWnbdKihvBIdbUIQpofElYdSEE9OYJQ4cLGdbQKj5AJGhlWM4qmlxbnpqcWGeanl
        esWJucWleel6yfm5mxiBcXz63/FPOxi/Xko6xCjAwajEw7syYFe0EGtiWXFl7iFGCQ5mJRFe
        0e1AId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzL5m2MFhJITyxJzU5NLUgtgskycXBKNTAWLjSY
        prgrsYulUKUqcKfiwY7Ig8rlYoKMiiHHuzaY9+zK6zBM6U4yflwaP+s/j3XB6xsu8ix+x33W
        y+kwhvx+uKmT7+RTflbJ5xY3S2efUeMNE94mse1eavaO2TES2y6wSu+b1//L+M/F6jv2N+US
        Vr/vdj0xSVd9EcOExet9g+w+9VaVnVViKc5INNRiLipOBAAiMFoP3wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xy7rLg3ZHG3xrs7DYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mha8amcseM9e8WQxZwPjC7YuRk4OCQETiQX7zjN2MXJxCAksYZR43jKdBcJpYpK4um43
        I0gVm4ChRNfbLrAOEYFsifl7u9lBbGaBJcwSN+87gNjCAiES+xvPg9WzCKhKTH65mRnE5hWw
        kVh25xjUNnmJ1RsOgMU5BWwlnnStYgGxhYBqeqdfZJ3AyLOAkWEVo0hqaXFuem6xoV5xYm5x
        aV66XnJ+7iZGYBhuO/Zz8w7GSxuDDzEKcDAq8fAG+O2KFmJNLCuuzD3EKMHBrCTCK7odKMSb
        klhZlVqUH19UmpNafIhRmoNFSZz3vEFllJBAemJJanZqakFqEUyWiYNTqoHR+rOf1anFgROX
        O30z3jGFwUV804fr3eXpyYKCs//P57C4YaCS3TqfPVpJrrZZ2iriv7U2197DMj9dtfM1b7y5
        3vmicfrvjZPfiVXVxewQlJzyPHDD8tMFFcxCZ4Pad623WilglyzKXsq52Ix3Xe4Wf6YlO37d
        1n10bGbAdEvulGtNO+M7ff2VWIozEg21mIuKEwEs3xaxPwIAAA==
X-CMS-MailID: 20181008125047eucas1p1bbd0c4759612b6df8fbe25f759e03130
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008125047eucas1p1bbd0c4759612b6df8fbe25f759e03130
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
        <CGME20181008125047eucas1p1bbd0c4759612b6df8fbe25f759e03130@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos Multi-Core Timer driver (exynos_mct) must be started before
ARM Architected Timers (arch_timer), because both timers share common
hardware block and turning on MCT is needed to get ARM Architected
Timer working properly.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/cpuhotplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index caf40ad0bbc6..5d9e4a6ea299 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -115,10 +115,10 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
+	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_JCORE_TIMER_STARTING,
-	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
-- 
2.17.1

