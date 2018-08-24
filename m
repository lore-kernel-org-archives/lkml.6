Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F18C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288162098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288162098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeHXPzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:55:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:41676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726471AbeHXPzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:55:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B086CB070;
        Fri, 24 Aug 2018 12:20:56 +0000 (UTC)
Date:   Fri, 24 Aug 2018 14:20:56 +0200
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
Message-ID: <20180824122056.GM29735@dhcp22.suse.cz>
References: <20180823134418.17008-1-vbabka@suse.cz>
 <20180823142812.7363-1-vbabka@suse.cz>
 <20180823192709.GT29735@dhcp22.suse.cz>
 <966571f0-9d7f-43dc-92c6-a10eec7a1254@suse.cz>
 <d789bd84-a982-b8bb-ee24-6a7fcdf8221d@suse.cz>
 <a24503e1-5b18-529c-49d9-94fc3d2b6986@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24503e1-5b18-529c-49d9-94fc3d2b6986@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-08-18 14:10:54, Vlastimil Babka wrote:
> On 08/24/2018 12:36 PM, Vlastimil Babka wrote:
> > On 08/24/2018 09:32 AM, Vlastimil Babka wrote:
> >> On 08/23/2018 09:27 PM, Michal Hocko wrote:
> >>> On Thu 23-08-18 16:28:12, Vlastimil Babka wrote:
> >>>> Two users have reported [1] that they have an "extremely unlikely" system
> >>>> with more than MAX_PA/2 memory and L1TF mitigation is not effective. Let's
> >>>> make the warning more helpful by suggesting the proper mem=X kernel boot param,
> >>>> a rough calculation of how much RAM can be lost (not precise if there's holes
> >>>> between MAX_PA/2 and max_pfn in the e820 map) and a link to the L1TF document
> >>>> to help decide if the mitigation is worth the unusable RAM.
> >>>>
> >>>> [1] https://bugzilla.suse.com/show_bug.cgi?id=1105536
> >>>>
> >>>> Suggested-by: Michal Hocko <mhocko@suse.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >>>
> >>> I wouldn't bother with max_pfn-half_pa part but other than that this is
> >>> much more useful than the original message.
> >>
> >> Right, and it causes build failures on some configs.
> >>
> >>> Acked-by: Michal Hocko <mhocko@suse.com>
> >>
> >> Thanks! Here's a v2:
> > 
> > Just realized that kvm printk's refer to the online version at
> > https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html
> > which should be easier for the users of distro kernels, should I change
> > that?
> 
> FWIW, if it's not possible to amend anymore...
> ----8<----
> >From a650e6a4b989c6e029ac1ab4e0a68553e074ba7a Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Fri, 24 Aug 2018 14:05:45 +0200
> Subject: [PATCH] x86/speculation/l1tf: replace Documentation path with
>  kernel.org URL
> 
> The URL might be easier to reach for users of distro kernels without unpacked
> source, and be more up-to-date. It's also used in KVM warnings related to L1TF.

Yes, URL is much more convenient than a reference to the kernel source
documentation. If the link below is meant to be long lived then sure.

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/x86/kernel/cpu/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 5c32b5006738..4c2313d0b9ca 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -705,7 +705,7 @@ static void __init l1tf_select_mitigation(void)
>  		pr_info("You may make it effective by booting the kernel with mem=%llu parameter.\n",
>  				half_pa);
>  		pr_info("However, doing so will make a part of your RAM unusable.\n");
> -		pr_info("Reading Documentation/admin-guide/l1tf.rst might help you decide.\n");
> +		pr_info("Reading https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html might help you decide.\n");
>  		return;
>  	}
>  
> -- 
> 2.18.0
> 
> 
>  

-- 
Michal Hocko
SUSE Labs
