Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDF0C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2374820644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZZ3QfjhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2374820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeJIWyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:54:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55854 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIWyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:54:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009153712euoutp020a065096911fede8262fc1b26ff68a55~b_sd7Q_xr0413104131euoutp02c
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:37:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009153712euoutp020a065096911fede8262fc1b26ff68a55~b_sd7Q_xr0413104131euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539099432;
        bh=x1bf3MsW/wPYz2QJQSLqiVkzUS/LiaWTAl/4D1cbY/Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZZ3QfjhOgjITjLJePnPCN1ttLm4T9j3KqgFiFvq3pHlyBpZ1w3k9Oc213egiVw5pT
         d27P0TD/sQFjyDGFLCvkf44AOPlEE57txEsriQ1x+jVGUg4rgXzPXm/hb1mbxqKLGt
         mM6LytDBcERfd1joq5boNF+DUgx66Lzy31YUNavE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009153711eucas1p10351fb978924b42e5432333ce8c2a253~b_sddwWft1337113371eucas1p1a;
        Tue,  9 Oct 2018 15:37:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9B.CA.04294.72BCCBB5; Tue,  9
        Oct 2018 16:37:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153711eucas1p29688c4724f8b9d81a3096dd97a363083~b_scuHGMD0310103101eucas1p2i;
        Tue,  9 Oct 2018 15:37:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181009153710eusmtrp12118ab2ea358baed1af555b9811df0ca~b_scdWRyW0495904959eusmtrp1X;
        Tue,  9 Oct 2018 15:37:10 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-73-5bbccb27ec0b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1E.64.04284.62BCCBB5; Tue,  9
        Oct 2018 16:37:10 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153710eusmtip2083b380d354157e366c577833dca23a3~b_scKLHb01235412354eusmtip2d;
        Tue,  9 Oct 2018 15:37:10 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     l.luba@partner.samsung.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk
Subject: [PATCH] config: arm: moxart: remove PROVE_LOCKING from defconfig
Date:   Tue,  9 Oct 2018 17:36:58 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7djPc7rqp/dEG6yZoGSxccZ6VotbDTIW
        mx5fY7W4vGsOm8WhqXsZHVg9Ll+7yOyxeUm9x8F3e5g8+rasYvT4vEkugDWKyyYlNSezLLVI
        3y6BK+PrJaeCzZwVZy7dZWxg/MzexcjJISFgInHjcyNTFyMXh5DACkaJJ8t+MkM4Xxglmj4s
        h8p8ZpSYt2IVSxcjB1jLzNVyEPHljBL/z55lg+v4MmM/WBGbgJ7EjlWFICtEBNwkbjR2MIHY
        zAKBEkvO7GcEsYUFPCUO9j9iBbFZBFQletasY4I4SU7i5rlOsCskBI6wSczq/c4MkuAVKJPo
        2zefDaLIRWLBwxYWCFtY4tXxLVD/yEicntwDFS+WONuxCqq+RqL95A6oGmuJw8cvsoLcySyg
        KbF+lz5E2FFi183lrBA/8knceCsIcTKfxKRt05khwrwSHW1CENUaElt6LkBdLCaxfM00qOEe
        Eps2TgAHgpBArMSRjfUTGOVmIaxawMi4ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzDW
        T/87/mUH464/SYcYBTgYlXh4Z+TtjhZiTSwrrsw9xCjBwawkwiu6fVe0EG9KYmVValF+fFFp
        TmrxIUZpDhYlcd5l8zZGCwmkJ5akZqemFqQWwWSZODilGhhzfLTnHrXwOmTXtCe//5XDYobo
        o+u60hZW6N5a0//72tGKj+GVwgxNJU+lWeLSd+0R9l1yTn1CgMS8srSX5jKufF9nq7OeepJs
        zvFQP5pr2dod6otMFng/lduePJlDWfaHMb9Kx7xV2SsmJlub92VFZy+bIRm95cH7IhnveeES
        obNfvlp6cZkSS3FGoqEWc1FxIgAehx338QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsVy+t/xe7pqp/dEGxxcrWexccZ6VotbDTIW
        mx5fY7W4vGsOm8WhqXsZHVg9Ll+7yOyxeUm9x8F3e5g8+rasYvT4vEkugDVKz6Yov7QkVSEj
        v7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PrJaeCzZwVZy7dZWxg
        /MzexcjBISFgIjFztVwXIxeHkMBSRomjD3czdzFyAsXFJCbt284OYQtL/LnWxQZiCwl8YpTY
        v6kepJdNQE9ix6pCkLCIgIdE2797YK3MAsESc77MYgWxhQU8JQ72PwKzWQRUJXrWrGMCsXmB
        4l+uT2aFGC8ncfNcJ/MERp4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAoNs27Gfm3cw
        XtoYfIhRgINRiYd3Rt7uaCHWxLLiytxDjBIczEoivKLbd0UL8aYkVlalFuXHF5XmpBYfYjQF
        Wj6RWUo0OR8YAXkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhgZ
        qixWreOb/e6vlcyp956mRqKLxGoEjy33vXN0a2nlvkY2nuVV+bvuZxmc2mFx+srZKyKsl8JD
        kxaX1n0+wnp48uvX/TeTli+eLue+/5+p6ZU87QmzpKN+qqX9/ffhdSz/vKsyJiLlj6qXmfZq
        BtZceVF1akWf8e6QoF3sb1gE7j3O4oubf3S1EktxRqKhFnNRcSIAHuTXp0gCAAA=
Message-Id: <20181009153711eucas1p29688c4724f8b9d81a3096dd97a363083~b_scuHGMD0310103101eucas1p2i@eucas1p2.samsung.com>
X-CMS-MailID: 20181009153711eucas1p29688c4724f8b9d81a3096dd97a363083
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153711eucas1p29688c4724f8b9d81a3096dd97a363083
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153711eucas1p29688c4724f8b9d81a3096dd97a363083
References: <CGME20181009153711eucas1p29688c4724f8b9d81a3096dd97a363083@eucas1p2.samsung.com>
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
 arch/arm/configs/moxart_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index 2da0d9e..5740d47 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -136,7 +136,6 @@ CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_PROVE_LOCKING=y
 CONFIG_DMA_API_DEBUG=y
 CONFIG_KGDB=y
 CONFIG_DEBUG_LL=y
-- 
2.7.4

