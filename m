Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069BFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1108218A6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfAHIIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:08:31 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56113 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727368AbfAHIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:08:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01406;MF=zhabin@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0THn6-NU_1546934829;
Received: from localhost(mailfrom:zhabin@linux.alibaba.com fp:SMTPD_---0THn6-NU_1546934829)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Jan 2019 16:07:10 +0800
From:   Zha Bin <zhabin@linux.alibaba.com>
To:     stefanha@redhat.com
Cc:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gerry@linux.alibaba.com,
        kata-dev@lists.katacontainers.io
Subject: [PATCH] vhost/vsock: fix vhost vsock cid hashing inconsistent
Date:   Tue,  8 Jan 2019 16:07:03 +0800
Message-Id: <20190108080703.70050-1-zhabin@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vsock core only supports 32bit CID, but the Virtio-vsock spec define
CID (dst_cid and src_cid) as u64 and the upper 32bits is reserved as
zero. This inconsistency causes one bug in vhost vsock driver. The
scenarios is:

  0. A hash table (vhost_vsock_hash) is used to map an CID to a vsock
  object. And hash_min() is used to compute the hash key. hash_min() is
  defined as:
  (sizeof(val) <= 4 ? hash_32(val, bits) : hash_long(val, bits)).
  That means the hash algorithm has dependency on the size of macro
  argument 'val'.
  0. In function vhost_vsock_set_cid(), a 64bit CID is passed to
  hash_min() to compute the hash key when inserting a vsock object into
  the hash table.
  0. In function vhost_vsock_get(), a 32bit CID is passed to hash_min()
  to compute the hash key when looking up a vsock for an CID.

Because the different size of the CID, hash_min() returns different hash
key, thus fails to look up the vsock object for an CID.

To fix this bug, we keep CID as u64 in the IOCTLs and virtio message
headers, but explicitly convert u64 to u32 when deal with the hash table
and vsock core.

Fixes: 834e772c8db0 ("vhost/vsock: fix use-after-free in network stack callers")
Link: https://github.com/stefanha/virtio/blob/vsock/trunk/content.tex
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
---
 drivers/vhost/vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index bc42d38ae031..3fbc068eaa9b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -642,7 +642,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 		hash_del_rcu(&vsock->hash);
 
 	vsock->guest_cid = guest_cid;
-	hash_add_rcu(vhost_vsock_hash, &vsock->hash, guest_cid);
+	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
 	mutex_unlock(&vhost_vsock_mutex);
 
 	return 0;
-- 
2.19.1.856.g8858448bb

