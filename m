Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6C2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981312525F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981312525F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeGBNks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:46108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752401AbeGBNkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:40:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6E1CAD12;
        Mon,  2 Jul 2018 13:40:43 +0000 (UTC)
Date:   Mon, 2 Jul 2018 15:40:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 2/5] mm: introduce VM_DEAD flag
Message-ID: <20180702134043.GW19043@dhcp22.suse.cz>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-3-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530311985-31251-3-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30-06-18 06:39:42, Yang Shi wrote:
> VM_DEAD flag is used to mark a vma is being unmapped, access to this
> area will trigger SIGSEGV.
> 
> This flag will be used by the optimization for unmapping large address
> space (>= 1GB) in the later patch. It is 64 bit only at the moment,
> since:
>   * we used up vm_flags bit for 32 bit
>   * 32 bit machine typically will not have such large mapping
> 
> All architectures, which support 64 bit, need check this flag in their
> page fault handler. This is implemented in later patches.

Please add a new flag with its users. There is simply no way to tell the
semantic from the above description and the patch as well.
 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  include/linux/mm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a0fbb9f..28a3906 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -242,6 +242,12 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
>  #endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */
>  
> +#ifdef CONFIG_64BIT
> +#define VM_DEAD			BIT(37)	/* bit only usable on 64 bit kernel */
> +#else
> +#define VM_DEAD			0
> +#endif
> +
>  #if defined(CONFIG_X86)
>  # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
>  #elif defined(CONFIG_PPC)
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
