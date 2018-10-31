Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D980C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA72220685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA72220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeJaTR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:17:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2310 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727852AbeJaTR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:17:27 -0400
X-UUID: a01d6aa4ff4e453aa6a678f0eac8928f-20181031
X-UUID: a01d6aa4ff4e453aa6a678f0eac8928f-20181031
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1806330942; Wed, 31 Oct 2018 18:19:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 31 Oct 2018 18:19:42 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 31 Oct 2018 18:19:42 +0800
Message-ID: <1540981182.16084.1.camel@mtkswgap22>
Subject: Re: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 31 Oct 2018 18:19:42 +0800
In-Reply-To: <20181031101501.GL32673@dhcp22.suse.cz>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
         <20181029080708.GA32673@dhcp22.suse.cz>
         <20181029081706.GC32673@dhcp22.suse.cz>
         <1540862950.12374.40.camel@mtkswgap22>
         <20181030060601.GR32673@dhcp22.suse.cz>
         <1540882551.23278.12.camel@mtkswgap22>
         <20181030081537.GV32673@dhcp22.suse.cz>
         <1540975637.10275.10.camel@mtkswgap22>
         <20181031101501.GL32673@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 31A53AD034CBF0DCA792824C567B80F5D0BDF81AFCA42A2E2F46CE800FDA46072000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-31 at 11:15 +0100, Michal Hocko wrote:
> On Wed 31-10-18 16:47:17, Miles Chen wrote:
> > On Tue, 2018-10-30 at 09:15 +0100, Michal Hocko wrote:
> > > On Tue 30-10-18 14:55:51, Miles Chen wrote:
> > > [...]
> > > > It's a real problem when using page_owner.
> > > > I found this issue recently: I'm not able to read page_owner information
> > > > during a overnight test. (error: read failed: Out of memory). I replace
> > > > kmalloc() with vmalloc() and it worked well.
> > > 
> > > Is this with trimming the allocation to a single page and doing shorter
> > > than requested reads?
> > 
> > 
> > I printed out the allocate count on my device the request count is <=
> > 4096. So I tested this scenario by trimming the count to from 4096 to
> > 1024 bytes and it works fine. 
> > 
> > count = count > 1024? 1024: count;
> > 
> > It tested it on both 32bit and 64bit kernel.
> 
> Are you saying that you see OOMs for 4k size?
> 
yes, because kmalloc only use normal memor, not highmem + normal memory
I think that's why vmalloc() works.

