Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F87C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D19420831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFRdl2ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D19420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeKTC5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730162AbeKTC5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0B02086A;
        Mon, 19 Nov 2018 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645184;
        bh=/I429B/ea4r3vV6CbZRVAVHm4tajAJSeWBPh+WNw9AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFRdl2gel4CLoscFSeX4kQxsQsXiTzed6X4RNzwn5aWasy+1NxjcryrnxvzWZQqGn
         YZCdLQ7g94SGjnlJk5WMG33gouI6d7aL2dnoXUkB3Z18zblIpuZ9A4zYKq+UmoeCSd
         zuvb46l5LGDDDXAjE4fCCrYQVThBy0ST+9g0iysQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/205] staging: erofs: fix a missing endian conversion
Date:   Mon, 19 Nov 2018 17:25:36 +0100
Message-Id: <20181119162622.731665592@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
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

From: Gao Xiang <gaoxiang25@huawei.com>

[ Upstream commit 37ec35a6cc2b99eb7fd6b85b7d7b75dff46bc353 ]

This patch fixes a missing endian conversion in
vle_get_logical_extent_head.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/erofs/unzip_vle.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1490,6 +1490,7 @@ static erofs_off_t vle_get_logical_exten
 	unsigned long long ofs;
 	const unsigned int clusterbits = EROFS_SB(inode->i_sb)->clusterbits;
 	const unsigned int clustersize = 1 << clusterbits;
+	unsigned int delta0;
 
 	if (page->index != blkaddr) {
 		kunmap_atomic(*kaddr_iter);
@@ -1504,12 +1505,13 @@ static erofs_off_t vle_get_logical_exten
 	di = *kaddr_iter + vle_extent_blkoff(inode, lcn);
 	switch (vle_cluster_type(di)) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		BUG_ON(!di->di_u.delta[0]);
-		BUG_ON(lcn < di->di_u.delta[0]);
+		delta0 = le16_to_cpu(di->di_u.delta[0]);
+		DBG_BUGON(!delta0);
+		DBG_BUGON(lcn < delta0);
 
 		ofs = vle_get_logical_extent_head(inode,
 			page_iter, kaddr_iter,
-			lcn - di->di_u.delta[0], pcn, flags);
+			lcn - delta0, pcn, flags);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		*flags ^= EROFS_MAP_ZIPPED;


