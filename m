Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90363FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCBB20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XS/aZZ5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCBB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeG3H2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:28:38 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:52217 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbeG3H2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:28:38 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180730055516epoutp033967709efed979dd45bab9683c429c67~GD9G85mfx2539525395epoutp03X
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 05:55:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180730055516epoutp033967709efed979dd45bab9683c429c67~GD9G85mfx2539525395epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532930116;
        bh=OrkvIA1IBryCv0nKA5NFS4dtnm4peGJumz02+T3L2X4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XS/aZZ5B3/cTx5d/ArM/w68GrY76tA/1Vr3fn449xQXtF1PHq3yxesEzK+jQPzhWR
         fLZEtiC3h88+CsqNDgEjjgZQnCZ9Qx7mP7oRgAJkOMbTXuepx9vZMOwBQln282VDlv
         TcU9bh+MB6CIMHXAHdEXbdVXO4uFp50m5Xpc92lQ=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.192]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20180730055516epcas5p1e435357445c398d6ae7acdc71d91c60d~GD9Gcor_B0653306533epcas5p11;
        Mon, 30 Jul 2018 05:55:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.E7.04304.448AE5B5; Mon, 30 Jul 2018 14:55:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20180730055515epcas5p3358ce6d5e80b66256ea92aa5659f74bb~GD9F1P8zb2847928479epcas5p3D;
        Mon, 30 Jul 2018 05:55:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180730055515epsmtrp1de37c8889c5ea203fd95e9d5318f7d0a~GD9FzrHlG0054000540epsmtrp14;
        Mon, 30 Jul 2018 05:55:15 +0000 (GMT)
X-AuditID: b6c32a4b-239ff700000010d0-49-5b5ea84431de
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.8A.03889.348AE5B5; Mon, 30 Jul 2018 14:55:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180730055513epsmtip2b678a5f6f4d9c64c9293d0e5096b5e9f~GD9D4fsFi1311913119epsmtip2i;
        Mon, 30 Jul 2018 05:55:13 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com,
        nishant.y08@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH] drm/kms/plane: Avoiding redundant checks in case of EDEADLK
 retries
Date:   Mon, 30 Jul 2018 10:48:36 +0530
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmlq7Lirhog/dzWC16z51ksrjy9T2b
        xc4Hu9gtXp1/w2xxedccNouFH7eyWPS9O85msfZ8K4vF3Q1nGS2Wn77ObHFs6yV2B26P2Q0X
        WTx2zrrL7rH92wNWj3knAz3udx9n8tg5aS+TR9+WVYwenzfJBXBEpdpkpCampBYppOYl56dk
        5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2qpFCWmFMKFApILC5W0rezKcov
        LUlVyMgvLrFVijY0NNIzNDDXMzIC0qaxVkamQCUJqRmrlhxkLVjJW7Gpaw1TA+M1ri5GTg4J
        AROJ59t3MnYxcnEICexmlFj+7ys7hPOJUeLspV8sIFVCAt8YJZY9y+pi5ADrWLcsBaJmL6PE
        qvkzobq/MErc2bKVHaSBDWTsnBmsIAkRgZeMEjdbzoA5zAJ9jBJH+x+zglQJC4RJnPn0A6yD
        RUBVYknrcnaIo+Qkbp7rZAZpkBDYwyax5F4PI0iCV6BMYsPOs1BFLhKzp/+GsoUlXh3fAmVL
        Sbzsb4OyJzNKNJ/1gxi0Guihi71QCXuJlikHWEAeYhbQlFi/Sx8kzCzAJ9H7+wkTxJ+8Eh1t
        QhDVKhIrXxxmhhn/Z0EXK4TtIXGi5wQbJIhiJWZtmsM0gVFmFsLQBYyMqxglUwuKc9NTi00L
        jPNSy/WKE3OLS/PS9ZLzczcxgpOblvcOxk3nfA4xCnAwKvHwCkjERQuxJpYVV+YeYpTgYFYS
        4U26HxstxJuSWFmVWpQfX1Sak1p8iNEUGGgTmaVEk/OBiTevJN7Q1MjMzMDSwNTYwsxQSZz3
        g19wtJBAemJJanZqakFqEUwfEwenVAOj+6Gk31EFvzo1IxLOTZOZk+h5z/vuVl8XvnuVRbKR
        /6pnHT8yZ+5umwP1F8O5+jJXZB7eWvl3Kffb9LV/s55IK//45sRzjGXWxDy+yzdCjge/zpVb
        Y/z/N1NL8pJtd5QSLJSPXL5x7edqgbpb803ZijRMT77b4MgRvPR7xTvvgw/ivZhK80tqlFiK
        MxINtZiLihMBnbezLYQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvK7zirhogxMd4ha9504yWVz5+p7N
        YueDXewWr86/Yba4vGsOm8XCj1tZLPreHWezWHu+lcXi7oazjBbLT19ntji29RK7A7fH7IaL
        LB47Z91l99j+7QGrx7yTgR73u48zeeyctJfJo2/LKkaPz5vkAjiiuGxSUnMyy1KL9O0SuDJW
        LTnIWrCSt2JT1xqmBsZrXF2MHBwSAiYS65aldDFycQgJ7GaUWL9sCXMXIydQXEpi2ZttbBC2
        sMTKf8/ZIYo+MUrcObCIFSTBBtT8fM4MVpCEiMBbRonWnadZQBxmgSmMEmtWnGcCqRIWCJFo
        P3+YEcRmEVCVWNK6nB3E5hVwlXj7+i0rxAo5iZvnOpknMPIsYGRYxSiZWlCcm55bbFhglJda
        rlecmFtcmpeul5yfu4kRHIxaWjsYT5yIP8QowMGoxMObIRUXLcSaWFZcmXuIUYKDWUmEN+l+
        bLQQb0piZVVqUX58UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUwWSYOTqkGxvAzkXaM
        ZvPb1b7/3PtArtRwofhso8jf2d+6TBPO3t95efaFbQuFbWy780X0zSsum8tueHzKyjOyvuKD
        tfeZ7o0+XU0B1kaq1+wfbg2wk+Hc3nWLNVnWaq7z8iva3xacsuv/2HbhbNLN74a91eduzH0m
        5JmqJGcs4zv3Q1JhjdSP2szuc/9dlFiKMxINtZiLihMB5vQD7EICAAA=
