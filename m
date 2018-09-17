Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9211EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475EA20867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5G7jgnOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475EA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeIQXZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:25:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59086 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIQXZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:25:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8HHsC45128988;
        Mon, 17 Sep 2018 17:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=h1JZzBrF4PZlpeiePmKRDHPc9I67vlmJwNJXrhrvDyU=;
 b=5G7jgnOKZX3taKG6XBEjY/QsKJOwiSe7LbYYyB5vwiDKn4fRh4gYLjFF+BnY0Aji+3lb
 xaxDOwTYDqGtLJloy/v1j5IM1b8NB10JVypPkB/gBwSX8zC0oO2AbJiHj19v1QpqvCmn
 5Ay/iC2Ww5xJo+nyRqjXELGmJVYykC4NSBKPft39m3RzYFA6+TSzZTwpTNcA52cCgbDy
 AZO4R56PP0pU9vj2VvB2WlZVB+YBg6K6t3e5xZ0YWvpBhwbsn5X84Iif8qARqlAgCZED
 +CDWHz9MNNffcSmAB9iH7OHn9AsXleFuaciqzWD+7WvuMAY7qbS+RN+o25pXMuYn+Wxr +Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mgt1pfvw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 17:57:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8HHvD7W029281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 17:57:13 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8HHvDpU028469;
        Mon, 17 Sep 2018 17:57:13 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Sep 2018 10:57:12 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, yishaih@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca
Cc:     jackm@dev.mellanox.co.il
Subject: [PATCH v2 0/2] IB/mlx4: Enable debug print of SMPs and enhance output for MADs
Date:   Mon, 17 Sep 2018 19:56:56 +0200
Message-Id: <20180917175658.1261435-1-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=445
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMPs were not printed at all. Added printing of port number and TID to
all MADs





Håkon Bugge (2):
  IB/mlx4: Enable debug print of SMPs
  IB/mlx4: Add port and TID to MAD debug print

 drivers/infiniband/hw/mlx4/mad.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--

v1 -> v2
    * Fixed incorrect format for printing the TID for the second patch

2.14.3

