Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeBLRuf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:50:35 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:56583 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751063AbeBLRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:50:34 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Lyude Paul <lyude@redhat.com>, "Lukas Wunner" <lukas@wunner.de>,
        "Tejun Heo" <tj@kernel.org>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Dave Airlie" <airlied@redhat.com>, "Ben Skeggs" <bskeggs@redhat.com>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1518457571.5319.7.camel@redhat.com>
Cc: "Pierre Moreau" <pierre.morrow@free.fr>,
        "Archit Taneja" <architt@codeaurora.org>,
        "Ismo Toijala" <ismo.toijala@gmail.com>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Hans de Goede" <hdegoede@redhat.com>,
        "Peter Wu" <peter@lekensteyn.nl>
References: <cover.1518338788.git.lukas@wunner.de>
 <7831d4f21dde8cd0b1659e393854598995dfb249.1518338788.git.lukas@wunner.de>
 <1518457571.5319.7.camel@redhat.com>
Message-ID: <151845781278.18923.259952134307306444@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [Intel-gfx] [PATCH 2/5] drm: Allow determining if current task is output
 poll worker
Date: Mon, 12 Feb 2018 17:50:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lyude Paul (2018-02-12 17:46:11)
> On Sun, 2018-02-11 at 10:38 +0100, Lukas Wunner wrote:
> > Introduce a helper to determine if the current task is an output poll
> > worker.
> > 
> > This allows us to fix a long-standing deadlock in several DRM drivers
> > wherein the ->runtime_suspend callback waits for the output poll worker
> > to finish and the worker in turn calls a ->detect callback which waits
> > for runtime suspend to finish.  The ->detect callback is invoked from
> > multiple call sites and waiting for runtime suspend to finish is the
> > correct thing to do except if it's executing in the context of the
> > worker.
> > 
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/gpu/drm/drm_probe_helper.c | 14 ++++++++++++++
> >  include/drm/drm_crtc_helper.h      |  1 +
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_probe_helper.c
> > b/drivers/gpu/drm/drm_probe_helper.c
> > index 555fbe54d6e2..019881d15ce1 100644
> > --- a/drivers/gpu/drm/drm_probe_helper.c
> > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > @@ -653,6 +653,20 @@ static void output_poll_execute(struct work_struct
> > *work)
> >               schedule_delayed_work(delayed_work,
> > DRM_OUTPUT_POLL_PERIOD);
> >  }
> >  
> > +/**
> > + * drm_kms_helper_is_poll_worker - is %current task an output poll worker?
> > + *
> > + * Determine if %current task is an output poll worker.  This can be used
> > + * to select distinct code paths for output polling versus other contexts.
> > + */
> For this, it would be worth explicitly noting in the comments herethat this
> should be called by DRM drivers in order to prevent racing with hotplug
> polling workers, so that new drivers in the future can avoid implementing this
> race condition in their driver.
> 
> > +bool drm_kms_helper_is_poll_worker(void)
> > +{
> > +     struct work_struct *work = current_work();
> > +
> > +     return work && work->func == output_poll_execute;

What ensures that work is accessible? Does this need rcu_read_lock
protection or more?
-Chris
