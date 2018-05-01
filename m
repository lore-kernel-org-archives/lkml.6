Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeEAHF5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 03:05:57 -0400
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:39929 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752090AbeEAHF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 03:05:56 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3870:3871:3874:4250:4321:5007:6119:6120:7901:7903:8603:10004:10400:10848:10967:11026:11232:11473:11658:11914:12043:12438:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21060:21080:21627:30054:30090:30091,0,RBL:90.174.4.65:@perches.com:.lbl8.mailshell.net-62.14.11.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: side00_331de2d47bf02
X-Filterd-Recvd-Size: 2473
Message-ID: <e854ad5b8798efc2e33af153c4bdae2c16031e54.camel@perches.com>
Subject: Re: [RFC v5 PATCH] mm: shmem: make stat.st_blksize return huge page
 size if THP is on
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc: kirill.shutemov@linux.intel.com, hughd@google.com, mhocko@kernel.org,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Tue, 01 May 2018 00:05:48 -0700
In-Reply-To: <20180430164000.00f92084ecb1876e481c6a11@linux-foundation.org>
References: <1524665633-83806-1-git-send-email-yang.shi@linux.alibaba.com>
         <20180430164000.00f92084ecb1876e481c6a11@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-30 at 16:40 -0700, Andrew Morton wrote:
> On Wed, 25 Apr 2018 22:13:53 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
> 
> > Since tmpfs THP was supported in 4.8, hugetlbfs is not the only
> > filesystem with huge page support anymore. tmpfs can use huge page via
> > THP when mounting by "huge=" mount option.
[]
> > @@ -571,6 +571,16 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
> >  }
> >  #endif /* CONFIG_TRANSPARENT_HUGE_PAGECACHE */
> >  
> > +static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
> > +{
> > +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE) &&
> > +	    (shmem_huge == SHMEM_HUGE_FORCE || sbinfo->huge) &&
> > +	    shmem_huge != SHMEM_HUGE_DENY)
> > +		return true;
> > +	else
> > +		return false;
> > +}
> 
> Nit: we don't need that `else'.  Checkpatch normally warns about this,
> but not in this case.

because there are those that like symmetry.

> --- a/mm/shmem.c~mm-shmem-make-statst_blksize-return-huge-page-size-if-thp-is-on-fix
> +++ a/mm/shmem.c
> @@ -577,8 +577,7 @@ static inline bool is_huge_enabled(struc
>  	    (shmem_huge == SHMEM_HUGE_FORCE || sbinfo->huge) &&
>  	    shmem_huge != SHMEM_HUGE_DENY)
>  		return true;
> -	else
> -		return false;
> +	return false;
>  }

Perhaps this case is better without the if/else as just

	return <logic>;
