Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeCSNvs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:51:48 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53603 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbeCSNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:51:46 -0400
X-Google-Smtp-Source: AG47ELtcsGavnwl/W4sMvB0bo2YiRYGg2tZ2OkA7EHnqKOcA/gdndBIglm7itlXlYH3Wfa9CKNDAHA==
Date: Mon, 19 Mar 2018 14:51:41 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH RESEND v2 1/2] drm/xen-front: Add support for Xen PV
 display frontend
Message-ID: <20180319135141.GK14155@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1520958066-22875-1-git-send-email-andr2000@gmail.com>
 <1520958066-22875-2-git-send-email-andr2000@gmail.com>
 <20180316082330.GF25297@phenom.ffwll.local>
 <b466004a-821e-60b7-787b-526e10a67505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b466004a-821e-60b7-787b-526e10a67505@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:52:09PM +0200, Oleksandr Andrushchenko wrote:
> Hi, Daniel!
> Sorry, if I strip the patch too much below.
> 
> On 03/16/2018 10:23 AM, Daniel Vetter wrote:
> > 
> > S-o-b line went missing here :-)
> will restore it back ;)
> > 
> > I've read through it, 2 actual review comments (around hot-unplug and
> > around the error recovery for failed flips), a few bikesheds, but looks
> > all reasonable to me. And much easier to read as one big patch (it's just
> > 3k).
> > 
> > One more thing I'd do as a follow-up (don't rewrite everything, this is
> > close to merge, better to get it in first): You have a lot of indirections
> > and function calls across sources files. That's kinda ok if you have a
> > huge driver with 100+k lines of code where you have to split things up.
> > But for a small driver like yours here it's a bit overkill.
> will review and try to rework after the driver is in
> > 
> > Personally I'd merge at least the xen backend stuff into the corresponding
> > kms code, but that's up to you.
> I prefer to have it in smaller chunks and all related code at
> one place, so it is easier to maintain. That is why I didn't
> plumb frontend <-> backend code right into the KMS code.
> > And as mentioned, if you decide to do
> > that, a follow-up patch (once this has merged) is perfectly fine.
> Ok, after the merge

If you prefer your current layout, then pls keep it. Bikeshed = personal
style nit, feel free to ignore if you like stuff differently. In the end
it's your driver, not mine, and I can easily navigate the current code
(with a few extra jumps).
-Daniel

