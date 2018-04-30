Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755169AbeD3WQq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 18:16:46 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42536 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbeD3WQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 18:16:45 -0400
X-Google-Smtp-Source: AB8JxZqhBlSdRTXTrO3xJsTw5EPow9RPX7AcCmP1U1ZfybhAj92hxhBGng+iIQ80zmKdhWHpBBp3jw==
Date: Mon, 30 Apr 2018 15:16:43 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        Guenter Roeck <groeck@chromium.org>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Disable some extra clang
 warnings
Message-ID: <20180430221643.GD133494@google.com>
References: <20180319191451.83910-1-mka@chromium.org>
 <20180430193119.GB133494@google.com>
 <152511850981.10429.1077865835761338509@mail.alporthouse.com>
 <20180430205145.GC133494@google.com>
 <152512211018.25556.5922164301972750801@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <152512211018.25556.5922164301972750801@mail.alporthouse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 10:01:50PM +0100, Chris Wilson wrote:
> Quoting Matthias Kaehlcke (2018-04-30 21:51:45)
> > On Mon, Apr 30, 2018 at 09:01:49PM +0100, Chris Wilson wrote:
> > > Quoting Matthias Kaehlcke (2018-04-30 20:31:19)
> > > > On Mon, Mar 19, 2018 at 12:14:51PM -0700, Matthias Kaehlcke wrote:
> > > > > Commit 39bf4de89ff7 ("drm/i915: Add -Wall -Wextra to our build, set
> > > > > warnings to full") enabled extra warnings for i915 to spot possible
> > > > > bugs in new code, and then disabled a subset of these warnings to keep
> > > > > the current code building without warnings (with gcc). Enabling the
> > > > > extra warnings also enabled some additional clang-only warnings, as a
> > > > > result building i915 with clang currently is extremely noisy. For now
> > > > > also disable the clang warnings sign-compare, sometimes-uninitialized,
> > > > > unneeded-internal-declaration and initializer-overrides. If desired
> > > > > they can be re-enabled after the code has been fixed.
> > > > > 
> > > > > Fixes: 39bf4de89ff7 ("drm/i915: Add -Wall -Wextra to our build, set
> > > > > warnings to full")
> > > 
> > > Do we need to backport this for a non-default build with a non-default
> > > compiler?
> > 
> > If it affected a LTS build I'd say yes, but since that isn't the case
> > I think it's not necessary.
> > 
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > ---
> > > > > Changes in v2:
> > > > > - rebased on drm-tip
> > > > > - added comment indicating that disabled warnings are clang warnings
> > > > > 
> > > > >  drivers/gpu/drm/i915/Makefile | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> > > > > index 4eee91a3a236..9717c037b582 100644
> > > > > --- a/drivers/gpu/drm/i915/Makefile
> > > > > +++ b/drivers/gpu/drm/i915/Makefile
> > > > > @@ -18,6 +18,11 @@ subdir-ccflags-y += $(call cc-disable-warning, type-limits)
> > > > >  subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
> > > > >  subdir-ccflags-y += $(call cc-disable-warning, implicit-fallthrough)
> > > > >  subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
> > > > > +# clang warnings
> > > > > +subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
> > > 
> > > Too much mixup in the code to be fixed overnight indeed.
> > > 
> > > > > +subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
> > > 
> > > Annoyingly it appears that clang has more false positives.
> > > 
> > > > > +subdir-ccflags-y += $(call cc-disable-warning, unneeded-internal-declaration)
> > > 
> > > Example? I don't recall this one, so don't know if we should just not
> > > fix it rather than suppress. I've used ignored-attributes, perhaps that
> > > was for the same cause.
> > 
> > drivers/gpu/drm/i915/intel_guc_submission.c:183:13: warning: function
> >   'has_doorbell' is not needed and will not be emitted
> >   [-Wunneeded-internal-declaration]
> > static bool has_doorbell(struct intel_guc_client *client)
> > 
> > The function is only called within a GEM_BUG_ON macro, which does not
> > evaluate the expression unless CONFIG_DRM_I915_DEBUG_GEM is set.
> > 
> > Instead of disabling the warning it would probably be better to mark
> > has_doorbell as __maybe_unused.
> 
> Hmm, if it is just this one, I would remove the use from
> intel_guc_submission and move it into selftests/
> The single use case inside intel_guc_submission isn't that interesting
> and I doubt we would miss not having the assert.

Could you take care of this? I'm not really familiar with the i915
codebase and might not put it exactly where you want it ;-)

I'd then rebase this patch and leave -Wunneeded-internal-declaration enabled.
