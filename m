Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wvUMEt4TGVt4MgAAmS7hNA
	; Thu, 07 Jun 2018 11:15:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1F7DB608B8; Thu,  7 Jun 2018 11:15:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="miiSMOfp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7811C607DC;
	Thu,  7 Jun 2018 11:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7811C607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbeFGLPj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:15:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35184 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeFGLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:15:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w57BBPVW100419;
        Thu, 7 Jun 2018 11:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=dfyz2gqra2Fj2UIzJqJoTeNKwITu/FfO7R6AS9JWE3U=;
 b=miiSMOfp4AZs9um3dkTpnFXIi6w4ZbybpuPJ1HM2BTLQzw7jNbsWOuYE6ey1TFFPgtk+
 30B8AU69K6rA3GSjhS1Vz7JOuOsal71OAfD2pvePkP7PuSxXkadJ3ufOyQUFP+9WEpmX
 nCqQHelrG/G3ACtb88EqbY9nPmjSz6JTcg2zeSUtWHH+CmALpbKecU6S2a0AJtlrZMfB
 W/bhtQfNNKjApUAmqeIyQj9OiFe/pnuhWZnrh4dpfqcokNzAzwgUhszitAGDuBUe/69+
 zMWAdY2g3kuZN4EPxVrZYxAriyKRjtMo3klgVGlMafBGzBkwusCfPKytIfHHh2aEpPpn Nw==
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jbvyp8h7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jun 2018 11:15:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w57BF6Kc024410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 11:15:07 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w57BF3mf015899;
        Thu, 7 Jun 2018 11:15:03 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 04:14:58 -0700
From: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Hakon Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Wei Wang <wei.w.wang@intel.com>,
        Chris Mi <chrism@mellanox.com>,
        Eric Biggers <ebiggers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] IB:mad Use ID allocator routines to allocate agent number
Date: Thu,  7 Jun 2018 13:14:33 +0200
Message-Id: <20180607111435.17538-1-hans.westgaard.ry@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
References: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8916 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=497
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806070132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- Removed Oracle internal bug number information
v2:

- Implement ida_get_simple_cyclic and use it when allocating
  ib_mad_client_ids.

Hans Westgaard Ry (2):
  idr: Add ida_simple_get_cyclic
  IB/mad: Use ID allocator routines to allocate agent number

 drivers/infiniband/core/mad.c | 24 +++++++++++++---
 include/linux/idr.h           |  8 ++++--
 lib/idr.c                     | 66 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 6 deletions(-)

-- 
2.14.3
