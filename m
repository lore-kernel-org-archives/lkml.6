Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C907AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80496214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80496214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJKTkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:40:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:47148 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeJKTkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:40:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 05:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="264809462"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.158])
  by orsmga005.jf.intel.com with ESMTP; 11 Oct 2018 05:13:37 -0700
Date:   Thu, 11 Oct 2018 20:12:21 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
Message-ID: <20181011121221.GA27106@debian>
References: <20180827170005-mutt-send-email-mst@kernel.org>
 <20180907012225.GA32677@debian>
 <20180907084509-mutt-send-email-mst@kernel.org>
 <20180910030053.GA15645@debian>
 <f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
 <20180911053726.GA7472@debian>
 <20180912121457-mutt-send-email-mst@kernel.org>
 <20180913085919.GA42049@fbsd1.sh.intel.com>
 <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
 <20181010103335-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010103335-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:36:26AM -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 13, 2018 at 05:47:29PM +0800, Jason Wang wrote:
> > On 2018年09月13日 16:59, Tiwei Bie wrote:
> > > > If what you say is true then we should take a careful look
> > > > and not supporting these generic things with packed layout.
> > > > Once we do support them it will be too late and we won't
> > > > be able to get performance back.
> > > I think it's a good point that we don't need to support
> > > everything in packed ring (especially these which would
> > > hurt the performance), as the packed ring aims at high
> > > performance. I'm also wondering about the features. Is
> > > there any possibility that we won't support the out of
> > > order processing (at least not by default) in packed ring?
> > > If I didn't miss anything, the need to support out of order
> > > processing in packed ring will make the data structure
> > > inside the driver not cache friendly which is similar to
> > > the case of the descriptor table in the split ring (the
> > > difference is that, it only happens in driver now).
> > 
> > Out of order is not the only user, DMA is another one. We don't have used
> > ring(len), so we need to maintain buffer length somewhere even for in order
> > device.
> 
> For a bunch of systems dma unmap is a nop so we do not really
> need to maintain it. It's a question of an API to detect that
> and optimize for it. I posted a proposed patch for that -
> want to try using that?

Yeah, definitely!

> 
> > But if it's not too late, I second for a OUT_OF_ORDER feature.
> > Starting from in order can have much simpler code in driver.
> > 
> > Thanks
> 
> It's tricky to change the flag polarity because of compatibility
> with legacy interfaces. Why is this such a big deal?
> 
> Let's teach drivers about IN_ORDER, then if devices
> are in order it will get enabled by default.

Yeah, make sense.

Besides, I have done some further profiling and debugging
both in kernel driver and DPDK vhost. Previously I was mislead
by a bug in vhost code. I will send a patch to fix that bug.
With that bug fixed, the performance of packed ring in the
test between kernel driver and DPDK vhost is better now.
I will send a new series soon. Thanks!

> 
> -- 
> MST
