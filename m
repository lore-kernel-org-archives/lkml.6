Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeDDMN6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:13:58 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40177 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeDDMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:13:56 -0400
X-Google-Smtp-Source: AIpwx49x2Y60WNyYqcQcEHahoFs/y9FDGgcuM6GPzZWnVy8yFCBu44yEvPbn1Ze1vcIDv2ckSKQTcA==
Date: Wed, 4 Apr 2018 14:13:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Hellstrom <thomas@shipmail.org>
Cc: Rob Clark <robdclark@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>,
        Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>,
        Deepak Singh Rawat <drawat@vmware.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
Message-ID: <20180404121351.GJ3881@phenom.ffwll.local>
Mail-Followup-To: Thomas Hellstrom <thomas@shipmail.org>,
        Rob Clark <robdclark@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>,
        Deepak Singh Rawat <drawat@vmware.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180403224225.26776-1-robdclark@gmail.com>
 <CAKMK7uEH3Qu_Lkok60bOYkik6kyvDGtrS0kcQ=dFmCLRD-+1HA@mail.gmail.com>
 <307adb15-412a-1fe2-f116-27fe5b4a657d@shipmail.org>
 <20180404084320.GA3881@phenom.ffwll.local>
 <fa4074c7-5469-a69f-e4aa-bdc84e1a919a@shipmail.org>
 <20180404095604.GD3881@phenom.ffwll.local>
 <9b731e33-32fd-e7e7-952f-75b87ff26f8a@shipmail.org>
 <61931c2e-4c81-0d94-fd45-f4f7dd91cb13@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61931c2e-4c81-0d94-fd45-f4f7dd91cb13@shipmail.org>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 01:46:37PM +0200, Thomas Hellstrom wrote:
