Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9FEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3042120880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfA1IKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:10:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfA1IKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:10:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12A8385546;
        Mon, 28 Jan 2019 08:10:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-116.ams2.redhat.com [10.36.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF4F91048116;
        Mon, 28 Jan 2019 08:10:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DC7F8A1E7; Mon, 28 Jan 2019 09:10:05 +0100 (CET)
Date:   Mon, 28 Jan 2019 09:10:05 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH v3 10/23] drm/qxl: move qxl_primary_apply_cursor to
 correct place
Message-ID: <20190128081005.j6z2ecnytuocfidh@sirius.home.kraxel.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-11-kraxel@redhat.com>
 <b3c756b3-c7b6-f4d3-5208-c8de0168d655@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3c756b3-c7b6-f4d3-5208-c8de0168d655@tronnes.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 28 Jan 2019 08:10:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The cursor must be set again after creating the primary surface.
> > Also drop the error message.

> >  	if (!bo->is_primary) {
> > -		if (!same_shadow)
> > +		if (!same_shadow) {
> >  			qxl_io_create_primary(qdev, 0, bo);
> > +			qxl_primary_apply_cursor(plane);
> > +		}
> >  		bo->is_primary = true;
> >  	}
> >  
> > 
> 
> I don't see how the commit message matches what you're doing. It gives
> the impression that it must be applied under yet another condition, but
> the condition for applying the cursor is changed from bo_old->is_primary
> to !bo->is_primary.

The qxl device ties the cursor to the primary surface.  Therefore
calling qxl_io_destroy_primary() and qxl_io_create_primary() to switch
the framebuffer causes the cursor information being lost and the driver
must re-apply it.

The correct call order to do that is qxl_io_destroy_primary() +
qxl_io_create_primary() + qxl_primary_apply_cursor().

The old code did qxl_io_destroy_primary() + qxl_primary_apply_cursor() +
qxl_io_create_primary().  Due to qxl_primary_apply_cursor request being
queued in a ringbuffer and qxl_io_create_primary() trapping to the
hypervisor instantly there is a high chance that qxl_io_create_primary()
is processed first even with the wrong call order.  But it's racy and
thus not reliable.

> It probably makes sense to someone that knows the driver.

If the above explains things better to you I should probably replace the
commit message with that.

> Acked-by: Noralf Trønnes <noralf@tronnes.org>

thanks,
  Gerd

