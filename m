Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE61CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610242086A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610242086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbeGWDal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:30:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731243AbeGWDal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:30:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 770C19CCD6888;
        Mon, 23 Jul 2018 10:31:45 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.174) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.382.0; Mon, 23 Jul 2018 10:31:39 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <bfields@fieldses.org>, <jlayton@kernel.org>,
        <chuck.lever@oracle.com>, <trondmy@hammerspace.com>,
        <andros@netapp.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>
Subject: [PATCH v2] fs/nfsd: Delete invalid assignment statements in nfsd4_decode_exchange_id
Date:   Mon, 23 Jul 2018 09:57:11 +0800
Message-ID: <20180723015711.27961-1-nixiaoming@huawei.com>
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
---
 fs/nfsd/nfs4xdr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a96843c..375ad4b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1392,8 +1392,6 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 
 		/* ssp_window and ssp_num_gss_handles */
 		READ_BUF(8);
-		dummy = be32_to_cpup(p++);
-		dummy = be32_to_cpup(p++);
 		break;
 	default:
 		goto xdr_error;
-- 
2.10.1

