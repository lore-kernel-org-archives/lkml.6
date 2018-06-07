Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 30dBAGgOGVutCQAAmS7hNA
	; Thu, 07 Jun 2018 10:52:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D7AC2608BA; Thu,  7 Jun 2018 10:52:57 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rth7hNDR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 471A560290;
	Thu,  7 Jun 2018 10:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 471A560290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeFGKwz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:52:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46804 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeFGKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:52:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w57AojR4025593;
        Thu, 7 Jun 2018 10:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=wcn5xdx1h+tX95DVlfy5wYNH8sbLfJdxTw/eeU7NFjA=;
 b=rth7hNDRi4BADcZtpW2dhZTnlUNyOAtdsVkfmvflPPwEfvhSnEi/eT5rXqcZD4nJixb/
 CONNwMfgm0okr3I/ZobESaMpnSKveRZ1f7fhYff000a4vVYt9RuWj/Uyed+Q18eiFHQr
 2QdP+ZqoL2e3NLFMhxYZmulunVFuMxwkKsbNEZh0KgsVHZSFV7jH45/t0qAjE7kzLcxc
 6JWuywsKrKH++IRJiE42EZKf0Es8MFRnYwzzpqqMIRFpQJALXyPljXn2fSPpaJeKJGqC
 Jvot3Kk4rbVoKiwJ+j3LavFlRSXESxPFiu2vdN8lBSA4RiCRBSDeLFjeeHA2w7mgKlL8 uA==
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jbvyprdpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jun 2018 10:52:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w57AqMTR012214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 10:52:22 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w57AqKfQ003761;
        Thu, 7 Jun 2018 10:52:20 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 03:52:19 -0700
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
Subject: [PATCH v2 0/2] IB:mad Use ID allocator routines to allocate agent number
Date: Thu,  7 Jun 2018 12:52:06 +0200
Message-Id: <20180607105208.16332-1-hans.westgaard.ry@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
References: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8916 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=549
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806070128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:

Implement ida_get_simple_cyclic and use it when allocating ib_mad_client_ids.

Hans Westgaard Ry (2):
  idr: Add ida_simple_get_cyclic
  IB/mad: Use ID allocator routines to allocate agent number

 drivers/infiniband/core/mad.c | 24 +++++++++++++---
 include/linux/idr.h           |  8 ++++--
 lib/idr.c                     | 66 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 6 deletions(-)

-- 
2.14.3
