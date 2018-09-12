Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43771C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64C420882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64C420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeILMGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:06:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbeILMGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4E1B804B9F4;
        Wed, 12 Sep 2018 07:03:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B3CA2023416;
        Wed, 12 Sep 2018 07:03:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8212611AB7; Wed, 12 Sep 2018 09:03:12 +0200 (CEST)
Date:   Wed, 12 Sep 2018 09:03:12 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Peter Wu <peter@lekensteyn.nl>
Cc:     Dave Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qxl: refactor to use drm_fb_helper_fbdev_setup
Message-ID: <20180912070312.kop4e2s3v5xeriwu@sirius.home.kraxel.org>
References: <20180910132156.23201-1-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910132156.23201-1-peter@lekensteyn.nl>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 07:03:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 07:03:13 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 03:21:56PM +0200, Peter Wu wrote:
> Lots of code can be removed by relying on fb-helper:
> - "struct drm_framebuffer" moves to fb_helper.fb.
> - "struct drm_gem_object" moves to fb_helper.obj[0].
> - "struct qxl_device" can be inferred as drm_fb_helper is embedded.
> - qxl_user_framebuffer_create -> drm_gem_fb_create.
> - qxl_user_framebuffer_destroy -> drm_gem_fb_destroy.
> - qxl_fbdev_destroy -> drm_fb_helper_fbdev_teardown + vfree(shadow).
> 
> Remove unused code:
> - qxl_fbdev_qobj_is_fb, qxl_fbdev_set_suspend.
> - Unused fields of qxl_fbdev: delayed_ops, delayed_ops_lock, size.
> 
> Misc notes:
> - The dirty callback is preserved as it is necessary to trigger update
>   commands in the hw (the screen stays black otherwise).
> - No idea when .create_handle in drm_framebuffer_funcs is used, but use
>   the same drm_gem_fb_create_handle to match drm_gem_fb_funcs.
> - I don't know why qxl_fb_find_or_create_single used to check for an
>   existing framebuffer and removed that check to match other drivers.
> - Use of drm_fb_helper_fbdev_teardown also requires "info->fbdefio" to
>   be dynamically allocated. Replace the existing defio config by
>   drm_fb_helper_defio_init to accomodate this.
> 
> Testing results: startx with fbdev, modesetting and qxl all seems to
> work. Tested also with CONFIG_DRM_FBDEV_EMULATION=n, fbdev obviously
> fails but others are fine. QEMU -spice and QEMU -spice with vdagent and
> multiple (resized) displays (via remote-viewer) also works.
> unbind vtconsole and rmmod has *not* regressed (i.e. it still trips on a
> use-after-free in qxl_check_idle via qxl_ttm_fini).
> 
> Ideally setup/teardown is replaced by drm_fbdev_generic_setup as that
> would result in further code reduction, improve error handling (like not
> leaking shadow memory), but unfortunately QXL has no implementation for
> qxl_gem_prime_vmap.

Pushed to drm-misc-next.

thanks,
  Gerd

