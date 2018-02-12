Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbeBLSkK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:40:10 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40853 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbeBLSkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:40:08 -0500
Date: Mon, 12 Feb 2018 19:40:06 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Lyude Paul <lyude@redhat.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Pierre Moreau <pierre.morrow@free.fr>,
        Archit Taneja <architt@codeaurora.org>,
        Ismo Toijala <ismo.toijala@gmail.com>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Peter Wu <peter@lekensteyn.nl>
Subject: Re: [Intel-gfx] [PATCH 2/5] drm: Allow determining if current task
 is output poll worker
Message-ID: <20180212184006.GA3862@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
 <7831d4f21dde8cd0b1659e393854598995dfb249.1518338788.git.lukas@wunner.de>
 <1518457571.5319.7.camel@redhat.com>
 <151845781278.18923.259952134307306444@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151845781278.18923.259952134307306444@mail.alporthouse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 05:50:12PM +0000, Chris Wilson wrote:
> Quoting Lyude Paul (2018-02-12 17:46:11)
> > On Sun, 2018-02-11 at 10:38 +0100, Lukas Wunner wrote:
> > > Introduce a helper to determine if the current task is an output poll
> > > worker.
> > > 
> > > This allows us to fix a long-standing deadlock in several DRM drivers
> > > wherein the ->runtime_suspend callback waits for the output poll worker
> > > to finish and the worker in turn calls a ->detect callback which waits
> > > for runtime suspend to finish.  The ->detect callback is invoked from
> > > multiple call sites and waiting for runtime suspend to finish is the
> > > correct thing to do except if it's executing in the context of the
> > > worker.
> > > 
> > > Cc: Dave Airlie <airlied@redhat.com>
> > > Cc: Ben Skeggs <bskeggs@redhat.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > ---
> > >  drivers/gpu/drm/drm_probe_helper.c | 14 ++++++++++++++
> > >  include/drm/drm_crtc_helper.h      |  1 +
> > >  2 files changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_probe_helper.c
> > > b/drivers/gpu/drm/drm_probe_helper.c
> > > index 555fbe54d6e2..019881d15ce1 100644
> > > --- a/drivers/gpu/drm/drm_probe_helper.c
> > > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > > @@ -653,6 +653,20 @@ static void output_poll_execute(struct work_struct
> > > *work)
> > >               schedule_delayed_work(delayed_work,
> > > DRM_OUTPUT_POLL_PERIOD);
> > >  }
> > >  
> > > +/**
> > > + * drm_kms_helper_is_poll_worker - is %current task an output poll worker?
> > > + *
> > > + * Determine if %current task is an output poll worker.  This can be used
> > > + * to select distinct code paths for output polling versus other contexts.
> > > + */
> > > +bool drm_kms_helper_is_poll_worker(void)
> > > +{
> > > +     struct work_struct *work = current_work();
> > > +
> > > +     return work && work->func == output_poll_execute;
> 
> What ensures that work is accessible? Does this need rcu_read_lock
> protection or more?

The work_struct exists as long this kthread is working on it.
Since this is called by the kthread itself, it is guaranteed to exist.
So there's no protection needed.

Thanks,

Lukas
