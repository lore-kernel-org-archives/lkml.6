Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBHBhd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:37:33 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38280 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeBHBhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:37:32 -0500
X-Google-Smtp-Source: AH8x225u9LdOVh/9koRAKdAuZccFIknWxLqDNCQUesDfMDzGn1p1UTz0og8E5JkMSIkVnJ0gV9s0yw==
Date: Wed, 7 Feb 2018 17:37:30 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Guenter Roeck <groeck@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>
Subject: Re: [PATCH 2/2] amdgpu/dc/dml: Support clang option for stack
 alignment
Message-ID: <20180208013730.GC116483@google.com>
References: <20180208012156.165934-1-mka@chromium.org>
 <20180208012156.165934-2-mka@chromium.org>
 <CABXOdTeOvFkRp=Z6P47o3ky0HNWkeQ5b_Ff2DVKb8g5tdo3G_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXOdTeOvFkRp=Z6P47o3ky0HNWkeQ5b_Ff2DVKb8g5tdo3G_Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, Feb 07, 2018 at 05:34:44PM -0800 Guenter Roeck ha dit:

> On Wed, Feb 7, 2018 at 5:21 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > DML uses the compiler option -mpreferred-stack-boundary=4 to configure
> > a stack alignment of 16 bytes. Clang uses the option -mstack-alignment
> > instead, which expects as parameter the alignment in bytes, and not a
> > power of two like -mpreferred-stack-boundary.
> >
> > Probe for both compiler options and use the correct one, similar to
> > what is done in arch/x86/Makefile.
> >
> > Reported-by: Guenter Roeck <groeck@chromium.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dml/Makefile | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > index b8cadf833e71..740975931d21 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > @@ -24,7 +24,13 @@
> >  # It provides the general basic services required by other DAL
> >  # subcomponents.
> >
> > -subdir-ccflags-y += -mhard-float -msse -mpreferred-stack-boundary=4
> > +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> > +       cc_stack_align=-mpreferred-stack-boundary=4
> > +else ifneq ($(call cc-option, -mstack-alignment=16),)
> > +       cc_stack_align := -mstack-alignment=16
> > +endif
> > +
> Any reason for using both = and := ?

Not really, will fix.

Thanks!
