Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756159AbeD3UCF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 16:02:05 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:56965 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755214AbeD3UCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 16:02:03 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Matthias Kaehlcke <mka@chromium.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180430193119.GB133494@google.com>
Cc: "Guenter Roeck" <groeck@chromium.org>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180319191451.83910-1-mka@chromium.org>
 <20180430193119.GB133494@google.com>
Message-ID: <152511850981.10429.1077865835761338509@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Disable some extra clang warnings
Date: Mon, 30 Apr 2018 21:01:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-04-30 20:31:19)
> On Mon, Mar 19, 2018 at 12:14:51PM -0700, Matthias Kaehlcke wrote:
> > Commit 39bf4de89ff7 ("drm/i915: Add -Wall -Wextra to our build, set
> > warnings to full") enabled extra warnings for i915 to spot possible
> > bugs in new code, and then disabled a subset of these warnings to keep
> > the current code building without warnings (with gcc). Enabling the
> > extra warnings also enabled some additional clang-only warnings, as a
> > result building i915 with clang currently is extremely noisy. For now
> > also disable the clang warnings sign-compare, sometimes-uninitialized,
> > unneeded-internal-declaration and initializer-overrides. If desired
> > they can be re-enabled after the code has been fixed.
> > 
> > Fixes: 39bf4de89ff7 ("drm/i915: Add -Wall -Wextra to our build, set
> > warnings to full")

Do we need to backport this for a non-default build with a non-default
compiler?

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - rebased on drm-tip
> > - added comment indicating that disabled warnings are clang warnings
> > 
> >  drivers/gpu/drm/i915/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> > index 4eee91a3a236..9717c037b582 100644
> > --- a/drivers/gpu/drm/i915/Makefile
> > +++ b/drivers/gpu/drm/i915/Makefile
> > @@ -18,6 +18,11 @@ subdir-ccflags-y += $(call cc-disable-warning, type-limits)
> >  subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
> >  subdir-ccflags-y += $(call cc-disable-warning, implicit-fallthrough)
> >  subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
> > +# clang warnings
> > +subdir-ccflags-y += $(call cc-disable-warning, sign-compare)

Too much mixup in the code to be fixed overnight indeed.

> > +subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)

Annoyingly it appears that clang has more false positives.

> > +subdir-ccflags-y += $(call cc-disable-warning, unneeded-internal-declaration)

Example? I don't recall this one, so don't know if we should just not
fix it rather than suppress. I've used ignored-attributes, perhaps that
was for the same cause.

> > +subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)

While we used per-file to restrict this one, I don't think we care that
much for precision with clang as well.
-Chris
