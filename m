Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeDLPrl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:47:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34146 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbeDLPrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:47:39 -0400
Date: Thu, 12 Apr 2018 16:47:27 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Ayan Kumar Halder <ayan.halder@arm.com>
Cc: liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        alexandru-cosmin.gheorghe@arm.com, nd@arm.com
Subject: Re: [PATCH] tda998x: Check ref count before invoking
 drm_connector_cleanup in unbind
Message-ID: <20180412154727.GJ16141@n2100.armlinux.org.uk>
References: <1523544152-15241-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523544152-15241-1-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 03:42:32PM +0100, Ayan Kumar Halder wrote:
> In a situation when the reference count of the drm connector is greater than 1,
> the unbind function should not invoke drm_connector_cleanup as this will lead
> to an inconsistent state where the drm_crtc_state->connector_mask still has
> a bitmask referring to the stale connector. Later, when drm driver invokes
> drm_atomic_helper_shutdown() which invokes ---> drm_atomic_helper_disable_all()
>  ---> drm_atomic_commit() --> drm_atomic_check_only() -->
> drm_atomic_helper_check() --> drm_atomic_helper_check_modeset(). This returns
> an error due to enabled/connectors mismatch.
> 
> In such a scenario, one should just return from _unbind() and let the drm driver
> subsequently invoke drm_atomic_helper_shutdown. This will reset the
> drm_crtc_state->connector_mask and will shutdown the crtcs. It will also decrement
> the reference count of the connectors to 1. Subsequently, drm_mode_config_cleanup
> will get invoked which will do the following :-

If the device is still in-use after unbind() has been called, that is
_very_ bad news, and probably means that the "host" driver is not
calling component_unbind() at the right point.

Any resources claimed in the bind() callback using devm functions
will be freed, which will include (eg) the drm_encoder structure and
in fact the drm_connector.  So what you have here is a use-after-free
bug, and your change does nothing for that.

Please fix the "host" driver instead.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
