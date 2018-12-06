Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A356420989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A356420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLFPVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:21:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbeLFPVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:21:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68284CA369;
        Thu,  6 Dec 2018 15:21:20 +0000 (UTC)
Received: from redhat.com (ovpn-122-74.rdu2.redhat.com [10.10.122.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0354D608C4;
        Thu,  6 Dec 2018 15:21:18 +0000 (UTC)
Date:   Thu, 6 Dec 2018 10:21:17 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] dma-buf: fix debugfs versus rcu and fence dumping
Message-ID: <20181206152116.GA3544@redhat.com>
References: <20181206014103.1364-1-jglisse@redhat.com>
 <b520e7b6-a8f6-da49-fc7d-460823eabf47@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b520e7b6-a8f6-da49-fc7d-460823eabf47@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 06 Dec 2018 15:21:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:09:28AM +0000, Koenig, Christian wrote:
> Am 06.12.18 um 02:41 schrieb jglisse@redhat.com:
> > From: Jérôme Glisse <jglisse@redhat.com>
> >
> > The debugfs take reference on fence without dropping them. Also the
> > rcu section are not well balance. Fix all that ...
> >
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: linux-media@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: Stéphane Marchesin <marcheu@chromium.org>
> > Cc: stable@vger.kernel.org
> 
> Well NAK, you are now taking the RCU lock twice and dropping the RCU and 
> still accessing fobj has a huge potential for accessing freed up memory.
> 
> The only correct thing I can see here is to grab a reference to the 
> fence before printing any info on it,
> Christian.

Hu ? That is exactly what i am doing, take reference under rcu,
rcu_unlock print the fence info, drop the fence reference, rcu
lock rinse and repeat ...

Note that the fobj in _existing_ code is access outside the rcu
end that there is an rcu imbalance in that code ie a lonlely
rcu_unlock after the for loop.

So that the existing code is broken.

> 
> > ---
> >   drivers/dma-buf/dma-buf.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 13884474d158..f6f4de42ac49 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1051,24 +1051,31 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
> >   			fobj = rcu_dereference(robj->fence);
> >   			shared_count = fobj ? fobj->shared_count : 0;
> >   			fence = rcu_dereference(robj->fence_excl);
> > +			fence = dma_fence_get_rcu(fence);
> >   			if (!read_seqcount_retry(&robj->seq, seq))
> >   				break;
> >   			rcu_read_unlock();
> >   		}
> > -
> > -		if (fence)
> > +		if (fence) {
> >   			seq_printf(s, "\tExclusive fence: %s %s %ssignalled\n",
> >   				   fence->ops->get_driver_name(fence),
> >   				   fence->ops->get_timeline_name(fence),
> >   				   dma_fence_is_signaled(fence) ? "" : "un");
> > +			dma_fence_put(fence);
> > +		}
> > +
> > +		rcu_read_lock();
> >   		for (i = 0; i < shared_count; i++) {
> >   			fence = rcu_dereference(fobj->shared[i]);
> >   			if (!dma_fence_get_rcu(fence))
> >   				continue;
> > +			rcu_read_unlock();
> >   			seq_printf(s, "\tShared fence: %s %s %ssignalled\n",
> >   				   fence->ops->get_driver_name(fence),
> >   				   fence->ops->get_timeline_name(fence),
> >   				   dma_fence_is_signaled(fence) ? "" : "un");
> > +			dma_fence_put(fence);
> > +			rcu_read_lock();
> >   		}
> >   		rcu_read_unlock();
> >   
> 
