Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBHSsc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:48:32 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45967 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHSsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:48:31 -0500
X-Google-Smtp-Source: AH8x226wbHlzF0ArpJN24peVOHpYfUP/E3S6g5fCuqM8OPPe6cU+1If1bywCr5xN0QyuNc1da6a0Zg==
Date: Thu, 8 Feb 2018 10:48:27 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>
Subject: Re: [PATCH v2 1/2] amdgpu/dc/dml: Consolidate redundant CFLAGS
Message-ID: <20180208184827.GD116483@google.com>
References: <20180208015103.169603-1-mka@chromium.org>
 <ef9de5a5-a5b3-63a3-7ddb-5d9338019e71@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef9de5a5-a5b3-63a3-7ddb-5d9338019e71@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, Feb 08, 2018 at 09:33:53AM -0500 Harry Wentland ha dit:

> On 2018-02-07 08:51 PM, Matthias Kaehlcke wrote:
> > Use subdir-ccflags instead of specifying the same flags for every source
> > file.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Guenter Roeck <groeck@chromium.org>
> > ---
> > Changes in v2:
> > - added 'Reviewed-by: Guenter Roeck <groeck@chromium.org>' tag
> > 
> >  drivers/gpu/drm/amd/display/dc/dml/Makefile | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > index 3488af2b5786..b8cadf833e71 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > @@ -24,15 +24,7 @@
> >  # It provides the general basic services required by other DAL
> >  # subcomponents.
> >  
> > -CFLAGS_display_mode_vba.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > -CFLAGS_display_mode_lib.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > -CFLAGS_display_pipe_clocks.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > -CFLAGS_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > -CFLAGS_dml1_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > -CFLAGS_display_rq_dlg_helpers.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > -CFLAGS_soc_bounding_box.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > -CFLAGS_dml_common_defs.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > -
> > +subdir-ccflags-y += -mhard-float -msse -mpreferred-stack-boundary=4
> 
> Are you sure this will only apply to dc/dml?
> 
> The way the amdgpu build is setup I've seen this flag apply to all of amdgpu, even if specified in a subdirectories build file. The reason being that amdgpu/Makefile recursively includes all other Makefiles in the module.
> 
> According to kbuild/makefiles.txt this will have effect for the kbuild file where it's present and all subdirectories:
> 
> https://www.kernel.org/doc/Documentation/kbuild/makefiles.txt:
> >     subdir-ccflags-y, subdir-asflags-y
> > 	The two flags listed above are similar to ccflags-y and asflags-y.
> > 	The difference is that the subdir- variants have effect for the kbuild
> > 	file where they are present and all subdirectories.
> > 	Options specified using subdir-* are added to the commandline before
> > 	the options specified using the non-subdir variants.
> > 
> > 	Example:
> > 		subdir-ccflags-y := -Werror

Thanks, I didn't realize the recursive inclusion from amdgpu/Makefile,
in this case using subdir-ccflags-y indeed isn't a good idea.

> For your 2nd patch you probably want to make a dml_cflags variable
> that's set different for clang and gcc, and then still set it for
> all files in DML individually.

Yep, that was my first impulse and then I remembered
subdir-ccflags-y. Will go back to that.

> You'll probably also have to do the same for dc/calcs/Makefile.

Thanks for the heads up!
