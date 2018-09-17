Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0479BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B949A214FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B949A214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeIQPkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:40:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725757AbeIQPkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:40:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6C213082DD4;
        Mon, 17 Sep 2018 10:13:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92B5F17A7C;
        Mon, 17 Sep 2018 10:13:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 36D9541A42; Mon, 17 Sep 2018 12:13:55 +0200 (CEST)
Date:   Mon, 17 Sep 2018 12:13:55 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] vfio: add edid api for display (vgpu) devices.
Message-ID: <20180917101355.pfk2bbmgdwabcyqc@sirius.home.kraxel.org>
References: <20180913054745.6353-1-kraxel@redhat.com>
 <20180913054745.6353-2-kraxel@redhat.com>
 <20180913115139.02775316@t450s.home>
 <20180914122552.3xmepqo7azzmx7ky@sirius.home.kraxel.org>
 <20180917065154.GI20737@zhen-hp.sh.intel.com>
 <20180917085033.ttcs3cpznnf3wngd@sirius.home.kraxel.org>
 <20180917091550.GK20737@zhen-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917091550.GK20737@zhen-hp.sh.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 17 Sep 2018 10:13:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 05:15:50PM +0800, Zhenyu Wang wrote:
> On 2018.09.17 10:50:33 +0200, Gerd Hoffmann wrote:
> > > > +#define VFIO_DEVICE_INFO_CAP_EDID	1
> > > > +
> > > > +struct vfio_device_info_edid_cap {
> > > > +	struct vfio_info_cap_header header;
> > > > +	__u32   max_x;     /* Max display height (zero == no limit) */
> > > > +	__u32   max_y;     /* Max display height (zero == no limit) */
> > > > +};
> > > 
> > > As current virtual display for Intel vGPU is still emulating against real HW
> > > pipeline with same limitations, asked display developers that whether or not
> > > specific mode can work might still depend on current or future HW behavior.
> > > So could we add some hints on what kind of edid mode vfio device can operate?
> > > Some may support arbitrary modes, but some may only support standard modes.
> > 
> > What kind of restrictions do we have here?  Really to a fixed list of
> > standard modes?
> 
> Restriction is still with HW differences, e.g for skl/kbl with ddi wrpll
> within min/max clock range which may generate any required frequency, but
> I've been told for bxt there're some gaps in clock range that could be
> generated.

Ok, handling min/max clock (pixel clock I assume) should be easy.
Ranges are more difficuilt ...

But shouldn't the guest driver be able to cope with modes which can't be
displayed?  Monitors don't adjust edid to display driver capabilities
either, so the non-working modes are probably simply dropped from the
list of monitor modes ...

> > Oh, and btw:  Seems the resolution restriction (to 1024x768 for the
> > smallest vgpu type) seems to not be enforced.  Intentional?
> 
> hmm, what do you mean here? Not enforce to have only one mode for vgpu type?
> Or can't change to other mode?

Using i915-GVTg_V5_8 type.  Description says "resolution: 1024x768".
The edid data lists 640x480, 800x600, 1024x768.

I can set modes higher than 1024x768 though.  Can create custom modes
(using xrandr --newmode), attach them to the output (xrandr --addmode)
and activate them (xrandr --mode).

cheers,
  Gerd

