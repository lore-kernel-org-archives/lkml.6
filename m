Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC97C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736D920866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736D920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeILOUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:20:30 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:2317 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeILOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:20:30 -0400
X-IronPort-AV: E=Sophos;i="5.53,364,1531785600"; 
   d="scan'208";a="78924982"
Date:   Wed, 12 Sep 2018 11:16:39 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Julien Grall <julien.grall@arm.com>
CC:     Jan Beulich <JBeulich@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        zhong jiang <zhongjiang@huawei.com>
Subject: Re: [Xen-devel] [PATCH] drivers/block/xen-blkback/common.h: use
 DIV_ROUND_UP instead of reimplementing its function
Message-ID: <20180912091639.oynlvdo6pghnqfvt@mac.bytemobile.com>
References: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
 <5B98CAE202000078001E79CC@prv1-mh.provo.novell.com>
 <20180912091350.6wuvt2jkvzg6wruo@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912091350.6wuvt2jkvzg6wruo@mac.bytemobile.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I've failed to add Julien in my previous reply.

On Wed, Sep 12, 2018 at 11:13:50AM +0200, Roger Pau Monné wrote:
> Adding Julien how did the work to support XEN_PAGE_SIZE != PAGE_SIZE.
> 
> On Wed, Sep 12, 2018 at 02:14:26AM -0600, Jan Beulich wrote:
> > >>> On 12.09.18 at 07:45, <zhongjiang@huawei.com> wrote:
> > > --- a/drivers/block/xen-blkback/common.h
> > > +++ b/drivers/block/xen-blkback/common.h
> > > @@ -65,7 +65,7 @@
> > >  	(XEN_PAGES_PER_INDIRECT_FRAME / XEN_PAGES_PER_SEGMENT)
> > >  
> > >  #define MAX_INDIRECT_PAGES \
> > > -	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
> > > +		DIV_ROUND_UP(MAX_INDIRECT_SEGMENTS, SEGS_PER_INDIRECT_FRAME)
> > >  #define INDIRECT_PAGES(_segs) DIV_ROUND_UP(_segs, XEN_PAGES_PER_INDIRECT_FRAME)
> > 
> > My first reaction was to suggest
> > 
> > #define MAX_INDIRECT_PAGES INDIRECT_PAGES(MAX_INDIRECT_SEGMENTS)
> > 
> > but that wouldn't match what's there currently (note the two different
> > divisors). I can't really decide whether that's just unfortunate naming
> > of the two macros, or an actual bug.
> 
> I think there's indeed a bug here.
> 
> AFAICT, MAX_INDIRECT_PAGES should use XEN_PAGES_PER_INDIRECT_FRAME and
> then it could be changed as Jan suggested.
> 
> Current MAX_INDIRECT_PAGES is misnamed and should instead be
> MAX_INDIRECT_SEGS (which on x86 is exactly the same because PAGE_SIZE
> == XEN_PAGE_SIZE).
> 
> Roger.
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
