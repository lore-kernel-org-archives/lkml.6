Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B06C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBAB25DEC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBAB25DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeGBNht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:37:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752147AbeGBNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:37:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62DYgVL059652
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 09:37:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jykvgbcku-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:37:45 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <benh@au1.ibm.com>;
        Mon, 2 Jul 2018 14:37:43 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 14:37:40 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62DbdGA38404120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 13:37:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A552B5204E;
        Mon,  2 Jul 2018 14:37:23 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 046A052057;
        Mon,  2 Jul 2018 14:37:23 +0100 (BST)
Received: from pasglop (unknown [9.192.196.148])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D569CA01C1;
        Mon,  2 Jul 2018 23:37:36 +1000 (AEST)
Subject: Re: DMA mappings and crossing boundaries
From:   Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Russell Currey <ruscur@au1.ibm.com>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <jens.axboe@oracle.com>
Date:   Mon, 02 Jul 2018 23:37:36 +1000
In-Reply-To: <82688fc5-c294-1db3-9a05-fecf9b9b5e17@arm.com>
References: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel@au1.ibm.com>
         <82688fc5-c294-1db3-9a05-fecf9b9b5e17@arm.com>
Organization: IBM Australia
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18070213-0028-0000-0000-000002D74CD0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070213-0029-0000-0000-0000238EC962
Message-Id: <5f31e833851f5b9a58ca4ed9b5f0a1958cca0efd.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 14:06 +0100, Robin Murphy wrote:

 .../...

Thanks Robin, I was starting to depair anybody would reply ;-)

> > AFAIK, dma_alloc_coherent() is defined (Documentation/DMA-API-
> > HOWTO.txt) as always allocating to the next power-of-2 order, so we
> > should never have the problem unless we allocate a single chunk larger
> > than the IOMMU page size.
> 
> (and even then it's not *that* much of a problem, since it comes down to 
> just finding n > 1 consecutive unused IOMMU entries for exclusive use by 
> that new chunk)

Yes, this case is not my biggest worry.

> > For dma_map_sg() however, if a request that has a single "entry"
> > spawning such a boundary, we need to ensure that the result mapping is
> > 2 contiguous "large" iommu pages as well.
> > 
> > However, that doesn't fit well with us re-using existing mappings since
> > they may already exist and either not be contiguous, or partially exist
> > with no free hole around them.
> > 
> > Now, we *could* possibly construe a way to solve this by detecting this
> > case and just allocating another "pair" (or set if we cross even more
> > pages) of IOMMU pages elsewhere, thus partially breaking our re-use
> > scheme.
> > 
> > But while doable, this introduce some serious complexity in the
> > implementation, which I would very much like to avoid.
> > 
> > So I was wondering if you guys thought that was ever likely to happen ?
> > Do you see reasonable cases where dma_map_sg() would be called with a
> > list in which a single entry crosses a 256M or 1G boundary ?
> 
> For streaming mappings of buffers cobbled together out of any old CPU 
> pages (e.g. user memory), you may well happen to get two 
> physically-adjacent pages falling either side of an IOMMU boundary, 
> which comprise all or part of a single request - note that whilst it's 
> probably less likely than the scatterlist case, this could technically 
> happen for dma_map_{page, single}() calls too.

Could it ? I wouldn't think dma_map_page is allows to cross page
boundaries ... what about single() ? The main worry is people using
these things on kmalloc'ed memory

> Conceptually it looks pretty easy to extend the allocation constraints 
> to cope with that - even the pathological worst case would have an 
> absolute upper bound of 3 IOMMU entries for any one physical region - 
> but if in practice it's a case of mapping arbitrary CPU pages to 32-bit 
> DMA addresses having only 4 1GB slots to play with, I can't really see a 
> way to make that practical :(

No we are talking about 40-ish-bits of address space, so there's a bit
of leeway. Of course no scheme will work if the user app tries to map
more than the GPU can possibly access.

But with newer AMD adding a few more bits and nVidia being at 47-bits,
I think we have some margin, it's just that they can't reach our
discontiguous memory with a normal 'bypass' mapping and I'd rather not
teach Linux about every single way our HW can scatter memory accross
nodes, so an "on demand" mechanism is by far the most flexible way to
deal with all configurations.

> Maybe the best compromise would be some sort of hybrid scheme which 
> makes sure that one of the IOMMU entries always covers the SWIOTLB 
> buffer, and invokes software bouncing for the awkward cases.

Hrm... not too sure about that. I'm happy to limit that scheme to well
known GPU vendor/device IDs, and SW bouncing is pointless in these
cases. It would be nice if we could have some kind of guarantee that a
single mapping or sglist entry never crossed a specific boundary
though... We more/less have that for 4G already (well, we are supposed
to at least). Who are the main potential problematic subsystems here ?
I'm thinking network skb allocation pools ... and page cache if it
tries to coalesce entries before issuing the map request, does it ?

Ben.

> Robin.

