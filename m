Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A61C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8D3214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2oLKyoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8D3214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeKZV6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeKZV6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1119B2147D;
        Mon, 26 Nov 2018 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230266;
        bh=bwldbHRaS0kWyyQlVRdZLy8i/lpvYXbvhw+Qwxi2LnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2oLKyoMt8PD4TJAqHeaZqVSiut2v58SsS1MGTkn/qlu1PkylStp+jl3MLJCbEBU+
         KxFzdAH0Co4vvlXYgveMr5fLzQQDl42ZNvevLT7FEpX2C+QBKixCiXWR+xe2wYmLU6
         PS/h38fzXfx/TVivcUuQGVOtSEOlIUXrFNDKz7n4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Luis Henriques <lhenriques@suse.com>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/118] ceph: quota: fix null pointer dereference in quota check
Date:   Mon, 26 Nov 2018 11:51:03 +0100
Message-Id: <20181126105103.912978214@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 71f2cc64d027d712f29bf8d09d3e123302d5f245 ]

This patch fixes a possible null pointer dereference in
check_quota_exceeded, detected by the static checker smatch, with the
following warning:

   fs/ceph/quota.c:240 check_quota_exceeded()
    error: we previously assumed 'realm' could be null (see line 188)

Fixes: b7a2921765cf ("ceph: quota: support for ceph.quota.max_files")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
-- 
2.17.1



