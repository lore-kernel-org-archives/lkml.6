Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A660CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636C6208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636C6208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbeGMUiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:38:02 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731616AbeGMUiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:38:02 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MWbbG-1fY8Y61Nbm-00Xenw; Fri, 13 Jul 2018 22:21:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ilya Dryomov <idryomov@gmail.com>, Yan Zheng <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@redhat.com>,
        Luis Henriques <lhenriques@suse.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ceph: use 64-bit timespec for r_stamp
Date:   Fri, 13 Jul 2018 22:18:38 +0200
Message-Id: <20180713201923.3200799-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180713201923.3200799-1-arnd@arndb.de>
References: <20180713201923.3200799-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ViBTVvcv6mtA6tWMTE3C1++AQdDD8EJTQLhA3P7Gr/IM7UQV8PX
 NRQVeP+QlJn3yUJoqeQ8p9shS7iUXbGaNuZvrMwDUV9614iU8bIGal79INUB+shszLUKzGW
 9pWP9/45bo4VeoyS5rbO9ZAMI+fI8a5ChAi/2tWXcwcESwhkuwmyRiQ4VtrySYC/JrWtPBQ
 132/K6P2V0mNV709UqiCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YTVzdVpeLD4=:6Tu33opsBOApxT2+NqL0Q+
 cYWMXQf+ca/h9L+CMWistrPEAFvyhZVOdFjyNNcPKc6mrBlio6lBRrfOv7Cphz7RW6YkFREvr
 jKcyD5b2hfbTSVR8LbFMkmYUpuJXvX3FqXVWuTDFu3RtSqqG6X0jtyVoWgifA74dTxlSdSnPu
 P2OxZpS7Z0/9LuU/8//yFTHQyBO04fkLGfGPhcnf7fI6edyrrWTV5kDOS3hZSVadnlZ/Fmmtm
 UWPWRz/BZPtJca0m/07a1Zzv/ILlHZJgBVoZyKllzyO+09TINn2rImcG6xDC4H0FLs1L3jh4y
 eojqsCCcsFr6pxt7yVltYsopIcAxA4B9W0TI6aIctLc/Omdwtg98/F3fNu6pSqVpoK380bYIL
 rElRtPa4HFcnTap7UyZgSjtr86+ZFHWyTOoz3+V9tAN5Cl9J9WgkFqD8XKdZf0961Z841OKpr
 qr0sXtQthUQQ+Nh37zYvyiAfxlsY7JRRzRgdpvsT2hg+/T/i/GF90qbuoTgyNxdUcWItKdoKy
 iGG9e0Osee5YesS5PxWXiIoliEJi3gcYuaE6NeGy8HNiCKaH9L/K2RHDcnaTtL3dMqmWr3nvY
 Xo1XD+GHZU8k265gGdpmbBhnR5PZ8nzqX697e2Dwlqo+On+WXYv+sh3aizYgSMLUfzATfWx0W
 irFxPMpaYPu0IqQ+TLR7r2KBHDfAS1cVgMUSH82n8WwUx4iENHbvxN2bTDWgaN1z7meI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ceph_mds_request stamp still uses the deprecated timespec structure,
this converts it over as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/inode.c      | 2 +-
 fs/ceph/mds_client.c | 7 +++----
 fs/ceph/mds_client.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 715a6f2a4613..d62f65f2875d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2136,7 +2136,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		req->r_inode_drop = release;
 		req->r_args.setattr.mask = cpu_to_le32(mask);
 		req->r_num_caps = 1;
-		req->r_stamp = timespec64_to_timespec(attr->ia_ctime);
+		req->r_stamp = attr->ia_ctime;
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 	}
 	dout("setattr %p result=%d (%s locally, %d remote)\n", inode, err,
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 580644b04737..09142d309912 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1799,8 +1799,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 
 	ktime_get_coarse_real_ts64(&ts);
-	req->r_stamp = timespec64_to_timespec(timespec64_trunc(ts,
-						mdsc->fsc->sb->s_time_gran));
+	req->r_stamp = timespec64_trunc(ts, mdsc->fsc->sb->s_time_gran);
 
 	req->r_op = op;
 	req->r_direct_mode = mode;
@@ -2097,7 +2096,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
 	/* time stamp */
 	{
 		struct ceph_timespec ts;
-		ceph_encode_timespec(&ts, &req->r_stamp);
+		ceph_encode_timespec64(&ts, &req->r_stamp);
 		ceph_encode_copy(&p, &ts, sizeof(ts));
 	}
 
@@ -2190,7 +2189,7 @@ static int __prepare_send_request(struct ceph_mds_client *mdsc,
 		p = msg->front.iov_base + req->r_request_release_offset;
 		{
 			struct ceph_timespec ts;
-			ceph_encode_timespec(&ts, &req->r_stamp);
+			ceph_encode_timespec64(&ts, &req->r_stamp);
 			ceph_encode_copy(&p, &ts, sizeof(ts));
 		}
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 2ec3b5b35067..80a7523e1523 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -229,7 +229,7 @@ struct ceph_mds_request {
 	int r_fmode;        /* file mode, if expecting cap */
 	kuid_t r_uid;
 	kgid_t r_gid;
-	struct timespec r_stamp;
+	struct timespec64 r_stamp;
 
 	/* for choosing which mds to send this request to */
 	int r_direct_mode;
-- 
2.9.0

