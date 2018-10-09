Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87471C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1F120644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q4BG3ERc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1F120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJIWx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:53:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55657 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeJIWx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:53:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009153625euoutp021f50a6fd6e21785a17cc6e76a3099d30~b_rykW2nM0440604406euoutp02L
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:36:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009153625euoutp021f50a6fd6e21785a17cc6e76a3099d30~b_rykW2nM0440604406euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539099385;
        bh=R/Zl9HfQNYQmBN2pMyY4CARyVAwL0/4FnCqdSlI5l84=;
        h=From:To:Cc:Subject:Date:References:From;
        b=q4BG3ERcwY4AXkFTATvWmc4cxOhfLwI4Us/OEkh3GTkZPnPxKLzvccb4r+bxoPFgi
         Ydhpq0jTIvwuOhbglATUObLlrXpyZ7LSqchOV+SIHeW3PEZ375gBdESI5LPdhSCLO7
         2fKBpDrsYOaWHa8sLSMykbz5lLTxqM42lD5Y6kXw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181009153625eucas1p26048682b31c4e204b9c3efad599aacdc~b_ryHjF120311703117eucas1p2V;
        Tue,  9 Oct 2018 15:36:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1B.11.04806.8FACCBB5; Tue,  9
        Oct 2018 16:36:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af~b_rxQW8J90311703117eucas1p2U;
        Tue,  9 Oct 2018 15:36:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181009153624eusmtrp1760c4deb5a4d51e11dbba9b0ba3874ab~b_rw-ash10469104691eusmtrp1Y;
        Tue,  9 Oct 2018 15:36:24 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-e5-5bbccaf88973
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.E3.04128.8FACCBB5; Tue,  9
        Oct 2018 16:36:24 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181009153623eusmtip1849019a0c0bbe13b74f6b30709cd9b06~b_rwpbtGE1636716367eusmtip1D;
        Tue,  9 Oct 2018 15:36:23 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     l.luba@partner.samsung.com, b.zolnierkie@samsung.com,
        tony@atomide.com, linux-omap@vger.kernel.org
Subject: [PATCH] config: arm: omap2: remove PROVE_LOCKING from defconfig
Date:   Tue,  9 Oct 2018 17:36:12 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWy7djP87o/Tu2JNri808pi44z1rBa3GmQs
        Nj2+xmpxedccNovZS/pZLPZf8XJg8/j2dRKLx+Yl9R4H3+1h8ujbsorR4/MmuQDWKC6blNSc
        zLLUIn27BK6MjXM3Mxec5qyY2rWGpYGxn6OLkZNDQsBE4tOSb6xdjFwcQgIrGCU2TT3EBuF8
        YZSYf/swE4TzmVHia0MzC0zL7V8HoKqWM0q82PeAEa5l3+LjQMM4ONgE9CR2rCoEaRARcJO4
        0djBBGIzC2RI/Jy4C8wWFvCQ+Lv3GjuIzSKgKnH77il2iAVyEjfPdTJD2CfYJE7O8QWxeQXK
        JDav+gh1hIvErWmXoGxhiVfHt0D1ykicntwDFS+WONuxig3CrpFoP7kDqsZa4vDxi2BnMgto
        SqzfpQ8RdpQ4P7mXDSQsIcAnceOtIMTFfBKTtk1nhgjzSnS0CUFUa0hs6bnABGGLSSxfMw1q
        uIfEzKt/wZYKCcRK9B44xjiBUW4Wwq4FjIyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcx
        AuP+9L/jX3cw7vuTdIhRgINRiYd3Rt7uaCHWxLLiytxDjBIczEoivKLbd0UL8aYkVlalFuXH
        F5XmpBYfYpTmYFES5102b2O0kEB6YklqdmpqQWoRTJaJg1OqgXFd3PVPWiGzyiZWyfLOermj
        O+Tu4mVrdCsP1dU8eX9ge4jHuoLsgh9n9W8uN3XreufZfVj+02wZI+YXYUu3cJ+1dv7z1aiU
        /RgvU+wXfieVSP37kXouXJsrWkxYV2bPjV1QdTlONHiK10mb/TGH1q27mfUsaI/c08bnlm9T
        z119Ml1g76V3s+2VWIozEg21mIuKEwGkw1P59wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsVy+t/xu7o/Tu2JNtixn8Vi44z1rBa3GmQs
        Nj2+xmpxedccNovZS/pZLPZf8XJg8/j2dRKLx+Yl9R4H3+1h8ujbsorR4/MmuQDWKD2bovzS
        klSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MjXM3Mxec5qyY
        2rWGpYGxn6OLkZNDQsBE4vavA2xdjFwcQgJLGSVuLGlkhEiISUzat50dwhaW+HOtC6roE6PE
        0n//WbsYOTjYBPQkdqwqBKkREfCQaPt3jxnEZhbIkXi16ScriC0MFP+79xrYHBYBVYnbd0+x
        g7TyCnhKrLxkDjFeTuLmuU7mCYw8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgQG3LZj
        P7fsYOx6F3yIUYCDUYmHd0be7mgh1sSy4srcQ4wSHMxKIryi23dFC/GmJFZWpRblxxeV5qQW
        H2I0Bdo9kVlKNDkfGA15JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4
        pRoYdX/GFcX//X3/asBOfc6jCy5L8KxYdi33z6345Tr7rtrIrKxhLxTk7yp2/m4fKP9s9c7M
        q/oXxOrPMqw+ajSD7QqD/ysNtsMhnFfeue69vr1x4r+Lhhnfwln6wmScvi/zXXJ2+QPhF6dm
        r+XZ1lZ4XCBCmfW3jXHhTcsZVXXGWhu9O4/79S/+rcRSnJFoqMVcVJwIAE9cX8NOAgAA
Message-Id: <20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af~b_rxQW8J90311703117eucas1p2U@eucas1p2.samsung.com>
X-CMS-MailID: 20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af
References: <CGME20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af@eucas1p2.samsung.com>
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
 arch/arm/configs/omap2plus_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6491419..1bbfd76 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -536,7 +536,6 @@ CONFIG_DEBUG_INFO_SPLIT=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_SCHEDSTATS=y
-CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
-- 
2.7.4