Message-Id: <20180730055515epcas5p3358ce6d5e80b66256ea92aa5659f74bb~GD9F1P8zb2847928479epcas5p3D@epcas5p3.samsung.com>
X-CMS-MailID: 20180730055515epcas5p3358ce6d5e80b66256ea92aa5659f74bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180730055515epcas5p3358ce6d5e80b66256ea92aa5659f74bb
References: <CGME20180730055515epcas5p3358ce6d5e80b66256ea92aa5659f74bb@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Currently, if modeset_lock is re-tried many times in case of EDEADLK
error, then this will be the code flow

retry:
	ret = drm_modeset_lock();

if (ret)-->this is true
		goto out;

out:
	if (fb)
	if (plane->old_fb)
	if (ret == -EDEADLK)
		goto retry;
It can be observed that checks on fb, old_fb are redundant
in retry-case.
If we keep if (ret == -EDEADLK) right after the out label,
that will avoid redundant checks.
It won't affect normal scenario (non-retry case).
2. Moved NULL assignment inside if statement related to NULL check

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 drivers/gpu/drm/drm_plane.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 0350544..ed42cd4 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -658,9 +658,10 @@ static int __setplane_internal(struct drm_plane *plane,
 	}
 
 out:
-	if (plane->old_fb)
+	if (plane->old_fb) {
 		drm_framebuffer_put(plane->old_fb);
-	plane->old_fb = NULL;
+		plane->old_fb = NULL;
+	}
 
 	return ret;
 }
@@ -1097,17 +1098,17 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 	}
 
 out:
-	if (fb)
-		drm_framebuffer_put(fb);
-	if (plane->old_fb)
-		drm_framebuffer_put(plane->old_fb);
-	plane->old_fb = NULL;
-
 	if (ret == -EDEADLK) {
 		ret = drm_modeset_backoff(&ctx);
 		if (!ret)
 			goto retry;
 	}
+	if (fb)
+		drm_framebuffer_put(fb);
+	if (plane->old_fb) {
+		drm_framebuffer_put(plane->old_fb);
+		plane->old_fb = NULL;
+	}
 
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
-- 
2.7.4

