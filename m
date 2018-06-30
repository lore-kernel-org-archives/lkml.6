Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A5AC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD80253E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wo30ILA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD80253E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755501AbeF3DKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 23:10:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60966 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755141AbeF3DKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 23:10:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5U39F5x056000;
        Sat, 30 Jun 2018 03:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2017-10-26;
 bh=enl21a6cSef3u6SMrHH8UYUZ7K0TQ9x9/lq7jwNHeds=;
 b=Wo30ILA6kjcemDuBkGlihLbES+7aODRj7iddlpXYQ9agtLLeVqUXsjMs2CqY8c1h8sLR
 ublrX/z7k1+SpJUMptQ+su79RUNecxs3V1xLkEfQujK7kn5QI/KYBhL5UbV5IjgWSb0u
 +LLkwQFXIcJgXqZgDmBv9BunKmHsO5s4msnkUDLptznWr1rKJrQZhZ7HTMwp6NPW8hWh
 8E5kA7Un3LYzC8Bef1Spo40I67k1s6cx+1DOxfVQTx4wQ23hOkq3Rp0BnmV/779blYJ8
 rND0sm5jZvQlxdE3gkX1w6vv/HFm5ZjCTOafXjZogt6/JjGu5OHSgKHNASdErx4pl5P0 UQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jwyccg475-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jun 2018 03:09:53 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5U39qBt023970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jun 2018 03:09:52 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5U39o06010427;
        Sat, 30 Jun 2018 03:09:50 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 20:09:50 -0700
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
Subject: [PATCH v2 0/2] sparse_init rewrite
Date:   Fri, 29 Jun 2018 23:09:42 -0400
Message-Id: <20180630030944.9335-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=548
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806300033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

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
 mm/sparse.c         | 282 +++++++++++++++-----------------------------
 3 files changed, 125 insertions(+), 210 deletions(-)

-- 
2.18.0

