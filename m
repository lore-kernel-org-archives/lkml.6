Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046EA2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfAGOTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:19:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfAGOTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:19:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19E2D88E55;
        Mon,  7 Jan 2019 14:19:37 +0000 (UTC)
Received: from redhat.com (ovpn-122-143.rdu2.redhat.com [10.10.122.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 953E55D756;
        Mon,  7 Jan 2019 14:19:35 +0000 (UTC)
Date:   Mon, 7 Jan 2019 09:19:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] virtio-net: bql support
Message-ID: <20190107091334-mutt-send-email-mst@kernel.org>
References: <20181226101528-mutt-send-email-mst@kernel.org>
 <0fa99d9b-e510-d7eb-db1b-831bd7610ce9@redhat.com>
 <20181230134106-mutt-send-email-mst@kernel.org>
 <b4f06d11-4761-dabb-f641-5fc05c1c34fc@redhat.com>
 <20190102085457-mutt-send-email-mst@kernel.org>
 <17d2ab21-1c9a-2bb9-166f-2863d019cb0b@redhat.com>
 <20190106221506-mutt-send-email-mst@kernel.org>
 <aea2fd16-ec5b-64b5-2095-9a37044223f6@redhat.com>
 <20190106225951-mutt-send-email-mst@kernel.org>
 <88db987e-b519-5c1f-f64f-6f65f8415799@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88db987e-b519-5c1f-f64f-6f65f8415799@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 07 Jan 2019 14:19:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:31:47PM +0800, Jason Wang wrote:
> 
> On 2019/1/7 下午12:01, Michael S. Tsirkin wrote:
> > On Mon, Jan 07, 2019 at 11:51:55AM +0800, Jason Wang wrote:
> > > On 2019/1/7 上午11:17, Michael S. Tsirkin wrote:
> > > > On Mon, Jan 07, 2019 at 10:14:37AM +0800, Jason Wang wrote:
> > > > > On 2019/1/2 下午9:59, Michael S. Tsirkin wrote:
> > > > > > On Wed, Jan 02, 2019 at 11:28:43AM +0800, Jason Wang wrote:
> > > > > > > On 2018/12/31 上午2:45, Michael S. Tsirkin wrote:
> > > > > > > > On Thu, Dec 27, 2018 at 06:00:36PM +0800, Jason Wang wrote:
> > > > > > > > > On 2018/12/26 下午11:19, Michael S. Tsirkin wrote:
> > > > > > > > > > On Thu, Dec 06, 2018 at 04:17:36PM +0800, Jason Wang wrote:
> > > > > > > > > > > On 2018/12/6 上午6:54, Michael S. Tsirkin wrote:
> > > > > > > > > > > > When use_napi is set, let's enable BQLs.  Note: some of the issues are
> > > > > > > > > > > > similar to wifi.  It's worth considering whether something similar to
> > > > > > > > > > > > commit 36148c2bbfbe ("mac80211: Adjust TSQ pacing shift") might be
> > > > > > > > > > > > benefitial.
> > > > > > > > > > > I've played a similar patch several days before. The tricky part is the mode
> > > > > > > > > > > switching between napi and no napi. We should make sure when the packet is
> > > > > > > > > > > sent and trakced by BQL,  it should be consumed by BQL as well. I did it by
> > > > > > > > > > > tracking it through skb->cb.  And deal with the freeze by reset the BQL
> > > > > > > > > > > status. Patch attached.
> > > > > > > > > > > 
> > > > > > > > > > > But when testing with vhost-net, I don't very a stable performance,
> > > > > > > > > > So how about increasing TSQ pacing shift then?
> > > > > > > > > I can test this. But changing default TCP value is much more than a
> > > > > > > > > virtio-net specific thing.
> > > > > > > > Well same logic as wifi applies. Unpredictable latencies related
> > > > > > > > to radio in one case, to host scheduler in the other.
> > > > > > > > 
> > > > > > > > > > > it was
> > > > > > > > > > > probably because we batch the used ring updating so tx interrupt may come
> > > > > > > > > > > randomly. We probably need to implement time bounded coalescing mechanism
> > > > > > > > > > > which could be configured from userspace.
> > > > > > > > > > I don't think it's reasonable to expect userspace to be that smart ...
> > > > > > > > > > Why do we need time bounded? used ring is always updated when ring
> > > > > > > > > > becomes empty.
> > > > > > > > > We don't add used when means BQL may not see the consumed packet in time.
> > > > > > > > > And the delay varies based on the workload since we count packets not bytes
> > > > > > > > > or time before doing the batched updating.
> > > > > > > > > 
> > > > > > > > > Thanks
> > > > > > > > Sorry I still don't get it.
> > > > > > > > When nothing is outstanding then we do update the used.
> > > > > > > > So if BQL stops userspace from sending packets then
> > > > > > > > we get an interrupt and packets start flowing again.
> > > > > > > Yes, but how about the cases of multiple flows. That's where I see unstable
> > > > > > > results.
> > > > > > > 
> > > > > > > 
> > > > > > > > It might be suboptimal, we might need to tune it but I doubt running
> > > > > > > > timers is a solution, timer interrupts cause VM exits.
> > > > > > > Probably not a timer but a time counter (or event byte counter) in vhost to
> > > > > > > add used and signal guest if it exceeds a value instead of waiting the
> > > > > > > number of packets.
> > > > > > > 
> > > > > > > 
> > > > > > > Thanks
> > > > > > Well we already have VHOST_NET_WEIGHT - is it too big then?
> > > > > I'm not sure, it might be too big.
> > > > > 
> > > > > 
> > > > > > And maybe we should expose the "MORE" flag in the descriptor -
> > > > > > do you think that will help?
> > > > > > 
> > > > > I don't know. But how a "more" flag can help here?
> > > > > 
> > > > > Thanks
> > > > It sounds like we should be a bit more aggressive in updating used ring.
> > > > But if we just do it naively we will harm performance for sure as that
> > > > is how we are doing batching right now.
> > > 
> > > I agree but the problem is to balance the PPS and throughput. More batching
> > > helps for PPS but may damage TCP throughput.
> > That is what more flag is supposed to be I think - it is only set if
> > there's a socket that actually needs the skb freed in order to go on.
> 
> 
> I'm not quite sure I get, but is this something similar to what you want?
> 
> https://lists.linuxfoundation.org/pipermail/virtualization/2014-October/027667.html
> 
> Which enables tx interrupt for TCP packets, and you want to add used more
> aggressively for those sockets?
> 
> 
> Thanks

That's the idea.
But then you said we can just play with event index
instead. I think the answer to why not do that is that it's tricky to do
without races.


We need to think about the exact semantics: e.g. I think it is better to
keep interrupts on and then saying "I promise sending more buffers even
if you do not use any buffers so using this one is not urgent" rather
than as your patches do keeping them off and then saying "this one is
urgent".

The reason being is that "I promise to send more" is
more informative and can allow better batching for the
host.

> 
> > > >    Instead we could make guest
> > > > control batching using the more flag - if that's not set we write out
> > > > the used ring.
> > > 
> > > It's under the control of guest, so I'm afraid we still need some more guard
> > > (e.g time/bytes counters) on host.
> > > 
> > > Thanks
> > Point is if guest does not care about the skb being freed, then there is no
> > rush host side to mark buffer used.
> > 
> > 
