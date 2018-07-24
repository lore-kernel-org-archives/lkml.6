Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAE8C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F3020880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B46YZsE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F3020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbeGYBE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:04:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44410 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388426AbeGYBE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:04:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6ONs7RV101361;
        Tue, 24 Jul 2018 23:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=SrZSB0NymPZVESO9mhldWYECRmLCB6Qy+uaRQZPVRjc=;
 b=B46YZsE4AftOTHTdBEZyeU/dy3sSjKdtYUqtOYDKQMgK068KYx0jnjE+SVBzdL42d3sn
 1Sz/hG0mtJME5VlDOTgiUFcewEl/HT3VDdDMKtmzN4Af012sCOmbpO9T7WHKVTX5mdhd
 fa1SMBHfCfbP9bplz7W9SIGXY61dk8qaGfJBlA73LAhWKyHQAGfoK0LwT/x+kYU8Jf0j
 PhDkfNM+GPtU4LmkvqckbpDdk2vFy+EgHUItRydiPlKqb3BoYlNfVPTXpKY63PotQ47r
 /bFGWzqeA97wbVlDphUc/3KCn2rZW9Zpv9UZUC/aRWRqGC7o4n8DXeRzJRExN0aW+rLk XQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2kbwfpu7kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jul 2018 23:55:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6ONtTWH005365
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jul 2018 23:55:30 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6ONtQ9R025872;
        Tue, 24 Jul 2018 23:55:26 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 16:55:25 -0700
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
Subject: [PATCH 0/3] memmap_init_zone improvements
Date:   Tue, 24 Jul 2018 19:55:17 -0400
Message-Id: <20180724235520.10200-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=686
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807240248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three small patches that improve memmap_init_zone() and also fix a small
deferred pages bug.

The improvements include reducing number of ifdefs and making code more
modular.

The bug is the deferred_init_update() should be called after the mirrored
memory skipping is taken into account.

Pavel Tatashin (3):
  mm: make memmap_init a proper function
  mm: calculate deferred pages after skipping mirrored memory
  mm: move mirrored memory specific code outside of memmap_init_zone

 arch/ia64/include/asm/pgtable.h |   1 -
 mm/page_alloc.c                 | 115 +++++++++++++++-----------------
 2 files changed, 55 insertions(+), 61 deletions(-)

-- 
2.18.0

