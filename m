Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933722AbeBMIRR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:17:17 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:59127 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933651AbeBMIRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:17:15 -0500
Date: Tue, 13 Feb 2018 09:17:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mike Lothian <mike@fireburn.co.uk>,
        Ismo Toijala <ismo.toijala@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dave Airlie <airlied@redhat.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 0/5] Fix deadlock on runtime suspend in DRM drivers
Message-ID: <20180213081713.GA8239@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
 <CAHbf0-Fhi9j5H7VTxF84SENQph+UQE2zRbi2Q-u_DAMh6x+eSg@mail.gmail.com>
 <20180211192314.GA22869@wunner.de>
 <20180211194154.GB22869@wunner.de>
 <CAHbf0-HSNJmXs_Nm+bbcfUifoLEpFsMSpM96a-pVfLFMNz3GFw@mail.gmail.com>
 <20180212033947.GA19049@wunner.de>
 <CAHbf0-GFdw9M8rv0+xHms9_HdcK_cgHak7G1ugtz0ch1_k6=vQ@mail.gmail.com>
 <20180212094500.22nvzzzpy6vrbqgc@wunner.de>
 <CADnq5_OaLNDZ10wzaqKGKkkjGVNLSTBPP76tch0aJY_mJ-EV4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OaLNDZ10wzaqKGKkkjGVNLSTBPP76tch0aJY_mJ-EV4Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 01:58:32PM -0500, Alex Deucher wrote:
> On Mon, Feb 12, 2018 at 4:45 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Feb 12, 2018 at 09:03:26AM +0000, Mike Lothian wrote:
> >> On 12 February 2018 at 03:39, Lukas Wunner <lukas@wunner.de> wrote:
> >> > On Mon, Feb 12, 2018 at 12:35:51AM +0000, Mike Lothian wrote:
> >> > > I've not been able to reproduce the original problem you're trying to
> >> > > solve on amdgpu thats with or without your patch set and the above
> >> > > "trigger" too
> >
> > Okay the reason you're not seeing deadlocks is because the output poll
> > worker is not enabled.  And the output poll worker is not enabled
> > because your discrete GPU doesn't have any outputs:
> >
> > [    0.265568] [drm:dc_create] *ERROR* DC: Number of connectors is zero!
> >
> > The outputs are only polled if there are connectors which have the
> > DRM_CONNECTOR_POLL_CONNECT or DRM_CONNECTOR_POLL_DISCONNECT flag set.
> > And that only ever seems to be the case for VGA and DVI.
> >
> > We know based on bugzilla reports that hybrid graphics laptops do exist
> > which poll outputs with radeon and nouveau.  If there are no laptops
> > supported by amdgpu whose discrete GPU has polled connectors, then
> > patch [5/5] would be unnecessary.  That is for Alex to decide.
> 
> Most hybrid laptops don't have display connectors on the dGPU and we
> only use polling on analog connectors, so you are not likely to run
> into this on recent laptops.  That said, I don't know if there is some
> OEM system out there with a VGA port on the dGPU in a hybrid laptop.
> I guess another option is to just disable polling on hybrid laptops.

If we don't know for sure, applying patch [5/5] would seem to be the
safest approach.  (Assuming it doesn't break anything else.)

Right now runtime PM is only used on hybrid graphics dGPUs by nouveau,
radeon and amdgpu.  Would it be conceivable that its use is expanded
beyond that in the future?  E.g. on a desktop machine, if DPMS is off
on all screens, why keep the GPU in D0?  If that is conceivable, chances
that analog connectors are present are higher, and then the patch would
be necessary again.  (Of course this would mean that analog screens
wouldn't light up automatically if they're attached while the GPU is
in D3hot, but the user may forbid runtime PM via sysfs if that is
unwanted.)

Thanks,

Lukas
