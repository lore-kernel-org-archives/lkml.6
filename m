Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9250AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60609222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G+535ioT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406383AbfBNKDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:03:51 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21487 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392765AbfBNKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:03:49 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190214100347epoutp02be815d5488f57d5253536fbb0489fe18~DMt5L3GEx0717007170epoutp02R
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:03:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190214100347epoutp02be815d5488f57d5253536fbb0489fe18~DMt5L3GEx0717007170epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550138627;
        bh=3c4AJsYUUXoVYPzv45HkrTxy5Ju9ASCEopYAvrtso6E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=G+535ioT152kkpm9b3zxpcdnNSqsKIqgbsPI/PCcTF1qgygyzrXXDiaukguJQ4kOU
         k5f6Cn3R+ucXlo1GTYnDQFACa7HZ8yC7aNAN2vjEoeuouUP+IUWTLhPJSrp2bjmqBM
         qsqa73gGK7L0rdigLSLk5f0dL3uwhIxNTbZOZFNc=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214100344epcas1p124f078ea3ae4a933defdda3742c7f097~DMt27YwZM0548405484epcas1p1P;
        Thu, 14 Feb 2019 10:03:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.C2.04173.00D356C5; Thu, 14 Feb 2019 19:03:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190214100344epcas1p316a40d88f3b52a10745c95cc3d16a0ed~DMt2fsxaI1036010360epcas1p3j;
        Thu, 14 Feb 2019 10:03:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190214100344epsmtrp194a0811bb5c0ee4613d853b673ec08ef~DMt2cnqm40220902209epsmtrp1e;
        Thu, 14 Feb 2019 10:03:44 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-87-5c653d009845
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.7F.03601.FFC356C5; Thu, 14 Feb 2019 19:03:44 +0900 (KST)
Received: from jaehoon-DeskTop.10.32.193.11 (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190214100343epsmtip2e7e19e82122204dd9ad8d9bedf77a31a~DMt2OxLf71521815218epsmtip2b;
        Thu, 14 Feb 2019 10:03:43 +0000 (GMT)
From:   Jaehoon Chung <jh80.chung@samsung.com>
To:     linux-usb@vger.kernel.org
Cc:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] usb: dwc2: hcd: call dwc2_is_controller_alive under
 spinlock
Date:   Thu, 14 Feb 2019 19:03:42 +0900
Message-Id: <1550138622-10761-1-git-send-email-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7bCmri6DbWqMQesZNYvmxevZLBp/7WW3
        uPGrjdXi8q45bBaLlrUyW6w9cpfdgc1j/9w17B59W1YxemzZ/5nR4/MmuQCWqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDlSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjIe/G9gLXnBW
        7G1+wNzA2MrRxcjJISFgIvHiyxKmLkYuDiGBHYwSi9bvYIdwPjFK3Nn4gxHC+cYosXvVHBaY
        lkun5rGB2EICexkl5vbGQBT9ZpQ4dvIcM0iCTUBHYvu340wgtoiArMThK7+ZQYqYBaYzSqz+
        s5ERJCEs4C+xfPk/VhCbRUBV4saMDewgNq+Am8TKw5tYIbbJSdw81wnWLCHwk1VixpmXUAkX
        ietbn0LZwhKvjm9hh7ClJF72t0HZ1RK7ms9ANXcwStza1sQEkTCW2L90MpDNAXSSpsT6Xfog
        YWYBPol3X3tYQcISArwSHW1CENUqEpdev2SCGX/3yX+otR4Sf+fdZYWERKzE7t0N7BMYZWYh
        DF3AyLiKUSy1oDg3PbXYsMAIOWo2MYJTkZbZDsZF53wOMQpwMCrx8FYIpcQIsSaWFVfmHmKU
        4GBWEuG9aJQaI8SbklhZlVqUH19UmpNafIjRFBhiE5mlRJPzgWkyryTe0NTI2NjYwsTQzNTQ
        UEmcd72Dc4yQQHpiSWp2ampBahFMHxMHp1QDo/S9N83HvBnrZ+7dJb5MJP2s04aZ7w8ezN7f
        mjj/3sFUH+emTk79iJcXzi7qLZyd0m4k8G5KVtIiGeP1jemSMTc/Scxj3fT3HLfzrtOuBqf/
        745Jed96OLhE9dlzRk/97tclHOs1Xxik17HUS/P8Wzc3OrH33PcMfofYqW8+vSo8W50cenaO
        oRJLcUaioRZzUXEiADjrxP1bAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42LZdlhJXpfBNjXGoGUdk0Xz4vVsFo2/9rJb
        3PjVxmpxedccNotFy1qZLdYeucvuwOaxf+4ado++LasYPbbs/8zo8XmTXABLFJdNSmpOZllq
        kb5dAlfGw98N7AUvOCv2Nj9gbmBs5ehi5OSQEDCRuHRqHlsXIxeHkMBuRokNixazQSSkJD4/
        nQpkcwDZwhKHDxeDhIUEfjJKLJlUC2KzCehIbP92nAnEFhGQlTh85TczyBxmgdmMEosO3GYB
        SQgL+Eq8+LgcrIhFQFXixowN7CA2r4CbxMrDm1ghdslJ3DzXyTyBkWcBI8MqRsnUguLc9Nxi
        wwKjvNRyveLE3OLSvHS95PzcTYzggNHS2sF44kT8IUYBDkYlHl4FgZQYIdbEsuLK3EOMEhzM
        SiK8/6xTY4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUw
        Vt5drszytMNnj4zthX9K0jsfLBHojT2/fP6S8+cX54YtEfy9VyuVXYsl8EVC7aHV8ho/eUXn
        eld6Suif3V/x/JPLz/+/ff5zS/4XS2YRPu3dYvvM40P83dmOZ4wtjGz2v91UxutfGn71iEr5
        m3h18ee3X8tsvtXo4mHZpa92S3q30GP9W9q/lFiKMxINtZiLihMBJY9txRQCAAA=
X-CMS-MailID: 20190214100344epcas1p316a40d88f3b52a10745c95cc3d16a0ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190214100344epcas1p316a40d88f3b52a10745c95cc3d16a0ed
References: <CGME20190214100344epcas1p316a40d88f3b52a10745c95cc3d16a0ed@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is referred to Robert's patch
commit cf54772b913b ("usb: dwc2: call dwc2_is_controller_alive() under spinlock")

During running sdb with otg mode, the usb is hung sometime.

The one of SDB hang issues should be fixed with this patch.
After hang, it doesn't never trigger the usb interrupt.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/usb/dwc2/hcd_intr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index 88b5dcf..8d3b155 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -2222,13 +2222,13 @@ irqreturn_t dwc2_handle_hcd_intr(struct dwc2_hsotg *hsotg)
 	u32 gintsts, dbg_gintsts;
 	irqreturn_t retval = IRQ_NONE;
 
+	spin_lock(&hsotg->lock);
+
 	if (!dwc2_is_controller_alive(hsotg)) {
 		dev_warn(hsotg->dev, "Controller is dead\n");
-		return retval;
+		goto out;
 	}
 
-	spin_lock(&hsotg->lock);
-
 	/* Check if HOST Mode */
 	if (dwc2_is_host_mode(hsotg)) {
 		gintsts = dwc2_read_core_intr(hsotg);
@@ -2276,6 +2276,7 @@ irqreturn_t dwc2_handle_hcd_intr(struct dwc2_hsotg *hsotg)
 		}
 	}
 
+out:
 	spin_unlock(&hsotg->lock);
 
 	return retval;
-- 
2.7.4

