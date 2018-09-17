Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B25214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LfU6q1m8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B25214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeIQUhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:37:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54816 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeIQUhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:37:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180917151008euoutp013e99fd33db2e89b106c9ca3ca77435e8~VOIjMZOQb2472624726euoutp01A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:10:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180917151008euoutp013e99fd33db2e89b106c9ca3ca77435e8~VOIjMZOQb2472624726euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537197008;
        bh=g3RorNLxXU6pHJrFDZvhtON4nN0xcIymWtdQdIQNHtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfU6q1m8ILD6JS3GimkhYqeAPlGarZgvKs6Y1QavX9haf57fUGfAvh2RJPOvGq/eW
         3lM9OhcgB6wbF16TynS1TiUx4vI87Y4C0aKPoSGNBhW1SRYVRJffI4d2MiHwc0bbL1
         NHdguwvjXd3THnbcxhl55mHe9vqdC0x3SLAAbHto=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180917151007eucas1p287db2d512a0af558d21176cce16a182b~VOIiQnvyT1112911129eucas1p2r;
        Mon, 17 Sep 2018 15:10:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 78.F7.04806.EC3CF9B5; Mon, 17
        Sep 2018 16:10:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495~VOIhXssSK0729007290eucas1p25;
        Mon, 17 Sep 2018 15:10:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180917151005eusmtrp18cc33922795db87af587619b1d8acd70~VOIhFdGj03069130691eusmtrp1q;
        Mon, 17 Sep 2018 15:10:05 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-ba-5b9fc3ce4acc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 41.48.04284.DC3CF9B5; Mon, 17
        Sep 2018 16:10:05 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180917151005eusmtip2bd2888d07a6fb2b4fe73e5decabd865e~VOIglyGLT2368423684eusmtip29;
        Mon, 17 Sep 2018 15:10:05 +0000 (GMT)
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
Subject: [PATCH v2 1/4] crypto: s5p-sss: Fix race in error handling
Date:   Mon, 17 Sep 2018 17:09:27 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87rnDs+PNrj4Uc1i44z1rBbHdy9l
        tJhzvoXFovuVjEXfvv+MFufPb2C3uH/vJ5PF5V1z2CxmnN/HZPH/VzOzA5fHlpU3mTy2HVD1
        2LSqk83j38IpLB4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6Ml89mMRWcEa743fef
        pYFxlUAXIyeHhICJxL+uiaxdjFwcQgIrGCWmvf/LDuF8YZR42nuZBcL5zCixZsUsVpiWX7f2
        MkEkljNKHN72gA2uZf+XpywgVWwCphK3734CSnBwiAgoSMz7qgMSZhZoYZb4tZoTJCws4Czx
        eb4jSJhFQFXi3fonjBDz5SRunutkBrE5BTwk3v+ZBXaRhEA/u0TL1VfsIAlegTKJvcvaWUDm
        SAi4SPz6LwLRKyzx6vgWdghbRuL05B4WiN5mRolbX66xQjgTGCUOru5igaiylth04xUTyCBm
        AU2J9bv0IWY6SlxproAw+SRuvBWEuJ5PYtK26cwQYV6JjjYhiBlqEq+3bGGD2fri81eoTzwk
        jp9oggbhbEaJdfOOsk9glJ+FsGsBI+MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwHRy
        +t/xrzsY9/1JOsQowMGoxMO7YMH8aCHWxLLiytxDjBIczEoivMx8QCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8fFpp0UIC6YklqdmpqQWpRTBZJg5OqQZG12OC78K4KzK3rdqzNUZy1W+TfZIx
        q/9mdueIr7/tKTWHXeWI+f7mX9o26zzezfhqP+Ow56mUvj8t569Y373+bx4bp2F1ktX+9YkZ
        T5viZD4pTpZIYl28zsH+QtgNv5YE1spjd09crvMtLbfZsEPVVfBt9vfvvr+cRJMeGF7O/xMV
        d6VmtoSmEktxRqKhFnNRcSIAqr5h7CMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xe7pnD8+PNji8WN1i44z1rBbHdy9l
        tJhzvoXFovuVjEXfvv+MFufPb2C3uH/vJ5PF5V1z2CxmnN/HZPH/VzOzA5fHlpU3mTy2HVD1
        2LSqk83j38IpLB4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNL
        PUNj81grI1MlfTublNSczLLUIn27BL2Ml89mMRWcEa743fefpYFxlUAXIyeHhICJxK9be5m6
        GLk4hASWMkr82tLIDpGQkZh3to8NwhaW+HOtiw2i6BOjxOX+N8wgCTYBU4nbdz8BJTg4RAQU
        JOZ91QGpYRboYpaY8aQDLC4s4Czxeb4jSDmLgKrEu/VPGEFsXgF3iVn3e1kh5stJ3DzXCTaS
        U8BD4v2fWWA3CAHVbJk6g3ECI98CRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgQG+7djP
        zTsYL20MPsQowMGoxMO7YMH8aCHWxLLiytxDjBIczEoivMx8QCHelMTKqtSi/Pii0pzU4kOM
        pkBHTWSWEk3OB0ZfXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYOTqkG
        RkbZ3Vnf/+00ZVrgcGR6NkP6tZldizvcWV21/O6JHfv7ZcLP00bb/qcKiLTwml/3nHazq3XK
        V7usvorFrny/Otwkix55CEx4svakLs/MmYpRp+VybxwKPO+43Jr3kLpA3gOmmV8S+EzSO+Ud
        Flyaw1/9VsFz/VXND5kpyxIOb/F5bV6ntvSznBJLcUaioRZzUXEiAJz1/iaGAgAA
