Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAD4C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A327A204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iuoEV8Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A327A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeIJN2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:28:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52812 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeIJN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:28:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8A8YJ6C028962;
        Mon, 10 Sep 2018 08:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=MFO2VU1zEdUNxzpwWtP66Q/mihchpAKIo2EXgJZ23AU=;
 b=iuoEV8Js6KWuL7SdKqujjIbqr91xrG4+JorOhX/PCCKrv+S3Hfk5IgzrUvtCbAy4wBZE
 y00+KYc6aO3g9nGJk0YaAWeH1HVjD8S3WNuqT69spE83so9KmC5G/EkJana9131nZhWj
 9h2JT5VP19paeclALfZKDxflwXPdin71+mUmS8woB6S5BW11LxoiUArucreHauq+AzID
 /P2vcHSNYIV97LnJJva0EVzguohaCefFORU7h4EbZUaGikB0W2G1Ko7VeVQMxLe/hsOm
 cFmNx1miA3xd+xhH4poDJD+gZSlOj/M3oAd5YU3WgEHUv2jOrhDOw+EU64oAk6bZpmUA Aw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mc72qce7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 08:35:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8A8ZKOf007101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 08:35:21 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8A8ZKTp017265;
        Mon, 10 Sep 2018 08:35:20 GMT
Received: from kili.mountain (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 01:35:19 -0700
Date:   Mon, 10 Sep 2018 11:35:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/hns: Fix an error code in hns_roce_v2_init_eq_table()
Message-ID: <20180910083511.egoljxb5rr3do6ue@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9011 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=678
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809100093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error code isn't set on this path.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0218c0f8c2a7..b84bfa48371d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5125,6 +5125,7 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 		create_singlethread_workqueue("hns_roce_irq_workqueue");
 	if (!hr_dev->irq_workq) {
 		dev_err(dev, "Create irq workqueue failed!\n");
+		ret = -ENOMEM;
 		goto err_request_irq_fail;
 	}
 
