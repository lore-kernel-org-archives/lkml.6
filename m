Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DA422C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8634E208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iLDYlftP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8634E208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934730AbeFMI67 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:58:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55341 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbeFMI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:58:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180613085854euoutp018ff3cabedf37a09c69947a5e27c3377e~3rJBjGyat1235812358euoutp01V
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:58:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180613085854euoutp018ff3cabedf37a09c69947a5e27c3377e~3rJBjGyat1235812358euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528880334;
        bh=HUnq++m5CppSQm+bcPQ3G6N6tBLG9IP2HZVNlu4Jyy4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iLDYlftPiTDRaR5JGAS8QUBzjgAV6e+d4DbKJ4lp7xEnHs41oxszdUzd5mc0K/jR1
         2+Uh0uJSqHkw9h9TpLvFQHyNjZ/9DYh+KIM9Qv8w+YBYnIu3T3GNv4mZj/HDYnpoQO
         zhtobZuSafqWovHFddl1EgQ1kBKkppbDRtkeiGBI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180613085853eucas1p16799205776268eeb412e02aa82262e2f~3rJAMuGQi3167631676eucas1p1O;
        Wed, 13 Jun 2018 08:58:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3F.39.10409.CCCD02B5; Wed, 13
        Jun 2018 09:58:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C;
        Wed, 13 Jun 2018 08:58:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180613085851eusmtrp1c914d3cc1cb11c98864055332de6e22d~3rI_sd8iv0606306063eusmtrp15;
        Wed, 13 Jun 2018 08:58:51 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-c3-5b20dccc0771
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.E8.04183.BCCD02B5; Wed, 13
        Jun 2018 09:58:51 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.116.147.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180613085851eusmtip2e855b02eef7a56d620ae35bb6b4515a6~3rI_SvkQB3117331173eusmtip2B;
        Wed, 13 Jun 2018 08:58:51 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
Date:   Wed, 13 Jun 2018 10:58:37 +0200
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzned0zdxSiDZ6cNbWYs34Nm8XK7mY2
        i02Pr7FaXN41h83i3pr/rBZrj9xlt1hwvIXVYnZjH6MDh8emT5PYPbreXmHyODHjN4vH5iX1
        Huv+vGLy6NuyitHjzIIj7B6fN8kFcERx2aSk5mSWpRbp2yVwZazb381ecI+r4uENvQbGcxxd
        jJwcEgImEhPvr2DvYuTiEBJYwShxdOIkNgjnC6PEpJcNTBDOZ0aJbzf+scO0TD/9kxEisZxR
        4sW561DOV0aJ7V9vsoBUsQkYSnS97WIDsUUEYiS2HLnPDFLELHCWUWLmoSuMIAlhATuJKSdb
        WUFsFgFVid9v77BCrJCXWL3hAFiDhMB7Nonp56+BTeIVKJOYtus8M0SRi0TPow4WCFtY4tXx
        LVD3yUicntzDAtHczCjRPmMWO4TTwyixdc4ONogqa4nDxy8CreMAuklTYv0ufYiwo0TLqZts
        IGEJAT6JG28FQcLMQOakbdOZIcK8Eh1tQhDVahKzjq+DW3vwwiWo0zwkGjbsAJsiJBArsW2f
        3gRGuVkIqxYwMq5iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITBmn/x3/uoNx35+kQ4wC
        HIxKPLwWWxWihVgTy4orcw8xSnAwK4nwTpgKFOJNSaysSi3Kjy8qzUktPsQozcGiJM4bp1EX
        JSSQnliSmp2aWpBaBJNl4uCUamDc1/1LK/50ZuPKGfwWxdIHTScWrjvaOeNffpdZVMf6hfcy
        t/pe0Nmyd8PUm0l8TO5coXNXu86ffeGPd1/5tikl5/M+Hj0bpRu/IN57965d0213mn/uuVBw
        8Uyk2ZFPMnffrjKevF7iZY11uCJ30J9rleKmr/cWGM8L2jP5EMMV87DHgu/6Dc37lFiKMxIN
        tZiLihMBNUAC+xUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsVy+t/xe7qn7yhEG1xeqWAxZ/0aNouV3c1s
        FpseX2O1uLxrDpvFvTX/WS3WHrnLbrHgeAurxezGPkYHDo9Nnyaxe3S9vcLkcWLGbxaPzUvq
        Pdb9ecXk0bdlFaPHmQVH2D0+b5IL4IjSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaP
        tTIyVdK3s0lJzcksSy3St0vQy1i3v5u94B5XxcMbeg2M5zi6GDk5JARMJKaf/snYxcjFISSw
        lFFi3cJTzBAJGYmT0xpYIWxhiT/XuthAbCGBz4wS7/6WgdhsAoYSXW8h4iICcRIXXh9lAxnE
        LHCRUaJn31awhLCAncSUk61gg1gEVCV+v70DZvMK2Ehcm93LCLFAXmL1hgPMExh5FjAyrGIU
        SS0tzk3PLTbSK07MLS7NS9dLzs/dxAgM1G3Hfm7Zwdj1LvgQowAHoxIP74OL8tFCrIllxZW5
        hxglOJiVRHgnTFWIFuJNSaysSi3Kjy8qzUktPsRoCrR8IrOUaHI+MIrySuINTQ3NLSwNzY3N
        jc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwzlztE7ri2vcClj+nZkjtNGg57ZKUVJYv
        Kh97RPjzeWnxFU3FJaz/r4Sxf7M/J/+vfi6f8k/j6QsbtBfa7RK+m7Kk1vZkf+d6T1mlAyc4
        ay901MVrf/m9KOZn+zPJsrRin5+xgpx50qe7eURvlTnsfXh7s+i72G/vFec/Lpes5I6xXC/y
        LqBKiaU4I9FQi7moOBEAFSZDqGoCAAA=
Message-Id: <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
X-CMS-MailID: 20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cma_alloc() function has gfp mask parameter, so users expect that it
honors typical memory allocation related flags. The most imporant from
the security point of view is handling of __GFP_ZERO flag, because memory
allocated by this function usually can be directly remapped to userspace
by device drivers as a part of multimedia processing and ignoring this
flag might lead to leaking some kernel structures to userspace.
Some callers of this function (for example arm64 dma-iommu glue code)
already assumed that the allocated buffers are cleared when this flag
is set. To avoid such issues, add simple code for clearing newly
allocated buffer when __GFP_ZERO flag is set. Callers will be then
updated to skip implicit clearing or adjust passed gfp flags.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 mm/cma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 5809bbe360d7..1106d5aef2cc 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -464,6 +464,13 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		start = bitmap_no + mask + 1;
 	}
 
+	if (ret == 0 && gfp_mask & __GFP_ZERO) {
+		int i;
+
+		for (i = 0; i < count; i++)
+			clear_highpage(page + i);
+	}
+
 	trace_cma_alloc(pfn, page, count, align);
 
 	if (ret && !(gfp_mask & __GFP_NOWARN)) {
-- 
2.17.1

