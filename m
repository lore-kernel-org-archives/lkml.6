Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98B6C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7541C2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7541C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeLHNtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 08:49:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:33858 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbeLHNtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 08:49:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2018 05:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,330,1539673200"; 
   d="scan'208";a="124143071"
Received: from btwcube1.sh.intel.com (HELO dpdk-tbie) ([10.67.104.173])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2018 05:49:21 -0800
Date:   Sat, 8 Dec 2018 21:47:29 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [RFC 3/3] virtio_ring: use new vring flags
Message-ID: <20181208134728.GC29772@dpdk-tbie>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
 <20181207084842.13133-4-tiwei.bie@intel.com>
 <20181207130822-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207130822-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 01:10:48PM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 04:48:42PM +0800, Tiwei Bie wrote:
> > Switch to using the _SPLIT_ and _PACKED_ variants of vring flags
> > in split ring and packed ring respectively.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> > @@ -502,7 +505,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  		}
> >  	}
> >  	/* Last one doesn't continue. */
> > -	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > +	desc[prev].flags &= cpu_to_virtio16(_vq->vdev,
> > +				(u16)~BIT(VRING_SPLIT_DESC_F_NEXT));
> >  
> >  	if (indirect) {
> >  		/* Now that the indirect table is filled in, map it. */
> 
> I kind of dislike it that this forces use of a cast here.
> Kind of makes it more fragile. Let's use a temporary instead?

I tried something like this:

u16 mask = ~BIT(VRING_SPLIT_DESC_F_NEXT);

And it will still cause the warning:

warning: large integer implicitly truncated to unsigned type [-Woverflow]
  u16 mask = ~BIT(VRING_SPLIT_DESC_F_NEXT);

If the cast isn't wanted, maybe use ~(1 << VRING_SPLIT_DESC_F_NEXT)
directly?

> 
> > -- 
> > 2.17.1
