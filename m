Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70EFC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A632077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A632077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJJV67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:58:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbeJJV66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CD52307D853;
        Wed, 10 Oct 2018 14:36:31 +0000 (UTC)
Received: from redhat.com (ovpn-120-148.rdu2.redhat.com [10.10.120.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DEF95D973;
        Wed, 10 Oct 2018 14:36:27 +0000 (UTC)
Date:   Wed, 10 Oct 2018 10:36:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
Message-ID: <20181010103335-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180827170005-mutt-send-email-mst@kernel.org>
 <20180907012225.GA32677@debian>
 <20180907084509-mutt-send-email-mst@kernel.org>
 <20180910030053.GA15645@debian>
 <f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
 <20180911053726.GA7472@debian>
 <20180912121457-mutt-send-email-mst@kernel.org>
 <20180913085919.GA42049@fbsd1.sh.intel.com>
 <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 10 Oct 2018 14:36:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 05:47:29PM +0800, Jason Wang wrote:
> 
> 
> On 2018年09月13日 16:59, Tiwei Bie wrote:
> > > If what you say is true then we should take a careful look
> > > and not supporting these generic things with packed layout.
> > > Once we do support them it will be too late and we won't
> > > be able to get performance back.
> > I think it's a good point that we don't need to support
> > everything in packed ring (especially these which would
> > hurt the performance), as the packed ring aims at high
> > performance. I'm also wondering about the features. Is
> > there any possibility that we won't support the out of
> > order processing (at least not by default) in packed ring?
> > If I didn't miss anything, the need to support out of order
> > processing in packed ring will make the data structure
> > inside the driver not cache friendly which is similar to
> > the case of the descriptor table in the split ring (the
> > difference is that, it only happens in driver now).
> 
> Out of order is not the only user, DMA is another one. We don't have used
> ring(len), so we need to maintain buffer length somewhere even for in order
> device.

For a bunch of systems dma unmap is a nop so we do not really
need to maintain it. It's a question of an API to detect that
and optimize for it. I posted a proposed patch for that -
want to try using that?

> But if it's not too late, I second for a OUT_OF_ORDER feature.
> Starting from in order can have much simpler code in driver.
> 
> Thanks

It's tricky to change the flag polarity because of compatibility
with legacy interfaces. Why is this such a big deal?

Let's teach drivers about IN_ORDER, then if devices
are in order it will get enabled by default.

-- 
MST
