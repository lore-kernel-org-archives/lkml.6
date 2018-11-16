Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A31DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C392086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C392086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbeKQDRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:17:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:43300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729036AbeKQDRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:17:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 898BEB063;
        Fri, 16 Nov 2018 17:04:08 +0000 (UTC)
Date:   Fri, 16 Nov 2018 18:04:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: fix 'dubious: x & !y' warning from Sparse
Message-ID: <20181116170406.GM14706@dhcp22.suse.cz>
References: <1542346829-31063-1-git-send-email-yamada.masahiro@socionext.com>
 <010001671cca4b8b-2333373d-6b28-44e1-bca3-24570b8e0d2b-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001671cca4b8b-2333373d-6b28-44e1-bca3-24570b8e0d2b-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-11-18 13:51:19, Cristopher Lameter wrote:
> On Fri, 16 Nov 2018, Masahiro Yamada wrote:
> 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 918f374..d395c73 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -329,7 +329,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
> >  	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
> >  	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
> >  	 */
> > -	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
> > +	return type_dma + (is_reclaimable && !is_dma) * KMALLOC_RECLAIM;
> >  }
> 
> Ok then lets revert the initial patch whose point was to avoid a branch.
> && causes a branch again.

I believe Vlastimil managed to get rid of the branch http://lkml.kernel.org/r/aa5975b6-58ed-5a3e-7de1-4b1384f88457@suse.cz

-- 
Michal Hocko
SUSE Labs
