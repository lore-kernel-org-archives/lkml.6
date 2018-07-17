Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F3ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450B220C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450B220C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbeGQODx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:03:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:35316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731580AbeGQODx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:03:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C15DAAFC0;
        Tue, 17 Jul 2018 13:31:09 +0000 (UTC)
Date:   Tue, 17 Jul 2018 15:31:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Deprecate kernelcore=nn and movable_core=
Message-ID: <20180717133109.GI7193@dhcp22.suse.cz>
References: <20180717131837.18411-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717131837.18411-1-bhe@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-07-18 21:18:37, Baoquan He wrote:
> We can still use 'kernelcore=mirror' or 'movable_node' for the usage
> of hotplug and movable zone. If somebody shows up with a valid usecase
> we can reconsider.

Well this doesn't really explain why to deprecate this functionality.
It is a rather ugly hack that has been originally introduced for large
order allocations. But we do have compaction these days. Even though the
compaction cannot solve all the fragmentation issues the zone movable is
not a great answer as it introduces other issues (basically highmem kind
of issues we used to have on 32b systems).
The current code doesn't work with KASLR and the code is too subtle to
work properly in other cases as well. E.g. movablecore range might cover
already used memory (e.g. bootmem allocations) and therefore it doesn't
comply with the basic assumption that the memory is movable and that
confuses memory hotplug (e.g. 15c30bc09085 ("mm, memory_hotplug: make
has_unmovable_pages more robust").

There are probably other issues I am not aware of but primarily the code
adds a maintenance burden which would be better to get rid of.

I would also go further and remove all the code the feature is using at
one go. If somebody really needs this functionality we would need to
revert the whole thing anyway.

> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>  mm/page_alloc.c                                 | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index efc7aa7a0670..1e22c49866a2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1855,6 +1855,7 @@
>  	keepinitrd	[HW,ARM]
>  
>  	kernelcore=	[KNL,X86,IA-64,PPC]
> +			[Usage of kernelcore=nn[KMGTPE] | nn% is deprecated]
>  			Format: nn[KMGTPE] | nn% | "mirror"
>  			This parameter specifies the amount of memory usable by
>  			the kernel for non-movable allocations.  The requested
> @@ -2395,6 +2396,7 @@
>  			reporting absolute coordinates, such as tablets
>  
>  	movablecore=	[KNL,X86,IA-64,PPC]
> +			[Deprecated]
>  			Format: nn[KMGTPE] | nn%
>  			This parameter is the complement to kernelcore=, it
>  			specifies the amount of memory used for migratable
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1521100f1e63..86cf05f48b5f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6899,6 +6899,8 @@ static int __init cmdline_parse_kernelcore(char *p)
>  		return 0;
>  	}
>  
> +	pr_warn("Only kernelcore=mirror supported, "
> +		"usage of kernelcore=nn[KMGTPE]|nn%% is deprecated.\n");
>  	return cmdline_parse_core(p, &required_kernelcore,
>  				  &required_kernelcore_percent);
>  }
> @@ -6909,6 +6911,7 @@ static int __init cmdline_parse_kernelcore(char *p)
>   */
>  static int __init cmdline_parse_movablecore(char *p)
>  {
> +	pr_warn("Option movablecore= is deprecated.\n");
>  	return cmdline_parse_core(p, &required_movablecore,
>  				  &required_movablecore_percent);
>  }
> -- 
> 2.13.6

-- 
Michal Hocko
SUSE Labs
