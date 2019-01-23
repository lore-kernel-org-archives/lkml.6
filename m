Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B769320870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YLIz/SI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfAWOSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:18:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55628 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfAWOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:18:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NE46fI092844;
        Wed, 23 Jan 2019 14:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=z3pwMa4h9zXXCY53sAok6NuaOmQ7mwy4i3yvZxDP0p0=;
 b=YLIz/SI9wsMcaUT3lOLWm/bCeTyc0P0pyi0JMeJ+ZL67BgMtSDvU2itZbwGwc2hYsxu8
 mHO4+jqVWTxUS1dPOSxf4R5veFBZKbhCIUqPbjJF1lir4xLZM6kpxIcjPI1cKV9XU08p
 mIU/TVrcNBW3YSiHzjT6mWR9iBMk70WMs47YXN4UjC69Egn0S3aj2QGth3s2l9os65Sh
 JjbyCvJ6bGa8Z69vdWNGoShZOqDgG/RJatOstS12OdsoAhxxPmjCfsXA16T8BhWcNyIj
 xyM7Ki4czQZT5TYAKZlPgGrORMIcrH8wdtXD48RVPdoZqNWMXgUPQUvxgIlfPKAPtGdh VA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2q3uaut3df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:17:41 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NEHY2N029498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:17:35 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NEHXu6009959;
        Wed, 23 Jan 2019 14:17:33 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 06:17:33 -0800
Date:   Wed, 23 Jan 2019 09:16:35 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@docker.com>
Subject: Re: [RFC PATCH v7 04/16] swiotlb: Map the buffer if it was unmapped
 by XPFO
Message-ID: <20190123141614.GA19289@Konrads-MacBook-Pro.local>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <98f9b9be522d694d5a52640dd1dfbdd14ca6f8e5.1547153058.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f9b9be522d694d5a52640dd1dfbdd14ca6f8e5.1547153058.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 02:09:36PM -0700, Khalid Aziz wrote:
> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> 
> v6: * guard against lookup_xpfo() returning NULL
> 
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Signed-off-by: Tycho Andersen <tycho@docker.com>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

> ---
>  include/linux/xpfo.h |  4 ++++
>  kernel/dma/swiotlb.c |  3 ++-
>  mm/xpfo.c            | 15 +++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
> index a39259ce0174..e38b823f44e3 100644
> --- a/include/linux/xpfo.h
> +++ b/include/linux/xpfo.h
> @@ -35,6 +35,8 @@ void xpfo_kunmap(void *kaddr, struct page *page);
>  void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp);
>  void xpfo_free_pages(struct page *page, int order);
>  
> +bool xpfo_page_is_unmapped(struct page *page);
> +
>  #else /* !CONFIG_XPFO */
>  
>  static inline void xpfo_kmap(void *kaddr, struct page *page) { }
> @@ -42,6 +44,8 @@ static inline void xpfo_kunmap(void *kaddr, struct page *page) { }
>  static inline void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp) { }
>  static inline void xpfo_free_pages(struct page *page, int order) { }
>  
> +static inline bool xpfo_page_is_unmapped(struct page *page) { return false; }
> +
>  #endif /* CONFIG_XPFO */
>  
>  #endif /* _LINUX_XPFO_H */
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 045930e32c0e..820a54b57491 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -396,8 +396,9 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>  {
>  	unsigned long pfn = PFN_DOWN(orig_addr);
>  	unsigned char *vaddr = phys_to_virt(tlb_addr);
> +	struct page *page = pfn_to_page(pfn);
>  
> -	if (PageHighMem(pfn_to_page(pfn))) {
> +	if (PageHighMem(page) || xpfo_page_is_unmapped(page)) {
>  		/* The buffer does not have a mapping.  Map it in and copy */
>  		unsigned int offset = orig_addr & ~PAGE_MASK;
>  		char *buffer;
> diff --git a/mm/xpfo.c b/mm/xpfo.c
> index bff24afcaa2e..cdbcbac582d5 100644
> --- a/mm/xpfo.c
> +++ b/mm/xpfo.c
> @@ -220,3 +220,18 @@ void xpfo_kunmap(void *kaddr, struct page *page)
>  	spin_unlock(&xpfo->maplock);
>  }
>  EXPORT_SYMBOL(xpfo_kunmap);
> +
> +bool xpfo_page_is_unmapped(struct page *page)
> +{
> +	struct xpfo *xpfo;
> +
> +	if (!static_branch_unlikely(&xpfo_inited))
> +		return false;
> +
> +	xpfo = lookup_xpfo(page);
> +	if (unlikely(!xpfo) && !xpfo->inited)
> +		return false;
> +
> +	return test_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags);
> +}
> +EXPORT_SYMBOL(xpfo_page_is_unmapped);
> -- 
> 2.17.1
> 
