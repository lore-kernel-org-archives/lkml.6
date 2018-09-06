Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A0DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C019020844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C019020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeIFRZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:25:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727514AbeIFRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:25:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86CmwYQ048992
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 08:49:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mb2c6p3dr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:49:54 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 13:49:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 13:49:48 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86Cnl4R43909146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 12:49:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E89E742045;
        Thu,  6 Sep 2018 15:49:41 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CED5942041;
        Thu,  6 Sep 2018 15:49:40 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Sep 2018 15:49:40 +0100 (BST)
Date:   Thu, 6 Sep 2018 15:49:44 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 14/29] memblock: add align parameter to
 memblock_alloc_node()
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-15-git-send-email-rppt@linux.vnet.ibm.com>
 <20180906080614.GW14951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906080614.GW14951@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090612-4275-0000-0000-000002B63917
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090612-4276-0000-0000-000037BF583B
Message-Id: <20180906124944.GF27492@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:06:14AM +0200, Michal Hocko wrote:
> On Wed 05-09-18 18:59:29, Mike Rapoport wrote:
> > With the align parameter memblock_alloc_node() can be used as drop in
> > replacement for alloc_bootmem_pages_node().
> 
> Why do we need an additional translation later? Sparse code which is the
> only one to use it already uses memblock_alloc_try_nid elsewhere
> (sparse_mem_map_populate).

It is also used in later patches to replace alloc_bootmem* in several
places and most of them explicitly set the alignment.
 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> >  include/linux/bootmem.h | 4 ++--
> >  mm/sparse.c             | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
> > index 7d91f0f..3896af2 100644
> > --- a/include/linux/bootmem.h
> > +++ b/include/linux/bootmem.h
> > @@ -157,9 +157,9 @@ static inline void * __init memblock_alloc_from_nopanic(
> >  }
> >  
> >  static inline void * __init memblock_alloc_node(
> > -						phys_addr_t size, int nid)
> > +		phys_addr_t size, phys_addr_t align, int nid)
> >  {
> > -	return memblock_alloc_try_nid(size, 0, BOOTMEM_LOW_LIMIT,
> > +	return memblock_alloc_try_nid(size, align, BOOTMEM_LOW_LIMIT,
> >  					    BOOTMEM_ALLOC_ACCESSIBLE, nid);
> >  }
> >  
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 04e97af..509828f 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -68,7 +68,7 @@ static noinline struct mem_section __ref *sparse_index_alloc(int nid)
> >  	if (slab_is_available())
> >  		section = kzalloc_node(array_size, GFP_KERNEL, nid);
> >  	else
> > -		section = memblock_alloc_node(array_size, nid);
> > +		section = memblock_alloc_node(array_size, 0, nid);
> >  
> >  	return section;
> >  }
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

