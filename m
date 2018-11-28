Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F56C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D0020832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ihiEFXYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D0020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeK1TDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:03:32 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33578 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeK1TDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:03:32 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181128080245euoutp027a3b6bbdf571a1c26c7197324aa81b62~rOv9qudh33067330673euoutp02J;
        Wed, 28 Nov 2018 08:02:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181128080245euoutp027a3b6bbdf571a1c26c7197324aa81b62~rOv9qudh33067330673euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543392166;
        bh=EmIe6nFPKEzz80wkhOcNbeYCmFDnDnvZF9rKVNOCDAw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ihiEFXYBU6vhYWtpZnxiXRKvpZWuDNhStVU7UngOPbiuPqEPmlw92/OWxJ1q+P3HY
         DW5NDlxJou1sKuOJP+f3H0gP3lU/SSxqcgR0yQ+B8Ey+nfyy0kUnSAMI9D6/1fhvKL
         +so2Zq5xTfysPofmoXEDT83ES3W0D2KqyvLDWx8s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181128080245eucas1p1cf827e90e36727fd21795aacfbedfeb5~rOv9LJ1uj1314313143eucas1p1N;
        Wed, 28 Nov 2018 08:02:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 13.2E.04441.5AB4EFB5; Wed, 28
        Nov 2018 08:02:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181128080244eucas1p15d9478c4fdbb0609005a12d24703d6d8~rOv8MuYNy1318113181eucas1p1I;
        Wed, 28 Nov 2018 08:02:44 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-9a-5bfe4ba57996
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.8F.04128.4AB4EFB5; Wed, 28
        Nov 2018 08:02:44 +0000 (GMT)
Received: from localhost.localdomain ([10.88.99.240]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PIW00AW5908T130@eusync1.samsung.com>; Wed, 28 Nov
        2018 08:02:44 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Huijin Park <huijin.park@samsung.com>, bbanghj.park@gmail.com,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3] mtd: spi-nor: cast to u64 to avoid uint overflows
Date:   Wed, 28 Nov 2018 03:02:14 -0500
Message-id: <1543392134-1443-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7djP87pLvf9FG8xeymnxcu8hZot9p/pZ
        LJ7d2stk0XHRxeLyrjlsFrublrFbHN1zj9mB3WPemmqPnbPusnscOtzB6LF5Sb1H35ZVjB6f
        N8kFsEVx2aSk5mSWpRbp2yVwZSzomc9W8JWj4lPfCcYGxi3sXYycHBICJhI9bUsYuxi5OIQE
        VjBKrGxdxQ7hfGaUeHFuGhNM1dZ769ggEssYJe5cf8UM4fxllFi0cAEbSBWbgLbE9bVbGUFs
        EQFDiZVTW1hAipgFLjFKXH/6FqxIWMBVYsXMLrCxLAKqEptmtrOA2LwCbhK7Nq+CWicncfNc
        J9gGCYG3rBK7J/9ihki4SPS+fg9VJCzx6jjMFzISlyd3s0DY2RK/HrUC2RxAdoXE23kqEGFj
        iXdv14KNYRbgk5i0bTozRAmvREebEESJh8TD24/B7hcSiJXofHyQcQKjxAJGhlWM4qmlxbnp
        qcWGeanlesWJucWleel6yfm5mxiBsXb63/FPOxi/Xko6xCjAwajEwxuQ+jdaiDWxrLgy9xCj
        BAezkghvqd2/aCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTByc
        Ug2MG7wjawU/C/gu/eHILyiZ8t5vbs0ThdeXnzopKlUuTmH8wJMy4/lKnafLzhu9f2+TbbUr
        U85GxEG31X5qUMZ9xncad9wv2a5amOsQt7b5m4TNTNVJd+ecMdHMs1ir43Ljc49u346VuqmG
        u20Opa/vvRtl88ru7YwvVQd3LOXrXmhnyPFVe1m+EktxRqKhFnNRcSIAJ2Qlg7ECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJMWRmVeSWpSXmKPExsVy+t/xy7pLvP9FG/y+xG7xcu8hZot9p/pZ
        LJ7d2stk0XHRxeLyrjlsFrublrFbHN1zj9mB3WPemmqPnbPusnscOtzB6LF5Sb1H35ZVjB6f
        N8kFsEVx2aSk5mSWpRbp2yVwZSzomc9W8JWj4lPfCcYGxi3sXYycHBICJhJb761j62Lk4hAS
        WMIo0ff9LjuE859RovHANlaQKjYBbYnra7cygtgiAoYSK6e2sIAUMQtcYpT49eQt2ChhAVeJ
        FTO7mEBsFgFViU0z21lAbF4BN4ldm1cxQayTk7h5rpN5AiPXAkaGVYwiqaXFuem5xUZ6xYm5
        xaV56XrJ+bmbGIEhse3Yzy07GLveBR9iFOBgVOLhDUj9Gy3EmlhWXJl7iFGCg1lJhLfU7l+0
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd7zBpVRQgLpiSWp2ampBalFMFkmDk6pBsYY4QkcfbcY
        +02s629eNVpkt/Y/P2vs3fZK5t7zCVbX19/p/MsvVePnbhT+TlT3ZP3jEwJBT3eIG2ptyl3/
        KNos8QO/nV2qc/fzvTznZbbL/kwsmBHU/PlNqPGTzyvND3Rc6ErKX6V8pPPnNO8F53h8z+/1
        sW3c0hW79NHu+fKeT7glwoS4jZVYijMSDbWYi4oTAU1asggFAgAA
X-CMS-MailID: 20181128080244eucas1p15d9478c4fdbb0609005a12d24703d6d8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181128080244eucas1p15d9478c4fdbb0609005a12d24703d6d8
References: <CGME20181128080244eucas1p15d9478c4fdbb0609005a12d24703d6d8@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huijin.park" <huijin.park@samsung.com>

The "params->size" is defined as "u64".
And "info->sector_size" and "info->n_sectors" are defined as
unsigned int and u16.
Thus, u64 data might have strange data(loss data) if the result
overflows an unsigned int.
This patch casts "info->sector_size" to an u64.

Signed-off-by: huijin.park <huijin.park@samsung.com>
---

Changes since v1:
 * Made commit subject and message more clear.
Changes since v2:
 * Adding the cast to only the first operand.
---
 drivers/mtd/spi-nor/spi-nor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d9c368c..59a1075 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2459,7 +2459,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	memset(params, 0, sizeof(*params));
 
 	/* Set SPI NOR sizes. */
-	params->size = info->sector_size * info->n_sectors;
+	params->size = (u64)info->sector_size * info->n_sectors;
 	params->page_size = info->page_size;
 
 	/* (Fast) Read settings. */
-- 
1.7.9.5

