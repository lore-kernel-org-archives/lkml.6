Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22689C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF83E20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Edheh4Lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF83E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJOUQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:16:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51570 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeJOUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:16:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181015123138euoutp01ce6625f80a0a02ec738efdf946862c96~dyCKmgIfE0535705357euoutp01c;
        Mon, 15 Oct 2018 12:31:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181015123138euoutp01ce6625f80a0a02ec738efdf946862c96~dyCKmgIfE0535705357euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539606698;
        bh=qeEVRttB2T9mgh+2zEC2o9kA/oN7J5+B2nsy6WtlGC0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Edheh4LqbK2S3y1Q8J8V9wfO7G3v+Ei9i4DC7sEJGDzZQbMxElSJDcn3q72nU7nQd
         VTnfbsOEf42fgTol3wTbuEEfe+PA8jjZuw5FvIhbBJBE8wnqwK72UzkmYN/Q5NlyXP
         91IECxigz+wiWvGkkCpu7olit0Ufw1wzCW8D0CqM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181015123138eucas1p2cc2b7a7072e64a082d1cc84cd190daad~dyCKHa6_02085720857eucas1p2m;
        Mon, 15 Oct 2018 12:31:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4B.DE.04294.9A884CB5; Mon, 15
        Oct 2018 13:31:37 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015123137eucas1p1cf043644b9b40e15c9d2f221f26bef51~dyCJaZuJ31988219882eucas1p1r;
        Mon, 15 Oct 2018 12:31:37 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-33-5bc488a92ed2
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F9.DE.04128.9A884CB5; Mon, 15
        Oct 2018 13:31:37 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGN00GZC4490K70@eusync1.samsung.com>;
        Mon, 15 Oct 2018 13:31:37 +0100 (BST)
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
Subject: [PATCH v2 6/6] arm64: platform: Add enable Exynos Multi-Core Timer
 driver
Date:   Mon, 15 Oct 2018 14:31:12 +0200
Message-id: <20181015123112.9379-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181015123112.9379-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7djPc7orO45EG/RttrLYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Ms5efctU0MJWsXlXG0sDYydrFyMnh4SAiUT3707GLkYuDiGBFYwSty6sZYNwPjNKPD4+
        l7mLkQOsqnFiPUR8GaPEpO55TBBOA5PEwTObmUBGsQkYSnS97WIDsUUEsiU6Hz9gBLGZBRYx
        Sxw4JgxiCwuESPw9vw0sziKgKnH/4AqwM3gFbCR+bX/CCHGSvMTqDQeYQWxOAVuJw/9XsYAs
        kxA4wCbx9HMnM0SRi0Tv/y6oBmGJV8e3sEPYMhKXJ3dDNTQzSrTPmMUO4fQwSmyds4MNospa
        4vDxi6wQ5/FJTNo2HepPXomONiGIEg+J3ccOs4DYQgITGCU6FkdNYJRcwMiwilE8tbQ4Nz21
        2CgvtVyvODG3uDQvXS85P3cTIzCaT/87/mUH464/SYcYBTgYlXh4BXiORAuxJpYVV+YeYpTg
        YFYS4ZUIORQtxJuSWFmVWpQfX1Sak1p8iFGag0VJnHfZvI3RQgLpiSWp2ampBalFMFkmDk6p
        BkYvr117my/2sV89c+ipU24j28JFMju/nX5vu+yQxOdg5R0L/yttr990a8q2ydlpb1jv7m75
        u+6V+FXxkMzO1q0zlsc7/+LewTtfl0vPnYth70WJhBy+92pWqmybUp40HPsd+ShOe/YkDk62
        H9Yzrv5z47kWXim6ePvufcnntbS031Qe+L7rlL2dEktxRqKhFnNRcSIAmt2Fy+ICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xy7orO45EG5y4JmmxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZZy9+papoIWtYvOuNpYGxk7WLkYODgkBE4nGifVdjFwcQgJLGCVW7Z7DDuE0MUncfL+H
        pYuRk4NNwFCi620XG4gtIpAtMX9vNzuIzSywhFni5n0HEFtYIETi7/ltjCA2i4CqxP2DK1hB
        bF4BG4lf25+AxSUE5CVWbzjADGJzCthKHP6/Cmy+EFDNhWN/GScw8ixgZFjFKJJaWpybnlts
        pFecmFtcmpeul5yfu4kRGIbbjv3csoOx613wIUYBDkYlHl4BniPRQqyJZcWVuYcYJTiYlUR4
        JUIORQvxpiRWVqUW5ccXleakFh9ilOZgURLnPW9QGSUkkJ5YkpqdmlqQWgSTZeLglGpgtFpa
        JO9hlVGYu2fG9sJdDV4L/gqG++5xWtvi2T/l3owO1ufCN9Zf9g1ijXDds+KYK5/1m+YboaZh
        lyvDV7yVnH/yBFPsHZFrL7x8y7eEyCXs0ZgTmbYvhOUua+THnan+AWaXvZ5NmRn77NSKk8fO
        xpaqxzGcXrZrt9KFU4alaSeSTlzy1Ls2VYmlOCPRUIu5qDgRAKPukG4/AgAA
X-CMS-MailID: 20181015123137eucas1p1cf043644b9b40e15c9d2f221f26bef51
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015123137eucas1p1cf043644b9b40e15c9d2f221f26bef51
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123137eucas1p1cf043644b9b40e15c9d2f221f26bef51@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Exynos SoCs enabling MCT driver is required even if ARM Architected
Timer driver is used to for managing timer hardware and clock source
events.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479334a4..7cc687580fad 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -62,6 +62,7 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-- 
2.17.1

