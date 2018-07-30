Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61500FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB8920873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hAuYmLdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB8920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeG3HsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:48:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:26928 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeG3HsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:48:17 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180730061452epoutp0259d223cb9b7292229ea8bf34238070bd~GEOOSFVtS1349713497epoutp02m
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:14:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180730061452epoutp0259d223cb9b7292229ea8bf34238070bd~GEOOSFVtS1349713497epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532931292;
        bh=ZweHNJrLKzBpIbjnjV8yVQJdDIVnvDtMLUR/8CpKQeY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hAuYmLdnmAbznTcMMg70b/4SoTP9VEgNRhrkiGpxftXDQUlxf2ymUo0Qxw5hhgrwO
         4zr2OAayhdxpwEW2byFbeYkUl/J0lhcy7vXjOX1f/SUz/bz3OUwcoOlZEiPmH/DxFR
         s6pf6GugTCQnDBDFZVcCZ3d1N7SnDoLcjIHYZeOA=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.196]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20180730061452epcas5p4753bff3ab30bf6ded44b258f063f8950~GEONxf2dX1094910949epcas5p40;
        Mon, 30 Jul 2018 06:14:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.A2.04309.CDCAE5B5; Mon, 30 Jul 2018 15:14:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20180730061450epcas5p137fd022ec7fda83eeadea2102a62ae4f~GEOMmSYCD1391313913epcas5p1G;
        Mon, 30 Jul 2018 06:14:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180730061450epsmtrp121de2edb54db742de62397debf4ff834~GEOMiULif0793407934epsmtrp1R;
        Mon, 30 Jul 2018 06:14:50 +0000 (GMT)
X-AuditID: b6c32a4a-9cbff700000010d5-92-5b5eacdc7eaa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.7B.03889.ADCAE5B5; Mon, 30 Jul 2018 15:14:50 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180730061449epsmtip219d822d7a9e9f07694d01c1c14770dc1~GEOKzF7vV1811118111epsmtip2S;
        Mon, 30 Jul 2018 06:14:48 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH] drm/kms/atomic: Improved the func
 drm_atomic_set_crtc_for_connector
Date:   Mon, 30 Jul 2018 11:44:15 +0530
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmuu6dNXHRBmeWcVv0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lsVh7vpXF4u6Gs4wWy09fZ7Y4tvUSuwOXx+yGiyweO2fd
        ZffY/u0Bq8e8k4Ee97uPM3nsnLSXyaNvyypGj8+b5AI4olJtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKkUbGhrpGRqY6xkZAWnTWCsjU6CShNSMPb8mMxf0ClS8OSfawLiNt4uRg0NCwETi+aey
        LkYuDiGB3YwS3zc8YIZwPjFKND2czw7hfGOUuLqqm6WLkROs49iC40wQib2MEieXfWMHSQgJ
        fGGUmDo9H8RmAxk7ZwYrSJGIwEtGiZstZ1hBEswCpRIPbjYxg9jCAmESx779ApvKIqAqMWPC
        dWaIDXISN891gt0hIbCGTWJvcy8LyLG8AmUSPXMEIWpcJKbfWgNVLyzx6vgWdghbSuJlfxuU
        PZlRovmsH8Sc1YwSZy/2QiXsJVqmHACbySygKbF+lz7EbXwSvb+fMEHChVeio00IolpFYuWL
        w8ww4/8s6GKFsD0kNi6dzQZSLiQQK/Gl32ACo8wshJkLGBlXMUqmFhTnpqcWmxYY5aWW6xUn
        5haX5qXrJefnbmIEpzItrx2My875HGIU4GBU4uEVkIiLFmJNLCuuzD3EKMHBrCTCm3Q/NlqI
        NyWxsiq1KD++qDQntfgQoykwyCYyS4km5wPTbF5JvKGpkZmZgaWBqbGFmaGSOO8Hv+BoIYH0
        xJLU7NTUgtQimD4mDk6pBsblR5dM5hD6ylU516bkYPrBGg3/Xi/N3yq25dYTRfm2fRc96nP0
        RqZscyxbvrxdbKtzw9Nr62d6a75+w2i/6yzzBqW+e19Tq+Z9Xqr7Z/Wt/oUhLjk3m6T3tb+Q
        3KzhsWzxmiQzLS/BK4+rv8+aH3aiOZhhaWEe267zX4P+5rJfShE7Fuwq8kqJpTgj0VCLuag4
        EQAL7/YRewMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvO6tNXHRBo9mGlv0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lsVh7vpXF4u6Gs4wWy09fZ7Y4tvUSuwOXx+yGiyweO2fd
        ZffY/u0Bq8e8k4Ee97uPM3nsnLSXyaNvyypGj8+b5AI4orhsUlJzMstSi/TtErgy9vyazFzQ
        K1Dx5pxoA+M23i5GTg4JAROJYwuOM3UxcnEICexmlGif18MGkZCSWPZmG5QtLLHy33N2iKJP
        jBK3upuZQRJsQN3P58xgBUmICLxllGjdeZoFJMEsUClx7vlkRhBbWCBE4uu77WA2i4CqxIwJ
        18GaeQVcJQ7sv8wEsUFO4ua5TuYJjDwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefn
        bmIEB6CW1g7GEyfiDzEKcDAq8fBmSMVFC7EmlhVX5h5ilOBgVhLhTbofGy3Em5JYWZValB9f
        VJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBsdXgztfSK3cNDmasEK8Pe9+4
        hvdV2CwZMwWnZauf/GhscljG2npkeWuHQrFzaqJ46+Fts8+enqX24obzkh8a7Cs4MwJf9RXc
        +F0+7U/ZzWZzdgcDM4/5O9a1LX3xplhnZo5a08tKX14NrqQCu8Aeh3smh2WiJBY8jTm/n+nq
        7UfzjjyzvBn8WImlOCPRUIu5qDgRAD9jWcA8AgAA
