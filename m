Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBE3216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBE3216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeI1TNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1TNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:13:24 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F1C8C058CBE;
        Fri, 28 Sep 2018 12:49:47 +0000 (UTC)
Received: from t450s.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5462C3091373;
        Fri, 28 Sep 2018 12:49:42 +0000 (UTC)
Date:   Fri, 28 Sep 2018 06:49:41 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        <intel-gvt-dev@lists.freedesktop.org>, <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] vfio: add edid support to mbochs sample driver
Message-ID: <20180928064941.4fac51ef@t450s.home>
In-Reply-To: <646427f9-7bed-43aa-6aba-9b5e82eecb68@nvidia.com>
References: <20180921083013.15028-1-kraxel@redhat.com>
        <20180921083013.15028-3-kraxel@redhat.com>
        <4b9847dd-c37d-1d5d-3343-7030e62894fb@nvidia.com>
        <20180928054056.vjqwxvaj7sjmsozh@sirius.home.kraxel.org>
        <646427f9-7bed-43aa-6aba-9b5e82eecb68@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 28 Sep 2018 12:49:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 14:10:26 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 9/28/2018 11:10 AM, Gerd Hoffmann wrote:
> >>> +	case MBOCHS_EDID_REGION_INDEX:
> >>> +		ext->base.argsz = sizeof(*ext);
> >>> +		ext->base.offset = MBOCHS_EDID_OFFSET;
> >>> +		ext->base.size = MBOCHS_EDID_SIZE;
> >>> +		ext->base.flags = (VFIO_REGION_INFO_FLAG_READ  |
> >>> +				   VFIO_REGION_INFO_FLAG_WRITE |
> >>> +				   VFIO_REGION_INFO_FLAG_CAPS);  
> >>
> >> Any reason to not to use _MMAP flag?  
> > 
> > There is no page backing this.  Also it is not performance-critical,
> > edid updates should be rare, so the extra code for mmap support doesn't
> > look like it is worth it.
> > 
> > Also for the virtual registers (especially link_state) it is probably
> > useful to have the write callback of the mdev driver called to get
> > notified about the change.
> >   
> >> How would QEMU side code read this region? will it be always trapped?  
> > 
> > qemu uses read & write syscalls (well, pread & pwrite actually).
> >   
> >> If vendor driver sets _MMAP flag, will QEMU side handle that case as well?  
> > 
> > The current test branch doesn't, it expects read+write to work.
> >   https://git.kraxel.org/cgit/qemu/log/?h=sirius/edid-vfio
> >   
> 
> Ok.
> Can you add a comment in vfio.h that this region is non-mmappable?

No, region access mechanisms are self describing through the region
info ioctl, it's left to the implementation to decide what to support.
The region definition should not impose such a restriction.  Thanks,

Alex
