Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754810AbeEHHlQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:41:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37016 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754500AbeEHHlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:41:14 -0400
X-Google-Smtp-Source: AB8JxZpTx/wCXIemvIfV4obGEXZZjvYtxKCEQ+1iYVqXqyQznARUYP+1RkPW08XQd6gwl3dGirLw2g==
Date: Tue, 8 May 2018 09:41:09 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] drm/sti: do not remove the drm_bridge that was never
 added
Message-ID: <20180508074109.GL28661@phenom.ffwll.local>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180502074025.12421-1-peda@axentia.se>
 <20180502074025.12421-2-peda@axentia.se>
 <20180503090648.GG12521@phenom.ffwll.local>
 <bd8d12f7-0c71-c96b-80fa-54de7de39511@axentia.se>
 <20180507133929.GG12521@phenom.ffwll.local>
 <d378241f-7420-bbaf-c447-18cdfd4f9dd3@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d378241f-7420-bbaf-c447-18cdfd4f9dd3@axentia.se>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 03:59:04PM +0200, Peter Rosin wrote:
> On 2018-05-07 15:39, Daniel Vetter wrote:
> > On Thu, May 03, 2018 at 11:12:21PM +0200, Peter Rosin wrote:
> >> On 2018-05-03 11:06, Daniel Vetter wrote:
> >>> On Wed, May 02, 2018 at 09:40:23AM +0200, Peter Rosin wrote:
> >>>> The more natural approach would perhaps be to add an drm_bridge_add,
> >>>> but there are several other bridges that never call drm_bridge_add.
> >>>> Just removing the drm_bridge_remove is the easier fix.
> >>>>
> >>>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>>
> >>> This mess is much bigger. There's 2 pairs of bridge functions:
> >>>
> >>> - drm_bridge_attach/detach. Those are meant to be called by the overall
> >>>   drm driver to connect/disconnect a drm_bridge.
> >>>
> >>> - drm_bridge_add/remove. These are supposed to be called by the bridge
> >>>   driver itself to register/unregister itself. Maybe we should rename
> >>>   them, since the same issue happens with drm_panel, with the same
> >>>   confusion.
> >>>
> >>> I thought someone was working on a cleanup series to fix this mess, but I
> >>> didn't find anything.
> >>
> >> Ok, I just spotted the imbalance and didn't really dig into what
> >> actually happens in these error paths. Now that I have done so I
> >> believe that the removed drm_bridge_remove calls causes NULL
> >> dereferences if/when the error paths are triggered.
> >>
> >> So, I don't think this can wait for some bigger cleanup.
> >>
> >> drm_bridge_remove calls list_del_init calls __list_del_entry calls
> >> __list_del with NULL in both prev and next since the list member
> >> is never initialized. prev and next are dereferenced by __list_del
> >> and you have *boom*
> >>
> >> I recommend adding the tag
> >>
> >> Fixes: 84601dbdea36 ("drm: sti: rework init sequence")
> >>
> >> so that stable picks this one up.
> > 
> > I just wanted to correct your commit message text - the correct solution
> > is definitely _not_ for sti here to call drm_bridge_add.
> 
> Ah, I see what you mean. Do you want me to respin?
> 
> >                                                          It should call
> > drm_bridge_attach/detach only, as a pair.
> 
> Alas, the attach/detach functions are generally not called from the same
> level. After the bridge has been attached to an encoder, it is detached
> in the generic code shutting down the encoder, i.e. the bridge consumer
> is not explicitly involved with bridge detaching.
> 
> > I didn't check whether you instead have a _detach call missing or what's
> > going on here.
> 
> So, even though there is no _detach call, it is still not "missing" as
> it is not supposed to be there...

Oh, TIL. Totally missed that we've improved this to be closer to dwim()
semantics. I think your patch is correct as-is and has my

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

It'd be great to improve the kerneldoc for drm_bridge_attach though to
mention that bridges get auto-detached on encoder cleanup as don in
drm_encoder_cleanup(). Care to do that?

And on that note I've again realized that most drivers totally get this
wrong when they set their ->destroy callback to drm_encoder_cleanup
(similar for other kms objects), because that one does _not_ do the final
kfree. Oh well.
-Daniel

> 
> Cheers,
> Peter
> 
> > -Daniel
> >>
> >> Cheers,
> >> Peter
> >>
> >>> -Daniel
> >>>
> >>>> ---
> >>>>  drivers/gpu/drm/sti/sti_hda.c  | 1 -
> >>>>  drivers/gpu/drm/sti/sti_hdmi.c | 1 -
> >>>>  2 files changed, 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
> >>>> index 67bbdb49fffc..199db13f565c 100644
> >>>> --- a/drivers/gpu/drm/sti/sti_hda.c
> >>>> +++ b/drivers/gpu/drm/sti/sti_hda.c
> >>>> @@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
> >>>>  	return 0;
> >>>>  
> >>>>  err_sysfs:
> >>>> -	drm_bridge_remove(bridge);
> >>>>  	return -EINVAL;
> >>>>  }
> >>>>  
> >>>> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> >>>> index 58f431102512..932724784942 100644
> >>>> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> >>>> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> >>>> @@ -1315,7 +1315,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
> >>>>  	return 0;
> >>>>  
> >>>>  err_sysfs:
> >>>> -	drm_bridge_remove(bridge);
> >>>>  	hdmi->drm_connector = NULL;
> >>>>  	return -EINVAL;
> >>>>  }
> >>>> -- 
> >>>> 2.11.0
> >>>>
> >>>> _______________________________________________
> >>>> dri-devel mailing list
> >>>> dri-devel@lists.freedesktop.org
> >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>>
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
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
