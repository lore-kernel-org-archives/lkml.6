Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EB9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BFD2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CSFkM+ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BFD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeIQUhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:37:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54828 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbeIQUhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:37:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180917151009euoutp015ed21d55ce967cabf0536a901caaaf2f~VOIkT4ZS-2474724747euoutp014
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:10:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180917151009euoutp015ed21d55ce967cabf0536a901caaaf2f~VOIkT4ZS-2474724747euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537197009;
        bh=cY5FL3WC+eM3DcQ+/PpJo7RkBq4nR1ygXuBk+NVTqA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSFkM+utx8lqhZgV1ryz1lCp9xzJtlCAtfvrhmAWxsHq96susRrtMuuNRnirl/lZD
         AdzcYFshYETxE1Lpt5vuHvLrLVzLdeyGbOM/k2BwsqvQvzAI7vHK0zi29yJyHB8+Ks
         Gzx/8ust4PPXtk4JmgoLvXx+R3wJaNv5rgIzf9b0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180917151008eucas1p16b9eb3e55838a61ab9189103e61fc49f~VOIj0tqCn0202502025eucas1p1B;
        Mon, 17 Sep 2018 15:10:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F6.7C.04441.0D3CF9B5; Mon, 17
        Sep 2018 16:10:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8~VOIi9Gjo-0057700577eucas1p1F;
        Mon, 17 Sep 2018 15:10:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180917151007eusmtrp1fff1b980948ca0b8b3a35d00aa2776f4~VOIirRn0r3069130691eusmtrp1r;
        Mon, 17 Sep 2018 15:10:07 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-09-5b9fc3d0917b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.48.04284.FC3CF9B5; Mon, 17
        Sep 2018 16:10:07 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180917151006eusmtip2e95b823564f6593536dcfb7691a71258~VOIiMxK3q2417824178eusmtip2U;
        Mon, 17 Sep 2018 15:10:06 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     linux-crypto@vger.kernel.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 2/4] crypto: s5p-sss: Fix Fix argument list alignment
Date:   Mon, 17 Sep 2018 17:09:28 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7oXDs+PNvhxS9Ri44z1rBbHdy9l
        tJhzvoXFovuVjEXfvv+MFufPb2C3uH/vJ5PF5V1z2CxmnN/HZPH/VzOzA5fHlpU3mTy2HVD1
        2LSqk83j38IpLB4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6MtskfGAtOs1f0P3nH
        0sA4l62LkZNDQsBE4vqZ++wgtpDACkaJz+dSuxi5gOwvjBIt+/uZIJzPjBLLjl9lgum49Hs5
        VGI5o8T2O4sY4VreNZ1hBaliEzCVuH33E9AODg4RAQWJeV91QMLMAi3MEr9Wc4LYwgIeEvtX
        fgVbzSKgKvHlzjqok+Qkbp7rZAaxOYFq3v+ZxQ4R72eX2LbeBcTmFSiTeDdvN9RBLhJHr22E
        qhGWeHV8C5QtI3F6cg8LyG0SAs2MEre+XGOFcCYwShxc3cUCUWUtsenGKyaQQ5kFNCXW79KH
        CDtK3L6ygRkkLCHAJ3HjrSDE/XwSk7ZNhwrzSnS0CUFUq0m83rKFDWbti89fGSFsD4m3c88x
        Q4JnNqPEm3MXWScwys9CWLaAkXEVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYEI5/e/4
        px2MXy8lHWIU4GBU4uFdsGB+tBBrYllxZe4hRgkOZiURXmY+oBBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXFePq20aCGB9MSS1OzU1ILUIpgsEwenVANjbUf9BcX6ryUxPktcFJd/O/Vi2fn22ZrT
        PmbM2XhvPvuHJWIKuzP+3GRfdEw3T+lAoKmO1494uVvRLxk++5/Snn7rltG9hx3zFPfX7e5R
        XLu25WVl2bZ/00y2KVSH/5thZiz+0pw79eV3vU1z5EstXsZeL+Ddeu5j3KbIssblbC8f9Zpd
        WXg3XomlOCPRUIu5qDgRALQbsYkkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xe7rnD8+PNvj8QcJi44z1rBbHdy9l
        tJhzvoXFovuVjEXfvv+MFufPb2C3uH/vJ5PF5V1z2CxmnN/HZPH/VzOzA5fHlpU3mTy2HVD1
        2LSqk83j38IpLB4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNL
        PUNj81grI1MlfTublNSczLLUIn27BL2MtskfGAtOs1f0P3nH0sA4l62LkZNDQsBE4tLv5Uxd
        jFwcQgJLGSXWrX3CCpGQkZh3tg+qSFjiz7UuNoiiT4wSM7ufMoMk2ARMJW7f/QSU4OAQEVCQ
        mPdVB6SGWaCLWWLGkw6wZmEBD4n9K7+yg9gsAqoSX+6sA4vzCrhLnLm2jxligZzEzXOdYDYn
        UP37P7PA6oWAarZMncE4gZFvASPDKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAQ33bs5+Yd
        jJc2Bh9iFOBgVOLhXbBgfrQQa2JZcWXuIUYJDmYlEV5mPqAQb0piZVVqUX58UWlOavEhRlOg
        oyYyS4km5wPjL68k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA6Nk
        o/+MClGfJ4vniHVNeGTw+PgJPd697DqRCps7+e6efbfP8aeuRdaa7K/aMhkuH8QrGGLnlEZ2
        7Ddnm8ApXvx73XnPX3vDm8RmlYZ0zL8bFPHhJnu114Pdr+XSpNMm2f20nVa2ieHIx1Pm92tv
        sAbP3KfjZjvtYnh82IxJGya6XHy70G6Z9nUlluKMREMt5qLiRAACB94ghwIAAA==
Message-Id: <20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8~VOIi9Gjo-0057700577eucas1p1F@eucas1p1.samsung.com>
X-CMS-MailID: 20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8
References: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misalignment of continued argument list.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/s5p-sss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 9021ad9df0c4..b7216935236f 100644
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
@@ -1889,7 +1889,7 @@ static int s5p_set_indata_start(struct s5p_aes_dev *dev,
 }
 
 static int s5p_set_outdata_start(struct s5p_aes_dev *dev,
-				struct ablkcipher_request *req)
+				 struct ablkcipher_request *req)
 {
 	struct scatterlist *sg;
 	int err;
-- 
2.7.4

