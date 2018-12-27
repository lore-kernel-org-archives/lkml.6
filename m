Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FE520873
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5PJ/17a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbeL0Qoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 11:44:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeL0Qoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 11:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=78yHGtR4lwEixU6iXq1ohtrsERVtB+HiO/h1xbOVqm8=; b=O5PJ/17aWF1SzNEEBWNoSdB0D
        e6OTg/S9BCNf8fJlXwIGHepJDcQp2xJmQ3SwgjbTVtUeORJurP35PZzHChXyKc2ofAYzX/w83trQK
        UBIiFex7bjbr+rY0yVRNjWzs7lwj+B7pz2yVJ+fHOb0pIwQucCGb2f/+fqXjoc/UZYfevY2zE6Bhb
        td3qFuLMiXTZ/mSBXctWjK0bLKmjS7/1cqzp+SyzzMCEBiqfxqfLfGnluEH7+bpQTX1Jw0K6fbfkI
        F1J/qQshgUSCkbY3PvkAnCLmE0CmAVYQ8OaLg2JEE/wXaFugpoyL2sFMZCvOBAKs1FPWdHo2rXLws
        RD5nbQKtA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcYm8-0000yM-Sy; Thu, 27 Dec 2018 16:44:49 +0000
Subject: Re: [PATCH] mm: compaction.c: Propagate return value upstream
To:     Matthew Wilcox <willy@infradead.org>,
        Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joe Perches <joe@perches.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20181226194257.11038-1-pakki001@umn.edu>
 <20181227035029.GE20878@bombadil.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6af3b9ee-34c9-ba6d-f4c0-2c8e21b0550e@infradead.org>
Date:   Thu, 27 Dec 2018 08:44:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181227035029.GE20878@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/18 7:50 PM, Matthew Wilcox wrote:
> On Wed, Dec 26, 2018 at 01:42:56PM -0600, Aditya Pakki wrote:
>> In sysctl_extfrag_handler(), proc_dointvec_minmax() can return an
>> error. The fix propagates the error upstream in case of failure.
> 
> Why not just ...

Yes, this change (below) makes sense to me.

> Mel, Randy?  You seem to have been the prime instigators on this.

I expect that all I did was move the location of the source code lines of
the sysctl, but that is just a guess, based on this commit message:
  [randy.dunlap@oracle.com: Fix build errors when proc fs is not configured]

> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 68250a57aace..70d0256edd31 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -88,8 +88,6 @@ extern int sysctl_compact_memory;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void __user *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
> -extern int sysctl_extfrag_handler(struct ctl_table *table, int write,
> -			void __user *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_compact_unevictable_allowed;
>  
>  extern int fragmentation_index(struct zone *zone, unsigned int order);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 5fc724e4e454..e9c69247fc29 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1439,7 +1439,7 @@ static struct ctl_table vm_table[] = {
>  		.data		= &sysctl_extfrag_threshold,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= sysctl_extfrag_handler,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &min_extfrag_threshold,
>  		.extra2		= &max_extfrag_threshold,
>  	},
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 7c607479de4a..80b941d9b6e7 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1876,14 +1876,6 @@ int sysctl_compaction_handler(struct ctl_table *table, int write,
>  	return 0;
>  }
>  
> -int sysctl_extfrag_handler(struct ctl_table *table, int write,
> -			void __user *buffer, size_t *length, loff_t *ppos)
> -{
> -	proc_dointvec_minmax(table, write, buffer, length, ppos);
> -
> -	return 0;
> -}
> -
>  #if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
>  static ssize_t sysfs_compact_node(struct device *dev,
>  			struct device_attribute *attr,
> 


-- 
~Randy