> On 04/04/2018 12:28 PM, Thomas Hellstrom wrote:
> > On 04/04/2018 11:56 AM, Daniel Vetter wrote:
> > > On Wed, Apr 04, 2018 at 11:10:08AM +0200, Thomas Hellstrom wrote:
> > > > On 04/04/2018 10:43 AM, Daniel Vetter wrote:
> > > > > On Wed, Apr 04, 2018 at 10:22:21AM +0200, Thomas Hellstrom wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On 04/04/2018 08:58 AM, Daniel Vetter wrote:
> > > > > > > On Wed, Apr 4, 2018 at 12:42 AM, Rob Clark
> > > > > > > <robdclark@gmail.com> wrote:
> > > > > > > > Add an atomic helper to implement dirtyfb
> > > > > > > > support.  This is needed to
> > > > > > > > support DSI command-mode panels with x11
> > > > > > > > userspace (ie. when we can't
> > > > > > > > rely on pageflips to trigger a flush to the panel).
> > > > > > > > 
> > > > > > > > To signal to the driver that the async atomic update needs to
> > > > > > > > synchronize with fences, even though the fb didn't change, the
> > > > > > > > drm_atomic_state::dirty flag is added.
> > > > > > > > 
> > > > > > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > > > > > > ---
> > > > > > > > Background: there are a number of different
> > > > > > > > folks working on getting
> > > > > > > > upstream kernel working on various different
> > > > > > > > phones/tablets with qcom
> > > > > > > > SoC's.. many of them have command mode panels, so we kind of need a
> > > > > > > > way to support the legacy dirtyfb ioctl for x11 support.
> > > > > > > > 
> > > > > > > > I know there is work on a proprer non-legacy atomic property for
> > > > > > > > userspace to communicate dirty-rect(s) to the kernel, so this can
> > > > > > > > be improved from triggering a full-frame flush once that is in
> > > > > > > > place.  But we kinda needa a stop-gap solution.
> > > > > > > > 
> > > > > > > > I had considered an in-driver solution for this, but things get a
> > > > > > > > bit tricky if userspace ands up combining dirtyfb ioctls with page-
> > > > > > > > flips, because we need to synchronize setting
> > > > > > > > various CTL.FLUSH bits
> > > > > > > > with setting the CTL.START bit.  (ie. really all we need to do for
> > > > > > > > cmd mode panels is bang CTL.START, but is this ends up racing with
> > > > > > > > pageflips setting FLUSH bits, then bad things.)  The easiest soln
> > > > > > > > is to wrap this up as an atomic commit and rely on the worker to
> > > > > > > > serialize things.  Hence adding an atomic dirtyfb helper.
> > > > > > > > 
> > > > > > > > I guess at least the helper, with some small addition to translate
> > > > > > > > and pass-thru the dirty rect(s) is useful to the
> > > > > > > > final atomic dirty-
> > > > > > > > rect property solution.  Depending on how far off that is, a stop-
> > > > > > > > gap solution could be useful.
> > > > > > > Adding Noralf, who iirc already posted the full
> > > > > > > dirty helpers already somewhere.
> > > > > > > -Daniel
> > > > > > I've asked Deepak to RFC the core changes suggested for
> > > > > > the full dirty blob
> > > > > > on dri-devel. It builds on DisplayLink's suggestion,
> > > > > > with a simple helper to
> > > > > > get to the desired coordinates.
> > > > > > 
> > > > > > One thing to perhaps discuss is how we would like to fit this with
> > > > > > front-buffer rendering and the dirty ioctl. In the
> > > > > > page-flip context, the
> > > > > > dirty rects, like egl's swapbuffer_with_damage is a hint
> > > > > > to restrict the
> > > > > > damage region that can be fully ignored by the driver, new content is
> > > > > > indicated by a new framebuffer.
> > > > > > 
> > > > > > We could do the same for frontbuffer rendering: Either
> > > > > > set a dirty flag like
> > > > > > you do here, or provide a content_age state member.
> > > > > > Since we clear the dirty
> > > > > > flag on state copies, I guess that would be sufficient.
> > > > > > The blob rectangles
> > > > > > would then become a hint to restrict the damage region.
> > > > > I'm not entirely following here - I thought for frontbuffer
> > > > > rendering the
> > > > > dirty rects have always just been a hint, and that the
> > > > > driver was always
> > > > > free to re-upload the entire buffer to the screen.
> > > > > 
> > > > > And through a helper like Rob's proposing here (and have
> > > > > floated around in
> > > > > different versions already) we'd essentially map a frontbuffer dirtyfb
> > > > > call to a fake flip with dirty rect. Manual upload drivers
> > > > > already need to
> > > > > upload the entire screen if they get a flip, since some userspace uses
> > > > > that to flush out frontbuffer rendering (instead of calling dirtyfb).
> > > > > 
> > > > > So from that pov the new dirty flag is kinda not necessary imo.
> > > > > 
> > > > > > Another approach would be to have the presence of dirty rects without
> > > > > > framebuffer change to indicate frontbuffer rendering.
> > > > > > 
> > > > > > I think I like the first approach best, although it may
> > > > > > be tempting for
> > > > > > user-space apps to just set the dirty bit instead of
> > > > > > providing the full
> > > > > > damage region.
> > > > > Or I'm not following you here, because I don't quite see the
> > > > > difference
> > > > > between dirtyfb and a flip.
> > > > > -Daniel
> > > > OK, let me rephrase:
> > > > 
> > > >  From the driver's point-of-view, in the atomic world, new
> > > > content and the
> > > > need for manual upload is indicated by a change in fb attached
> > > > to the plane.
> > > > 
> > > > With Rob's patch here, (correct me if I'm wrong) in addition new
> > > > content and
> > > > the need for manual upload is identified by the dirty flag,
> > > > (since the fb
> > > > stays the same and the driver thus never identifies a page-flip).
> > > Hm, I'm not entirely sure Rob's approach is correct. Imo a pageflip
> > > (atomic or not) should result in the entire buffer getting uploaded. The
> > > dirty flag is kinda redundant, a flip with the same buffer works the
> > > same
> > > way as a dirtyfb with the entire buffer as the dirty rectangle.
> > > 
> > > > In both these situations, clip rects can provide a hint to restrict the
> > > > dirty region.
> > > > 
> > > > Now I was thinking about the preferred way for user-space to
> > > > communicate
> > > > front buffer rendering through the atomic ioctl:
> > > > 
> > > > 1) Expose a dirty (or content_age property)
> > > > 2) Attach a clip-rect blob property.
> > > > 3) Fake a page-flip by ping-ponging two frame-buffers pointing
> > > > to the same
> > > > underlying buffer object.
> > > > 
> > > > Are you saying that people are already using 3) and we should
> > > > keep using
> > > > that?
> > > I'm saying they're using 3b), flip the same buffer wrapped in the same
> > > drm_framebuffer, and expect it to work.
> > > 
> > > The only advantage dirtyfb has is that it allows you to supply the
> > > optimized upload rectangles, but at the cost of a funny api (it's
> > > working
> > > on the fb, not the plane/crtc you want to upload) and lack of
> > > drm_event to
> > > confirm when exactly you uploaded your stuff. But imo they should be the
> > > same underlying operation.
> > > 
> > > Also note that atomic helpers don't optimize out plane flips for same
> > > buffers. We only optimize out some of the waiting, in a failed
> > > attempt at
> > > making cursors stall less, but that's not fixed with the async plane
> > > update stuff. And we can obviously optimize out the prepare/cleanup
> > > hooks,
> > > because the buffer should be pinned already.
> > > 
> > 
> > I'm a bit confused.
> > 
> > Apparently we have different opinions in when an uploading driver should
> > assume altered plane content and the need for re-upload.
> > vmwgfx is from what I know currently assuming that this happens only on
> > changed fb attachment (what we call a page-flip) whereas if I understand
> > you correctly it should happen on each atomic state commit?
> > 
> > If we should assume the latter, then it has odd implications, let's say
> > you have 8 screens up, and you pan one of them on the large fb, why
> > would you upload the contents of the other 7?
> > 
> > Likewise for cursors,  why would you want to upload the cursor image on
> > each cursor move?
> > 
> > So in my POW, option 1) is the option that aligns with the current
> > vmwgfx implementation and from what I can tell, what Rob has implemented
> > in his patch.
> > 
> 
> Hmm.
> 
> After doing some apparently well needed reading up on the code it looks like
> vmwgfx is actually doing a full upload on each plane state change,
> only those planes that actually got changed are referenced in the update. So
> that takes care of the panning example, assuming user-space is smart enough
> to leave the unchanged planes / crtcs out of the update.
> 
> However, the cursor example still holds, and IMHO we should have a better
> way to define content change than plane state update...

We're definitely inconsistent here. I guess for manual upload drivers on
real hw panning isn't a note-worthy special case, since if you pan you
need to upload the entire damaged area on the screen anyway. But virtual
hw drivers like vmwgfx are different this way, since panning only means
you transmit the new position to the host driver, but don't have to upload
the entire thing.

And the legacy cursor ioctl seems to be the only thing with that
expectation (although I think funny experiments on i915 used gpu
rendering for that too).

Simply for robustness reasons I'd say that with maybe the exception of
cursors, we should assume that a flip must upload the entire buffer that's
getting flipped, since that's how it works on most drivers.

And then we can add the dirty rectangle stuff so that clever userspace and
clever drives can optimize this all again. And preferrably the cursor
trick would be implemented by having an empty dirty rect, instead of one
that spans the entire fb.
-Daniel

> 
> /Thomas
> 
> 
> 
> > /Thomas
> > 
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
