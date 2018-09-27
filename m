Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA94216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA94216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeI1ChM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:37:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54049 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeI1ChM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:37:12 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7C313002737;
        Thu, 27 Sep 2018 20:17:12 +0000 (UTC)
Received: from t450s.home (ovpn-116-42.phx2.redhat.com [10.3.116.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07A762010CAA;
        Thu, 27 Sep 2018 20:17:06 +0000 (UTC)
Date:   Thu, 27 Sep 2018 14:17:06 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        <intel-gvt-dev@lists.freedesktop.org>, <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] vfio: add edid support to mbochs sample driver
Message-ID: <20180927141706.1d15a579@t450s.home>
In-Reply-To: <4b9847dd-c37d-1d5d-3343-7030e62894fb@nvidia.com>
References: <20180921083013.15028-1-kraxel@redhat.com>
        <20180921083013.15028-3-kraxel@redhat.com>
        <4b9847dd-c37d-1d5d-3343-7030e62894fb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 27 Sep 2018 20:17:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 01:27:16 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 9/21/2018 2:00 PM, Gerd Hoffmann wrote:
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > @@ -964,6 +1050,20 @@ static int mbochs_get_region_info(struct mdev_device *mdev,
> >  		region_info->flags  = (VFIO_REGION_INFO_FLAG_READ  |
> >  				       VFIO_REGION_INFO_FLAG_WRITE);
> >  		break;
> > +	case MBOCHS_EDID_REGION_INDEX:
> > +		ext->base.argsz = sizeof(*ext);
> > +		ext->base.offset = MBOCHS_EDID_OFFSET;
> > +		ext->base.size = MBOCHS_EDID_SIZE;
> > +		ext->base.flags = (VFIO_REGION_INFO_FLAG_READ  |
> > +				   VFIO_REGION_INFO_FLAG_WRITE |
> > +				   VFIO_REGION_INFO_FLAG_CAPS);  
> 
> Any reason to not to use _MMAP flag?
> How would QEMU side code read this region? will it be always trapped?
> If vendor driver sets _MMAP flag, will QEMU side handle that case as well?
> I think since its blob, edid could be read by QEMU using one memcpy
> rather than adding multiple memcpy of 4 or 8 bytes.

"Trapping" would only come into play if the region were exposed to the
VM, which there's no intention to do here afaik.  Also, just because
it doesn't support mmap doesn't mean that QEMU necessarily needs to
break down accesses into smaller words, QEMU could do:

pwrite(fd, buf, edid_max_size, region_offset + edid_offset)

ie. write the entire edid area with one operation.  I don't think
there's anything in the specification that prevents mmap now,
edid_offset could be at a page alignment, edid_max_size could be
PAGE_SIZE, and a sparse mmap capability could indicate that only the
EDID area is mmap'able, but is it worth the code to support that?
Thanks,

Alex
