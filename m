Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C33C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D972245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rod9ja4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D972245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbeKMPPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:15:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52554 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:15:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181113051849euoutp01dd58ddfd79e119cd29f99c519394f61f~ml1iv-uc10645806458euoutp01c;
        Tue, 13 Nov 2018 05:18:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181113051849euoutp01dd58ddfd79e119cd29f99c519394f61f~ml1iv-uc10645806458euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542086329;
        bh=5LRIQh9YHvh62I5JA0g7iDNlkANNGmFUQHYraxvpNoU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Rod9ja4gM12Ej7XJOMk12jR1CMfX9eBFDHlZa5+O3eODTLYOyfu/qYkH775RZF6Cw
         dF5+fDbTE5BJfUS5qh8O5Ygf4pE5Jqv+qAYYCtMezuneXRnfKnYGJvbluCReW2tP4K
         DYHCppSIsEYcr/k2pjqq3kyTgYAgfvYEeZOhRm7I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181113051848eucas1p10f43b86f12bb0a4fb035c317eabe67bb~ml1iCDDBd0047400474eucas1p1Y;
        Tue, 13 Nov 2018 05:18:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 21.5C.04294.8BE5AEB5; Tue, 13
        Nov 2018 05:18:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181113051847eucas1p1fb080ea1727b8be444bf3bf6aeb746f0~ml1g6Tig_0047000470eucas1p1W;
        Tue, 13 Nov 2018 05:18:47 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-9b-5bea5eb8765c
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 99.C3.04284.7BE5AEB5; Tue, 13
        Nov 2018 05:18:47 +0000 (GMT)
Received: from localhost.localdomain ([10.88.99.240]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI4009139F5HM50@eusync4.samsung.com>; Tue, 13 Nov
        2018 05:18:47 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Huijin Park <huijin.park@samsung.com>, bbanghj.park@gmail.com
Subject: [PATCH] mtd: spi-nor: cast to u64 to avoid uint overflows
Date:   Tue, 13 Nov 2018 00:18:38 -0500
Message-id: <1542086318-18416-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7djP87o74l5FG1x4KGLxcu8hZot9p/pZ
        LDouulhc3jWHzWJ30zJ2i6N77jE7sHnMW1PtsXPWXXaPzUvqPfq2rGL0+LxJLoA1issmJTUn
        syy1SN8ugSuj48cF5oIWjorDP1eyNDA+Yuti5OSQEDCR+P+3jaWLkYtDSGAFo8Sb+a+ZIJzP
        jBL3z69iham6cGsNI4gtJLCMUeJ3uylE0V9GiZ1n9rGAJNgEtCWur90KViQiYCixcmoL2Fhm
        geWMEu9OzABLCAs4STRs3Q60goODRUBV4t6tcJAwr4C7xJTWXkaIZXISN891MoP0Sgg8ZJW4
        O68NKuEi8XH9KihbWOLV8S3sELaMRGfHQSYIO1vi16NWFpD5EgIVEm/nqUCEjSXevV3LDGIz
        C/BJTNo2nRmihFeio00IosRD4lP/S6gfYyU+/bvGOoFRYgEjwypG8dTS4tz01GKjvNRyveLE
        3OLSvHS95PzcTYzAmDr97/iXHYy7/iQdYhTgYFTi4T0x/WW0EGtiWXFl7iFGCQ5mJRHenSav
        ooV4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUwmrhc5ORv
        CLUrfqc2Xcyj/kp3jmPte1vVHwo5ttlGBuvjdlYdvmpyloX750QB5e1LnM4yLGLoTYhmF9yj
        Vef34JCK34LEEp7Hs7+bz7vqdsppRX9R4N9Jp38I/kpcH25ddYyX44Zlq8Ej9Wzp/7cskl62
        XV0z8dZjJb+vD69Ln3nSc3tGxdbZSizFGYmGWsxFxYkAQfH6TqUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJMWRmVeSWpSXmKPExsVy+t/xa7rb415FG/w5r2Txcu8hZot9p/pZ
        LDouulhc3jWHzWJ30zJ2i6N77jE7sHnMW1PtsXPWXXaPzUvqPfq2rGL0+LxJLoA1issmJTUn
        syy1SN8ugSuj48cF5oIWjorDP1eyNDA+Yuti5OSQEDCRuHBrDWMXIxeHkMASRokdi2dCOf8Z
        JSaf3MMOUsUmoC1xfe1WRhBbRMBQYuXUFhYQm1lgOaPEhSs2ILawgJNEw9btTF2MHBwsAqoS
        926Fg4R5BdwlprT2MkIsk5O4ea6TeQIj1wJGhlWMIqmlxbnpucWGesWJucWleel6yfm5mxiB
        vt927OfmHYyXNgYfYhTgYFTi4T0x/WW0EGtiWXFl7iFGCQ5mJRHenSavooV4UxIrq1KL8uOL
        SnNSiw8xSnOwKInznjeojBISSE8sSc1OTS1ILYLJMnFwSjUw+l/4vvcCt7L8bU2dKwIxTh2/
        ODfbi7m3hZVWHr5jWfLd+/Nuic7F+UszXrxSYC3repx7jSF+5h73uTdmqL3rvrlHW1JkjWhP
        44HiT6d21bGeT68obnQ3m1XW6re3SlAmv+dB+tr90kdnHgy7+lf21Tp2dbH+w26nmN/w6fId
        VdojflZS8+ZVJZbijERDLeai4kQACbRmXPkBAAA=
X-CMS-MailID: 20181113051847eucas1p1fb080ea1727b8be444bf3bf6aeb746f0
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181113051847eucas1p1fb080ea1727b8be444bf3bf6aeb746f0
References: <CGME20181113051847eucas1p1fb080ea1727b8be444bf3bf6aeb746f0@eucas1p1.samsung.com>
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
This patch casts "info->sector_size" and "info->n_sectors" to an u64.

Signed-off-by: huijin.park <huijin.park@samsung.com>
---
 drivers/mtd/spi-nor/spi-nor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d9c368c..527f281 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2459,7 +2459,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	memset(params, 0, sizeof(*params));
 
 	/* Set SPI NOR sizes. */
-	params->size = info->sector_size * info->n_sectors;
+	params->size = (u64)info->sector_size * (u64)info->n_sectors;
 	params->page_size = info->page_size;
 
 	/* (Fast) Read settings. */
-- 
1.7.9.5

