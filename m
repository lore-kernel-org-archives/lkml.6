Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC82C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7C02082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7C02082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJ3PsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:48:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:63313 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727501AbeJ3PsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:48:18 -0400
X-UUID: fce3c53b849b4bad842c84424a684b20-20181030
X-UUID: fce3c53b849b4bad842c84424a684b20-20181030
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1840357904; Tue, 30 Oct 2018 14:55:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Oct 2018 14:55:51 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Oct 2018 14:55:51 +0800
Message-ID: <1540882551.23278.12.camel@mtkswgap22>
Subject: Re: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 30 Oct 2018 14:55:51 +0800
In-Reply-To: <20181030060601.GR32673@dhcp22.suse.cz>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
         <20181029080708.GA32673@dhcp22.suse.cz>
         <20181029081706.GC32673@dhcp22.suse.cz>
         <1540862950.12374.40.camel@mtkswgap22>
         <20181030060601.GR32673@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2E26B09DC99F707EAE83DE70B9D57D6161CD602C3CEB5221A275CD5945312BFA2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 07:06 +0100, Michal Hocko wrote:
> On Tue 30-10-18 09:29:10, Miles Chen wrote:
> > On Mon, 2018-10-29 at 09:17 +0100, Michal Hocko wrote:
> > > On Mon 29-10-18 09:07:08, Michal Hocko wrote:
> > > [...]
> > > > Besides that, the following doesn't make much sense to me. It simply
> > > > makes no sense to use vmalloc for sub page allocation regardless of
> > > > HIGHMEM.
> > > 
> > > OK, it is still early morning here. Now I get the point of the patch.
> > > You just want to (ab)use highmeme for smaller requests. I do not like
> > > this, to be honest. It causes an internal fragmentation and more
> > > importantly the VMALLOC space on 32b where HIGHMEM is enabled (do we
> > > have any 64b with HIGHMEM btw?) is quite small to be wasted like that.
> > > 
> > thanks for your comment. It looks like that using vmalloc fallback for
> > sub page allocation is not good here.
> > 
> > Your comment gave another idea:
> > 
> > 1. force kbuf to PAGE_SIZE
> > 2. allocate a page by alloc_page(GFP_KERNEL | __GFP_HIGHMEM); so we can
> > get a highmem page if possible
> > 3. use kmap/kunmap pair to create mapping for this page. No vmalloc
> > space is used.
> > 4. do not change kvmalloc logic.
> 
> If you mean for this particular situation then is this really worth
> it? I mean this is a short term allocation for root only so you do not
> have to worry about low mem depletion.

The 1...3 are applied to print_page_owner(), not in kmalloc() or
kvmalloc() logic. 


It's a real problem when using page_owner.
I found this issue recently: I'm not able to read page_owner information
during a overnight test. (error: read failed: Out of memory). I replace
kmalloc() with vmalloc() and it worked well.

> 
> If you are thiking in more generic terms to allow kmalloc to use highmem
> then I am not really sure this will work out.

I'm thinking about modify print_page_owner().


