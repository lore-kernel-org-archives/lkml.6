Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A085DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6440E21522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6440E21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbeISX6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:58:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbeISX6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:58:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AAA830B9321;
        Wed, 19 Sep 2018 18:19:44 +0000 (UTC)
Received: from t450s.home (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8FC9183AE;
        Wed, 19 Sep 2018 18:19:37 +0000 (UTC)
Date:   Wed, 19 Sep 2018 12:19:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC v4 2/2] vfio: platform: Add generic reset controller
 support
Message-ID: <20180919121937.4c7fac9c@t450s.home>
In-Reply-To: <9dc74e23-2f57-7db3-6fb6-4f75ed61575f@redhat.com>
References: <20180917163955.19023-1-geert+renesas@glider.be>
        <20180917163955.19023-3-geert+renesas@glider.be>
        <b7c4f5d1-020b-4a64-d511-b8e89f8c9196@redhat.com>
        <CAMuHMdXM9eog_+1oV_YCmSbOfBSFWOXy+YXwKGvfJA65rDqtzA@mail.gmail.com>
        <9dc74e23-2f57-7db3-6fb6-4f75ed61575f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 19 Sep 2018 18:19:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 17:31:43 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Geert,
> 
> On 9/19/18 2:54 PM, Geert Uytterhoeven wrote:
> > Hi Eric,
> > 
> > On Wed, Sep 19, 2018 at 2:36 PM Auger Eric <eric.auger@redhat.com> wrote:  
> >> On 9/17/18 6:39 PM, Geert Uytterhoeven wrote:  
> >>> Vfio-platform requires dedicated reset support, provided either by ACPI,
> >>> or, on DT platforms, by a device-specific reset driver matching against
> >>> the device's compatible value.
> >>>
> >>> On many SoCs, devices are connected to an SoC-internal reset controller.
> >>> If the reset hierarchy is described in DT using "resets" properties, or
> >>> in lookup tables in platform code, such devices can be reset in a
> >>> generic way through the reset controller subsystem.  Hence add support
> >>> for this, avoiding the need to write device-specific reset drivers for
> >>> each single device on affected SoCs.
> >>>
> >>> Devices that do require a more complex reset procedure can still provide
> >>> a device-specific reset driver, as that takes precedence.
> >>>
> >>> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
> >>> becomes a no-op (as in: "No reset function found for device") if reset
> >>> controller support is disabled.
> >>>
> >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> >>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>  
> >   
> >>> --- a/drivers/vfio/platform/vfio_platform_common.c
> >>> +++ b/drivers/vfio/platform/vfio_platform_common.c  
> >   
> >>> @@ -128,8 +131,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
> >>>               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
> >>>                                                       &vdev->reset_module);
> >>>       }
> >>> +     if (vdev->of_reset)
> >>> +             return 0;
> >>> +
> >>> +     rstc = reset_control_get_dedicated(vdev->device, NULL);
> >>> +     if (!IS_ERR(rstc)) {
> >>> +             vdev->reset_control = rstc;
> >>> +             return 0;
> >>> +     }
> >>>
> >>> -     return vdev->of_reset ? 0 : -ENOENT;
> >>> +     return PTR_ERR(rstc);  
> >> This changes the returned value as seen by the user (probe returned
> >> valud). Can we keep -ENOENT in case of no reset controller found?  
> > 
> > On success, it still returns 0.
> > On failure, it forwards the error from reset_control_get_dedicated(), which
> > is IMHO better than replacing it by -ENOENT: we try to propagate error
> > codes as much as possible.  It could e.g. return -EPROBE_DEFER.
> > 
> > Is there anything that relies on the function returning -ENOENT?  
> None I am aware of actually. I was afraid about compatibility break but
> here we would change an errno by another one so maybe that's not a big
> deal at that stage of vfio_platform usage?

Yeah, I don't see that one errno vs another really matters in the grand
scheme of things.  I also don't see that propagating this particular
errno adds much value, but it is good general practice, so seems ok to
me unless there are other concerns.  Thanks,

Alex
