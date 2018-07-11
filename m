Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24086C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1976208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1976208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeGKBLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:11:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:44237 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbeGKBLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:11:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 18:09:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,336,1526367600"; 
   d="scan'208";a="215011065"
Received: from debian.sh.intel.com (HELO debian) ([10.67.104.228])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2018 18:09:18 -0700
Date:   Wed, 11 Jul 2018 09:09:05 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v1 4/5] virtio_ring: add event
 idx support in packed ring
Message-ID: <20180711010905.GB28235@debian>
References: <20180709072241.8886-1-tiwei.bie@intel.com>
 <20180709072241.8886-5-tiwei.bie@intel.com>
 <9ee31221-9f4a-f1c5-0f0b-8d178bb536e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ee31221-9f4a-f1c5-0f0b-8d178bb536e9@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 01:50:03PM +0800, Jason Wang wrote:
> On 2018年07月09日 15:22, Tiwei Bie wrote:
> > @@ -1059,9 +1059,19 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> >   	 * suppressions. */
> >   	virtio_mb(vq->weak_barriers);
> > +	old = vq->next_avail_idx - vq->num_added;
> > +	new = vq->next_avail_idx;
> > +	vq->num_added = 0;
> > +
> >   	snapshot = *(u32 *)vq->vring_packed.device;
> 
> I think we should use READ_ONCE() to prevent compiler from re-reading.

I'll do it. Thanks!

Best regards,
Tiwei Bie

> 
> > +	off_wrap = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot & 0xffff));
> >   	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
> > +	wrap_counter = off_wrap >> 15;
> > +	event_idx = off_wrap & ~(1 << 15);
> > +	if (wrap_counter != vq->avail_wrap_counter)
> > +		event_idx -= vq->vring_packed.num;
> 
> Thanks
> 
