Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E751C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308CF276AB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tsfkHPoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308CF276AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965456AbeF1QpG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:45:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53388 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeF1QoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:44:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180628164422euoutp019aa98b35fd582810ae855023ced64f59~8YKtRsfhx3259132591euoutp01P;
        Thu, 28 Jun 2018 16:44:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180628164422euoutp019aa98b35fd582810ae855023ced64f59~8YKtRsfhx3259132591euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530204262;
        bh=Q6ZcA6Q9u+T6MP0h+m6XkuS0jiKVNSHo2sy2IrN8/5c=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=tsfkHPoiQaarnbwuHFd7y7hT/NY3eGKXpO5KcHb4MQkcYSXdXaocF9550jczHR59A
         1TQ2HFqUsj4Sqirnwh9waWBoAU7pzBj04Ja4O1hSKoQze0BScBm1Fdsus7UiGCzcZt
         N5IlF2KV6NJRRvlnY8gyR/8Gb5miC79hchTKMoKU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180628164421eucas1p28be39d84687466f775db3c3645db64d4~8YKsQ-HFo1087510875eucas1p2K;
        Thu, 28 Jun 2018 16:44:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EC.49.10409.460153B5; Thu, 28
        Jun 2018 17:44:20 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180628164420eucas1p1c27249c883e0829989d4309ae9a115d6~8YKrNWPjT0677306773eucas1p1D;
        Thu, 28 Jun 2018 16:44:20 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-c8-5b3510644830
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.2F.04178.460153B5; Thu, 28
        Jun 2018 17:44:20 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PB1006SUL5Q0Y10@eusync3.samsung.com>;
        Thu, 28 Jun 2018 17:44:20 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 2/3] drm/bridge/sii8620: Fix display of packed pixel modes
Date:   Thu, 28 Jun 2018 18:44:02 +0200
Message-id: <1530204243-6370-3-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1530204243-6370-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7djPc7opAqbRBn+3W1jcWneO1aL33Ekm
        i6aOt6wWG2esZ7W48vU9m0XnxCXsFpd3zWGzWPDyFovF2iN32R04PS739TJ5zO6Yyeqx/dsD
        Vo/73ceZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj/Eu1glV8FSe3/2dsYLzJ3cXIySEh
        YCLx7/pnpi5GLg4hgRWMEgduP2KGcD4zSlxY8JYFpmr7jEVQVcsYJaZ/msQC4fxnlGj8/Rmo
        hYODTUBLYk17PEiDiICyxN+JqxhBapgFrjJJnLy8nQkkISzgJfHo9ldGEJtFQFXi16T9YHFe
        AWeJKacOsUNsk5O4ea6TGcTmFHCRmNO4AmyQhMAcNonr594yQRS5SDx+vpYVwhaWeHV8C1Sz
        jERnx0GommqJlS+Xs0A0NzBKfLl7mRkiYS1x+PhFsGZmAT6JSdumg30gIcAr0dEmBFHiIdE3
        YQc0LKYzSmy4N411AqPkAkaGVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIHxefrf8a87
        GPf9STrEKMDBqMTDe+KKSbQQa2JZcWXuIUYJDmYlEV4hTtNoId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rxxGnVRQgLpiSWp2ampBalFMFkmDk6pBkZRDz/+y3vmv130tODCN+uScPY9GV8mt9zh
        90jzrW56OT25kHm5NcuXeRzHWXI/5KfPXv8qL+H67X0heosXvHm5R1x+KYfli4dVdcVqp7Qn
        38veGXXrT12K1JQFnReKdtdfX/9//UNvH2flPYIBG6oOnrZw/q6wiMmNabk/y5/F/PyXHmW0
        LVusxFKckWioxVxUnAgA1aQTRMsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsVy+t/xq7opAqbRBnuPMVvcWneO1aL33Ekm
        i6aOt6wWG2esZ7W48vU9m0XnxCXsFpd3zWGzWPDyFovF2iN32R04PS739TJ5zO6Yyeqx/dsD
        Vo/73ceZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj/Eu1glV8FSe3/2dsYLzJ3cXIySEh
        YCKxfcYipi5GLg4hgSWMEm9uHmOBcBqZJO59PgWU4eBgE9CSWNMeD9IgIqAs8XfiKkaQGmaB
        m0wSf8/uZQVJCAt4STy6/ZURxGYRUJX4NWk/E4jNK+AsMeXUIXaIbXISN891MoPYnAIuEnMa
        V4DVCwHVnN7bxDaBkWcBI8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwMDaduzn5h2MlzYG
        H2IU4GBU4uE9ccUkWog1say4MvcQowQHs5IIrxCnabQQb0piZVVqUX58UWlOavEhRmkOFiVx
        3vMGlVFCAumJJanZqakFqUUwWSYOTqkGxtTvu7OX9Lx8O9/hd1O3z7duBvXybf+UnoWrqVw/
        Va6eF2dsF9i2NWmr88F5/UJdm2cV689fdDXU7vvCLarBu04dFK7b2/Rqpaa7xEvLFwvP33hx
        ZmvGe6a4fnWOlGkZ07MlD97ZWTIvas7bXqOPnfcMbrpfDIjafMEnlUuscO7EbvHgeV6yxkos
        xRmJhlrMRcWJAJ9MlDooAgAA
