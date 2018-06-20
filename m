Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B96C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F4820875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F4820875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbeFTPv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:51:27 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51759 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754253AbeFTPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:51:24 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LrGGm-1gCbMJ0OhY-0136Jc; Wed, 20 Jun 2018 17:51:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     y2038@lists.linaro.org, ceph-devel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@redhat.com>,
        Chengguang Xu <cgxu519@gmx.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ceph: stop using current_kernel_time()
Date:   Wed, 20 Jun 2018 17:50:34 +0200
Message-Id: <20180620155101.57685-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620155101.57685-1-arnd@arndb.de>
References: <20180620155101.57685-1-arnd@arndb.de>
X-Provags-ID: V03:K1:D9ZtQblntLhNlSNxx95Ziv1EwFCzG1gTeZhm7iqeQjldpcc9aIK
 xSCHjHeu8TWuYU3oGM0dH7ee6K5WquZqrFWy5XFB8o5IGyadwisnDRLmBD4cOmQANY3q4jn
 8YUAM71mFyVVAM0vxhhzM/eM77FMAF0/UscrFokm7sZ6p7vlBr8o+i5NcC+G95GRvVTDJRq
 +gs36UqlnDngiKwxC8UBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:31Ulfigi7cc=:f8aLhrP0Nedg+3p2MdcsbU
 TlSV+qIENnofJZHNQU+DasmvuIyJp71hOmZ/O1FhtAGAX/hL/p1PSKLnNtSxaJ7Rb8nzcwAHE
 sWJ4YlBzqg1HfUpnLdciNtGSBUbY/rl1K+BPBlPP6r4j4x53Rn18uNJmQOxoS2ztxpPqWHYKT
 Spcx8o/sAt6CEZ6DAOKJ9+MoSnLLj25UDVUZHuaMSQfbYPuK8nB3KpP0dyTgIv/mqjkC2Gui/
 RJu+pLLLWvUoUeKFHEQslpAvKmF/Oh9QpzOQTLaTNqR4PYUjb5pEXpx4gioUa0D5MhWs0WG3H
 tMjm9yRly0ZBj1nBBUAxVavTrl8b7bOC0tm+5+ltETHv8xH8da/larZVBpssREbWxU4xnd9wo
 ftiU3EFbPvgKjxPZ8aZlRZx286A6rcp/g5nzffOKBt0wpEGulz7RgNA0tbnpjdyJlN4w8XcrU
 ohslIXWPmWSjlv1FaWFfquQsECxw2wVNPnCs73ydlsoqKuJ0xnudIwsT8J81T2C0gzCfesIm/
 Tp5BsTmjHkT4QHj7r1AtDkgw4eUGcVatl+3on2MyTyTzTU0Ypcl/VT9b3n+9qcQGH677aNPU/
 8BZjpHik060EjlQwyYg+B1XHu00RSlPQNUQUQrbA2JzJ/JT2qiDD7fxKE0eVPzNB8EO1sO/Mj
 WKP8210Y/b6fdupt1MFbi8pWMzge+VWMgax2ZFmrsrS7RZTVYs3QzcyOD18+FtufUOcQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ceph_mdsc_create_request() is one of the last callers of the
deprecated current_kernel_time() as well as timespec_trunc().

This changes it to use the timespec64 based interfaces instead,
though we still need to convert the result until we are ready to
change over req->r_stamp.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/mds_client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index dc8bc664a871..69c839316a7a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1779,6 +1779,7 @@ struct ceph_mds_request *
 ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 {
 	struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
+	struct timespec64 ts;
 
 	if (!req)
 		return ERR_PTR(-ENOMEM);
@@ -1797,7 +1798,9 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	init_completion(&req->r_safe_completion);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 
-	req->r_stamp = timespec_trunc(current_kernel_time(), mdsc->fsc->sb->s_time_gran);
+	ktime_get_coarse_real_ts64(&ts);
+	req->r_stamp = timespec64_to_timespec(timespec64_trunc(ts,
+						mdsc->fsc->sb->s_time_gran));
 
 	req->r_op = op;
 	req->r_direct_mode = mode;
-- 
2.9.0

