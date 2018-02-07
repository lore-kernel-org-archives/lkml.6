Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeBGSeX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:34:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753794AbeBGSeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:34:22 -0500
Date: Wed, 7 Feb 2018 20:34:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, huangzhichao@huawei.com
Subject: Re: [PATCH v27 3/4] mm/page_poison: expose page_poisoning_enabled to
 kernel modules
Message-ID: <20180207203004-mutt-send-email-mst@kernel.org>
References: <1517986471-15185-1-git-send-email-wei.w.wang@intel.com>
 <1517986471-15185-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517986471-15185-4-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 02:54:30PM +0800, Wei Wang wrote:
> In some usages, e.g. virtio-balloon, a kernel module needs to know if
> page poisoning is in use. This patch exposes the page_poisoning_enabled
> function to kernel modules.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  mm/page_poison.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index e83fd44..c08d02a 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -30,6 +30,11 @@ bool page_poisoning_enabled(void)
>  		debug_pagealloc_enabled()));
>  }
>  
> +/**
> + * page_poisoning_enabled - check if page poisoning is enabled
> + *
> + * Return true if page poisoning is enabled, or false if not.
> + */
>  static void poison_page(struct page *page)
>  {
>  	void *addr = kmap_atomic(page);
> @@ -37,6 +42,7 @@ static void poison_page(struct page *page)
>  	memset(addr, PAGE_POISON, PAGE_SIZE);
>  	kunmap_atomic(addr);
>  }
> +EXPORT_SYMBOL_GPL(page_poisoning_enabled);
>  
>  static void poison_pages(struct page *page, int n)
>  {

Looks like both the comment and the export are in the wrong place.
I'm a bit concerned that callers also in fact poke at the
PAGE_POISON - exporting that seems to be more of an accident
as it's only used without page_poisoning.c - it might be
better to have page_poisoning_enabled get u8 * and set it.

> -- 
> 2.7.4