> > -Daniel
> > 
> > > +int xen_drm_front_dbuf_create_from_sgt(struct xen_drm_front_info *front_info,
> > > +		uint64_t dbuf_cookie, uint32_t width, uint32_t height,
> > > +		uint32_t bpp, uint64_t size, struct sg_table *sgt)
> > > +{
> > > +	return be_dbuf_create_int(front_info, dbuf_cookie, width, height,
> > > +			bpp, size, NULL, sgt);
> > > +}
> > > +
> > > +int xen_drm_front_dbuf_create_from_pages(struct xen_drm_front_info *front_info,
> > > +		uint64_t dbuf_cookie, uint32_t width, uint32_t height,
> > > +		uint32_t bpp, uint64_t size, struct page **pages)
> > > +{
> > > +	return be_dbuf_create_int(front_info, dbuf_cookie, width, height,
> > > +			bpp, size, pages, NULL);
> > > +}
> > The above two wrappers seem a bit much, just to set sgt = NULL or pages =
> > NULL in one of them. I'd drop them, but that's a bikeshed so feel free to
> > ignore.
> I had that the way you say in some of the previous implementations,
> but finally decided to have these dummy wrappers: seems
> to be cleaner this way
> > > +static void displback_disconnect(struct xen_drm_front_info *front_info)
> > > +{
> > > +	bool removed = true;
> > > +
> > > +	if (front_info->drm_pdev) {
> > > +		if (xen_drm_front_drv_is_used(front_info->drm_pdev)) {
> > > +			DRM_WARN("DRM driver still in use, deferring removal\n");
> > > +			removed = false;
> > > +		} else
> > > +			xen_drv_remove_internal(front_info);
> > Ok this logic here is fishy, since you're open-coding the drm unplug
> > infrastructure, but slightly differently and slightyl racy. If you have a
> > driver where your underlying "hw" (well it's virtual here, but same idea)
> > can disappear any time while userspace is still using the drm driver, you
> > need to use the drm_dev_unplug() function and related code.
> > drm_dev_unplug() works like drm_dev_unregister, except for the hotplug
> > case.
> > 
> > Then you also have to guard all the driver entry points where you do
> > access the backchannel using drm_dev_is_unplugged() (I've seen a few of
> > those already). Then you can rip out all the logic here and the xen_drm_front_drv_is_used() helper.
> Will rework it with drm_dev_unplug, thank you
> > I thought there's some patches from Noralf in-flight that improved the
> > docs on this, I need to check
> > 
> > > +#define XEN_DRM_NUM_VIDEO_MODES		1
> > > +#define XEN_DRM_CRTC_VREFRESH_HZ	60
> > > +
> > > +static int connector_get_modes(struct drm_connector *connector)
> > > +{
> > > +	struct xen_drm_front_drm_pipeline *pipeline =
> > > +			to_xen_drm_pipeline(connector);
> > > +	struct drm_display_mode *mode;
> > > +	struct videomode videomode;
> > > +	int width, height;
> > > +
> > > +	mode = drm_mode_create(connector->dev);
> > > +	if (!mode)
> > > +		return 0;
> > > +
> > > +	memset(&videomode, 0, sizeof(videomode));
> > > +	videomode.hactive = pipeline->width;
> > > +	videomode.vactive = pipeline->height;
> > > +	width = videomode.hactive + videomode.hfront_porch +
> > > +			videomode.hback_porch + videomode.hsync_len;
> > > +	height = videomode.vactive + videomode.vfront_porch +
> > > +			videomode.vback_porch + videomode.vsync_len;
> > > +	videomode.pixelclock = width * height * XEN_DRM_CRTC_VREFRESH_HZ;
> > > +	mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
> > > +
> > > +	drm_display_mode_from_videomode(&videomode, mode);
> > > +	drm_mode_probed_add(connector, mode);
> > > +	return XEN_DRM_NUM_VIDEO_MODES;
> > Bikeshed: just hardcode this to 1, the #define is imo more confusing.
> ok, will remove #define
> > 
> > > +
> > > +	}
> > > +	/*
> > > +	 * Send page flip request to the backend *after* we have event cached
> > > +	 * above, so on page flip done event from the backend we can
> > > +	 * deliver it and there is no race condition between this code and
> > > +	 * event from the backend.
> > > +	 * If this is not a page flip, e.g. no flip done event from the backend
> > > +	 * is expected, then send now.
> > > +	 */
> > > +	if (!display_send_page_flip(pipe, old_plane_state))
> > > +		xen_drm_front_kms_send_pending_event(pipeline);
> > The control flow here is a bit confusing. I'd put the call to send out the
> > event right away in case of a failure to communicate with the backend into
> > display_send_page_flip() itself. Then drop the bool return value and make
> > it void, and also push the comment explaining what you do in case of
> > errors into that function.
> The reason for having bool for page flip here is that we
> need to send pending event for display enable/disable, for example.
> So, I decided to make it this way:
> 1. page flip handled - handles pending event internally
> (defers sending until frame done event from the backend)
> 2. page flip failed - handles externally in case of any
> page flip related error, e.g. "not handled" cases, either
> due to backend communication error or whatever else
> 3. all other cases, but page flip
> > 
> > That way the error handling and recovery is all neatly tied together in
> > one place instead of spread around.
> Well, I tried to keep it all at one place, but as we decided
> to implement connector hotplug for error delivery it
> became split. Also, I handle frame done event time-outs there.

You can leave things as-is if you prefer, just for me it looked a bit
confusion and unecessarily complex.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
