Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41390C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8302064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d7etUw/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8302064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbeIFSJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:09:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbeIFSJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:09:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w86DTR6T068889;
        Thu, 6 Sep 2018 13:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=jfEauDkiIlhDv4OBojkIPJcwx6Aotlu1wYe7j4efHtM=;
 b=d7etUw/x1GnWINmgbL4HfTFqCkQozzZgiWz4qW9qgSGEJYoVhjM25/nv/VhFIXbf5BdM
 RshgRy+tvVAJ+q9mcS0JeKuRUN54a46eeOi2WoFOlL2JsKcntfqSDjipezcvoDje3M38
 7EVQm3K3lXu1p+zxCrANVm/xPgAt6XWdbXvOMwc1FSpSb2ySh7NxcIjH0yWp4/kdttHn
 s6yPyn5nAC93Fb2cQ8F7DFuJ8ygUzsN4EJCBrcwNwSulnAM133uE2x8vhfZior9t6eFm
 zDTxH5gux9IDFdoU9cagf3/WNQKzyP1Kf5KEKGMwbsvq5DizERMV6xiC62Cs+F4heilu hg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2m7j6tv6bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 13:34:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w86DXuX3017541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 13:33:56 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w86DXtWK030931;
        Thu, 6 Sep 2018 13:33:55 GMT
Received: from kili.mountain (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Sep 2018 06:33:55 -0700
Date:   Thu, 6 Sep 2018 16:33:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Colin King <colin.king@canonical.com>
Subject: [PATCH] gpio: ep93xx: fix test for end of loop
Message-ID: <20180906133348.brzvqt53nzukn7n2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaHabhD_pW3XtDh+XzQ3d--r=qNRZVnhx44RV82p0boMA@mail.gmail.com>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=674
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that if port == ARRAY_SIZE() and "gc == &epg->gc[port]"
then that should be treated as invalid.

Fixes: fd935fc421e7 ("gpio: ep93xx: Do not pingpong irq numbers")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 68a416fc3141..b0699f57ddf5 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -80,7 +80,7 @@ static int ep93xx_gpio_port(struct gpio_chip *gc)
 		port++;
 
 	/* This should not happen but is there as a last safeguard */
-	if (gc != &epg->gc[port]) {
+	if (port == ARRAY_SIZE(epg->gc)) {
 		pr_crit("can't find the GPIO port\n");
 		return 0;
 	}
