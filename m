Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F9EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9233021470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="daxu2Bz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9233021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJDCuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:50:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJDCuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WfaXDH1t/nqC3tS6Sr15KeWJZhsOtic+vDj0DqqzZw0=; b=daxu2Bz/x8FJAVzxWRz06l5+8
        3Wr9Yj++I57WSPEJyTXOFF6v6frKPtgyOrxG1LtgWlsk61lJ4aTgHMw/Gi6g1hTWCyMnxXo3evPDr
        zZP6XGV8XE6r5stK8eiqA3ZkLzKrIcgGeE7IaorW+ThD1Uhl1qvgpICXAF78F1ylK6jBhX5sfNnS2
        V1+i/vb9ai5ckTCJ7PnU46WtKgajk+QbLNoC6SUSt6NScSVAp2a1J9jDoBc7edoljIP4tnXaYYvPJ
        HVwxUbZnzHO5H9xp487Fyji6PYlDuF1NghO7zsHTyd4JoTQrVLK/vBHPKRxYczzd9L0C7ySk/4Ij3
        N7cBX+OqQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7nJU-0004q9-KO; Wed, 03 Oct 2018 20:00:04 +0000
Date:   Wed, 3 Oct 2018 13:00:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux@armlinux.org.uk, miguel.ojeda.sandonis@gmail.com,
        robin@protonic.nl, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        heiko@sntech.de, airlied@linux.ie, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        m.szyprowski@samsung.com, keescook@chromium.org,
        treding@nvidia.com, mhocko@suse.com, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, mark.rutland@arm.com,
        aryabinin@virtuozzo.com, dvyukov@google.com,
        kstewart@linuxfoundation.org, tchibo@google.com, riel@redhat.com,
        minchan@kernel.org, peterz@infradead.org, ying.huang@intel.com,
        ak@linux.intel.com, rppt@linux.vnet.ibm.com,
        linux@dominikbrodowski.net, arnd@arndb.de, cpandya@codeaurora.org,
        hannes@cmpxchg.org, joe@perches.com, mcgrof@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
Message-ID: <20181003200003.GA9965@bombadil.infradead.org>
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 12:28:54AM +0530, Souptick Joarder wrote:
> These are the approaches which could have been taken to handle
> this scenario -
> 
> *  Replace vm_insert_page with vmf_insert_page and then write few
>    extra lines of code to convert VM_FAULT_CODE to errno which
>    makes driver users more complex ( also the reverse mapping errno to
>    VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
>    not preferred to introduce anything similar again)
> 
> *  Maintain both vm_insert_page and vmf_insert_page and use it in
>    respective places. But it won't gurantee that vm_insert_page will
>    never be used in #PF context.
> 
> *  Introduce a similar API like vm_insert_page, convert all non #PF
>    consumer to use it and finally remove vm_insert_page by converting
>    it to vmf_insert_page.
> 
> And the 3rd approach was taken by introducing vm_insert_kmem_page().
> 
> In short, vmf_insert_page will be used in page fault handlers
> context and vm_insert_kmem_page will be used to map kernel
> memory to user vma outside page fault handlers context.

As far as I can tell, vm_insert_kmem_page() is line-for-line identical
with vm_insert_page().  Seriously, here's a diff I just did:

-static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-                       struct page *page, pgprot_t prot)
+static int insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
+               struct page *page, pgprot_t prot)
-       /* Ok, finally just insert the thing.. */
-int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
+int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
-       return insert_page(vma, addr, page, vma->vm_page_prot);
+       return insert_kmem_page(vma, addr, page, vma->vm_page_prot);
-EXPORT_SYMBOL(vm_insert_page);
+EXPORT_SYMBOL(vm_insert_kmem_page);

What on earth are you trying to do?

