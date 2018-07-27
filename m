Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F53C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE022089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dMdXqAWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE022089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeG0Mcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:32:43 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:53351 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbeG0Mcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:32:43 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180727111114epoutp01c62ae45a656590d998eb7e5f73051bc0~FNVH2js-o0488004880epoutp01n
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:11:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180727111114epoutp01c62ae45a656590d998eb7e5f73051bc0~FNVH2js-o0488004880epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532689874;
        bh=2rxVXV4IZyVD+7u190/rUBtSmE8Km16+XG+rERbsr2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMdXqAWBxs+SkTwLw4yWFmgwBmRjoSIeUvDhiUNphXXiyu8AcCFnIrDD4uvIEtlRD
         zTxYLCy1Vi1BtiPSOSHyW75cy9wINLma0MElGZMOdCk/q3OdQ9WefgSsrnR714mTNu
         ZdXUv+1VqE693SxqXVb9walSMFq6EP5u6VYBCXyo=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.195]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20180727111113epcas5p3f4c6fc421b39dd9ad35c0d89fb7a3031~FNVHSjb6G2447324473epcas5p3H;
        Fri, 27 Jul 2018 11:11:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.2C.04309.1DDFA5B5; Fri, 27 Jul 2018 20:11:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20180727111112epcas5p35e49be90453d18c560207d6ab34661ec~FNVGm5QCq0042200422epcas5p3X;
        Fri, 27 Jul 2018 11:11:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180727111112epsmtrp1945caf469dc584f5fb18de5477e7481e~FNVGlbx010700207002epsmtrp1K;
        Fri, 27 Jul 2018 11:11:12 +0000 (GMT)
X-AuditID: b6c32a4a-9b3ff700000010d5-c8-5b5afdd1ed78
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.95.03889.0DDFA5B5; Fri, 27 Jul 2018 20:11:12 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180727111111epsmtip1571545345effcf9abfad87356d95cfc7~FNVExqOkv2482624826epsmtip1F;
        Fri, 27 Jul 2018 11:11:10 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH v1] drm/kms/atomic: Using existing func for checking
 framebuffer dimensions
Date:   Fri, 27 Jul 2018 16:41:02 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <0fe3bbc5-d10b-7c95-e77d-f4cd5ee6016b@linux.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmlu7Fv1HRBouuqln0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lsVh7vpXF4u6Gs4wWy09fZ7Y4tvUSuwOXx+yGiyweO2fd
        ZffY/u0Bq8e8k4Ee97uPM3nsnLSXyaNvyypGj8+b5AI4olJtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKkUbGhrpGRqY6xkZAWnTWCsjU6CShNSM/knrmAs2C1T07m5gbWBcxdvFyMkhIWAice3p
        H6YuRi4OIYHdjBJbFz9mhHA+MUo0r3nKDOF8Y5T48PESK0zL+z8N7BCJvYwSB5cdYgFJCAl8
        YZRYc8MaxGYDKno+ZwYrSJGIwEtGiZstZ8C6mQVKJR7cbGIGsYUFYiUeHz/EDmKzCKhK/Do8
        nw1ig5zEzXOdYDWcAs4Sb1dsYwEZJCFwgk1i6f9jjCAJXoEyiXmfzzFDNLhIXNq9kAnCFpZ4
        dXwLO4QtJfGyvw3Kngz00Fk/iEGrGSXOXuyFSthLtEw5ALSBA+g6TYn1u/QhDuWT6P39hAkk
        LCHAK9HRJgRRrSKx8sVhZpjxfxZ0QUPFQ2Lhh5/Q4JrGKPHx2EGmCYyysxCmLmBkXMUomVpQ
        nJueWmxaYJSXWq5XnJhbXJqXrpecn7uJEZzstLx2MC4753OIUYCDUYmHN+B1ZLQQa2JZcWXu
        IUYJDmYlEd4114FCvCmJlVWpRfnxRaU5qcWHGE2BITiRWUo0OR+YiPNK4g1NjczMDCwNTI0t
        zAyVxHk/+AVHCwmkJ5akZqemFqQWwfQxcXBKNTByHC/0mS+Q8c1y37aH6bG5XCENMuGLwj86
        znLXXPdPkq86zJGBZfIShx9vLkqKffP6sv/ItVKrmBcPrwpMEOj1M/rE4tIcvP2no7FlxDrW
        F6HxqyLu9n7+rrWXqSd2lfx5JR/7CXdS94ozSOifrMp4sMrdas1srXyTBtErByOK6t+XPWpx
        m6fEUpyRaKjFXFScCAANENDqjAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnO6Fv1HRBptfmVn0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lsVh7vpXF4u6Gs4wWy09fZ7Y4tvUSuwOXx+yGiyweO2fd
        ZffY/u0Bq8e8k4Ee97uPM3nsnLSXyaNvyypGj8+b5AI4orhsUlJzMstSi/TtErgy+ietYy7Y
        LFDRu7uBtYFxFW8XIyeHhICJxPs/DewgtpDAbkaJuVNNIOJSEsvebGODsIUlVv57DlTDBVTz
        iVHi6IX/zCAJNqDm53NmsIIkRATeMkq07jzNApJgFqiUOPd8MmMXIweHsEC0xP9uI5Awi4Cq
        xK/D88GG8gq4SvTsW80MsUBO4ua5TjCbU8BZ4u2KbSwQBzlJzJ/UzDyBkW8BI8MqRsnUguLc
        9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgcNXS2sF44kT8IUYBDkYlHt6A15HRQqyJZcWVuYcY
        JTiYlUR411wHCvGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCU
        amAsC30bHlya0vzcvUzujh1LveSp2awaITc3bty3Oa1/efzbjSJeG68liU2V2FS/PWzznziX
        zxeyTTx9/K9zW0oGOBbr5upGrP48dd56zpVF7nyS2+Z8MlYJmvOLd5HEsa13fbYc42+/2Les
        eGd+SJ5p7NwLcy6dEj64puHn5C8yhkeiL37/zDpPiaU4I9FQi7moOBEAQhxNL1MCAAA=
