Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F5DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D006820644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hElJNtZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D006820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeJIWw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:52:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55420 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIWw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:52:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009153528euoutp029269f6af356e7803219552459c178e1f~b_q9M3PC20362103621euoutp02c
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:35:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009153528euoutp029269f6af356e7803219552459c178e1f~b_q9M3PC20362103621euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539099328;
        bh=hox1kqY+pFmWU01fsUI85CIhF5OuVvZ+oigrlKzaFq8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hElJNtZ0OHUVeli5fp2m+0nZQFdfI+38zd0zNvNqiEyD7QopnBphqn4DGdfKTZTEb
         dqKW/t88jJhTI3ASDGH7/mE73OJQ4JhBG0A+qCb54sbPzT0HdOyh5Qef0Ld/SkJFth
         uXrmGji3W6+riRjSmthJQPZ24zWfR465QkZDq/jQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181009153527eucas1p20731b68f293903bb6c93c38e0f62465e~b_q8SnJde0945909459eucas1p2J;
        Tue,  9 Oct 2018 15:35:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E8.AA.04294.FBACCBB5; Tue,  9
        Oct 2018 16:35:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630~b_q7Stknv2226522265eucas1p2C;
        Tue,  9 Oct 2018 15:35:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181009153526eusmtrp176431333c88e6522b7a25a392b856269~b_q7Byxh00465304653eusmtrp1g;
        Tue,  9 Oct 2018 15:35:26 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-8f-5bbccabffbef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.D3.04128.EBACCBB5; Tue,  9
        Oct 2018 16:35:26 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153525eusmtip23471e92d26ee937a10ad6f3709ee39fe~b_q6nlzNC1013910139eusmtip2Y;
        Tue,  9 Oct 2018 15:35:25 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     l.luba@partner.samsung.com, b.zolnierkie@samsung.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com
Subject: [PATCH] config: arm: imx: remove PROVE_LOCKING from defconfig
Date:   Tue,  9 Oct 2018 17:35:00 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djPc7r7T+2JNlixn9ti44z1rBYbN99m
        sVg1dSeLxa0GGYtNj6+xWnT9WslscXnXHDaLv9s3sThweGxeUu+x8d0OJo+D7/YwefT/NfDo
        27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujLvLgwquclbMuNXP2MDYy9HFyMkhIWAisf7CDLYu
        Ri4OIYEVjBLT+/cxQjhfGCVO/OhihXA+M0p0bpnMDNOyYVc7VNVyRon9L9exw7XM+fkRKMPB
        wSagJ7FjVSFIg4iAm8SNxg4mkBpmgamMEi+P3mQHSQgDJQ507mEDsVkEVCXenZ7IBrFBTuLm
        uU6obffZJOatNAKxeQXKJH70nWWBiLtIzJ13kBXCFpZ4dXwLO4QtI3F6cg9UTbHE2Y5VUDNr
        JNpP7oCqsZY4fPwiK8idzAKaEut36UOEHSVWNu1nAQlLCPBJ3HgrCBJmBjInbZvODBHmleho
        E4Ko1pDY0nOBCcIWk1i+ZhrUcA+JlbO3gx0vJBArsXLuCqYJjHKzEHYtYGRcxSieWlqcm55a
        bJSXWq5XnJhbXJqXrpecn7uJEZgUTv87/mUH464/SYcYBTgYlXh4Z+TtjhZiTSwrrsw9xCjB
        wawkwiu6fVe0EG9KYmVValF+fFFpTmrxIUZpDhYlcd5l8zZGCwmkJ5akZqemFqQWwWSZODil
        Ghi1X69ZbP9xze1LLGVsLNskTvqHP5hn3rPp8+UXfXET/58+nHJqyiarqMTum7k7VFNqy/Lm
        Xeu9NnWRGvdplpKnNb8j8zo2/C99V7BT8LjGtT1KE2PYfXa+ZdW4zyinsf/K/AXOoYv///mX
        2vBRymuvVwdfzs96N/duowNBEmX9RW+OfNkZpHdGiaU4I9FQi7moOBEAhjajnwYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t/xe7r7Tu2JNmhbxW6xccZ6VouNm2+z
        WKyaupPF4laDjMWmx9dYLbp+rWS2uLxrDpvF3+2bWBw4PDYvqffY+G4Hk8fBd3uYPPr/Gnj0
        bVnF6PF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJext3lQQVXOStm3OpnbGDs5ehi5OSQEDCR2LCrnbGLkYtDSGApo8S2CZuZIBJiEpP2
        bWeHsIUl/lzrYoMo+sQocWnDYSCHg4NNQE9ix6pCkBoRAQ+Jtn/3mEFqmAVmAw36tI4NJCEs
        4CZxoHMPmM0ioCrx7vREMJtXwFPi49HzLBAL5CRunutknsDIs4CRYRWjSGppcW56brGRXnFi
        bnFpXrpecn7uJkZgQG479nPLDsaud8GHGAU4GJV4eGfk7Y4WYk0sK67MPcQowcGsJMIrun1X
        tBBvSmJlVWpRfnxRaU5q8SFGU6DlE5mlRJPzgdGSVxJvaGpobmFpaG5sbmxmoSTOe96gMkpI
        ID2xJDU7NbUgtQimj4mDU6qBUffZ26LQTZ/KUqb8l/n7/WTfFTttxhDxH3ZF1xVKZ6Ysff5+
        glTu+qm5nR2im88ylG+/GuzNUMSpUOVbys98eBLL7NyHWVbJd1jFFzG+mHj8br2Edsvj9mX9
        QfunaxUU28/0O/1SfIG2gHaaWkjdK97JDgeZt0g8fLD7Z2o2Z7WrYtz50x+XKbEUZyQaajEX
        FScCAJNQqPVeAgAA
Message-Id: <20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630~b_q7Stknv2226522265eucas1p2C@eucas1p2.samsung.com>
X-CMS-MailID: 20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630
References: <CGME20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
bus transactions.

On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
The overhead can be measures using hackbench which will speed up
by x3 times (11sec -> 3.4sec).
When you check transaction on cache or buses, the results are way higher
than normal for the same hackbench test:
L1d cache invalidations: 26mln vs 4mln
L2u cache invalidations: 42mln vs 12mln
bus cyc/access: 30cyc/access vs. 20cyc/access
context switch is x3 times cheaper

Enable this option only when you have some locking issue to investigate.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 7eca43f..f55cd2d 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -425,7 +425,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
 # CONFIG_ARM_UNWIND is not set
-- 
2.7.4

