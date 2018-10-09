Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4255DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EB920C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cdmheF8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EB920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJIWwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:52:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51749 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:52:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181009153441euoutp01dccf4aeb6841b99a698fd5debb236a26~b_qRRAYaf2472824728euoutp01k
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:34:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181009153441euoutp01dccf4aeb6841b99a698fd5debb236a26~b_qRRAYaf2472824728euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539099281;
        bh=ox3ssDeFhhKb7BhUn9hgODkK+LQZhkfSJjSturg+/00=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cdmheF8coCJy4LR9gAciz2QJjh0tpbaFQyvO4xvau+ZZ6Jg61sr3376CEkfISWSDn
         G88ct7oMNstNBYGOJwDSagT3pz66/Rfp7CWtemWCfx+MpbdAEaTKG+dqBerqUua38n
         b2SMO+KjJRoB6VIYO4H6+f14pz9zBMedU/zX4st4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009153440eucas1p11f29b0cef7d94ae7ff70f4c503a24bb9~b_qQS4BbM1415514155eucas1p17;
        Tue,  9 Oct 2018 15:34:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.F0.04806.F8ACCBB5; Tue,  9
        Oct 2018 16:34:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a~b_qPT4nMA1415514155eucas1p16;
        Tue,  9 Oct 2018 15:34:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181009153438eusmtrp1ababfda434a2ec8b6eb8c56abda74c8b~b_qPCyQz20414104141eusmtrp1b;
        Tue,  9 Oct 2018 15:34:38 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-0a-5bbcca8f0b18
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.34.04284.E8ACCBB5; Tue,  9
        Oct 2018 16:34:38 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153438eusmtip2edba67aea9b969fa128f649f597175b6~b_qOqrLBY1235412354eusmtip2q;
        Tue,  9 Oct 2018 15:34:38 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     l.luba@partner.samsung.com, b.zolnierkie@samsung.com,
        krzk@kernel.org, kgene@kernel.org, m.szyprowski@samsung.com
Subject: [PATCH] config: arm: exynos: remove PROVE_LOCKING from defconfig
Date:   Tue,  9 Oct 2018 17:33:57 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWy7djPc7r9p/ZEG/z9a2WxccZ6Vov+x6+Z
        Lc6f38BucatBxmLT42usFpd3zWGzWHvkLrsDu8emVZ1sHpuX1HscfLeHyaNvyypGj8+b5AJY
        o7hsUlJzMstSi/TtErgyTp/4xlJwiLNi3+KtjA2MrRxdjBwcEgImEnsXKXcxcnEICaxglPhz
        8Cs7hPOFUWLBgfssEM5nRonvr2exdTFygnU0zj3NCpFYzijR0LOeBa6l5VgvG8hcNgE9iR2r
        CkEaRATcJG40djCB2MwC5RL7vv4Fs4UFPCU2rXkKNpRFQFWiYd86RogFchI3z3Uyg8yUELjM
        JnF0/zdmkASvQJnEnymv2CGKXCTOdP9lgbCFJV4d3wIVl5E4PbkHKl4scbZjFdTVNRLtJ3dA
        1VhLHD5+kRXkTmYBTYn1u/Qhwo4Sn3qOMEKChU/ixltBiJP5JCZtm84MEeaV6GgTgqjWkNjS
        c4EJwhaTWL5mGtRwD4lFf6azgthCArESXcf6WCYwys1C2LWAkXEVo3hqaXFuemqxcV5quV5x
        Ym5xaV66XnJ+7iZGYAo4/e/41x2M+/4kHWIU4GBU4uGdkbc7Wog1say4MvcQowQHs5IIr+j2
        XdFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZfN2xgtJJCeWJKanZpakFoEk2Xi4JRqYNS5/i9E
        fk30+9ds08x/HLjo8/jh7QMm0Rd74k2dPeY6HMx4EpEsWL778gGfzBn6whPOVZuc2LbiSp3R
        78sn9ggzRC5kEL19XsX4R1XwjuI1P19bJrq9YNrrXDHzuXlbX6vJjNJARxfpa4vlBcr1/G8t
        Tq6+7KjXbRhz2uLtikML299qGipoXVBiKc5INNRiLipOBABp+oyP/QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t/xe7p9p/ZEG5z6ZWaxccZ6Vov+x6+Z
        Lc6f38BucatBxmLT42usFpd3zWGzWHvkLrsDu8emVZ1sHpuX1HscfLeHyaNvyypGj8+b5AJY
        o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyTp/4
        xlJwiLNi3+KtjA2MrRxdjJwcEgImEo1zT7N2MXJxCAksZZRo+dTDBpEQk5i0bzs7hC0s8eda
        FxtE0SdGiW1XVwA5HBxsAnoSO1YVgtSICHhItP27xwxiMwvUSkyctRzMFhbwlNi05inYTBYB
        VYmGfesYQWxeoHj/tF/MEPPlJG6e62SewMizgJFhFaNIamlxbnpusaFecWJucWleul5yfu4m
        RmD4bTv2c/MOxksbgw8xCnAwKvHwzsjbHS3EmlhWXJl7iFGCg1lJhFd0+65oId6UxMqq1KL8
        +KLSnNTiQ4ymQMsnMkuJJucDYyOvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFq
        EUwfEwenVAOj106PMzPYeLOe2HBslxVhLrjRsW3J9cC/k+c83LHbQeTlvXWnFO7UNvq8jV7u
        +eNustilvwtlQx7r7rjGyj7rXF6ORHZT0TzV7sL3UjufnXz+Lt/Qwv2VzmnpvQdl+4QVPug4
        Hee7vWt6moiB+s4NYfrs1a7ffGPYXjNs2diXKrLtewW/07GZSizFGYmGWsxFxYkAaow2tFUC
        AAA=
Message-Id: <20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a~b_qPT4nMA1415514155eucas1p16@eucas1p1.samsung.com>
X-CMS-MailID: 20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a
References: <CGME20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
bus transactions.

On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
The overhead can be measures using hackbench test which will speed up
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
 arch/arm/configs/exynos_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 27ea6dfc..fbf52f3 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -324,7 +324,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DETECT_HUNG_TASK is not set
-CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_RSA=m
-- 
2.7.4