Message-Id: <20180727111112epcas5p35e49be90453d18c560207d6ab34661ec~FNVGm5QCq0042200422epcas5p3X@epcas5p3.samsung.com>
X-CMS-MailID: 20180727111112epcas5p35e49be90453d18c560207d6ab34661ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180727111112epcas5p35e49be90453d18c560207d6ab34661ec
References: <0fe3bbc5-d10b-7c95-e77d-f4cd5ee6016b@linux.intel.com>
        <CGME20180727111112epcas5p35e49be90453d18c560207d6ab34661ec@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the func drm_atomic_plane_check, the fb geometry checking code
can be replaced by func drm_framebuffer_check_src_coords, this will
remove several redundant lines of code.

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 v1: Hi Mr Maarten, Thanks for the comments.
     I have splitted them into two patches.  

 drivers/gpu/drm/drm_atomic.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 895741e..953bd2a 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -909,7 +909,6 @@ plane_switching_crtc(struct drm_atomic_state *state,
 static int drm_atomic_plane_check(struct drm_plane *plane,
 		struct drm_plane_state *state)
 {
-	unsigned int fb_width, fb_height;
 	int ret;
 
 	/* either *both* CRTC and FB must be set, or neither */
@@ -954,24 +953,11 @@ static int drm_atomic_plane_check(struct drm_plane *plane,
 		return -ERANGE;
 	}
 
-	fb_width = state->fb->width << 16;
-	fb_height = state->fb->height << 16;
-
 	/* Make sure source coordinates are inside the fb. */
-	if (state->src_w > fb_width ||
-	    state->src_x > fb_width - state->src_w ||
-	    state->src_h > fb_height ||
-	    state->src_y > fb_height - state->src_h) {
-		DRM_DEBUG_ATOMIC("Invalid source coordinates "
-				 "%u.%06ux%u.%06u+%u.%06u+%u.%06u (fb %ux%u)\n",
-				 state->src_w >> 16, ((state->src_w & 0xffff) * 15625) >> 10,
-				 state->src_h >> 16, ((state->src_h & 0xffff) * 15625) >> 10,
-				 state->src_x >> 16, ((state->src_x & 0xffff) * 15625) >> 10,
-				 state->src_y >> 16, ((state->src_y & 0xffff) * 15625) >> 10,
-				 state->fb->width, state->fb->height);
-		return -ENOSPC;
-	}
-
+	ret = drm_framebuffer_check_src_coords(state->src_x, state->src_y,
+		state->src_w, state->src_h, state->fb);
+	if (ret)
+		return ret;
 	if (plane_switching_crtc(state->state, plane, state)) {
 		DRM_DEBUG_ATOMIC("[PLANE:%d:%s] switching CRTC directly\n",
 				 plane->base.id, plane->name);
-- 
2.7.4

