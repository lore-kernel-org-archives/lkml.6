Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A68AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12904204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kVl4ZRx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12904204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIJNbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:31:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeIJNbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:31:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8A8YPC5049511;
        Mon, 10 Sep 2018 08:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=V02W+xrWX+v1zqfK0uSjga+7RCLkKOvtqGoE0s2iC/E=;
 b=kVl4ZRx06rx2Rs+fpX1c+8BTJ/ISNQAz7eotLXJ2VI4+Qim1QUxn7bveOvdpBuatbVhi
 FLRfOjHi8/6Svf34A5356VqEFcRQxchA/KVnLvl0EjZcPO2MFAPZFiVI1IEyFGH1gnan
 pbueBMSG1/bAJYDtnabmjWZBNIvJksU3ySdut2pCl613T3MQKo69/YitQbRv8itpmGI3
 5LdvpyMswcjIkGaXaCD3lXEcKXjbchaiZcw2lmxtDBRgMLgvUJTxKlv7ylyPzv8Z6BNJ
 Plhvoa+tZ6pfb6plticJ0udlRa3kcczLGUVBTsBVIgciXyCNO3p3ELqwAya6xig9j9IU Gg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mc5ut4kuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 08:38:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8A8cPWE007438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 08:38:26 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8A8cPGQ027309;
        Mon, 10 Sep 2018 08:38:25 GMT
Received: from kili.mountain (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 01:38:24 -0700
Date:   Mon, 10 Sep 2018 11:38:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] vlynq: uninitialized return in vlynq_probe()
Message-ID: <20180910083817.l2xdfkxhrlml5q5q@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9011 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=832
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809100093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"result" isn't initialized on this error path.

Fixes: 55e331cf7ebe ("drivers: add support for the TI VLYNQ bus")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/vlynq/vlynq.c b/drivers/vlynq/vlynq.c
index c0227f9418eb..44d3485d1108 100644
--- a/drivers/vlynq/vlynq.c
+++ b/drivers/vlynq/vlynq.c
@@ -727,7 +727,8 @@ static int vlynq_probe(struct platform_device *pdev)
 	dev->local_irq = dev->irq_end - dev->irq_start;
 	dev->remote_irq = dev->local_irq - 1;
 
-	if (device_register(&dev->dev))
+	result = device_register(&dev->dev);
+	if (result)
 		goto fail_register;
 	platform_set_drvdata(pdev, dev);
 
