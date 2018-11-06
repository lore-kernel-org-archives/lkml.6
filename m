Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6153AC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EF32083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UwXEUlf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EF32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbeKFMFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:05:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38612 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeKFMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:05:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA62eJix122035;
        Tue, 6 Nov 2018 02:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=oa+DUnv1fJwkv+yNXuYO6FYnjyvQjD4bzBbmtgpCS2M=;
 b=UwXEUlf7YQzQttZpBmUOajdMCu2fkae3+qrA6PYvep+p9rDrbohAk+0ylyAfkjs7izQH
 Q8d9Q+7rYrDUDNlQD2LWMo1BTBB3REHKlvTYVUTD6XGZVuZWK4/ojZ4P+IgNIsVEXxst
 4TX1HJSir7c7t2g6bSElF6lEeZPXuxdXguRf7BqnOM8l6XwztTGjj0dFfuqOo2uIO4wB
 athB/YGmY+c9GDKPM/YuTqfGNVfD2AUf6dF03xdKtpvo0P2YE44gDGhecJFVYEZeg62e
 nfBs4Bp0cenJhID8SQN4cEzfyWJlAy65tyQXPX7ybJ/je/S14BLm2Uur1LsDDyNK6BBK qQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nh4aqjgph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 02:42:26 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA62gOMJ030859
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 02:42:24 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA62gMqV004802;
        Tue, 6 Nov 2018 02:42:22 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 18:42:21 -0800
Date:   Mon, 5 Nov 2018 18:42:28 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        bsd@redhat.com, darrick.wong@oracle.com,
        dave.hansen@linux.intel.com, jgg@mellanox.com, jwadams@google.com,
        jiangshanlai@gmail.com, mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 06/13] vfio: parallelize vfio_pin_map_dma
Message-ID: <20181106024228.sxkn3s22mfkf7lcc@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-7-daniel.m.jordan@oracle.com>
 <20181105145141.6f9937f6@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105145141.6f9937f6@w520.home>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:51:41PM -0700, Alex Williamson wrote:
> On Mon,  5 Nov 2018 11:55:51 -0500
> Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> > +static int vfio_pin_map_dma_chunk(unsigned long start_vaddr,
> > +				  unsigned long end_vaddr,
> > +				  struct vfio_pin_args *args)
> >  {
> > -	dma_addr_t iova = dma->iova;
> > -	unsigned long vaddr = dma->vaddr;
> > -	size_t size = map_size;
> > +	struct vfio_dma *dma = args->dma;
> > +	dma_addr_t iova = dma->iova + (start_vaddr - dma->vaddr);
> > +	unsigned long unmapped_size = end_vaddr - start_vaddr;
> > +	unsigned long pfn, mapped_size = 0;
> >  	long npage;
> > -	unsigned long pfn, limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >  	int ret = 0;
> >  
> > -	while (size) {
> > +	while (unmapped_size) {
> >  		/* Pin a contiguous chunk of memory */
> > -		npage = vfio_pin_pages_remote(dma, vaddr + dma->size,
> > -					      size >> PAGE_SHIFT, &pfn, limit);
> > +		npage = vfio_pin_pages_remote(dma, start_vaddr + mapped_size,
> > +					      unmapped_size >> PAGE_SHIFT,
> > +					      &pfn, args->limit, args->mm);
> >  		if (npage <= 0) {
> >  			WARN_ON(!npage);
> >  			ret = (int)npage;
> > @@ -1052,22 +1067,50 @@ static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >  		}
> >  
> >  		/* Map it! */
> > -		ret = vfio_iommu_map(iommu, iova + dma->size, pfn, npage,
> > -				     dma->prot);
> > +		ret = vfio_iommu_map(args->iommu, iova + mapped_size, pfn,
> > +				     npage, dma->prot);
> >  		if (ret) {
> > -			vfio_unpin_pages_remote(dma, iova + dma->size, pfn,
> > +			vfio_unpin_pages_remote(dma, iova + mapped_size, pfn,
> >  						npage, true);
> >  			break;
> >  		}
> >  
> > -		size -= npage << PAGE_SHIFT;
> > -		dma->size += npage << PAGE_SHIFT;
> > +		unmapped_size -= npage << PAGE_SHIFT;
> > +		mapped_size   += npage << PAGE_SHIFT;
> >  	}
> >  
> > +	return (ret == 0) ? KTASK_RETURN_SUCCESS : ret;
> 
> Overall I'm a big fan of this, but I think there's an undo problem
> here.  Per 03/13, kc_undo_func is only called for successfully
> completed chunks and each kc_thread_func should handle cleanup of any
> intermediate work before failure.  That's not done here afaict.  Should
> we be calling the vfio_pin_map_dma_undo() manually on the completed
> range before returning error?

Yes, we should be, thanks very much for catching this.

At least I documented what I didn't do?  :)

> 
> > +}
> > +
> > +static void vfio_pin_map_dma_undo(unsigned long start_vaddr,
> > +				  unsigned long end_vaddr,
> > +				  struct vfio_pin_args *args)
> > +{
> > +	struct vfio_dma *dma = args->dma;
> > +	dma_addr_t iova = dma->iova + (start_vaddr - dma->vaddr);
> > +	dma_addr_t end  = dma->iova + (end_vaddr   - dma->vaddr);
> > +
> > +	vfio_unmap_unpin(args->iommu, args->dma, iova, end, true);
> > +}
> > +
> > +static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
> > +			    size_t map_size)
> > +{
> > +	unsigned long limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > +	int ret = 0;
> > +	struct vfio_pin_args args = { iommu, dma, limit, current->mm };
> > +	/* Stay on PMD boundary in case THP is being used. */
> > +	DEFINE_KTASK_CTL(ctl, vfio_pin_map_dma_chunk, &args, PMD_SIZE);
> 
> PMD_SIZE chunks almost seems too convenient, I wonder a) is that really
> enough work per thread, and b) is this really successfully influencing
> THP?  Thanks,

Yes, you're right on both counts.  I'd been using PUD_SIZE for a while in
testing and meant to switch it back to KTASK_MEM_CHUNK (128M) but used PMD_SIZE
by mistake.  PUD_SIZE chunks have made thread finishing times too spread out
in some cases, so 128M seems to be a reasonable compromise.

Thanks for the thorough and quick review.

Daniel