Message-Id: <20180730061450epcas5p137fd022ec7fda83eeadea2102a62ae4f~GEOMmSYCD1391313913epcas5p1G@epcas5p1.samsung.com>
X-CMS-MailID: 20180730061450epcas5p137fd022ec7fda83eeadea2102a62ae4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180730061450epcas5p137fd022ec7fda83eeadea2102a62ae4f
References: <CGME20180730061450epcas5p137fd022ec7fda83eeadea2102a62ae4f@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a. Used drm_atomic_get_crtc_state instead of drm_atomic_get_new_crtc_state.
   Anyway new_state and state are same, this should make no difference.
   This change will make the code of this func and the func
   drm_atomic_set_crtc_for_plane similar.
b. Added error checking after this func call
c. Currently conn_state->crtc is getting assigned a value at two places
   We can just reduce this assignment to one

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 drivers/gpu/drm/drm_atomic.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 895741e..907fb2d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1552,16 +1552,16 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 		return 0;
 
 	if (conn_state->crtc) {
-		crtc_state = drm_atomic_get_new_crtc_state(conn_state->state,
+		crtc_state = drm_atomic_get_crtc_state(conn_state->state,
 							   conn_state->crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
 
 		crtc_state->connector_mask &=
 			~(1 << drm_connector_index(conn_state->connector));
 
 		drm_connector_put(conn_state->connector);
-		conn_state->crtc = NULL;
 	}
-
 	if (crtc) {
 		crtc_state = drm_atomic_get_crtc_state(conn_state->state, crtc);
 		if (IS_ERR(crtc_state))
@@ -1571,7 +1571,6 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 			1 << drm_connector_index(conn_state->connector);
 
 		drm_connector_get(conn_state->connector);
-		conn_state->crtc = crtc;
 
 		DRM_DEBUG_ATOMIC("Link connector state %p to [CRTC:%d:%s]\n",
 				 conn_state, crtc->base.id, crtc->name);
@@ -1579,7 +1578,7 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 		DRM_DEBUG_ATOMIC("Link connector state %p to [NOCRTC]\n",
 				 conn_state);
 	}
-
+	conn_state->crtc = crtc;
 	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_set_crtc_for_connector);
-- 
2.7.4

