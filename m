Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05731C00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3BA206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfBXLJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 06:09:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51794 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfBXLJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 06:09:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E72C7EBD;
        Sun, 24 Feb 2019 03:08:59 -0800 (PST)
Received: from MBP.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C90AB3F575;
        Sun, 24 Feb 2019 03:08:58 -0800 (PST)
Date:   Sun, 24 Feb 2019 11:08:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xuefeng Wang <wxf.wang@hisilicon.com>
Cc:     will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [PATCH] Use flush tlb last level when change protection
Message-ID: <20190224110855.GA26770@MBP.local>
References: <1550904447-45567-1-git-send-email-wxf.wang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550904447-45567-1-git-send-email-wxf.wang@hisilicon.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 02:47:27PM +0800, Xuefeng Wang wrote:
> The protection attributes are only kept in last level tlb, so
> protection changing only need invalidate last level tlb, exclude
> the PWC entries.
> 
> Signed-off-by: Xuefeng Wang <wxf.wang@hisilicon.com>
> ---
>  mm/mprotect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 36cb358..0c4303d 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -287,7 +287,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
>  
>  	/* Only flush the TLB if we actually modified any entries: */
>  	if (pages)
> -		flush_tlb_range(vma, start, end);
> +		__flush_tlb_range(vma, start, end, PAGE_SIZE, true);
>  	dec_tlb_flush_pending(mm);

You are changing a generic file to call an arm64-internal function,
breaking all the other architectures, so NAK.

Do you actually see any performance improvement?

-- 
Catalin
