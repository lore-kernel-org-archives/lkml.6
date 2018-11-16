Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A2FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BD72089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BD72089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbeKPWID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:08:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50276 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeKPWID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:08:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BC8180D;
        Fri, 16 Nov 2018 03:56:00 -0800 (PST)
Received: from [10.163.1.125] (unknown [10.163.1.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BC1A3F718;
        Fri, 16 Nov 2018 03:55:57 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/5] mm: print more information about mapping in
 __dump_page
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20181116083020.20260-1-mhocko@kernel.org>
 <20181116083020.20260-2-mhocko@kernel.org>
Message-ID: <36711b50-6f5d-deaa-ec6f-c6a6d66cd94b@arm.com>
Date:   Fri, 16 Nov 2018 17:25:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116083020.20260-2-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2018 02:00 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> __dump_page prints the mapping pointer but that is quite unhelpful
> for many reports because the pointer itself only helps to distinguish
> anon/ksm mappings from other ones (because of lowest bits
> set). Sometimes it would be much more helpful to know what kind of
> mapping that is actually and if we know this is a file mapping then also
> try to resolve the dentry name.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/debug.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index cdacba12e09a..a33177bfc856 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -44,6 +44,7 @@ const struct trace_print_flags vmaflag_names[] = {
>  
>  void __dump_page(struct page *page, const char *reason)
>  {
> +	struct address_space *mapping = page_mapping(page);
>  	bool page_poisoned = PagePoisoned(page);
>  	int mapcount;
>  
> @@ -70,6 +71,18 @@ void __dump_page(struct page *page, const char *reason)
>  	if (PageCompound(page))
>  		pr_cont(" compound_mapcount: %d", compound_mapcount(page));
>  	pr_cont("\n");
> +	if (PageAnon(page))
> +		pr_emerg("anon ");
> +	else if (PageKsm(page))
> +		pr_emerg("ksm ");
> +	else if (mapping) {
> +		pr_emerg("%ps ", mapping->a_ops);
> +		if (mapping->host->i_dentry.first) {
> +			struct dentry *dentry;
> +			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
> +			pr_emerg("name:\"%*s\" ", dentry->d_name.len, dentry->d_name.name);
> +		}
> +	}
>  	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>  
>  	pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
> 

Differentiating between anon, ksm mapping and going till dentry information
for file mappings is surely an improvement. 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
