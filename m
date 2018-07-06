Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19BC22B26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19BC22B26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeGFVXb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:23:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45561 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbeGFVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:23:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id u7-v6so5361632wrn.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 14:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=thi0DSX2sAOi0pFHz7c9yxGly7b6YkqtJDRpM9XbMx4=;
        b=EQHBmQyL+hnYFbschCe3zVsc/P/O8T0hVCGQLA+sfoWEdG/cNPhhfKDJV4CuGkTrmL
         vVES9hX8ThuroPjT3zuuT7xyDDyn82AA8ptNOSZbTAn8Pp9fe33S+l1hUoRnaKdDZrmV
         bcxR9RJRHzW4EUNYkG2ipiPvvMAO2DdwnTch4YdBkFw1ySg3BcjNPUjJo4fcjv8QeD43
         oWMtQXKUS7/CxyFuNRTyfji79hmKvn6fC3hZwFGh+Yr3jTnaGygQGFf7SHaHXbGgd1EX
         LQs7ZLhcA2E9qAR8atP03ApAx83wHLqktdptk7AavDdOTnKWWsfWHBM0SxihGt1KRtWf
         t+Hg==
X-Gm-Message-State: APt69E2e0YpMoDAGEeXoFnGL5UNggkVTm3iJOj3KV5tUR4ZZBe762R03
        opro+OpwJpkOsatV+JT5G08=
X-Google-Smtp-Source: AAOMgpf6fgRTQpUtW2a5uLxh05qd2gJ9mlb5NeWNZ57bK3kQb6sxgO6zV8ErmtY5FsCq7kRgQmH3Sg==
X-Received: by 2002:adf:af45:: with SMTP id z63-v6mr8260090wrc.238.1530912209268;
        Fri, 06 Jul 2018 14:23:29 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id p4-v6sm9177143wrj.71.2018.07.06.14.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 14:23:28 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id B1966123C48; Fri,  6 Jul 2018 23:23:27 +0200 (CEST)
Date:   Fri, 6 Jul 2018 23:23:27 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     pasha.tatashin@oracle.com, linux-nvdimm@lists.01.org,
        bhe@redhat.com, Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        osalvador@suse.de
Subject: Re: [PATCH] mm/sparse.c: fix error path in sparse_add_one_section
Message-ID: <20180706212327.GA10824@techadventures.net>
References: <CAOxpaSVkLh23jN_=0GpZ77EhKdAYaiWKkppnxWwf_MRa5FvopA@mail.gmail.com>
 <20180706190658.6873-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706190658.6873-1-ross.zwisler@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 01:06:58PM -0600, Ross Zwisler wrote:
> The following commit in -next:
> 
> commit 054620849110 ("mm/sparse.c: make sparse_init_one_section void and
> remove check")
> 
> changed how the error handling in sparse_add_one_section() works.
> 
> Previously sparse_index_init() could return -EEXIST, and the function would
> continue on happily.  'ret' would get unconditionally overwritten by the
> result from sparse_init_one_section() and the error code after the 'out:'
> label wouldn't be triggered.

My bad, I missed that.

> diff --git a/mm/sparse.c b/mm/sparse.c
> index 9574113fc745..d254bd2d3289 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -753,8 +753,12 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
>  	 * plus, it does a kmalloc
>  	 */
>  	ret = sparse_index_init(section_nr, pgdat->node_id);
> -	if (ret < 0 && ret != -EEXIST)
> -		return ret;
> +	if (ret < 0) {
> +		if (ret == -EEXIST)
> +			ret = 0;
> +		else
> +			return ret;
> +	}

sparse_index_init() can return:

-ENOMEM, -EEXIST or 0.

So what about this?:

diff --git a/mm/sparse.c b/mm/sparse.c
index f55e79fda03e..eb188eb6b82d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -770,6 +770,7 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
        ret = sparse_index_init(section_nr, pgdat->node_id);
        if (ret < 0 && ret != -EEXIST)
                return ret;
+       ret = 0;

Does this look more clean?
-- 
Oscar Salvador
SUSE L3
