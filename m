Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933373AbeBLJpE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:45:04 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:48681 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933089AbeBLJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:45:03 -0500
Date: Mon, 12 Feb 2018 10:45:00 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Ismo Toijala <ismo.toijala@gmail.com>, nouveau@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>, Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 0/5] Fix deadlock on runtime suspend in DRM drivers
Message-ID: <20180212094500.22nvzzzpy6vrbqgc@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
 <CAHbf0-Fhi9j5H7VTxF84SENQph+UQE2zRbi2Q-u_DAMh6x+eSg@mail.gmail.com>
 <20180211192314.GA22869@wunner.de>
 <20180211194154.GB22869@wunner.de>
 <CAHbf0-HSNJmXs_Nm+bbcfUifoLEpFsMSpM96a-pVfLFMNz3GFw@mail.gmail.com>
 <20180212033947.GA19049@wunner.de>
 <CAHbf0-GFdw9M8rv0+xHms9_HdcK_cgHak7G1ugtz0ch1_k6=vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbf0-GFdw9M8rv0+xHms9_HdcK_cgHak7G1ugtz0ch1_k6=vQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 09:03:26AM +0000, Mike Lothian wrote:
> On 12 February 2018 at 03:39, Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Feb 12, 2018 at 12:35:51AM +0000, Mike Lothian wrote:
> > > I've not been able to reproduce the original problem you're trying to
> > > solve on amdgpu thats with or without your patch set and the above
> > > "trigger" too
> > >
> > > Is anything else required to trigger it, I started multiple DRI_PRIME
> > > glxgears, in parallel, serial waiting the 12 seconds and serial within
> > > the 12 seconds and I couldn't reproduce it
> >
> > The discrete GPU needs to runtime suspend, that's the trigger,
> > so no DRI_PRIME executables should be running.  Just let it
> > autosuspend after boot.  Do you see "waiting 12 sec" messages
> > in dmesg?  If not it's not autosuspending.
> 
> Yes I'm seeing those messages, I'm just not seeing the hangs
> 
> I've attached the dmesg in case you're interested

Okay the reason you're not seeing deadlocks is because the output poll
worker is not enabled.  And the output poll worker is not enabled
because your discrete GPU doesn't have any outputs:

[    0.265568] [drm:dc_create] *ERROR* DC: Number of connectors is zero!

The outputs are only polled if there are connectors which have the
DRM_CONNECTOR_POLL_CONNECT or DRM_CONNECTOR_POLL_DISCONNECT flag set.
And that only ever seems to be the case for VGA and DVI.

We know based on bugzilla reports that hybrid graphics laptops do exist
which poll outputs with radeon and nouveau.  If there are no laptops
supported by amdgpu whose discrete GPU has polled connectors, then
patch [5/5] would be unnecessary.  That is for Alex to decide.

However that is very good to know, so thanks a lot for your testing
efforts, much appreciated!

Kind regards,

Lukas
