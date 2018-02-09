Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeBIWTp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:19:45 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37879 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753006AbeBIWTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:19:43 -0500
X-Google-Smtp-Source: AH8x2255dveqpPoGyzozqx4r/lVvOB8NQMuSCy7kd9+ZTgTl9p7g2iJdF0C3F5oyjjed3Bh19eX46w==
Date: Fri, 9 Feb 2018 14:19:41 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>
Subject: Re: [PATCH] amdgpu/dc: Add missing cast in
 dce_clock_set_min_clocks_state()
Message-ID: <20180209221941.GA79106@google.com>
References: <20180209212834.72129-1-mka@chromium.org>
 <95c4b316-ee97-d7c9-a9d8-f2a7e0daa9e3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95c4b316-ee97-d7c9-a9d8-f2a7e0daa9e3@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, Feb 09, 2018 at 04:55:57PM -0500 Harry Wentland ha dit:

> On 2018-02-09 04:28 PM, Matthias Kaehlcke wrote:
> > dce_clock_set_min_clocks_state() assigns (intentionally) a value of type
> > 'enum dm_pp_clocks_state' to a variable of type 'enum dm_pp_power_level'
> > without an explicit cast. This causes clang to raise the following
> > warning:
> > 
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clocks.c:308:4: error:
> >   implicit conversion from enumeration type 'enum dm_pp_clocks_state'
> >   to different enumeration type 'enum dm_pp_power_level' [-Werror,-Wenum-conversion]
> >     clocks_state };
> > 
> > Make the cast explicit.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> > index 9e98a5f39a6d..db3ceb283255 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> > @@ -304,7 +304,8 @@ static bool dce_clock_set_min_clocks_state(
> >  	enum dm_pp_clocks_state clocks_state)
> >  {
> >  	struct dm_pp_power_level_change_request level_change_req = {
> > -			clocks_state };
> > +		.power_level = (enum dm_pp_power_level)clocks_state
> 
> Thanks for spotting this. Looks like both enums are exactly the same so no need to keep both. I sent a patch to remove the dm_pp_power_level enum to amd-gfx and CC'd you on it.

Even better, thanks!
