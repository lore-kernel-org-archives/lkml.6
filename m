Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3562C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994DF2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="CCBhO0De"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBVNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:01:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32913 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfBVNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:01:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so1117395pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 05:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=onkZE8WbSVFAq66ZVCGJ/2/k18VmMeh7kNAg+mwLHWw=;
        b=CCBhO0DeHvPnX4smOVqBA3ma1CsqYKz79vk36KDNQvAiU9IE4jYxbC9bYdXbxq2XZl
         8DKg39/L2uT2RaXxhiHQ62V8we8DpABwhQpPpzM3+biaCQjizItVJ6qtxICY031D5XXJ
         ntaNHbnLWU5N1WTLTvKHA3l+vDW1WKW5ehxEAdxgyy3MBntk1RUDkhuU5Zj8lKNFdF8h
         1nUWYHyGdYee2NoT4ZebPXaMUvPzfcLlX4sdgXByTx92SZ0PC6uvzmwRoik53i/yYUan
         q5PbPElWBwlfVYARUlujnHmds2/kbVPimQk/qAxOdRyojDPqFojOzpb5+pUN9iJVumSv
         b+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=onkZE8WbSVFAq66ZVCGJ/2/k18VmMeh7kNAg+mwLHWw=;
        b=qkjyYLkaT6oWZIMdMy37LU64UhjhDrfnv7O6o7s8QQ35cnGuTSMCpfUjxgfPxyINEF
         zc7bzIaj5YfKxptq0xcUBwl24GyTCHCxOD0n6+7OQAkAjZcNHTbMfctxizXDUT44sL9i
         67ULxjTeP1cGn0sCrs0LCR3IuXfGFM6EjcmESDAq3bRRSVuemZw+Z2UQ9WXF9AMx9wON
         +NCiHYXIWf90kF8ewXzHmbG/IEXDmnIZ75s+qGySJgDSVy7mjabIhDhX1ju2ccUI7210
         gV4HYh8jye+r/B42Q5GWoCtb4wxQmbWs789pUEaiTYnSf12HusF7e+X2slAPb8LYbENQ
         034A==
X-Gm-Message-State: AHQUAubsHr7y/uZruyaQoBDQfJYgKrr8O8yo97NN6fglo5/G+TB2DwMl
        0pC8NJ56X2zw+5XXajQ6eBtodA==
X-Google-Smtp-Source: AHgI3Ibj7qZvvdq1/wt4KP+58XgtGJ+zPbnw0GY+h8/WF7m62jomELxnWg3mhD4zKB6qLPOHVv56UA==
X-Received: by 2002:aa7:8847:: with SMTP id k7mr4034679pfo.99.1550840490132;
        Fri, 22 Feb 2019 05:01:30 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id u186sm2360688pfu.51.2019.02.22.05.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 05:01:29 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B38F2301708; Fri, 22 Feb 2019 16:01:25 +0300 (+03)
Date:   Fri, 22 Feb 2019 16:01:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, hughd@google.com, vbabka@suse.cz,
        joel@joelfernandes.org, jglisse@redhat.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net
Subject: Re: [RFC PATCH] mm,mremap: Bail out earlier in mremap_to under map
 pressure
Message-ID: <20190222130125.apa2ysnahgfuj2vx@kshutemo-mobl1>
References: <20190221085406.10852-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221085406.10852-1-osalvador@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:54:06AM +0100, Oscar Salvador wrote:
> When using mremap() syscall in addition to MREMAP_FIXED flag,
> mremap() calls mremap_to() which does the following:
> 
> 1) unmaps the destination region where we are going to move the map
> 2) If the new region is going to be smaller, we unmap the last part
>    of the old region
> 
> Then, we will eventually call move_vma() to do the actual move.
> 
> move_vma() checks whether we are at least 4 maps below max_map_count
> before going further, otherwise it bails out with -ENOMEM.
> The problem is that we might have already unmapped the vma's in steps
> 1) and 2), so it is not possible for userspace to figure out the state
> of the vma's after it gets -ENOMEM, and it gets tricky for userspace
> to clean up properly on error path.
> 
> While it is true that we can return -ENOMEM for more reasons
> (e.g: see may_expand_vm() or move_page_tables()), I think that we can
> avoid this scenario in concret if we check early in mremap_to() if the
> operation has high chances to succeed map-wise.
> 
> Should not be that the case, we can bail out before we even try to unmap
> anything, so we make sure the vma's are left untouched in case we are likely
> to be short of maps.
> 
> The thumb-rule now is to rely on the worst-scenario case we can have.
> That is when both vma's (old region and new region) are going to be split
> in 3, so we get two more maps to the ones we already hold (one per each).
> If current map count + 2 maps still leads us to 4 maps below the threshold,
> we are going to pass the check in move_vma().
> 
> Of course, this is not free, as it might generate false positives when it is
> true that we are tight map-wise, but the unmap operation can release several
> vma's leading us to a good state.
> 
> Because of that I am sending this as a RFC.
> Another approach was also investigated [1], but it may be too much hassle
> for what it brings.

I believe we don't need the check in move_vma() with this patch. Or do we?

> 
> [1] https://lore.kernel.org/lkml/20190219155320.tkfkwvqk53tfdojt@d104.suse.de/
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/mremap.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 3320616ed93f..e3edef6b7a12 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -516,6 +516,23 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	if (addr + old_len > new_addr && new_addr + new_len > addr)
>  		goto out;
>  
> +	/*
> +	 * move_vma() need us to stay 4 maps below the threshold, otherwise
> +	 * it will bail out at the very beginning.
> +	 * That is a problem if we have already unmaped the regions here
> +	 * (new_addr, and old_addr), because userspace will not know the
> +	 * state of the vma's after it gets -ENOMEM.
> +	 * So, to avoid such scenario we can pre-compute if the whole
> +	 * operation has high chances to success map-wise.
> +	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
> +	 * split in 3 before unmaping it.
> +	 * That means 2 more maps (1 for each) to the ones we already hold.
> +	 * Check whether current map count plus 2 still leads us to 4 maps below
> +	 * the threshold, otherwise return -ENOMEM here to be more safe.
> +	 */
> +	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)

Nit: redundant parentheses around 'mm->map_count + 2'.

> +		return -ENOMEM;
> +
>  	ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
>  	if (ret)
>  		goto out;
> -- 
> 2.13.7
> 

-- 
 Kirill A. Shutemov
