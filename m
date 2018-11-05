Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42342C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EC62085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EC62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeKFA00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:26:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729536AbeKFA00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:26:26 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5F69ag002377
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 10:06:17 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2njpy841ce-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:06:13 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Mon, 5 Nov 2018 15:04:06 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Nov 2018 15:04:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA5F41G37012834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 15:04:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 951C1AE057;
        Mon,  5 Nov 2018 15:04:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57EAEAE059;
        Mon,  5 Nov 2018 15:04:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  5 Nov 2018 15:04:01 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, zaslonko@linux.ibm.com
Subject: [PATCH v2 0/1] memory_hotplug: fix the panic when memory end is not
Date:   Mon,  5 Nov 2018 16:04:00 +0100
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18110515-0012-0000-0000-000002C3A4A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110515-0013-0000-0000-000020F7E3E2
Message-Id: <20181105150401.97287-1-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refers to the older thread:
https://marc.info/?t=153658306400001&r=1&w=2

I have tried to take the approaches suggested in the discussion like
simply ignoring unaligned memory to section memory much earlier or
initializing struct pages beyond the "end" but both had issues.

First I tried to ignore unaligned memory early by adjusting memory_end
value. But the thing is that kernel mem parameter parsing and memory_end
calculation take place in the architecture code and adjusting it afterwards
in common code might be too late in my view. Also with this approach we
might lose the memory up to the entire section(256Mb on s390) just because
of unfortunate alignment.

Another approach was to fix memmap_init() and initialize struct pages
beyond the end. Since struct pages are allocated section-wise we can try to
round the size parameter passed to the memmap_init() function up to the
section boundary thus forcing the mapping initialization for the entire
section. But then it leads to another VM_BUG_ON panic due to
zone_spans_pfn() sanity check triggered for the first page of each page
block from set_pageblock_migratetype() function:
 page dumped because: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
      Call Trace:
      ([<00000000003013f8>] set_pfnblock_flags_mask+0xe8/0x140)
       [<00000000003014aa>] set_pageblock_migratetype+0x5a/0x70
       [<0000000000bef706>] memmap_init_zone+0x25e/0x2e0
       [<00000000010fc3d8>] free_area_init_node+0x530/0x558
       [<00000000010fcf02>] free_area_init_nodes+0x81a/0x8f0
       [<00000000010e7fdc>] paging_init+0x124/0x130
       [<00000000010e4dfa>] setup_arch+0xbf2/0xcc8
       [<00000000010de9e6>] start_kernel+0x7e/0x588
       [<000000000010007c>] startup_continue+0x7c/0x300
      Last Breaking-Event-Address:
       [<00000000003013f8>] set_pfnblock_flags_mask+0xe8/0x1401
We might ignore this check for the struct pages beyond the "end" but I'm not
sure about further implications.
For now I suggest to stay with my original proposal fixing specific
functions for memory hotplug sysfs handlers.

Changes v1 -> v2:
* Expanded commit message to show both failing scenarious.
* Use 'pfn + i' instead of 'pfn' for zone_spans_pfn() check within
test_pages_in_a_zone() function thus taking CONFIG_HOLES_IN_ZONE into
consideration.

Mikhail Zaslonko (1):
  memory_hotplug: fix the panic when memory end is not on the section
    boundary

 mm/memory_hotplug.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.16.4