Message-Id: <20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495~VOIhXssSK0729007290eucas1p25@eucas1p2.samsung.com>
X-CMS-MailID: 20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495
References: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a race condition introduced by error path in functions:
s5p_aes_interrupt and s5p_aes_crypt_start. Setting the busy field of
struct s5p_aes_dev to false made it possible for s5p_tasklet_cb to
change the req field, before s5p_aes_complete was called.

Change the first parameter of s5p_aes_complete to struct
ablkcipher_request. Before spin_unlock, make a copy of the currently
handled request, to ensure s5p_aes_complete function call with the
correct request.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/crypto/s5p-sss.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index faa282074e5a..9021ad9df0c4 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -475,9 +475,9 @@ static void s5p_sg_done(struct s5p_aes_dev *dev)
 }
 
 /* Calls the completion. Cannot be called with dev->lock hold. */
-static void s5p_aes_complete(struct s5p_aes_dev *dev, int err)
+static void s5p_aes_complete(struct ablkcipher_request *req, int err)
 {
-	dev->req->base.complete(&dev->req->base, err);
+	req->base.complete(&req->base, err);
 }
 
 static void s5p_unset_outdata(struct s5p_aes_dev *dev)
@@ -655,6 +655,7 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
 	struct s5p_aes_dev *dev = platform_get_drvdata(pdev);
+	struct ablkcipher_request *req;
 	int err_dma_tx = 0;
 	int err_dma_rx = 0;
 	int err_dma_hx = 0;
@@ -727,7 +728,7 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
 
 		spin_unlock_irqrestore(&dev->lock, flags);
 
-		s5p_aes_complete(dev, 0);
+		s5p_aes_complete(dev->req, 0);
 		/* Device is still busy */
 		tasklet_schedule(&dev->tasklet);
 	} else {
@@ -752,11 +753,12 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
 error:
 	s5p_sg_done(dev);
 	dev->busy = false;
+	req = dev->req;
 	if (err_dma_hx == 1)
 		s5p_set_dma_hashdata(dev, dev->hash_sg_iter);
 
 	spin_unlock_irqrestore(&dev->lock, flags);
-	s5p_aes_complete(dev, err);
+	s5p_aes_complete(req, err);
 
 hash_irq_end:
 	/*
@@ -1983,7 +1985,7 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	s5p_sg_done(dev);
 	dev->busy = false;
 	spin_unlock_irqrestore(&dev->lock, flags);
-	s5p_aes_complete(dev, err);
+	s5p_aes_complete(req, err);
 }
 
 static void s5p_tasklet_cb(unsigned long data)
-- 
2.7.4

