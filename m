Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC03EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D4C216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D4C216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeI1MDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbeI1MDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:03:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 359A55F730;
        Fri, 28 Sep 2018 05:41:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06455600C1;
        Fri, 28 Sep 2018 05:40:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EEE217724; Fri, 28 Sep 2018 07:40:56 +0200 (CEST)
Date:   Fri, 28 Sep 2018 07:40:56 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] vfio: add edid support to mbochs sample driver
Message-ID: <20180928054056.vjqwxvaj7sjmsozh@sirius.home.kraxel.org>
References: <20180921083013.15028-1-kraxel@redhat.com>
 <20180921083013.15028-3-kraxel@redhat.com>
 <4b9847dd-c37d-1d5d-3343-7030e62894fb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9847dd-c37d-1d5d-3343-7030e62894fb@nvidia.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 28 Sep 2018 05:41:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	case MBOCHS_EDID_REGION_INDEX:
> > +		ext->base.argsz = sizeof(*ext);
> > +		ext->base.offset = MBOCHS_EDID_OFFSET;
> > +		ext->base.size = MBOCHS_EDID_SIZE;
> > +		ext->base.flags = (VFIO_REGION_INFO_FLAG_READ  |
> > +				   VFIO_REGION_INFO_FLAG_WRITE |
> > +				   VFIO_REGION_INFO_FLAG_CAPS);
> 
> Any reason to not to use _MMAP flag?

There is no page backing this.  Also it is not performance-critical,
edid updates should be rare, so the extra code for mmap support doesn't
look like it is worth it.

Also for the virtual registers (especially link_state) it is probably
useful to have the write callback of the mdev driver called to get
notified about the change.

> How would QEMU side code read this region? will it be always trapped?

qemu uses read & write syscalls (well, pread & pwrite actually).

> If vendor driver sets _MMAP flag, will QEMU side handle that case as well?

The current test branch doesn't, it expects read+write to work.
  https://git.kraxel.org/cgit/qemu/log/?h=sirius/edid-vfio

> I think since its blob, edid could be read by QEMU using one memcpy
> rather than adding multiple memcpy of 4 or 8 bytes.

From qemu it's a single pwrite syscall actually.  mbochs_write() splits
it into 4 byte writes and calls mbochs_access() for each of them.  One
could probably add a special case for the EDID blob to mbochs_write().
But again: doesn't seem worth the effort given that edid updates should
be a rare event.

cheers,
  Gerd

