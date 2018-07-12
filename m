Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F44ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A822083B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tZCM6w/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A822083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbeGLUtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:49:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56998 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeGLUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:49:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CKSnIi182548;
        Thu, 12 Jul 2018 20:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=gPTDMzEnXd+fcfEt6u+qktTSHeQD0hG2qgOYakm1Guk=;
 b=tZCM6w/nPBTHwjshn0GAA2DItL83EpfqXEoluLg8Z8MdCc61upTQKY5GWiNEqkYGy7oX
 cKHafi0JefChWHheIn/FN1FLfQ+Z/L8hTRS3uZzMDWFbgwtXy2plcBtvT4bfQei2nwOW
 MOts55773OS9MKVbxjdxT8QMnGZ3wSNBj+fsVmVBwEZwquBSu+NdP2tbsUZaetSrfyx8
 I3DfQWsQpsFPb9VBxhiEG6k2j84/8ZvrVotxzUx4zZ2YyYIKkPz/T3T63VcEE9WMP2G0
 0nKU2S5CUJuahYaVZYTnhS31ibhJt0n6l3ilSgRllHdguMJikWvunMkkaE47FMpEEsur mQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k2p765bv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 20:37:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6CKbiPs030301
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 20:37:44 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6CKbeoP017012;
        Thu, 12 Jul 2018 20:37:40 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 13:37:40 -0700
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
Subject: [PATCH v5 0/5] sparse_init rewrite
Date:   Thu, 12 Jul 2018 16:37:25 -0400
Message-Id: <20180712203730.8703-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=831
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
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
  mm/sparse: delete old sprase_init and enable new one

 include/linux/mm.h  |   7 +-
 mm/Kconfig          |   4 -
 mm/sparse-vmemmap.c |  59 +--------
 mm/sparse.c         | 300 +++++++++++++++-----------------------------
 4 files changed, 105 insertions(+), 265 deletions(-)

-- 
2.18.0

