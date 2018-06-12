Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 500D9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9742089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bFnhuPV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9742089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbeFLMEw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:04:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50248 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932555AbeFLMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:04:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CBtwjW005185;
        Tue, 12 Jun 2018 12:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2017-10-26;
 bh=dqySys/KtvJm4GVvuxkMk9i2T8Q4gOemf0osXTv+xS4=;
 b=bFnhuPV+Fej/Zcv61uOQjaHmsHhNiX6od81A3zziRIHZ/0hISeEwa2Bqb8pFpil+zwxl
 sy6Y+cucicnuEpBso9jYDrhpsZbgc75cvibv8gr5qsAE9fBvZMwiEy4vbBqEI1swJ7LP
 Uzfz+ShLbhPdLdzjJATtROnRUPqhuZG/KfuFrEvHum/WxzXHz1qrixuDeGZryols4Vm2
 2+HpuLiu1uvvR8f05uCAf1TW3hUE9C0mmXwrDcnwloNKYqe72h6Zaxr+hyVqX6j+h0v/
 ryJlV44E06lwKYWGRc+ip8eDvAtlIp1DNFEfYMHIZApQFAPuItnqic3ua8TgSCjGhQjw CQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jg6b1hpt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 12:04:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5CC4ltX023148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 12:04:47 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CC4kpY003737;
        Tue, 12 Jun 2018 12:04:46 GMT
Received: from kili.mountain (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 05:04:45 -0700
Date:   Tue, 12 Jun 2018 15:04:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] test_overflow: fix an IS_ERR() vs NULL bug
Message-ID: <20180612120432.xqffkv7q74wnip5n@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=791
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

root_device_register() returns error pointers, it never returns NULL.

Fixes: ca90800a91ba ("test_overflow: Add memory allocation overflow tests")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index aecbbb217305..2278fe05a1b0 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -367,7 +367,7 @@ static int __init test_overflow_allocation(void)
 
 	/* Create dummy device for devm_kmalloc()-family tests. */
 	dev = root_device_register(device_name);
-	if (!dev) {
+	if (IS_ERR(dev)) {
 		pr_warn("Cannot register test device\n");
 		return 1;
 	}
