Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AD6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685272133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dFZWojfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685272133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeIMNHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:07:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56220 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIMNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:07:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180913075900euoutp01b80f729ea69bc81c82505e1c5f112780~T5q_wCuYd0088800888euoutp012
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:59:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180913075900euoutp01b80f729ea69bc81c82505e1c5f112780~T5q_wCuYd0088800888euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536825540;
        bh=7v5QH59Uq3sHR/4YC9yBlES3OBwwSzySwLmP73rY06c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFZWojfpiZ9gEEj7DC4kKAoCrHRHKwsqigFn/7NkXmowDC8XxNLOO+aHFxw6EKvrR
         Pf6e2+zjKQ5LGL1Y7V0EEXPyo8ZZNn8840NOnywqCmfE8nDfKiyaJyFGsm5AUn7gIm
         t4HEkKIWNWms+WM9le4oy9jt+TQdivjLjkx89WYM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180913075859eucas1p2b573fa724a13895b001d4f0a81e88a07~T5q9zzHfe1220612206eucas1p24;
        Thu, 13 Sep 2018 07:58:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DB.D7.04294.2C81A9B5; Thu, 13
        Sep 2018 08:58:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180913075858eucas1p1f528fd0776c32f1c10a3e46f8f2bacd0~T5q9BZO-j1335913359eucas1p1w;
        Thu, 13 Sep 2018 07:58:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180913075858eusmtrp22006697c936fbea92496004ba049e605~T5q9AVCw12501625016eusmtrp2H;
        Thu, 13 Sep 2018 07:58:58 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-84-5b9a18c26294
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AA.F8.04128.2C81A9B5; Thu, 13
        Sep 2018 08:58:58 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913075857eusmtip171a20f270645caa1e52c9d5c95064f6d~T5q8kTn-K1574715747eusmtip1X;
        Thu, 13 Sep 2018 07:58:57 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     linux-crypto@vger.kernel.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] crypto: s5p-sss: Fix whitespace issues
Date:   Thu, 13 Sep 2018 09:58:40 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536825522-6027-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOd1DErOiDaY0GFoc372U0WLO+RYW
        i+5XMhZ9+/4zWpw/v4Hd4v69n0wWl3fNYbOYcX4fk8X/X83MDpweW1beZPLYdkDVY9OqTjaP
        fwunsHgcfLeHyaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgynq1+w1KwmL3iY+NN5gbG76xd
        jJwcEgImEu8W32HrYuTiEBJYwSgxa14rWEJI4AujxLO9+hCJz4wSm88sYYfpeNX8DapjOaPE
        5z/3WCAcoI5DDTfB2tkETCVu3/0EVMXBISKgIDHvqw5IDbPAGSaJixPmMoPUCAtYS/T1LGMC
        sVkEVCUmTNgCtUFO4ua5TmaQXk4BD4nT29xBeiUE2tklXt2BqOcVKJN4ueEpC0S9i8Thl3eh
        bGGJV8dh5shI/N85nwmiuZlR4taXa6wQzgRGiYOru6A6rCU23XjFBLKNWUBTYv0ufYiwo8Sz
        29/AwhICfBI33gqChJmBzEnbpjNDhHklOtqEIKrVJF5v2cIGs/bF56+MELaHRPO8M4yQ8JnN
        KHHtxBXGCYzysxCWLWBkXMUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYSE7/O/5lB+Ou
        P0mHGAU4GJV4eGeoz4wWYk0sK67MPcQowcGsJML7mh0oxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nJdPKy1aSCA9sSQ1OzW1ILUIJsvEwSnVwFhozJ6869rhqbtDJZpM+W+ejHu1aYvrmieJQs3W
        /BOKkhbZSzIVrDnDdjzxxL2ylzVT7q5VmXri3Xd1Te/KTSpadvo7+6/XXHsiNmtCUpjOfz+B
        rWqKC+P9PCd9/pP1Ks2/Q+jFT825v5YziNU4VtqmvXqfuDxiydvNJ3xzLoTFTen4uZDn/isl
        luKMREMt5qLiRABK5vtgIAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsVy+t/xu7qHJGZFG8z+xW1xfPdSRos551tY
        LLpfyVj07fvPaHH+/AZ2i/v3fjJZXN41h81ixvl9TBb/fzUzO3B6bFl5k8lj2wFVj02rOtk8
        /i2cwuJx8N0eJo++LasYPT5vkgtgj9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
        MjJV0rezSUnNySxLLdK3S9DLeLb6DUvBYvaKj403mRsYv7N2MXJySAiYSLxq/sYGYgsJLGWU
        uLwvGSIuIzHvbB8bhC0s8edaF5DNBVTziVFiacNDZpAEm4CpxO27n4ASHBwiAgoS877qgNQw
        C1xiklgyeTFYjbCAtURfzzImEJtFQFViwoQt7CD1vALuEu/mSUDMl5O4ea6TGSTMKeAhcXqb
        O8Q57hKTPm1kn8DIt4CRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgSG879nPLDsaud8GH
        GAU4GJV4eF8ozYwWYk0sK67MPcQowcGsJML7mh0oxJuSWFmVWpQfX1Sak1p8iNEU6KSJzFKi
        yfnAeMsriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cCYdSnB8q3C
        ds0MeeZLKh9913C4vuZ/M/H19Ob3+/tfXWtymV4cV9iy8+SRucsENL+VVliX1Itus/G3myKz
        S2N1/2qHvbtzcrb9elXcv7u3e2bf04rirMqsZT/dnV6qMohoiR/mCkr5KfdaOOiASZ3fjesr
        GzOuM+V9d5u1hqVQInfp/jP7c6KVWIozEg21mIuKEwElkfPPfwIAAA==
Message-Id: <20180913075858eucas1p1f528fd0776c32f1c10a3e46f8f2bacd0~T5q9BZO-j1335913359eucas1p1w@eucas1p1.samsung.com>
X-CMS-MailID: 20180913075858eucas1p1f528fd0776c32f1c10a3e46f8f2bacd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180913075858eucas1p1f528fd0776c32f1c10a3e46f8f2bacd0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180913075858eucas1p1f528fd0776c32f1c10a3e46f8f2bacd0
References: <1536825522-6027-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180913075858eucas1p1f528fd0776c32f1c10a3e46f8f2bacd0@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two whitespace issues that occurred at line breakup.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/crypto/s5p-sss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 0cf3f12d8f74..ce9bd13ea166 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -491,7 +491,7 @@ static void s5p_unset_indata(struct s5p_aes_dev *dev)
 }
 
 static int s5p_make_sg_cpy(struct s5p_aes_dev *dev, struct scatterlist *src,
-			    struct scatterlist **dst)
+			   struct scatterlist **dst)
 {
 	void *pages;
 	int len;
@@ -1890,7 +1890,7 @@ static int s5p_set_indata_start(struct s5p_aes_dev *dev,
 }
 
 static int s5p_set_outdata_start(struct s5p_aes_dev *dev,
-				struct ablkcipher_request *req)
+				 struct ablkcipher_request *req)
 {
 	struct scatterlist *sg;
 	int err;
-- 
2.7.4

