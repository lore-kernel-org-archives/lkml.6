Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FC7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F1620870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dkAk4+qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F1620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeGPSNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:13:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41568 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:13:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GHi0tF193394;
        Mon, 16 Jul 2018 17:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=dGLRO11TUlnhN0rnrj9E2MuNnkiQ4jBESUeyC58s6mc=;
 b=dkAk4+qc73M4TO9x9Zj7xslesA7vzWKiyQ1Z82Ufmz/e0s2aN0+EnbMl5OxiEkfwOATW
 89iBUA4CF2tYEjd+Tow5Gek9oj7iVb8t4O40tda/L6Ox3RJUXu7hxAkhe1bWWw+I1elG
 39dgqGKLHGYTTXPuUEyCNFaqgQ1UJLigvaW/kRUC1uq5tckzp6u3zrt7pCwEI3bK9xhL
 A+ZKnyk/P3pDBQEDCcUF/AZlzzsSC2YqAsJPLmuMd9B7jRBwMmstMUT7eqn3zQQx/8El
 /WdziNjAWNC/9vozD4aYU5FYTJFFLLvjZ2gdhAsbkQSbUMHLTJ6YVAXTz69FgIwgyE8z PA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2k7a3swhh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:44:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6GHitMG001389
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:44:55 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6GHirnx010514;
        Mon, 16 Jul 2018 17:44:53 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 10:44:52 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, pasha.tatashin@oracle.com,
        abdhalee@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH v6 0/5] sparse_init rewrite
Date:   Mon, 16 Jul 2018 13:44:42 -0400
Message-Id: <20180716174447.14529-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=899
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v6 - v5
	- Removed one more obsolete function, as Oscar noticed
	- Replaced BUG_ON with WARN_ON, ALIGN with PTR_ALIGN.
	- Added review-by, and test-by.

v5 - v4
	- Fixed the issue that was reported on ppc64 when
	  CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER is removed
	- Consolidated the new buffer allocation between vmemmap
	  and non-vmemmap variants of sparse layout.
	- Removed all review-by comments, because I had to do
	  significant amount of changes compared to previous version
	  and need another round of review.
	- I also would appreciate if those who reported problems with
	  PPC64 could test this change.
v4 - v3
	- Addressed comments from Dave Hansen
v3 - v1
	- Fixed two issues found by Baoquan He
v1 - v2
	- Addressed comments from Oscar Salvador

In sparse_init() we allocate two large buffers to temporary hold usemap and
memmap for the whole machine. However, we can avoid doing that if we
changed sparse_init() to operated on per-node bases instead of doing it on
the whole machine beforehand.

As shown by Baoquan
http://lkml.kernel.org/r/20180628062857.29658-1-bhe@redhat.com

The buffers are large enough to cause machine stop to boot on small memory
systems.

Another benefit of these changes is that they also obsolete
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER.

Pavel Tatashin (5):
  mm/sparse: abstract sparse buffer allocations
  mm/sparse: use the new sparse buffer functions in non-vmemmap
  mm/sparse: move buffer init/fini to the common place
  mm/sparse: add new sparse_init_nid() and sparse_init()
  mm/sparse: delete old sparse_init and enable new one

 include/linux/mm.h  |   7 +-
 mm/Kconfig          |   4 -
 mm/sparse-vmemmap.c |  59 +--------
 mm/sparse.c         | 314 ++++++++++++++------------------------------
 4 files changed, 102 insertions(+), 282 deletions(-)

-- 
2.18.0

