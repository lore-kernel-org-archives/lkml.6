Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4263C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13FA214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfAJPDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:03:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfAJPDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:03:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C16CD2CD7FE;
        Thu, 10 Jan 2019 15:03:45 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18A727F1A2;
        Thu, 10 Jan 2019 15:03:45 +0000 (UTC)
Date:   Thu, 10 Jan 2019 10:03:43 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hmm: Convert to use vm_fault_t
Message-ID: <20190110150343.GA4394@redhat.com>
References: <20190110145900.GA1317@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190110145900.GA1317@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 10 Jan 2019 15:03:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:29:00PM +0530, Souptick Joarder wrote:
> convert to use vm_fault_t type as return type for
> fault handler.
> 
> kbuild reported warning during testing of
> *mm-create-the-new-vm_fault_t-type.patch* available in below link -
> https://patchwork.kernel.org/patch/10752741/
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.0-rc1 next-20190109]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> kernel/memremap.c:46:34: warning: incorrect type in return expression
>                          (different base types)
> kernel/memremap.c:46:34: expected restricted vm_fault_t
> kernel/memremap.c:46:34: got int
> 
> This patch has fixed the warnings and also hmm_devmem_fault() is
> converted to return vm_fault_t to avoid further warnings.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/hmm.h | 4 ++--
>  mm/hmm.c            | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 66f9ebb..ad50b7b 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -468,7 +468,7 @@ struct hmm_devmem_ops {
>  	 * Note that mmap semaphore is held in read mode at least when this
>  	 * callback occurs, hence the vma is valid upon callback entry.
>  	 */
> -	int (*fault)(struct hmm_devmem *devmem,
> +	vm_fault_t (*fault)(struct hmm_devmem *devmem,
>  		     struct vm_area_struct *vma,
>  		     unsigned long addr,
>  		     const struct page *page,
> @@ -511,7 +511,7 @@ struct hmm_devmem_ops {
>   * chunk, as an optimization. It must, however, prioritize the faulting address
>   * over all the others.
>   */
> -typedef int (*dev_page_fault_t)(struct vm_area_struct *vma,
> +typedef vm_fault_t (*dev_page_fault_t)(struct vm_area_struct *vma,
>  				unsigned long addr,
>  				const struct page *page,
>  				unsigned int flags,
> diff --git a/mm/hmm.c b/mm/hmm.c
> index a04e4b8..fe1cd87 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -990,7 +990,7 @@ static void hmm_devmem_ref_kill(struct percpu_ref *ref)
>  	percpu_ref_kill(ref);
>  }
>  
> -static int hmm_devmem_fault(struct vm_area_struct *vma,
> +static vm_fault_t hmm_devmem_fault(struct vm_area_struct *vma,
>  			    unsigned long addr,
>  			    const struct page *page,
>  			    unsigned int flags,
> -- 
> 1.9.1
> 
