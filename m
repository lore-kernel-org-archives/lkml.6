Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeELOW5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 10:22:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeELOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 10:22:56 -0400
Date: Sat, 12 May 2018 07:22:49 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@suse.com" <mhocko@suse.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External]  Re: [PATCH v1] include/linux/gfp.h: getting rid of
 GFP_ZONE_TABLE/BAD
Message-ID: <20180512142249.GA24215@bombadil.infradead.org>
References: <1525968625-40825-1-git-send-email-yehs1@lenovo.com>
 <20180510163023.GB30442@bombadil.infradead.org>
 <HK2PR03MB16843E14AD56B3E546D9F52D929F0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180511132613.GA30263@bombadil.infradead.org>
 <HK2PR03MB1684BC9802BC2E5C1BF2DC74929E0@HK2PR03MB1684.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR03MB1684BC9802BC2E5C1BF2DC74929E0@HK2PR03MB1684.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 11:35:00AM +0000, Huaisheng HS1 Ye wrote:
> > The point of this exercise is to actually encode the zone number in
> > the bottom bits of the GFP flags instead of something which has to be
> > interpreted into a zone number.  When somebody sets __GFP_MOVABLE, they
> > should also be setting ZONE_MOVABLE:
> > 
> > -#define __GFP_MOVABLE   ((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
> > +#define __GFP_MOVABLE   ((__force gfp_t)(___GFP_MOVABLE | (ZONE_MOVABLE ^ ZONE_NORMAL)))
> > 
> I am afraid we couldn't do that, because __GFP_MOVABLE would be used potentially with other __GFPs like __GFP_DMA and __GFP_DMA32.

That's not a combination that makes much sense.  I know it's permitted today
(and it has the effect of being a no-op), but when you think about it, it
doesn't actually make any sense.
