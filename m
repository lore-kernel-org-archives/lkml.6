Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2908FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED58D20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED58D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeJBOZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:25:46 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:60128 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeJBOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:25:46 -0400
X-IronPort-AV: E=Sophos;i="5.54,331,1534809600"; 
   d="scan'208";a="79877212"
Date:   Tue, 2 Oct 2018 09:43:44 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Julien Grall <julien.grall@arm.com>
CC:     Jan Beulich <JBeulich@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        zhong jiang <zhongjiang@huawei.com>
Subject: Re: [Xen-devel] [PATCH] drivers/block/xen-blkback/common.h: use
 DIV_ROUND_UP instead of reimplementing its function
Message-ID: <20181002074344.wjmxbybehrkpwnmd@mac.bytemobile.com>
References: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
 <5B98CAE202000078001E79CC@prv1-mh.provo.novell.com>
 <20180912091350.6wuvt2jkvzg6wruo@mac.bytemobile.com>
 <20180912091639.oynlvdo6pghnqfvt@mac.bytemobile.com>
 <364bad2c-708e-6406-7b52-7bfef9d5dbe1@arm.com>
 <20180912102908.4ls7vts55n2zfkdz@mac.bytemobile.com>
 <58794c01-16f4-b124-46fe-cdcb386235de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58794c01-16f4-b124-46fe-cdcb386235de@arm.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 02:28:26PM +0100, Julien Grall wrote:
> Hi Roger,
> 
> On 09/12/2018 11:29 AM, Roger Pau Monné wrote:
> > On Wed, Sep 12, 2018 at 10:48:42AM +0100, Julien Grall wrote:
> > > Hi,
> > > 
> > > On 09/12/2018 10:16 AM, Roger Pau Monné wrote:
> > > > On Wed, Sep 12, 2018 at 11:13:50AM +0200, Roger Pau Monné wrote:
> > > > > Adding Julien how did the work to support XEN_PAGE_SIZE != PAGE_SIZE.
> > > > > 
> > > > > On Wed, Sep 12, 2018 at 02:14:26AM -0600, Jan Beulich wrote:
> > > > > > > > > On 12.09.18 at 07:45, <zhongjiang@huawei.com> wrote:
> > > > > > > --- a/drivers/block/xen-blkback/common.h
> > > > > > > +++ b/drivers/block/xen-blkback/common.h
> > > > > > > @@ -65,7 +65,7 @@
> > > > > > >    	(XEN_PAGES_PER_INDIRECT_FRAME / XEN_PAGES_PER_SEGMENT)
> > > > > > >    #define MAX_INDIRECT_PAGES \
> > > > > > > -	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
> > > > > > > +		DIV_ROUND_UP(MAX_INDIRECT_SEGMENTS, SEGS_PER_INDIRECT_FRAME)
> > > > > > >    #define INDIRECT_PAGES(_segs) DIV_ROUND_UP(_segs, XEN_PAGES_PER_INDIRECT_FRAME)
> > > > > > 
> > > > > > My first reaction was to suggest
> > > > > > 
> > > > > > #define MAX_INDIRECT_PAGES INDIRECT_PAGES(MAX_INDIRECT_SEGMENTS)
> > > > > > 
> > > > > > but that wouldn't match what's there currently (note the two different
> > > > > > divisors). I can't really decide whether that's just unfortunate naming
> > > > > > of the two macros, or an actual bug.
> > > > > 
> > > > > I think there's indeed a bug here.
> > > > > 
> > > > > AFAICT, MAX_INDIRECT_PAGES should use XEN_PAGES_PER_INDIRECT_FRAME and
> > > > > then it could be changed as Jan suggested.
> > > 
> > > The problem is SEGS_PER_INDIRECT_FRAME has been miscalculated. So I think it
> > > would be fine to use XEN_PAGES_PER_INDIRECT_FRAME in MAX_INDIRECT_PAGES.
> > > 
> > > However the naming for XEN_PAGES_PER_INDIRECT_FRAME is misnamed. We return
> > > number of a for segments per indirect frame. So I would rename to
> > > SEGS_PER_INDIRECT_FRAME.
> > 
> > I don't think I agree with this last part, SEGS_PER_INDIRECT_FRAME
> > would have to take into account XEN_PAGES_PER_SEGMENT, and
> > XEN_PAGES_PER_INDIRECT_FRAME doesn't.
> > 
> > XEN_PAGES_PER_INDIRECT_FRAME currently returns the number of grant
> > references per indirect page, but as I understand it a segment can use
> > more than one grant reference, if for example the guest page size is
> > 64KB.
> 
> I am a bit confused. By segment, do you refer to the backend or frontend
> segment?

Backend segment. I guess it's quite messy to have both frontend
segment size and backend segment size which can be different.

> In any case, it would be possible to remove SEGS_PER_INDIRECT_FRAME if we
> rework MAX_INDIRECT_PAGES(...). This should improve the readability as well.

Yes, I think this should improve the code.

Roger.
