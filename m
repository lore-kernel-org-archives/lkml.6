Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D83C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4BB2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="maA0LgzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4BB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeJIUo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:44:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49412 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJIUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:44:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w99DNjhM114995;
        Tue, 9 Oct 2018 13:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=h1VeaCpm/fwQXKVhwVsySvQZxnVC/B1mE0jMY2yVsrw=;
 b=maA0LgzLrJghsvZHYy4yZ+ruAktkOOuWxHC8t2dxRvd8J1HoAvc75ZUYbx8xHcZG53WA
 spDF89jhN8kaMn/vdh/M9/wMEDVJ7F7EXHqZ6MORBJqJVQCJDnDVgNaY+qAK3tNQ//1A
 fwNo01THN3j3vlR61Lbpwq34rUonAW2m5katsD+fMgjuZ3ix24AYby70/tSNgjJQ/F1m
 Cfh+kB7twjhcMlVElRESP5rqVCXBXlM4Nl5MHc/yjjkHYVKPRxupoODfb+PWaXLEFvJz
 1ejGVA4DHN4uNW253hVTfcvjiGhnn/009G8E6uXUAy8rWQDkeQEiqZsCvf1XIB5d9Z2G Nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mxmftnaj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Oct 2018 13:27:56 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w99DRt4G001895
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Oct 2018 13:27:55 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w99DRtxl017345;
        Tue, 9 Oct 2018 13:27:55 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Oct 2018 13:27:54 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leon@kernel.org
Subject: [PATCH  v3 0/2] IB/mlx4: Enable debug print of SMPs and enhance output for MADs
Date:   Tue,  9 Oct 2018 15:27:38 +0200
Message-Id: <20181009132740.2210085-1-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9040 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=642
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810090133
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
v2 -> v3
   * Made v3 consistently for cover-letter and the two patches, my v2
     was partly original submission plus a v2. That probably fooled
     both the kbuild bot and patchwork

2.14.3
