Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC7AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409E821476
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gDXGgI7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409E821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeHBKc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:32:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33884 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:32:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w728cdYB003399;
        Thu, 2 Aug 2018 08:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=o31XMHtR5ST8rEzIeGhGvKHqn1AbKzkTU7u7/POb6No=;
 b=gDXGgI7ByIiQZlIBcPDsl0Af1Nk0k5i0iJJKN2q5QRHiF4wTLMmcRQNehXpX0I8TfQTh
 DkCf6cbdPkoZRWz7XJwgc46ER9C9XT1zCiuFj3JTTLxAonSF4ydTfijyiCB9+yqMhWz1
 LqYYCTCnK8pZltxzpcwB0gdjG2fVReiOcKk8bkbkh51+ki9stcOZ2a2J8n0UX78ATrqc
 2M3xfY4VAtwcavP1708XqgS2VKZzBmleW3z7c+pQN/xr6K/izAjAOTn9+WVLJ+ymj3Vk
 s/pDnO4WHtERm5CnYe6DuA4+Z1Zcx02qfwDm4MIlMfBQbZ8poePmR7iwjxVF2SNlqrv/ lA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kgh4qa4r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Aug 2018 08:42:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w728gVYE006928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Aug 2018 08:42:31 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w728gV2G027264;
        Thu, 2 Aug 2018 08:42:31 GMT
Received: from kili.mountain (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Aug 2018 01:42:30 -0700
Date:   Thu, 2 Aug 2018 11:42:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sudeep Dutt <sudeep.dutt@intel.com>
Cc:     Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] misc: mic: SCIF Fix scif_get_new_port() error handling
Message-ID: <20180802084222.xa3uwxld5en3cfzx@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8972 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=889
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808020092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only 2 callers of scif_get_new_port() and both appear to get
the error handling wrong.  Both treat zero returns as error, but it
actually returns negative error codes and >= 0 on success.

Fixes: e9089f43c9a7 ("misc: mic: SCIF open close bind and listen APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I have not tested this patch.  Please review carefully.

diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/scif_api.c
index 463f06d0b4ef..8dd0ccedeb94 100644
--- a/drivers/misc/mic/scif/scif_api.c
+++ b/drivers/misc/mic/scif/scif_api.c
@@ -371,11 +371,10 @@ int scif_bind(scif_epd_t epd, u16 pn)
 			goto scif_bind_exit;
 		}
 	} else {
-		pn = scif_get_new_port();
-		if (!pn) {
-			ret = -ENOSPC;
+		ret = scif_get_new_port();
+		if (ret < 0)
 			goto scif_bind_exit;
-		}
+		pn = ret;
 	}
 
 	ep->state = SCIFEP_BOUND;
@@ -649,13 +648,12 @@ int __scif_connect(scif_epd_t epd, struct scif_port_id *dst, bool non_block)
 			err = -EISCONN;
 		break;
 	case SCIFEP_UNBOUND:
-		ep->port.port = scif_get_new_port();
-		if (!ep->port.port) {
-			err = -ENOSPC;
-		} else {
-			ep->port.node = scif_info.nodeid;
-			ep->conn_async_state = ASYNC_CONN_IDLE;
-		}
+		err = scif_get_new_port();
+		if (err < 0)
+			break;
+		ep->port.port = err;
+		ep->port.node = scif_info.nodeid;
+		ep->conn_async_state = ASYNC_CONN_IDLE;
 		/* Fall through */
 	case SCIFEP_BOUND:
 		/*
