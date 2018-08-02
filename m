Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FDEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3E22150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3E22150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbeHBPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:00:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387411AbeHBPAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:00:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 85AFF22D19B6A;
        Thu,  2 Aug 2018 21:09:26 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.174) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Thu, 2 Aug 2018 21:09:21 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <bfields@fieldses.org>, <jlayton@kernel.org>,
        <trondmy@hammerspace.com>, <chuck.lever@oracle.com>,
        <nixiaoming@huawei.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] fs/nfsd: Delete invalid assignment statements in nfsd4_decode_exchange_id
Date:   Thu, 2 Aug 2018 20:32:45 +0800
Message-ID: <20180802123245.4276-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

READ_BUF(8);
dummy = be32_to_cpup(p++);
dummy = be32_to_cpup(p++);
...
READ_BUF(4);
dummy = be32_to_cpup(p++);

Assigning value to "dummy" here, but that stored value
is overwritten before it can be used.
At the same time READ_BUF() will re-update the pointer p.

delete invalid assignment statements

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: J. Bruce Fields <bfields@fieldses.org>
---
 fs/nfsd/nfs4xdr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a96843c..e669e20 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1390,10 +1390,8 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			p += XDR_QUADLEN(dummy);
 		}
 
-		/* ssp_window and ssp_num_gss_handles */
+		/* ignore ssp_window and ssp_num_gss_handles */
 		READ_BUF(8);
-		dummy = be32_to_cpup(p++);
-		dummy = be32_to_cpup(p++);
 		break;
 	default:
 		goto xdr_error;
-- 
2.10.1