X-CMS-MailID: 20180628164420eucas1p1c27249c883e0829989d4309ae9a115d6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180628164420eucas1p1c27249c883e0829989d4309ae9a115d6
References: <1530204243-6370-1-git-send-email-m.purski@samsung.com>
        <CGME20180628164420eucas1p1c27249c883e0829989d4309ae9a115d6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation does not guarantee packed pixel modes working
with every dongle. There are some dongles, which require selecting
the output mode explicitly.

Write proper values to registers in packed_pixel mode, based on how it
is done in vendor's code. Select output color space: RGB
(no packed pixel) or YCBCR422 (packed pixel).

This reverts commit e8b92efa629dac0e70ea4145c5e70616de5f89c8
("drm/bridge/sii8620: fix display of packed pixel modes in MHL2").

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index bd30ccf..16fe7ea 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -1015,21 +1015,36 @@ static void sii8620_stop_video(struct sii8620 *ctx)
 
 static void sii8620_set_format(struct sii8620 *ctx)
 {
+	u8 out_fmt;
+
 	if (sii8620_is_mhl3(ctx)) {
 		sii8620_setbits(ctx, REG_M3_P0CTRL,
 				BIT_M3_P0CTRL_MHL3_P0_PIXEL_MODE_PACKED,
 				ctx->use_packed_pixel ? ~0 : 0);
 	} else {
+		if (ctx->use_packed_pixel) {
+			sii8620_write_seq_static(ctx,
+				REG_VID_MODE, BIT_VID_MODE_M1080P,
+				REG_MHL_TOP_CTL, BIT_MHL_TOP_CTL_MHL_PP_SEL | 1,
+				REG_MHLTX_CTL6, 0x60
+			);
+		} else {
 			sii8620_write_seq_static(ctx,
 				REG_VID_MODE, 0,
 				REG_MHL_TOP_CTL, 1,
 				REG_MHLTX_CTL6, 0xa0
 			);
+		}
 	}
 
+	if (ctx->use_packed_pixel)
+		out_fmt = VAL_TPI_FORMAT(YCBCR422, FULL);
+	else
+		out_fmt = VAL_TPI_FORMAT(RGB, FULL);
+
 	sii8620_write_seq(ctx,
 		REG_TPI_INPUT, VAL_TPI_FORMAT(RGB, FULL),
-		REG_TPI_OUTPUT, VAL_TPI_FORMAT(RGB, FULL),
+		REG_TPI_OUTPUT, out_fmt,
 	);
 }
 
-- 
2.7.4

