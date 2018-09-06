Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5BFC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBAB20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBAB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeIFRUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:20:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727609AbeIFRUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:20:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86CiO6B030180
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 08:45:04 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mb3vn9ydw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:45:03 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 13:45:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 13:44:57 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86CiuFs39125136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 12:44:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63E2911C04C;
        Thu,  6 Sep 2018 15:44:48 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53CB011C05B;
        Thu,  6 Sep 2018 15:44:47 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Sep 2018 15:44:47 +0100 (BST)
Date:   Thu, 6 Sep 2018 15:44:53 +0300
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
Subject: Re: [RFC PATCH 13/29] memblock: replace __alloc_bootmem_nopanic with
 memblock_alloc_from_nopanic
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-14-git-send-email-rppt@linux.vnet.ibm.com>
 <20180906075721.GV14951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906075721.GV14951@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090612-0020-0000-0000-000002C22D70
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090612-0021-0000-0000-0000210F63C2
Message-Id: <20180906124453.GE27492@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 09:57:21AM +0200, Michal Hocko wrote:
> On Wed 05-09-18 18:59:28, Mike Rapoport wrote:
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> The translation is simpler here but still a word or two would be nice.
> Empty changelogs suck.

This is one of the things left to sort out :)
 
> To the change
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> > ---
> >  arch/arc/kernel/unwind.c       | 4 ++--
> >  arch/x86/kernel/setup_percpu.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> > index 183391d..2a01dd1 100644
> > --- a/arch/arc/kernel/unwind.c
> > +++ b/arch/arc/kernel/unwind.c
> > @@ -181,8 +181,8 @@ static void init_unwind_hdr(struct unwind_table *table,
> >   */
> >  static void *__init unw_hdr_alloc_early(unsigned long sz)
> >  {
> > -	return __alloc_bootmem_nopanic(sz, sizeof(unsigned int),
> > -				       MAX_DMA_ADDRESS);
> > +	return memblock_alloc_from_nopanic(sz, sizeof(unsigned int),
> > +					   MAX_DMA_ADDRESS);
> >  }
> >  
> >  static void *unw_hdr_alloc(unsigned long sz)
> > diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
> > index 67d48e26..041663a 100644
> > --- a/arch/x86/kernel/setup_percpu.c
> > +++ b/arch/x86/kernel/setup_percpu.c
> > @@ -106,7 +106,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
> >  	void *ptr;
> >  
> >  	if (!node_online(node) || !NODE_DATA(node)) {
> > -		ptr = __alloc_bootmem_nopanic(size, align, goal);
> > +		ptr = memblock_alloc_from_nopanic(size, align, goal);
> >  		pr_info("cpu %d has no node %d or node-local memory\n",
> >  			cpu, node);
> >  		pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
> > @@ -121,7 +121,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
> >  	}
> >  	return ptr;
> >  #else
> > -	return __alloc_bootmem_nopanic(size, align, goal);
> > +	return memblock_alloc_from_nopanic(size, align, goal);
> >  #endif
> >  }
> >  
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

