Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187A1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE95E20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE95E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeLFOKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:10:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbeLFOKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:10:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C053308ED4B;
        Thu,  6 Dec 2018 14:10:16 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C0235FC38;
        Thu,  6 Dec 2018 14:10:16 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 23BDC3F600;
        Thu,  6 Dec 2018 14:10:16 +0000 (UTC)
Date:   Thu, 6 Dec 2018 09:10:15 -0500 (EST)
From:   Frediano Ziglio <fziglio@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Message-ID: <621894308.48603466.1544105415949.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181206134933.krvdvoz52lkpewb5@sirius.home.kraxel.org>
References: <20181206103352.20587-1-kraxel@redhat.com> <207905511.48580418.1544093965441.JavaMail.zimbra@redhat.com> <20181206114217.vog4fgae73us437u@sirius.home.kraxel.org> <1902655248.48590444.1544100790071.JavaMail.zimbra@redhat.com> <20181206134933.krvdvoz52lkpewb5@sirius.home.kraxel.org>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: use qxl_num_crtc directly
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.33.32.16, 10.4.195.9]
Thread-Topic: drm/qxl: use qxl_num_crtc directly
Thread-Index: PNogfT/N1orZKoCW2mQLaGGRRqs83Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 06 Dec 2018 14:10:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, Dec 06, 2018 at 07:53:10AM -0500, Frediano Ziglio wrote:
> > > 
> > > On Thu, Dec 06, 2018 at 05:59:25AM -0500, Frediano Ziglio wrote:
> > > > > 
> > > > > Just use qxl_num_crtc directly everywhere instead of using
> > > > > qdev->monitors_config->max_allowed.  Drops pointless indirection
> > > > > and also is less confusing.
> > > > > 
> > > > 
> > > > To me is MORE confusing, why comparing number of something with
> > > > another number? Previously code was comparing number of monitors
> > > > with number of monitors, not number of CRTs with number of
> > > > monitors.
> > > 
> > > Yes, spice/qxl and drm/kms use slightly different terminology.
> > > 
> > > drm crtc == qxl monitor.
> > > drm framebuffer == qxl surface.
> > > 
> > > You need to know that anyway when looking at the qxl ksm code.  We
> > > have function names like qxl_crtc_update_monitors_config().  I fail
> > > to see why that is a problem ...
> > > 
> > > cheers,
> > >   Gerd
> > 
> > I don't see any problem too but you are explaining to me
> > why your rationale "and also is less confusing" does not
> > stand.
> 
> Well, it's less confusing because it takes away an indirection (not
> because of the naming).
> 

It does not confuse me.

> qdev->monitors_config->max_allowed is effectively set by a module
> parameter.  So using the module parameter variable qxl_num_crtc
> directly is better IMO.  The kernel doesn't need to dereference pointers
> each time it needs the value, and when reading the code you don't have
> to trace where and why qdev->monitors_config->max_allowed is set.
> 

That should go to the commit message!
With that the patch is fine for me.

Maybe there's no much point on reusing the same structure used
inside QXLRom/QXLRam but this is OT for this patch.

> cheers,
>   Gerd
> 
> 

Frediano
