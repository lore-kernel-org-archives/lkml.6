Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B61DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E665120671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E665120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeJWRPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:15:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727602AbeJWRPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:15:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AADD1AD1A;
        Tue, 23 Oct 2018 08:53:15 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: add destination file data sync before doing any remote copy
Date:   Tue, 23 Oct 2018 09:53:14 +0100
Message-Id: <20181023085314.3561-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we try to copy into a file that was just written, any data that is remote
copied will be overwritten by our buffered writes once they are flushed.  When
this happens, the call to invalidate_inode_pages2_range will also return a
-EBUSY error.

This patch fixes this by also sync'ing the destination file before starting any
copy.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f788496fafcc..b4607baa8969 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1932,10 +1932,17 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	if (!prealloc_cf)
 		return -ENOMEM;
 
-	/* Start by sync'ing the source file */
+	/* Start by sync'ing the source and destination files */
 	ret = file_write_and_wait_range(src_file, src_off, (src_off + len));
-	if (ret < 0)
+	if (ret < 0) {
+		dout("failed to write src file (%zd)\n", ret);
+		goto out;
+	}
+	ret = file_write_and_wait_range(dst_file, dst_off, (dst_off + len));
+	if (ret < 0) {
+		dout("failed to write dst file (%zd)\n", ret);
 		goto out;
+	}
 
 	/*
 	 * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
