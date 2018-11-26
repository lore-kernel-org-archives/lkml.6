Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B93C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559522082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O0QZ/4hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559522082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeKZTGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:06:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeKZTGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:06:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQ83W3G065120;
        Mon, 26 Nov 2018 08:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=qN6v4G0SguRO4WzKZHxSFVoE6mFC9MtgUvAXXDrwd98=;
 b=O0QZ/4hxySurWORUAWETRY9WgidIsUjlYFEiA6mnd41oUFoMcn57uhSDEOJ3Ib4KePwU
 +7ECG4PGwNxn2bCDQ3wobH9BQoTeWlm1hMqiUM7QAS61p/q/zBIdR0dNXHh0j37fIRs/
 hUomLEvetCRcdgXV5g/2QDxhUqbpcB9eGVLki73FoAkP3UArKQS7QnUoPZt7bW0uNdxL
 ez7efv/4BHeMj3+xysWN6Y1PnB3PCnson3gdoODmhtH9uc+qCAcAiKM8Iz/SIPjvPx3q
 P+RqrnhBF4Dmr/+9RMdBpS3V6/2FdUlCKZBUOfgdtP5rWxC0ZgmQovt3VWD3aB2JjA/k vw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9qv3g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 08:12:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAQ8Cjct008059
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 08:12:46 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAQ8CjYN006495;
        Mon, 26 Nov 2018 08:12:45 GMT
Received: from kili.mountain (/41.202.241.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 00:12:44 -0800
Date:   Mon, 26 Nov 2018 11:12:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>, Peng Hao <peng.hao2@zte.com.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] misc/pvpanic: fix a NULL vs IS_ERR() check
Message-ID: <20181126081229.zzgbambzjnbmmo7e@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9088 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=938
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap_resource() function doesn't return NULL, it returns
error pointers.

Fixes: 46f934c9a12f ("misc/pvpanic: add support to get pvpanic device info FDT")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/pvpanic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 01241ec6a5cd..595ac065b401 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -140,8 +140,8 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	base = devm_ioremap_resource(&pdev->dev, mem);
-	if (base == NULL)
-		return -EFAULT;
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &pvpanic_panic_nb);
-- 
2.11.0

