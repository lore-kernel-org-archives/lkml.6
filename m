Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206D3C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA64D26776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA64D26776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964817AbeF0Jyn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:54:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38148 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeF0Jyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:54:41 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so1374825wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tSnyXYNMtB89PyPUvBQ9XzgMaQqobBdr1nFJkfgAOtI=;
        b=P6AMYRdTBpJpbi1NIqe5vW7Uf2Jkylw6juOplUDbIWU16aYODBmBjOafrS6rp53Bq+
         hReedv+YXZuAWJ4ozwXVOeHwXUo+yzCG6Kww0CGP0iIpWxx/xgG3Ar+OeISX9uK4kkCc
         GduJqeM5bNC9VGWbS+w79uKny514ks2pEil3TQU9xG5eExs8yAdoHmSN4QbVq4nnEhbd
         ZxEBcrZQ/+9/x+N+95nldw/6Roa5uumf03EMet3mZppqkAcd6eVQalZM8dgaMtx5o1LT
         xZWye2UAI1QJnoXw6E2GaCDLJJM5gqF+Xz0KcalJTgpE3NZZRXQrvJ66RkaiFgJNSDML
         /VUQ==
X-Gm-Message-State: APt69E21l5FL67le2axbFAD+ExMjeJbAKnxYv4qb4gPdJ+z/eczgXeTO
        4rw4RW5ErwtiTcCmm3TbsoY=
X-Google-Smtp-Source: AAOMgpejyPqaB7A7FfW5WFCAX9Zb3INmHJsaaIbAspFBf2SJnDDZUvJTJwekH9kKf/7EYzcgQ4IXBg==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr4537521wrp.161.1530093280809;
        Wed, 27 Jun 2018 02:54:40 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5858696wrn.75.2018.06.27.02.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:54:40 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 786CB123872; Wed, 27 Jun 2018 11:54:39 +0200 (CEST)
Date:   Wed, 27 Jun 2018 11:54:39 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 2/4] mm/sparsemem: Defer the ms->section_mem_map
 clearing
Message-ID: <20180627095439.GA5924@techadventures.net>
References: <20180627013116.12411-1-bhe@redhat.com>
 <20180627013116.12411-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627013116.12411-3-bhe@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:31:14AM +0800, Baoquan He wrote:
> In sparse_init(), if CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y, system
> will allocate one continuous memory chunk for mem maps on one node and
> populate the relevant page tables to map memory section one by one. If
> fail to populate for a certain mem section, print warning and its
> ->section_mem_map will be cleared to cancel the marking of being present.
> Like this, the number of mem sections marked as present could become
> less during sparse_init() execution.
> 
> Here just defer the ms->section_mem_map clearing if failed to populate
> its page tables until the last for_each_present_section_nr() loop. This
> is in preparation for later optimizing the mem map allocation.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/sparse-vmemmap.c |  1 -
>  mm/sparse.c         | 12 ++++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index bd0276d5f66b..640e68f8324b 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -303,7 +303,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  		ms = __nr_to_section(pnum);
>  		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
>  		       __func__);
> -		ms->section_mem_map = 0;

Since we are deferring the clearing of section_mem_map, I guess we do not need

struct mem_section *ms;
ms = __nr_to_section(pnum);

anymore, right?

>  	}
>  
>  	if (vmemmap_buf_start) {
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6314303130b0..71ad53da2cd1 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -451,7 +451,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  		ms = __nr_to_section(pnum);
>  		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
>  		       __func__);
> -		ms->section_mem_map = 0;

The same goes here.



-- 
Oscar Salvador
SUSE L3
