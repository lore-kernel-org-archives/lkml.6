Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ABDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865E120850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l2hMccbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865E120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeLCOvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:51:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34278 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeLCOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:51:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3EmrfK009904;
        Mon, 3 Dec 2018 14:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=TAUiQ6aiT71zH98sRIu0a/+uH93BMf46X4X8ntKc2nI=;
 b=l2hMccbRt8lQSWAryblzBbqW9YmgkuXCXYpm6tzGjOqE/T+n2TPaUjtjZEoRIVl0mUoM
 BA6VTwxE1HSwV9clF6rvNNliWQWtxEy4IHOWTLkzhB6J9xlpdhqk6vBzrxYD8KJLTaZC
 GEPksCxbFQRZ4947lfp8+jiBXFaT9lPklWtVMBNOQHHAmeWhDL80ju033wss/YR74m0B
 tpsyZF2bMyb9z37Ms4xBZJmElYXCmbmC8ieFW444lLyVGLQ0vLwA4yoTFTZPvq1R1buT
 EH4Fwi5OxD4UuTS7QtLtkuoSdiVKraQJlCYkyI5OjIFEti83Nj8/FIpHT5+I9h8RsO4D vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2p3j8q6skk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 14:49:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB3Engi4012743
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 14:49:42 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB3EngOr029296;
        Mon, 3 Dec 2018 14:49:42 GMT
Received: from kili.mountain (/197.157.0.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 06:49:41 -0800
Date:   Mon, 3 Dec 2018 17:49:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: dmatest: fix a small memory leak in dmatest_func()
Message-ID: <20181203144933.uwkmm2sjs434t322@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently moved the test size tests around but it means we need to
adjust the error handling as well or we leak the "pq_coefs" memory.  I
updated the label name to reflect that we're freeing coefs.

Fixes: 787d3083caf8 ("dmaengine: dmatest: move size checks earlier in function")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/dma/dmatest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index e71aa1e3451c..28deaa084257 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -511,18 +511,18 @@ static int dmatest_func(void *data)
 	if ((src_cnt + dst_cnt) >= 255) {
 		pr_err("too many buffers (%d of 255 supported)\n",
 		       src_cnt + dst_cnt);
-		goto err_thread_type;
+		goto err_free_coefs;
 	}
 
 	if (1 << align > params->buf_size) {
 		pr_err("%u-byte buffer too small for %d-byte alignment\n",
 		       params->buf_size, 1 << align);
-		goto err_thread_type;
+		goto err_free_coefs;
 	}
 
 	thread->srcs = kcalloc(src_cnt + 1, sizeof(u8 *), GFP_KERNEL);
 	if (!thread->srcs)
-		goto err_srcs;
+		goto err_free_coefs;
 
 	thread->usrcs = kcalloc(src_cnt + 1, sizeof(u8 *), GFP_KERNEL);
 	if (!thread->usrcs)
@@ -800,7 +800,7 @@ static int dmatest_func(void *data)
 	kfree(thread->usrcs);
 err_usrcs:
 	kfree(thread->srcs);
-err_srcs:
+err_free_coefs:
 	kfree(pq_coefs);
 err_thread_type:
 	pr_info("%s: summary %u tests, %u failures %llu iops %llu KB/s (%d)\n",
-- 
2.11.0

