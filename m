Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E650CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908042148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908042148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbeHPMSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:18:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727243AbeHPMSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:18:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B856AEEE;
        Thu, 16 Aug 2018 09:21:18 +0000 (UTC)
Date:   Thu, 16 Aug 2018 11:21:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH] mm: introduce kvvirt_to_page() helper
Message-ID: <20180816092116.GT32645@dhcp22.suse.cz>
References: <1534411057-26276-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534411057-26276-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-08-18 17:17:37, Li RongQing wrote:
> The new helper returns address mapping page, which has several users
> in individual subsystem, like mem_to_page in xfs_buf.c and pgv_to_page
> in af_packet.c, after this, they can be unified

Please add users along with the new helper.

> 
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  include/linux/mm.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 68a5121694ef..bb34a3c71df5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -599,6 +599,14 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>  	return kvmalloc_array(n, size, flags | __GFP_ZERO);
>  }
>  
> +static inline struct page *kvvirt_to_page(const void *addr)
> +{
> +	if (!is_vmalloc_addr(addr))
> +		return virt_to_page(addr);
> +	else
> +		return vmalloc_to_page(addr);
> +}
> +
>  extern void kvfree(const void *addr);
>  
>  static inline atomic_t *compound_mapcount_ptr(struct page *page)
> -- 
> 2.16.2
> 

-- 
Michal Hocko
SUSE Labs
