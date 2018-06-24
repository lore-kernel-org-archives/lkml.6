Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E58C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01DD24E18
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01DD24E18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeFXHdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:33:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751352AbeFXHdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:33:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5O7TI0R124216
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 03:32:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jt3p9d4hs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 03:32:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <benh@au1.ibm.com>;
        Sun, 24 Jun 2018 08:32:57 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 24 Jun 2018 08:32:55 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5O7WsLm32702686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 24 Jun 2018 07:32:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B39C4C04E;
        Sun, 24 Jun 2018 08:32:50 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18F0F4C04A;
        Sun, 24 Jun 2018 08:32:50 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 24 Jun 2018 08:32:50 +0100 (BST)
Received: from pasglop (unknown [9.192.185.131])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C3F37A01E9;
        Sun, 24 Jun 2018 17:32:50 +1000 (AEST)
Subject: DMA mappings and crossing boundaries
From:   Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell Currey <ruscur@au1.ibm.com>,
        Jens Axboe <jens.axboe@oracle.com>
Date:   Sun, 24 Jun 2018 17:32:50 +1000
Organization: IBM Australia
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18062407-4275-0000-0000-000002913805
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062407-4276-0000-0000-00003798908D
Message-Id: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=695 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806240093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks !

So due work around issues with devices having to strict limitations in
DMA address bits (GPUs ugh....) on POWER, we've been playing with a
mechanism that does dynamic mapping in the IOMMU but using a very large
IOMMU page size (256M on POWER8 and 1G on POWER9) for performances.

Now, with such page size, we can't just pop out new entries for every
DMA map, we need to try to re-use entries for mappings in the same
"area". 

We've prototypes something using refcounts on the entires. It does
imply some locking which is potentially problematic, and we'll be
looking at options there long run, but it works... so far.

My worry is that it will fail if we ever get a mapping request (or
coherent allocation request) that spawns one of those giant pages
boundaries. At least our current implementation.

AFAIK, dma_alloc_coherent() is defined (Documentation/DMA-API-
HOWTO.txt) as always allocating to the next power-of-2 order, so we
should never have the problem unless we allocate a single chunk larger
than the IOMMU page size.

For dma_map_sg() however, if a request that has a single "entry"
spawning such a boundary, we need to ensure that the result mapping is
2 contiguous "large" iommu pages as well.

However, that doesn't fit well with us re-using existing mappings since
they may already exist and either not be contiguous, or partially exist
with no free hole around them.

Now, we *could* possibly construe a way to solve this by detecting this
case and just allocating another "pair" (or set if we cross even more
pages) of IOMMU pages elsewhere, thus partially breaking our re-use
scheme.

But while doable, this introduce some serious complexity in the
implementation, which I would very much like to avoid.

So I was wondering if you guys thought that was ever likely to happen ?
Do you see reasonable cases where dma_map_sg() would be called with a
list in which a single entry crosses a 256M or 1G boundary ?

Cheers,
Ben.

