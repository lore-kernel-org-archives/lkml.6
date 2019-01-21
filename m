Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9975C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953712089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cKW1OxKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfAUOAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:00:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50814 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbfAUOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:00:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0LDrfaX080600;
        Mon, 21 Jan 2019 14:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=A4wVZmOOJCL8R0T9Pq1cwkdwDQB1+Kktn4+P/8BRZRg=;
 b=cKW1OxKRMnSU6i2nRge+05dTf+jVCruUkadvUnEqXh4OpSMNtDni/N5ANk2AhJukMEbU
 qvjvp0VFH3pEFU6ZKxenDOwMB9N/9RRbMMxaeZ2JvSrRYFqQDboIIIUVMyD6UcKIlHQU
 lgwkjB9dZhDlbuCh8Pl8kixxMhrL4BgDUmsY/+ZicdiivYh0pr9480K38yhMSwu9jANl
 SEq/dT3sdZ0MeCNzrl3E/FZ/zDFaMzMkdcz8qUUBtxx8IyAYMRZDYnlsAnmN2C901jEw
 x1iUK5qgZqlWSSPNdFhtIowMXMmC+JiUjnGNh5Ats3bIRdOmjdHNwoCVTlXYahgnQv9I 5Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2q3uauexjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jan 2019 14:00:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0LE0Woq012188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jan 2019 14:00:32 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0LE0WMC008989;
        Mon, 21 Jan 2019 14:00:32 GMT
Received: from kadam (/197.157.34.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jan 2019 06:00:31 -0800
Date:   Mon, 21 Jan 2019 17:00:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] lib/test_kmod: Potential double free in error handling
Message-ID: <20190121140011.GA14283@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9142 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901210110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a copy and paste bug so we set "config->test_driver" to NULL
twice instead of setting "config->test_fs".  Smatch complains that it
leads to a double free:

lib/test_kmod.c:840 __kmod_config_init() warn: 'config->test_fs' double freed

Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/test_kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index d82d022111e0..9cf77628fc91 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -632,7 +632,7 @@ static void __kmod_config_free(struct test_config *config)
 	config->test_driver = NULL;
 
 	kfree_const(config->test_fs);
-	config->test_driver = NULL;
+	config->test_fs = NULL;
 }
 
 static void kmod_config_free(struct kmod_test_device *test_dev)
-- 
2.17.1

