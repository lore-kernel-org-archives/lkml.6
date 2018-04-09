Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeDIIgy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:36:54 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37197 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeDIIfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:35:33 -0400
X-Google-Smtp-Source: AIpwx4+kdQao1dt/G63aicb1t/WkQJ2VWn4n776nzPm84UhVoyCZw6ZE65TPPQCU4Wtdk314tx2ATw==
Date: Mon, 9 Apr 2018 10:35:29 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Deepak Singh Rawat <drawat@vmware.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "lukasz.spintzyk@displaylink.com" <lukasz.spintzyk@displaylink.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com"
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2/3] drm: Add helper iterator functions to iterate over
 plane damage.
Message-ID: <20180409083529.GN31310@phenom.ffwll.local>
Mail-Followup-To: Deepak Singh Rawat <drawat@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "lukasz.spintzyk@displaylink.com" <lukasz.spintzyk@displaylink.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-3-git-send-email-drawat@vmware.com>
 <20180405075205.GQ3881@phenom.ffwll.local>
 <bdf67c61-3f4f-f321-9125-dc608c05c9b3@vmware.com>
 <MWHPR05MB3117ABEF02B500A3558FB14BBABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR05MB3117ABEF02B500A3558FB14BBABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 11:59:57PM +0000, Deepak Singh Rawat wrote:
> > plane damage.
> > 
> > On 04/05/2018 09:52 AM, Daniel Vetter wrote:
> > >
> > > TYPE_PLANE I have no idea who needs that. I suggest we just drop it.
> > 
> > I'm assuming CRTC plane coordinates here. They are used for uploading
> > contents of hardware planes. Like, in the simplest case, cursor images.
> 
> Yes they are CRTC plane coordinates, so is TYPE_PLANE naming confusing ?
> And should be named to TYPE_CRTC_PLANE but then it is confusing with
> TYPE_CRTC.

Yeah, I think TYPE_PLANE is really confusing, and too much aimied at your
vmwgfx special case (where the virtual hw requires that this all lines up
properly). I think providing FB coordinates, and doing the vmwgfx-specific
remapping in vmwgfx code is better.

And someone else can then figure out how to handle CRTC overall damage for
physical devices. As mentioned by me (and Rob Clark too), most hw only
allows for 1 (or maybe 2) overall damage rects, so that helper would need
to combine all the damge rects into 1. Plus take stuff like
gamma/ctm/alpha into account too. Better we leave that to someone who
needs it.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
