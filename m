Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D84C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488282083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488282083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeFTPxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:53:09 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754504AbeFTPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:52:41 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M7Wjr-1gRkPb1N6F-00xGMl; Wed, 20 Jun 2018 17:52:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     y2038@lists.linaro.org, ceph-devel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ceph: use 64-bit timespec for r_stamp
Date:   Wed, 20 Jun 2018 17:50:37 +0200
Message-Id: <20180620155101.57685-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620155101.57685-1-arnd@arndb.de>
References: <20180620155101.57685-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ys71mwHTgJh5KNmV3E/6QWxtQV/Sz/hf4NtAdD83NniTNcu4UXk
 7WQMIYqa0I2Nq3qhGjNRhJ6usehKbPHXXfQQru7+cF1ArTLVaR/FFvLV7nkJC6boSoIf5+4
 cmyc9pEDkOMW26U1pNTXhQd09VOckBNCP3yyL6U0H9Eedyjfe+71bSAxMEV3Q8lK+Kbdt3w
 Kgn779X3JRHHM8v8ghyyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ID0eemQNOSQ=:BXbspyBpdfgTTigWm79oQX
 uUHk5p9TqHIJGTpBxPkYBzBePXcpZbsoo3GCqXM8YZt3yhgRkuzck7ST3CccPVYyD7WxM/6sJ
 XAGs4+o7DXqteqXfN/7Tx2O2cXmkKSCDfk9+ZM2ZLKtK6Wdt6Axwz8heiBrliEN2FfFg9C8cb
 XB3v0qEltE6JG/V4usMzpA5wUsTAQjyKuL1n6BbVPL0kYS2YJMEmVWlgFwj7Lq9ZFH1ofl7WJ
 1nvlQot/bjU3oHc3q6CI+H3uleKE6dw5Ot0sJHLkMV3VsW1YqYudHCNaLks1+P/ogI4YkTR27
 AkeXtIqH1fGpJuXQQq1KVl0AfudMdVbJ3rFQr56rTH0h2btj5e884Xsheaw/aoMlumNg8IFfw
 cAVXyLKjrGNP6T+unUqnM6GBw36e4Q+ueC4R1kLLDWKtjdJUK9PRVw8rmeU2MG8hqc0Kiq0wv
 io0L3W/V7CfqkQhVmBKvfpIeNPc7L5ZUphR/mQpiDL13QBFeJ5rZXHuLKwDaxX5bsYrKA7Cp4
 KKmxSKfjzP/Le+8/yzmzztvPjQBI17PhiLhr7BxfhB+2PTsd7DZjN3lQ03RzJW2qRespD8HcA
 H1sLBrvnMhiBN3gIvgF4hVoXzKW+OCLPXab7o4klHFJyQOqjNiyTQxjvsMQMQs4wNOdYt3zr0
 V1IAztVGwCVjI7AefmigzCKX6gAze0qG64Pb+qwCptH5hSG0jww0xeoZ8O2qDWQK53B4=
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
index d85f72bd585d..75fd2187833f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2135,7 +2135,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
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

