Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F71C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99431213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99431213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJINuc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:50:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbeJINuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:50:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w996XwY5053283
        for <linux-kernel@vger.kernel.org>; Tue, 9 Oct 2018 02:35:09 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n0hmkatxw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:35:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 9 Oct 2018 07:35:06 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Oct 2018 07:35:03 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w996Z2O663504558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Oct 2018 06:35:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E78542047;
        Tue,  9 Oct 2018 09:34:39 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DEB742041;
        Tue,  9 Oct 2018 09:34:39 +0100 (BST)
Received: from osiris (unknown [9.152.212.171])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Oct 2018 09:34:39 +0100 (BST)
Date:   Tue, 9 Oct 2018 08:35:00 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG -next 20181008] list corruption with "mm/slub: remove useless
 condition in deactivate_slab"
X-TM-AS-GCONF: 00
x-cbid: 18100906-0016-0000-0000-000002105F59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100906-0017-0000-0000-00003267C348
Message-Id: <20181009063500.GB3555@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=762 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810090069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with linux-next for 20181008 I can reliably crash my system with lot's of
debugging options enabled on s390. List debugging triggers the list
corruption below, which I could bisect down to this commit:

fde06e07750477f049f12d7d471ffa505338a3e7 is the first bad commit
commit fde06e07750477f049f12d7d471ffa505338a3e7
Author: Pingfan Liu <kernelfans@gmail.com>
Date:   Thu Oct 4 07:43:01 2018 +1000

    mm/slub: remove useless condition in deactivate_slab

    The var l should be used to reflect the original list, on which the page
    should be.  But c->page is not on any list.  Furthermore, the current code
    does not update the value of l.  Hence remove the related logic

    Link: http://lkml.kernel.org/r/1537941430-16217-1-git-send-email-kernelfans@gmail.com
    Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
    Acked-by: Christoph Lameter <cl@linux.com>
    Cc: Pekka Enberg <penberg@kernel.org>
    Cc: David Rientjes <rientjes@google.com>
    Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

list_add double add: new=000003d1029ecc08, prev=000000008ff846d0,next=000003d1029ecc08.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:31!
illegal operation: 0001 ilc:1 [#1] PREEMPT SMP
Modules linked in:
CPU: 3 PID: 106 Comm: (sd-executor) Not tainted 4.19.0-rc6-00291-gfde06e077504 #21
Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
Krnl PSW : (____ptrval____) (____ptrval____) (__list_add_valid+0x98/0xa8)
           R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
Krnl GPRS: 0000000074311fdf 0000000080000001 0000000000000058 0000000000e7b8b2
           0000000000000000 0000000075438c64 00000000a7b31928 001c007b00000000
           000000008fe99d00 00000000a7b31b40 000003d1029ecc08 00000000a7c03a80
           000003d1029ecc08 000000008ff84680 00000000007b5674 00000000a7c03960
Krnl Code: 00000000007b5668: c0200034734a        larl    %r2,e43cfc
           00000000007b566e: c0e5ffd0cf51        brasl   %r14,1cf510
          #00000000007b5674: a7f40001            brc     15,7b5676
          >00000000007b5678: a7290001            lghi    %r2,1
           00000000007b567c: ebcff0a00004        lmg     %r12,%r15,160(%r15)
           00000000007b5682: 07fe                bcr     15,%r14
           00000000007b5684: 0707                bcr     0,%r7
           00000000007b5686: 0707                bcr     0,%r7
Call Trace:
([<00000000007b5674>] __list_add_valid+0x94/0xa8)
 [<000000000037d30e>] deactivate_slab.isra.15+0x45e/0x810
 [<000000000037ede4>] ___slab_alloc+0x76c/0x7c0
 [<000000000037eeb0>] __slab_alloc.isra.16+0x78/0xa8
 [<00000000003808c8>] kmem_cache_alloc+0x160/0x458
 [<0000000000141a3a>] vm_area_dup+0x3a/0x60
 [<0000000000142f0a>] copy_process+0xd72/0x2100
 [<000000000014449a>] _do_fork+0xba/0x688
 [<0000000000144bb0>] sys_clone+0x48/0x50
 [<0000000000b8faf0>] system_call+0xd8/0x2d0
INFO: lockdep is turned off.
Last Breaking-Event-Address:
 [<00000000007b5674>] __list_add_valid+0x94/0xa8

Kernel panic - not syncing: Fatal exception: panic_on_oops

