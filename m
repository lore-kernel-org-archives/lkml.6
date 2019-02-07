Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F053C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4154E2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfBGVIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:08:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfBGVIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:08:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA6001BD946;
        Thu,  7 Feb 2019 21:08:42 +0000 (UTC)
Received: from redhat.com (ovpn-123-55.rdu2.redhat.com [10.10.123.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id 215F65DF49;
        Thu,  7 Feb 2019 21:08:32 +0000 (UTC)
Date:   Thu, 7 Feb 2019 16:08:32 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, dodgen@google.com, konrad.wilk@oracle.com,
        dhildenb@redhat.com, aarcange@redhat.com
Subject: Re: [RFC][Patch v8 4/7] KVM: Disabling page poisoning to prevent
 corruption
Message-ID: <20190207160506-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-5-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204201854.2328-5-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 07 Feb 2019 21:08:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 03:18:51PM -0500, Nitesh Narayan Lal wrote:
> This patch disables page poisoning if guest page hinting is enabled.
> It is required to avoid possible guest memory corruption errors.
> Page Poisoning is a feature in which the page is filled with a specific
> pattern of (0x00 or 0xaa) after arch_free_page and the same is verified
> before arch_alloc_page to prevent following issues:
>     *information leak from the freed data
>     *use after free bugs
>     *memory corruption
> Selection of the pattern depends on the CONFIG_PAGE_POISONING_ZERO
> Once the guest pages which are supposed to be freed are sent to the
> hypervisor it frees them. After freeing the pages in the global list
> following things may happen:
>     *Hypervisor reallocates the freed memory back to the guest
>     *Hypervisor frees the memory and maps a different physical memory
> In order to prevent any information leak hypervisor before allocating
> memory to the guest fills it with zeroes.
> The issue arises when the pattern used for Page Poisoning is 0xaa while
> the newly allocated page received from the hypervisor by the guest is
> filled with the pattern 0x00. This will result in memory corruption errors.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>

IMHO it's better to take the approach of the existing balloon code
and just send the poison value to host. Host can then avoid filling
memory with zeroes.


> ---
>  include/linux/page_hinting.h | 8 ++++++++
>  mm/page_poison.c             | 2 +-
>  virt/kvm/page_hinting.c      | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting.h
> index 2d7ff59f3f6a..e800c6b07561 100644
> --- a/include/linux/page_hinting.h
> +++ b/include/linux/page_hinting.h
> @@ -19,7 +19,15 @@ struct hypervisor_pages {
>  extern int guest_page_hinting_flag;
>  extern struct static_key_false guest_page_hinting_key;
>  extern struct smp_hotplug_thread hinting_threads;
> +extern bool want_page_poisoning;
>  
>  int guest_page_hinting_sysctl(struct ctl_table *table, int write,
>  			      void __user *buffer, size_t *lenp, loff_t *ppos);
>  void guest_free_page(struct page *page, int order);
> +
> +static inline void disable_page_poisoning(void)
> +{
> +#ifdef CONFIG_PAGE_POISONING
> +	want_page_poisoning = 0;
> +#endif
> +}
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index f0c15e9017c0..9af96021133b 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -7,7 +7,7 @@
>  #include <linux/poison.h>
>  #include <linux/ratelimit.h>
>  
> -static bool want_page_poisoning __read_mostly;
> +bool want_page_poisoning __read_mostly;
>  
>  static int __init early_page_poison_param(char *buf)
>  {
> diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
> index 636990e7fbb3..be529f6f2bc0 100644
> --- a/virt/kvm/page_hinting.c
> +++ b/virt/kvm/page_hinting.c
> @@ -103,6 +103,7 @@ void guest_free_page(struct page *page, int order)
>  
>  	local_irq_save(flags);
>  	if (page_hinting_obj->kvm_pt_idx != MAX_FGPT_ENTRIES) {
> +		disable_page_poisoning();
>  		page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].pfn =
>  							page_to_pfn(page);
>  		page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].zonenum =
> -- 
> 2.17.2
