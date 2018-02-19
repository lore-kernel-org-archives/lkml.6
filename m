Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbeBSOrs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:47:48 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:52499 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeBSOrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:47:45 -0500
Date: Mon, 19 Feb 2018 15:47:42 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Ismo Toijala <ismo.toijala@gmail.com>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, Liviu Dudau <Liviu.Dudau@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [Intel-gfx] [Nouveau] [PATCH 0/5] Fix deadlock on runtime
 suspend in DRM drivers
Message-ID: <20180219144742.yffm3ptzyrslccjj@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
 <20180219113443.GU22199@phenom.ffwll.local>
 <20180219115817.4e5ml4jdh22kbvs4@wunner.de>
 <20180219140553.GA22199@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219140553.GA22199@phenom.ffwll.local>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 03:05:53PM +0100, Daniel Vetter wrote:
> On Mon, Feb 19, 2018 at 12:58:17PM +0100, Lukas Wunner wrote:
> > On Mon, Feb 19, 2018 at 12:34:43PM +0100, Daniel Vetter wrote:
> > > Well, userspace expects hotplug events, even when we runtime suspend
> > > stuff. Hence waking shit up with polling. Imo ignoring hotplug events is a
> > > pretty serious policy decision which is ok in the context of
> > > vga_switcheroo, but not really as an automatic thing. E.g. usb also wakes
> > > up if you plug something in, even with all the runtime pm stuff enabled.
> > > Same for sata and everything else.
> > 
> > On the MacBook Pro, the HPD pin of external DP and HDMI ports goes into
> > the gmux controller, which sends an interrupt on hotplug even if the GPU
> > is powered down.
> > 
> > Apparently Optimus has a similar functionality, cf. 3a6536c51d5d.
> 
> Yeah, for vga_switcheroo and gmux setups shutting down polling explicitly
> makes sense. I think ideally we'd stop polling in the gmux handler somehow
> (maybe by dropping the relevant DRM_CONNECTOR_POLL flags, or outright
> stopping it all). But not when runtime suspending the entire gpu (e.g.
> idle system that shuts down the screen and everything, before it decides
> a few minutes later to do a full system suspend).

nouveau, radeon and amdgpu currently use runtime PM *only* on hybrid
graphics laptops.

Should the drivers later be extended to also use runtime PM in other
scenarios (desktop machines, eGPUs), they can easily detect whether
to disable polling on runtime suspend by calling apple_gmux_present()
on Macs or the equivalent for Optimus/ATPX.

Thanks,

Lukas
