Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89EBC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D2220644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SNR/oHCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D2220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJIWzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:55:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56075 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeJIWzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:55:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009153804euoutp02269fa1e490ebfffb44f1c24a4f38f968~b_tOccSaA0362103621euoutp02g
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009153804euoutp02269fa1e490ebfffb44f1c24a4f38f968~b_tOccSaA0362103621euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539099484;
        bh=oe25LEWnTSK+pvyxemkECCEEvEVyO505ZpL0+dcJoQ4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SNR/oHCpclrRYKb16ERmIo2TvvXtOioNvGX4VWwLKjdmFccpJDb4bDu5VCm2LCaet
         WhM/FQ/kh4UDdQJYcETNjKTp/mlYRO28Q7iX8HXww5qGFw/uId1I/i5jY0UHdQ/bN/
         MaZ9jul3Br/eVL3adsJiBEWYYMMhldO//VPiqHps=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009153803eucas1p155ccecc7cb05d88b21dddd70f8414a15~b_tOACiWJ1336313363eucas1p1P;
        Tue,  9 Oct 2018 15:38:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6E.31.04806.B5BCCBB5; Tue,  9
        Oct 2018 16:38:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153803eucas1p27051cdb030dd5cdbd1a935afe55ad111~b_tNPuZi40944609446eucas1p2f;
        Tue,  9 Oct 2018 15:38:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181009153802eusmtrp106597115817fd1d08b0ea3f9fd507d76~b_tM-AUgi0519405194eusmtrp15;
        Tue,  9 Oct 2018 15:38:02 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-be-5bbccb5b32ad
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.74.04284.A5BCCBB5; Tue,  9
        Oct 2018 16:38:02 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181009153802eusmtip115951003a0c9307899e23edab82805b8~b_tMqzl761660616606eusmtip1p;
        Tue,  9 Oct 2018 15:38:02 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     l.luba@partner.samsung.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk
Subject: [PATCH] config: arm: imote2: remove PROVE_LOCKING from defconfig
Date:   Tue,  9 Oct 2018 17:37:55 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7djPc7rRp/dEG3xYpWGxccZ6VotbDTIW
        mx5fY7W4vGsOm8WhqXsZHVg9Ll+7yOyxeUm9x8F3e5g8+rasYvT4vEkugDWKyyYlNSezLLVI
        3y6BK+Pkln/sBRs5K7593s3YwPiRvYuRk0NCwERi++pOFhBbSGAFo8S6B+FdjFxA9hdGiRM/
        epkhnM+MEo9/r2aG6Xj0eS8rRGI5o8TR/dNZ4FpeTpoF5HBwsAnoSexYVQjSICLgJnGjsYMJ
        xGYWCJRYcmY/I0iJsICnxMspsiBhFgFViXsTNzFBzJeTuHmuE2yxhMARNokD3afAErwCZRLf
        2rYxQhS5SCyf/wbKFpZ4dXwL1DsyEqcn97BA2MUSZztWsUHYNRLtJ3dA1VhLHD5+kRXkBmYB
        TYn1u/Qhwo4Sh3t/sYOEJQT4JG68FYS4mE9i0rbpzBBhXomONiGIag2JLT0XoC4Wk1i+ZhrU
        cA+JN9+Ws0PCM1Zi04Y+tgmMcrMQdi1gZFzFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kR
        GO2n/x3/uoNx35+kQ4wCHIxKPLwz8nZHC7EmlhVX5h5ilOBgVhLhFd2+K1qINyWxsiq1KD++
        qDQntfgQozQHi5I477J5G6OFBNITS1KzU1MLUotgskwcnFINjI0C04vnn65wWTSv6mbPhdXz
        n58+U7ro6wwRj516WkIHNG+7XprgY7rfy6I1++ZjJs7dy/mSHl+JU3zkKuRQsmXti8oPD3cE
        ejzo49pcnhpX1qtWMTm+ROOiz7r6hNf8wZtf9fbwKSys2fzOW+yM9w8v88mF76LmbdrUf0jk
        u0TPFTe2fKbJb5VYijMSDbWYi4oTAc/X+CbyAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t/xu7pRp/dEGzw+Y2yxccZ6VotbDTIW
        mx5fY7W4vGsOm8WhqXsZHVg9Ll+7yOyxeUm9x8F3e5g8+rasYvT4vEkugDVKz6Yov7QkVSEj
        v7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Pkln/sBRs5K7593s3Y
        wPiRvYuRk0NCwETi0ee9rCC2kMBSRokNp+Qg4mISk/Zth6oRlvhzrYuti5ELqOYTo8Skld+B
        HA4ONgE9iR2rCkFqRAQ8JNr+3WMGsZkFgiXmfJnFClIiLOAp8XKKLEiYRUBV4t7ETUwgNi9Q
        +Pr7Y2wQ4+Ukbp7rZJ7AyLOAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYJhtO/Zz8w7G
        SxuDDzEKcDAq8fDOyNsdLcSaWFZcmXuIUYKDWUmEV3T7rmgh3pTEyqrUovz4otKc1OJDjKZA
        yycyS4km5wNjIK8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA2MC
        p/GSXa7mPY0TZr+7+MlX4rpiiK/gStlt9QKvjirOeZyjfyDRunAq86OZkaa8q8Jll9sGSV+t
        X/dharql4YSPNTy7pCw+vw30WVY5aZXXjssafVc+yPD0FVdyS+/w5n23/NWPhE8Z77nv87xO
        kfNtsWM+/cxeneH5uoNL5bZoHtp60eKI1D8lluKMREMt5qLiRAD5hIO8SQIAAA==
Message-Id: <20181009153803eucas1p27051cdb030dd5cdbd1a935afe55ad111~b_tNPuZi40944609446eucas1p2f@eucas1p2.samsung.com>
X-CMS-MailID: 20181009153803eucas1p27051cdb030dd5cdbd1a935afe55ad111
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153803eucas1p27051cdb030dd5cdbd1a935afe55ad111
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153803eucas1p27051cdb030dd5cdbd1a935afe55ad111
References: <CGME20181009153803eucas1p27051cdb030dd5cdbd1a935afe55ad111@eucas1p2.samsung.com>
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
 arch/arm/configs/imote2_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imote2_defconfig b/arch/arm/configs/imote2_defconfig
index f204017..d190f74 100644
--- a/arch/arm/configs/imote2_defconfig
+++ b/arch/arm/configs/imote2_defconfig
@@ -341,7 +341,6 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_PROVE_LOCKING=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_NULL=m
-- 
2.7.4

