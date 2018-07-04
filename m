Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F35C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1442473C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1442473C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbeGDHCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:02:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752810AbeGDHCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:02:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w646x320057291
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 03:02:24 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0n98gceb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:02:23 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 08:02:21 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 08:02:18 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6472Hkp34144498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 07:02:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6AB4AE064;
        Wed,  4 Jul 2018 10:02:18 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BFB6AE045;
        Wed,  4 Jul 2018 10:02:18 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 10:02:18 +0100 (BST)
Date:   Wed, 4 Jul 2018 10:02:14 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18070407-0012-0000-0000-000002868EDA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070407-0013-0000-0000-000020B80F46
Message-Id: <20180704070214.GA4352@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=890 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:57:22PM -0700, Andrew Morton wrote:
> On Tue,  3 Jul 2018 20:05:06 +0300 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > Most functions in memblock already use phys_addr_t to represent a physical
> > address with __memblock_free_late() being an exception.
> > 
> > This patch replaces u64 with phys_addr_t in __memblock_free_late() and
> > switches several format strings from %llx to %pa to avoid casting from
> > phys_addr_t to u64.
> >
> > ...
> > 
> > @@ -1343,9 +1343,9 @@ void * __init memblock_virt_alloc_try_nid_raw(
> >  {
> >  	void *ptr;
> >  
> > -	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=0x%llx max_addr=0x%llx %pF\n",
> > -		     __func__, (u64)size, (u64)align, nid, (u64)min_addr,
> > -		     (u64)max_addr, (void *)_RET_IP_);
> > +	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pF\n",
> > +		     __func__, (u64)size, (u64)align, nid, &min_addr,
> > +		     &max_addr, (void *)_RET_IP_);
> >  
> 
> Did you see all this checkpatch noise?
> 
> : WARNING: Deprecated vsprintf pointer extension '%pF' - use %pS instead
> : #54: FILE: mm/memblock.c:1348:
> : +	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pF\n",
> : +		     __func__, (u64)size, (u64)align, nid, &min_addr,
> : +		     &max_addr, (void *)_RET_IP_);
> : ...
> : 
 
Sorry, my bad...

>  * - 'S' For symbolic direct pointers (or function descriptors) with offset
>  * - 's' For symbolic direct pointers (or function descriptors) without offset
>  * - 'F' Same as 'S'
>  * - 'f' Same as 's'
> 
> I'm not sure why or when all that happened.
> 
> I suppose we should do that as a separate patch sometime.
> 

-- 
Sincerely yours,
Mike.

