Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E37DC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA9524F82
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oRH2W4XF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA9524F82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932926AbeGBCEw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:04:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35344 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbeGBCEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:04:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6224PeH076403;
        Mon, 2 Jul 2018 02:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2017-10-26;
 bh=EGNF8dlaUY8MxQlPSFkWsLz6M1vTn2wvheGQlIJ263s=;
 b=oRH2W4XFuUiUamZ0YCtqkxNZDN7oh/+J+cAS3JRrY4kCddZg+WSTvt2R9DdYoAdzMU+q
 2Ccc5o8AF+yZyWA02rmmxIAqLySSijbTnIBUqEQdAT/QmHfDLzatYOA/ctp1JQRdcdQK
 9kywHnwlIprjbmdKRZzYGsHOvivBuvnHCMXiXC2AyJVWCaE0lSEY/qsFrufHpRmmLim9
 MXrM9HkQ/AoLzIuzF7voFzutXtMiIWL6IZ4yAHZ8YVGUOOJaqEVkatuw4g7FDYkyL+yz
 o1bmTI+PNHU5cJmf3Dqzcw014jEbopXlqMspS4gk92Ty9FZt8VQfNxWHEo7jyiiNhoGS Hg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jx2gptgx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Jul 2018 02:04:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6224OpQ028019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jul 2018 02:04:24 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6224MSr030350;
        Mon, 2 Jul 2018 02:04:22 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 19:04:22 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, pasha.tatashin@oracle.com
Subject: [PATCH v3 0/2] sparse_init rewrite
Date:   Sun,  1 Jul 2018 22:04:15 -0400
Message-Id: <20180702020417.21281-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=531
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
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

These patches should be applied on top of Baoquan's work, as
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER is removed in that work.

For the ease of review, I split this work so the first patch only adds new
interfaces, the second patch enables them, and removes the old ones.

Pavel Tatashin (2):
  mm/sparse: add sparse_init_nid()
  mm/sparse: start using sparse_init_nid(), and remove old code

 include/linux/mm.h  |   9 +-
 mm/sparse-vmemmap.c |  44 ++++---
 mm/sparse.c         | 279 +++++++++++++++-----------------------------
 3 files changed, 125 insertions(+), 207 deletions(-)

-- 
2.18.0

