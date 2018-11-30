Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E96A20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E96A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeLACXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:23:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbeLACXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:23:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUFCHvB038762
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:13:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p3621mvby-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:13:32 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 30 Nov 2018 15:11:31 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Nov 2018 15:11:29 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAUFBSBL58130570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 15:11:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63B3752054;
        Fri, 30 Nov 2018 15:11:28 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4343C5204E;
        Fri, 30 Nov 2018 15:11:28 +0000 (GMT)
Date:   Fri, 30 Nov 2018 16:11:27 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 13/73] s390/mm: fix mis-accounting of
 pgtable_bytes
In-Reply-To: <20181114222207.98701-13-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
        <20181114222207.98701-13-sashal@kernel.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18113015-0012-0000-0000-000002D2AFF8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18113015-0013-0000-0000-00002107FE1C
Message-Id: <20181130161127.4e936864@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811300129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 17:21:07 -0500
Sasha Levin <sashal@kernel.org> wrote:

> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> [ Upstream commit e12e4044aede97974f2222eb7f0ed726a5179a32 ]
> 
> In case a fork or a clone system fails in copy_process and the error
> handling does the mmput() at the bad_fork_cleanup_mm label, the
> following warning messages will appear on the console:
> 
>   BUG: non-zero pgtables_bytes on freeing mm: 16384
> 
> The reason for that is the tricks we play with mm_inc_nr_puds() and
> mm_inc_nr_pmds() in init_new_context().
> 
> A normal 64-bit process has 3 levels of page table, the p4d level and
> the pud level are folded. On process termination the free_pud_range()
> function in mm/memory.c will subtract 16KB from pgtable_bytes with a
> mm_dec_nr_puds() call, but there actually is not really a pud table.
> 
> One issue with this is the fact that pgtable_bytes is usually off
> by a few kilobytes, but the more severe problem is that for a failed
> fork or clone the free_pgtables() function is not called. In this case
> there is no mm_dec_nr_puds() or mm_dec_nr_pmds() that go together with
> the mm_inc_nr_puds() and mm_inc_nr_pmds in init_new_context().
> The pgtable_bytes will be off by 16384 or 32768 bytes and we get the
> BUG message. The message itself is purely cosmetic, but annoying.
> 
> To fix this override the mm_pmd_folded, mm_pud_folded and mm_p4d_folded
> function to check for the true size of the address space.
> 
> Reported-by: Li Wang <liwang@redhat.com>
> Tested-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

The fix for the page table accounting problem initially had four git commits:
a8874e7e8a "mm: make the __PAGETABLE_PxD_FOLDED defines non-empty"
1071fc5779 "mm: introduce mm_[p4d|pud|pmd]_folded"
6d212db119 "mm: add mm_pxd_folded checks to pgtable_bytes accounting functions"
e12e4044ae "s390/mm: fix mis-accounting of pgtable_bytes"

In the meantime a fifth git commit is needed to really fix it:
814cedbc0b "s390/mm: correct pgtable_bytes on page table downgrade"

The autoselect mechanism only pick up one of the initial four patches.
Not good. May I ask *WHY* this patch was picked out of the blue?

Same for 4.18-stable.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

