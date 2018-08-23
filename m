Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A37C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F7920841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F7920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeHWW6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:58:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:59684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeHWW6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:58:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EE2EAEC0;
        Thu, 23 Aug 2018 19:27:11 +0000 (UTC)
Date:   Thu, 23 Aug 2018 21:27:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation/l1tf: suggest what to do on systems with
 too much RAM
Message-ID: <20180823192709.GT29735@dhcp22.suse.cz>
References: <20180823134418.17008-1-vbabka@suse.cz>
 <20180823142812.7363-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823142812.7363-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-08-18 16:28:12, Vlastimil Babka wrote:
> Two users have reported [1] that they have an "extremely unlikely" system
> with more than MAX_PA/2 memory and L1TF mitigation is not effective. Let's
> make the warning more helpful by suggesting the proper mem=X kernel boot param,
> a rough calculation of how much RAM can be lost (not precise if there's holes
> between MAX_PA/2 and max_pfn in the e820 map) and a link to the L1TF document
> to help decide if the mitigation is worth the unusable RAM.
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1105536
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

I wouldn't bother with max_pfn-half_pa part but other than that this is
much more useful than the original message.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/x86/kernel/cpu/bugs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index cb4a16292aa7..4b820bb6c504 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -702,6 +702,11 @@ static void __init l1tf_select_mitigation(void)
>  	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
>  	if (e820__mapped_any(half_pa, ULLONG_MAX - half_pa, E820_TYPE_RAM)) {
>  		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
> +		pr_info("You may make it effective by booting the kernel with mem=%llu parameter.\n",
> +				half_pa);
> +		pr_info("However, doing so will make up to %llu bytes of RAM unusable.\n",
> +				((u64) max_pfn << PAGE_SHIFT) - half_pa);
> +		pr_info("Reading Documentation/admin-guide/l1tf.rst might help you decide.");
>  		return;
>  	}
>  
> -- 
> 2.18.0

-- 
Michal Hocko
SUSE Labs
