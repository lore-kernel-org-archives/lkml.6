Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436C0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7F62146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZkDOiXtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7F62146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeHBKPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:15:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeHBKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:15:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w728Nueb027941;
        Thu, 2 Aug 2018 08:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=q8muRu8lbaHpVKoe/uFElKCQ6kpDuQ21xLnYBbs4fM4=;
 b=ZkDOiXtCf9ZCbgTSIpkYOWHSdZlj9iHCXUy866JwrlZImt6pJW3T/9WhGXCZFBQp1VwS
 qpm6eG4jceEsC0+rQvpH6EwE7dV8LPV23/3D85nxYhWbmf29T0t60ZhK1pzt4ygDtI4P
 hWewdcluXIbKPvFIHbY2qK051tfMc5HkVRVv2vmRoHUoMuWWMTaWmIYkrXVnTJAI/p+O
 e/WuctHYEu9yWx5Jq5CJSP5I3kSS8GWkB50hAR98P4mq/ZpTR4lSAyIGJf0tpYBPJkgW
 R2xGygfreIQZo6fYMSpnvVMGc+3dzu7OnEDVDR4tySY6KcbxxtobvCPTYw/V0N9o9ej/ IA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kggepa3y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Aug 2018 08:24:55 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w728OtQD014535
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Aug 2018 08:24:55 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w728Osck020763;
        Thu, 2 Aug 2018 08:24:54 GMT
Received: from kili.mountain (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Aug 2018 01:24:54 -0700
Date:   Thu, 2 Aug 2018 11:24:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Hans J. Koch" <hjk@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] uio: potential double frees if __uio_register_device() fails
Message-ID: <20180802082447.rkdptfjxn5vyifbt@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8972 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808020090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uio_unregister_device() function assumes that if "info->uio_dev" is
non-NULL that means "info" is fully allocated.  Setting info->uio_de
has to be the last thing in the function.

In the current code, if request_threaded_irq() fails then we return with
info->uio_dev set to non-NULL but info is not fully allocated and it can
lead to double frees.

Fixes: beafc54c4e2f ("UIO: Add the User IO core code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 144cf7365288..cf388c384553 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -957,8 +957,6 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		goto err_uio_dev_add_attributes;
 
-	info->uio_dev = idev;
-
 	if (info->irq && (info->irq != UIO_IRQ_CUSTOM)) {
 		/*
 		 * Note that we deliberately don't use devm_request_irq
@@ -975,6 +973,7 @@ int __uio_register_device(struct module *owner,
 			goto err_request_irq;
 	}
 
+	info->uio_dev = idev;
 	return 0;
 
 err_request_irq:
