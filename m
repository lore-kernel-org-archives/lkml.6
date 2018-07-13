Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0ADECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54391208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54391208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbeGMUfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:35:55 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43312 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeGMUfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:35:53 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LhoIM-1gRD8S4BuM-00n8K8; Fri, 13 Jul 2018 22:19:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ilya Dryomov <idryomov@gmail.com>, Yan Zheng <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@redhat.com>,
        Chengguang Xu <cgxu519@gmx.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ceph: stop using current_kernel_time()
Date:   Fri, 13 Jul 2018 22:18:35 +0200
Message-Id: <20180713201923.3200799-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180713201923.3200799-1-arnd@arndb.de>
References: <20180713201923.3200799-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/j+JY3+jfVfjGOtbATDBM/o31CE64ErEH/eIn/H9NrmAbOKBaSE
 LMlflK/97LxT6OYpFTn3GjucYJD2/WZ2I4xHpRCwvJT6B4PgqdwPSwm3l7uD6ZrrrsN05FF
 t1GLyV3j9ZFxLI4/XYR1sYINP81CSmGZB2Y2pfWUS6lZuIOP4O9Hg9PL85FMxNtIsrRbi40
 NMntwq+8ToKDTLGNh0ijw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cte//dIbqTE=:iqJwBejVae/WcCBpq1r2oO
 Y4n031ct2AtQYLaZhRvTIKcLlFSR4fjK2fGPZg3ZI6IpAj3OeTkMtgI5ZRUDV7pUAGhepnGBX
 1xzFHgd/aG4FW9sddI7Gz7ucIH239FNo3RkhTBH0uHdnZEln+phMeYCY6cOqV7kX1eKroudHU
 NBT9jMxBslYnJgen1Wqb0ziZUYlkz67peADmvb4zUs/AUcr9TOMSUEo6d7BcDKCaHUOOtql2O
 1RXfv9gEWtsVWEri+Qvts4b5OlgRY0pLKE/UbY4+LMPf/nP2fS/9cJjpClIKenR77mQRbnxrX
 pv+4bMx+yL2mZlWLjJK6ur8d3fuJxpHuxc9mh5BdXh5BqqIS13nkIK6mK8Nfan4bpv3s3h6ue
 JrCUwqPZVlugbLTIPygLvIFodkmt1/8m24xO9AK+8G/fbfFgk18qs0H17/u3qUZqSswKw+XkB
 G7zfKU+77rzP0U7WW1KxueMJneKLRt3VnFsDL7SwsYIhKcHxQlPbQTvgw1p7iD2CK4g82qd5k
 xRwllrxSK/N4Tr7bBPfUQjGadkQbIliI0/jXmPTDVyQlSgSHZznFjlWMemw2I3rDabCS8ROfX
 y72O9J3OMUw4wGF326INIJaEYaX0d+ZS/h+sZab7pf3g5Ds/cuFFVwSWhjaaZknK0SYWrRCeM
 cWxz/g5c1hq4eNZxT6ZMS3n2TliS+b8tbPMn/Tnat6qO0j41Rh5nScY0UOiGHM5qP9vk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ceph_mdsc_create_request() is one of the last callers of the
deprecated current_kernel_time() as well as timespec_trunc().

This changes it to use the timespec64 based interfaces instead,
though we still need to convert the result until we are ready to
change over req->r_stamp.

The output of the two functions, ktime_get_coarse_real_ts64() and
current_kernel_time() is the same coarse-granular timestamp,
the only difference here is that ktime_get_coarse_real_ts64()
doesn't overflow in 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add clarification that this is the same timestamp
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

