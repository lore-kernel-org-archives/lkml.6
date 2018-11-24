Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B45C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4821620865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4821620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeKXKuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 05:50:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeKXKuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 05:50:24 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0555415;
        Sat, 24 Nov 2018 00:04:05 +0000 (UTC)
Date:   Fri, 23 Nov 2018 16:04:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     <linux-mm@kvack.org>, Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/5] mm: print more information about mapping in
 __dump_page
Message-Id: <20181123160404.259413e56a8cc9a22112712a@linux-foundation.org>
In-Reply-To: <20181107101830.17405-2-mhocko@kernel.org>
References: <20181107101830.17405-1-mhocko@kernel.org>
        <20181107101830.17405-2-mhocko@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 11:18:26 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> __dump_page prints the mapping pointer but that is quite unhelpful
> for many reports because the pointer itself only helps to distinguish
> anon/ksm mappings from other ones (because of lowest bits
> set). Sometimes it would be much more helpful to know what kind of
> mapping that is actually and if we know this is a file mapping then also
> try to resolve the dentry name.
> 
> ...
>
> --- a/mm/debug.c
> +++ b/mm/debug.c
>
> ...
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

There has to be a better way of printing the filename.  It is so often
needed.

The (poorly named and gleefully undocumented)
take_dentry_name_snapshot() looks promising.  However it's unclear that
__dump_page() is always called from contexts where
take_dentry_name_snapshot() and release_dentry_name_snapshot() can be
safely called.  Probably it's OK, but how to guarantee it?


