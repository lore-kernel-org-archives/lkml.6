Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15620ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F5B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h39gz+vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F5B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbeGZUyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:54:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42274 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbeGZUyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:54:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QJSQ0A149203;
        Thu, 26 Jul 2018 19:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=bVTATY/8BDhLbkA9mIha7thqBNFMjhkLxJwAAo4KRu0=;
 b=h39gz+vCpOKZbrPwKM4u45S6asYpZ0Y3feJWYPtehZUCgshaFHIxQQFK4wfJwG4hrIzO
 8U4QJMVVv3+p9hWtSolstek5lhBGkR4nEFeunG9y3+2aV30LBK1RwwVPSYphIrDbyTBg
 DW4fM+KpPhNhyi+u/vN74aD115d3l9jLBOSe+SAsSIEIDx1xrmBU8kQXvbICwdxJQtJW
 YmdhcoM/jBv8u/vbDog4jTNYCnTex/cgSjaU9ExmV8Yf3RWqUhBbYoL52/O3lWDXK4p6
 t6vKY1jdpnTgYKagM7frRKMKAs5SmzKRZL8GXYcmnAYWoVYKrIu3WgtgNm1AIfGQoFrQ bA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kbtbd4p3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:35:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJZH90012958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:35:17 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJZF9D002772;
        Thu, 26 Jul 2018 19:35:16 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:35:15 -0700
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
Subject: [PATCH v2 0/3] memmap_init_zone improvements
Date:   Thu, 26 Jul 2018 15:35:06 -0400
Message-Id: <20180726193509.3326-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8966 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=766
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

v1 - v2
	- Merged with linux-next
	- Removed inline from functions that have static variables.
	- Added a comment to defer_init() that it is called early in
	  boot and therefore no need to protect static.

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
 mm/page_alloc.c                 | 124 ++++++++++++++++----------------
 2 files changed, 62 insertions(+), 63 deletions(-)

-- 
2.18.0

