Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752DDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4F820827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4F820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeKEUUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:20:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:51004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727275AbeKEUUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:20:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33FB2AF8D;
        Mon,  5 Nov 2018 11:00:51 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: quota: fix null pointer dereference in quota check
Date:   Mon,  5 Nov 2018 11:00:52 +0000
Message-Id: <20181105110052.31759-1-lhenriques@suse.com>
In-Reply-To: <20181101065318.2cylxol6d444nzeu@kili.mountain>
References: <20181101065318.2cylxol6d444nzeu@kili.mountain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a possible null pointer dereference in
check_quota_exceeded, detected by the static checker smatch, with the
following warning:

    fs/ceph/quota.c:240 check_quota_exceeded()
     error: we previously assumed 'realm' could be null (see line 188)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lkml.kernel.org/n/20181101065318.2cylxol6d444nzeu@kili.mountain
Fixes: b7a2921765cf ("ceph: quota: support for ceph.quota.max_files")
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/quota.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 32d4f13784ba..03f4d24db8fe 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -237,7 +237,8 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		ceph_put_snap_realm(mdsc, realm);
 		realm = next;
 	}
-	ceph_put_snap_realm(mdsc, realm);
+	if (realm)
+		ceph_put_snap_realm(mdsc, realm);
 	up_read(&mdsc->snap_rwsem);
 
 	return exceeded;
