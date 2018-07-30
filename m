Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B899160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06E420894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="eUfyceB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06E420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeG3RYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:24:31 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:39754 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbeG3RYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1532965736;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=6MeMP/6oTP7C9TopqhPYMKdGbFexjggyz+7JZB2GpJo=;
        b=eUfyceB4qAm1Vyrsc2suqewJrZUEID8UHDTPKfjpqpc9uy4ogzptN3O9wjGuTyb8
        dT5LVkIwIsYhBIxTriw6PkdIEExX+DF92iSIpDcJ14KdbA5FmDVN6k+e2ia4RWjVaSd
        gbIHiqKEQRmJTCnzP+qzU2TqLFYGlUJw1RvNAfLs=
Date:   Mon, 30 Jul 2018 15:48:56 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 7/7] mm, slab: shorten kmalloc cache names for large
 sizes
In-Reply-To: <20180718133620.6205-8-vbabka@suse.cz>
Message-ID: <01000164ebe0d06f-8f639717-8d32-4eb9-9cc1-708332b12ca6-000000@email.amazonses.com>
References: <20180718133620.6205-1-vbabka@suse.cz> <20180718133620.6205-8-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.07.30-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Vlastimil Babka wrote:

> +static const char *
> +kmalloc_cache_name(const char *prefix, unsigned int size)
> +{
> +
> +	static const char units[3] = "\0kM";
> +	int idx = 0;
> +
> +	while (size >= 1024 && (size % 1024 == 0)) {
> +		size /= 1024;
> +		idx++;
> +	}
> +
> +	return kasprintf(GFP_NOWAIT, "%s-%u%c", prefix, size, units[idx]);
> +}

This is likely to occur elsewhere in the kernel. Maybe generalize it a
bit?

Acked-by: Christoph Lameter <cl@linux.com>

