Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1097DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB82724889
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DT7KOKRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB82724889
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965951AbeF1Rdr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:33:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50372 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965048AbeF1Rdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:33:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5SHSTgb009848;
        Thu, 28 Jun 2018 17:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2017-10-26;
 bh=Uu1TXHVoCh1VJycZExMXiIp0BMZr175rrSkXntgkytg=;
 b=DT7KOKRNSaTdPMWMPc1aREqicmJSbrfnFSWD+3pFt3qV7PlAZhr/okQCQ7dI+rGvJE4/
 K/aTmG8yBEzooNscI14L3ldHN2gdPy8LXOEdIDEa32z4ioNWpUavKVhMS2v1iwC8Xcfk
 pn0FP1adtd0Ylb3Tqoz6PCOcyvhIg0Rhr7Tvz8aqvl1U8v8YP4n5252u/sQy/5e2xHA5
 8d//g+hNm/fIlb8cJslQjUkATQfoa3t4y9FTRkLgKNHQ4GympDzZRSAGHe9/W6Y3XIWH
 Ul/eayrLaEbJzlEBGKyF1+Cv/n9E5j8p4hBM3etPut928yCZWJ7WzRCGfRcj/TXySxAa Lg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jum5838fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 17:30:19 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5SHUIfD007226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 17:30:18 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5SHUFd2010468;
        Thu, 28 Jun 2018 17:30:16 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 10:30:15 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org
Subject: [PATCH v1 0/2] sparse_init rewrite
Date:   Thu, 28 Jun 2018 13:30:08 -0400
Message-Id: <20180628173010.23849-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=533
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sparse_init() we allocate two large buffers to temporary hold usemap and
memmap for the whole machine. However, we can avoid doing that if we
changed sparse_init() to operated on per-node bases instead of doing it on
the whole machine beforehand.

As shown by Baoquan
http://lkml.kernel.org/r/20180628062857.29658-1-bhe@redhat.com

The buffers are large enough to cause machine stop to boot on small memory
systems.

These patches should be applied on top of Baoquan's work, as
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER is removed in that work.

For the ease of review, I split this work so the first patch only adds new
interfaces, the second patch enables them, and removes the old ones.

Pavel Tatashin (2):
  mm/sparse: add sparse_init_nid()
  mm/sparse: start using sparse_init_nid(), and remove old code

 include/linux/mm.h  |   9 +-
 mm/sparse-vmemmap.c |  44 ++++---
 mm/sparse.c         | 285 ++++++++++++++------------------------------
 3 files changed, 125 insertions(+), 213 deletions(-)

-- 
2.18.0

