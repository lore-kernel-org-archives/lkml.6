Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEBBC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AA1216F7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jU27pNKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AA1216F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeHOEhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:37:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42360 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeHOEhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:37:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7F1i4KC152946;
        Wed, 15 Aug 2018 01:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=BF6ckOX6D3HBEMe9A8vgqkrgM2FO83a6w0mt8vEOZ8g=;
 b=jU27pNKUc0S/I5G3N8+blbLCp3XEoQuWfeJV3KVIN97k5nLzHfF4Ws2haT/JgUJRRWnX
 Ly19pki3RsOAQpknhojNA/amizdU6b/xjSFwYjRcEph1bSUzu32Z7hGbsr1rmGF96X2h
 6jw1epvH3dtr9oA9E8lihyJeos9JTFpkR7ckEWIYNp6P0TLNtd5uNuMEEeC6j9dbJ7N4
 Wwkq5teTp2wqoeDDZRN+R4aogdDqoDvyDRxLpiTX+LzzKXKfQhRAy2gve831+5BcdY+Y
 3UVgQD+shjukve0y+X92zEPqglNK60yA2ZWEIBhu0N0G8MRAdJ0wbrhCQJ4zDTbNF269 ag== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2ksnad31ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 01:47:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7F1l2Rn020873
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 01:47:02 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7F1l2mg031462;
        Wed, 15 Aug 2018 01:47:02 GMT
Received: from linux.cn.oracle.com (/10.182.69.93)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Aug 2018 18:47:01 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     kvm@vger.kernel.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/1] vhost: change the signature of __vhost_get_user_slow()
Date:   Wed, 15 Aug 2018 09:46:40 +0800
Message-Id: <1534297600-2577-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8985 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=947
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808150017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'type' from the signature of __vhost_get_user_slow() as it is not
used.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/vhost/vhost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ed31145..f78d3bc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -807,8 +807,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
 }
 
 static void __user *__vhost_get_user_slow(struct vhost_virtqueue *vq,
-					  void __user *addr, unsigned int size,
-					  int type)
+					  void __user *addr, unsigned int size)
 {
 	int ret;
 
@@ -846,7 +845,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	if (uaddr)
 		return uaddr;
 
-	return __vhost_get_user_slow(vq, addr, size, type);
+	return __vhost_get_user_slow(vq, addr, size);
 }
 
 #define vhost_put_user(vq, x, ptr)		\
-- 
2.7.4

