Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26758C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17B5222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404442AbfBMQef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:34:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404089AbfBMQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:34:35 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DGYGsW115866
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:34:33 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmnswucxu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:34:30 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 13 Feb 2019 16:30:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Feb 2019 16:30:16 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1DGUFgm19857416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 16:30:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75C3642049;
        Wed, 13 Feb 2019 16:30:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 995ED42047;
        Wed, 13 Feb 2019 16:30:14 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Feb 2019 16:30:14 +0000 (GMT)
Date:   Wed, 13 Feb 2019 18:30:12 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
References: <20190123055414.GA4747@rapoport-lnx>
 <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx>
 <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
 <617e0d57-342d-4162-bd21-ece18e481d87@free.fr>
 <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
 <20190213085028.6199594b@canb.auug.org.au>
 <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
 <20190213065734.GA14425@rapoport-lnx>
 <5c9184f3-71c1-7875-52f7-616d299a9549@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c9184f3-71c1-7875-52f7-616d299a9549@free.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021316-0020-0000-0000-000003166604
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021316-0021-0000-0000-000021678C95
Message-Id: <20190213163012.GA6110@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=971 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:27:48AM +0100, Marc Gonzalez wrote:
> On 13/02/2019 07:57, Mike Rapoport wrote:
> 
> > Below is the version vs. current mmotm.
> > 
> > From 9ea6dceb46067d4f1cbbdbec1189c8496aa0a4bc Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > Date: Mon, 4 Feb 2019 15:37:21 +0100
> > Subject: [PATCH] of: fix kmemleak crash caused by imbalance in early memory reservation
> 
> Out of curiosity, why don't you send as a proper v3?
 
Was too much in a hurry

> > Marc Gonzalez reported the following kmemleak crash:
> > 
> > [...]
> > 
> > The crash happens when a no-map area is allocated in
> > early_init_dt_alloc_reserved_memory_arch(). The allocated region is
> > registered with kmemleak, but it is then removed from memblock using
> > memblock_remove() that is not kmemleak-aware.
> > 
> > Replacing __memblock_alloc_base() with memblock_find_in_range()
> 
> Nit: in this new version, you're replacing memblock_phys_alloc_range()
> with memblock_find_in_range() so I don't know if the comment still
> applies.

and didn't check the outcome of blindly applying the patch :(

I'll send a proper v3 soon. Sorry for the noise.
 
> > makes sure that the allocated memory is not added to kmemleak and then
> > memblock_remove()'ing this memory is safe.
> > 
> > As a bonus, since memblock_find_in_range() ensures the allocation in the
> > specified range, the bounds check can be removed.
> > 
> > Cc: stable@vger.kernel.org # 3.15+
> > Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
> > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Prateek Patel <prpatel@nvidia.com>
> > Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 

-- 
Sincerely yours,
Mike.

