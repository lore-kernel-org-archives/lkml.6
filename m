Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeEVQf4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:35:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbeEVQfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:35:52 -0400
Date: Tue, 22 May 2018 17:35:50 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Eric Anholt <eric@anholt.net>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>
Subject: Re: [PATCH v8 2/3] drm: writeback: Add out-fences for writeback
 connectors
Message-ID: <20180522163550.GE1582@e110455-lin.cambridge.arm.com>
References: <20180518151743.29937-1-Liviu.Dudau@arm.com>
 <20180518151743.29937-3-Liviu.Dudau@arm.com>
 <87a7ssu91a.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7ssu91a.fsf@anholt.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 12:02:25PM -0700, Eric Anholt wrote:
> Liviu Dudau <Liviu.Dudau@arm.com> writes:
> 
> > From: Brian Starkey <brian.starkey@arm.com>
> >
> > Add the WRITEBACK_OUT_FENCE_PTR property to writeback connectors, to
> > enable userspace to get a fence which will signal once the writeback is
> > complete. It is not allowed to request an out-fence without a
> > framebuffer attached to the connector.
> >
> > A timeline is added to drm_writeback_connector for use by the writeback
> > out-fences.
> 
> 
> > diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> > index cf3a28676006a..6a7462c1821ad 100644
> > --- a/include/drm/drm_writeback.h
> > +++ b/include/drm/drm_writeback.h
> > @@ -49,6 +49,32 @@ struct drm_writeback_connector {
> >  	 * drm_writeback_signal_completion()
> >  	 */
> >  	struct list_head job_queue;
> > +
> > +	/**
> > +	 * @fence_context:
> > +	 *
> > +	 * timeline context used for fence operations.
> > +	 */
> > +	unsigned int fence_context;
> > +	/**
> > +	 * @fence_lock:
> > +	 *
> > +	 * spinlock to protect the fences in the fence_context.
> > +	 */
> > +	spinlock_t fence_lock;
> > +	/**
> > +	 * @fence_seqno:
> > +	 *
> > +	 * Seqno variable used as monotonic counter for the fences
> > +	 * created on the connector's timeline.
> > +	 */
> > +	unsigned long fence_seqno;
> > +	/**
> > +	 * @timeline_name:
> > +	 *
> > +	 * The name of the connector's fence timeline.
> > +	 */
> > +	char timeline_name[32];
> >  };
> >  
> >  struct drm_writeback_job {
> > @@ -59,12 +85,14 @@ struct drm_writeback_job {
> >  	 * framebuffer reference to a workqueue.
> >  	 */
> >  	struct work_struct cleanup_work;
> > +
> >  	/**
> >  	 * @list_entry:
> >  	 *
> >  	 * List item for the connector's @job_queue
> >  	 */
> >  	struct list_head list_entry;
> > +
> >  	/**
> >  	 * @fb:
> >  	 *
> 
> Move this hunk into patch 1?

I can, however this is the only change I will be making. Is it worth
respinning a new revision for it?

> 
> Other than that, the series is:
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

Many thanks for that!

> 
> It's pretty clean and makes sense to me.  I only had some questions
> about the job_queue, which seems superfluous if we aren't supporting
> firing off a new writeback while an old one is outstanding (and maybe we
> should throw an error in that case).  Still, I think this is ready to land.

I know Sean and Daniel are on holiday. Are you OK to pull this into
drm-misc? Should I ask Gustavo to do it?

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
