Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F38CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB1220693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB1220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbeGFJng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:43:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753732AbeGFJnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:43:33 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7AA51DDAC82E0;
        Fri,  6 Jul 2018 17:43:19 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Fri, 6 Jul 2018
 17:43:14 +0800
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>,
        Jiangyiwen <jiangyiwen@huawei.com>
From:   piaojun <piaojun@huawei.com>
Subject: [PATCH] net/9p/client.c: put refcount of trans_mod in error case in
 parse_opts()
Message-ID: <5B3F39A0.2030509@huawei.com>
Date:   Fri, 6 Jul 2018 17:42:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From my test, the second mount will fail after umounting successfully.
The reason is that we put refcount of trans_mod in the correct case rather
than the error case in parse_opts() at last. That will cause the refcount
decrease to -1, and when we try to get trans_mod again in
try_module_get(), we could only increase refcount to 0 which will cause
failure as follows:
parse_opts
  v9fs_get_trans_by_name
    try_module_get : return NULL to caller which cause error

So we should put refcount of trans_mod in error case.

Fixes: 9421c3e64137ec ("net/9p/client.c: fix potential refcnt problem of trans module")

Signed-off-by: Jun Piao <piaojun@huawei.com>
---
 net/9p/client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 18c5271..5c13431 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -225,7 +225,8 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 	}

 free_and_return:
-	v9fs_put_trans(clnt->trans_mod);
+	if (ret)
+		v9fs_put_trans(clnt->trans_mod);
 	kfree(tmp_options);
 	return ret;
 }
-- 
