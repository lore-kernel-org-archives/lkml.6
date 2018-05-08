Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeEHHvp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:51:45 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54054 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeEHHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:51:43 -0400
X-Google-Smtp-Source: AB8JxZpJ+quhRR9mvoM8WknGuRW7ekEe9gpHCefxNgARfgOQ0yDPwO65m13W4w9hOqCdvm1LLwDJ3g==
Date: Tue, 8 May 2018 09:51:39 +0200
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
Message-ID: <20180508075139.GM28661@phenom.ffwll.local>
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
 <7f79c109-6b0f-000e-569b-1f702e0006d3@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f79c109-6b0f-000e-569b-1f702e0006d3@axentia.se>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 04:24:43PM +0200, Peter Rosin wrote:
> On 2018-05-07 15:59, Peter Rosin wrote:
> > On 2018-05-07 15:39, Daniel Vetter wrote:
> >> On Thu, May 03, 2018 at 11:12:21PM +0200, Peter Rosin wrote:
> >>> On 2018-05-03 11:06, Daniel Vetter wrote:
> >>>> On Wed, May 02, 2018 at 09:40:23AM +0200, Peter Rosin wrote:
> >>>>> The more natural approach would perhaps be to add an drm_bridge_add,
> >>>>> but there are several other bridges that never call drm_bridge_add.
> >>>>> Just removing the drm_bridge_remove is the easier fix.
> >>>>>
> >>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>>>
> >>>> This mess is much bigger. There's 2 pairs of bridge functions:
> >>>>
> >>>> - drm_bridge_attach/detach. Those are meant to be called by the overall
> >>>>   drm driver to connect/disconnect a drm_bridge.
> >>>>
> >>>> - drm_bridge_add/remove. These are supposed to be called by the bridge
> >>>>   driver itself to register/unregister itself. Maybe we should rename
> >>>>   them, since the same issue happens with drm_panel, with the same
> >>>>   confusion.
> >>>>
> >>>> I thought someone was working on a cleanup series to fix this mess, but I
> >>>> didn't find anything.
> >>>
> >>> Ok, I just spotted the imbalance and didn't really dig into what
> >>> actually happens in these error paths. Now that I have done so I
> >>> believe that the removed drm_bridge_remove calls causes NULL
> >>> dereferences if/when the error paths are triggered.
> >>>
> >>> So, I don't think this can wait for some bigger cleanup.
> >>>
> >>> drm_bridge_remove calls list_del_init calls __list_del_entry calls
> >>> __list_del with NULL in both prev and next since the list member
> >>> is never initialized. prev and next are dereferenced by __list_del
> >>> and you have *boom*
> >>>
> >>> I recommend adding the tag
> >>>
> >>> Fixes: 84601dbdea36 ("drm: sti: rework init sequence")
> >>>
> >>> so that stable picks this one up.
> >>
> >> I just wanted to correct your commit message text - the correct solution
> >> is definitely _not_ for sti here to call drm_bridge_add.
> > 
> > Ah, I see what you mean. Do you want me to respin?
> 
> Hold on, no I don't agree. sti_hda.c does create a bridge for it's own
> internal use. It does not drm_bridge_add it, because all that ever does
> is adding the bridge to the global lost of bridges. But since this is
> a bridge for internal use, there is little point in calling drm_bridge_add,
> the driver currently gains nothing by doing so.
> 
> But, drm_bridge_add might be a good place to put common stuff for every
> bridge in the system, so it might be worthwhile to start requiring all
> bridges to be drm_bridge_add-ed. And IMHO, it would not be wrong to have
> the sti-hda driver call drm_bridge_add on the bridge it creates.
> 
> Do you really think it is actively wrong to call drm_bridge_add for
> internal bridges such as this?

If we want to share bridge init code, then I think we need a
drm_bridge_init(). Not overload drm_bridge_add (which really should be
drm_bridge_register I think, but oh well, it's at least consistent with
drm_panel_add).
-Daniel

> 
> Cheers,
> Peter
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
