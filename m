Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934805AbeBURdm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:33:42 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:41721 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934375AbeBURdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:33:39 -0500
X-Google-Smtp-Source: AH8x227TC6UQHwFt9l/G+rVGNo5svkvUe7HrGBHylZ/OnBG6OfvPbYIrrzTONX5s8dZfTK7n9mNLLs4Es7jE6MsrU34=
MIME-Version: 1.0
In-Reply-To: <20180221163654.GS5453@intel.com>
References: <20180221143730.30285-1-robdclark@gmail.com> <20180221143730.30285-2-robdclark@gmail.com>
 <20180221144919.GN5453@intel.com> <CAF6AEGuYmLRphz1FusqaOqyz=mGtbvn7oOsxNYKg3MEMOvYO1A@mail.gmail.com>
 <20180221150727.GO5453@intel.com> <CAF6AEGucNXQZjKaL4KYXSnax=kFiurmsgxKHP9t5ycy_tbmj7g@mail.gmail.com>
 <20180221152720.GP5453@intel.com> <CAF6AEGs+_gjEzueON9Rz8ce9xzHKhkdR2yQGfSpC=6DQV19V2A@mail.gmail.com>
 <20180221155410.GQ5453@intel.com> <CAF6AEGvbQ6KF3utSmrx+_Bcmw=BC2D1yvbU8GeFfAd4rMWfvkQ@mail.gmail.com>
 <20180221163654.GS5453@intel.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 21 Feb 2018 12:33:36 -0500
Message-ID: <CAF6AEGsWwUi75yYqSaoKo-NKLcLLr1n3XPwNHHDN_K1cebLK4Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/atomic: integrate modeset lock with private objects
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LHXjCB029537

On Wed, Feb 21, 2018 at 11:36 AM, Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
> On Wed, Feb 21, 2018 at 11:17:21AM -0500, Rob Clark wrote:
>> On Wed, Feb 21, 2018 at 10:54 AM, Ville Syrjälä
>> <ville.syrjala@linux.intel.com> wrote:
>> > On Wed, Feb 21, 2018 at 10:36:06AM -0500, Rob Clark wrote:
>> >> On Wed, Feb 21, 2018 at 10:27 AM, Ville Syrjälä
>> >> <ville.syrjala@linux.intel.com> wrote:
>> >> > On Wed, Feb 21, 2018 at 10:20:03AM -0500, Rob Clark wrote:
>> >> >> On Wed, Feb 21, 2018 at 10:07 AM, Ville Syrjälä
>> >> >> <ville.syrjala@linux.intel.com> wrote:
>> >> >> > On Wed, Feb 21, 2018 at 09:54:49AM -0500, Rob Clark wrote:
>> >> >> >> On Wed, Feb 21, 2018 at 9:49 AM, Ville Syrjälä
>> >> >> >> <ville.syrjala@linux.intel.com> wrote:
>> >> >> >> > On Wed, Feb 21, 2018 at 09:37:21AM -0500, Rob Clark wrote:
>> >> >> >> >> Follow the same pattern of locking as with other state objects.  This
>> >> >> >> >> avoids boilerplate in the driver.
>> >> >> >> >
>> >> >> >> > I'm not sure we really want to do this. What if the driver wants a
>> >> >> >> > custom locking scheme for this state?
>> >> >> >>
>> >> >> >> That seems like something we want to discourage, ie. all the more
>> >> >> >> reason for this patch.
>> >> >> >>
>> >> >> >> There is no reason drivers could not split their global state into
>> >> >> >> multiple private objs's, each with their own lock, for more fine
>> >> >> >> grained locking.  That is basically the only valid reason I can think
>> >> >> >> of for "custom locking".
>> >> >> >
>> >> >> > In i915 we have at least one case that would want something close to an
>> >> >> > rwlock. Any crtc lock is enough for read, need all of them for write.
>> >> >> > Though if we wanted to use private objs for that we might need to
>> >> >> > actually make the states refcounted as well, otherwise I can imagine
>> >> >> > we might land in some use-after-free issues once again.
>> >> >> >
>> >> >> > Maybe we could duplicate the state into per-crtc and global copies, but
>> >> >> > then we have to keep all of those in sync somehow which doesn't sound
>> >> >> > particularly pleasant.
>> >> >>
>> >> >> Or just keep your own driver lock for read, and use that plus the core
>> >> >> modeset lock for write?
>> >> >
>> >> > If we can't add the private obj to the state we can't really use it.
>> >> >
>> >>
>> >> I'm not sure why that is strictly true (that you need to add it to the
>> >> state if for read-only), since you'd be guarding it with your own
>> >> driver read-lock you can just priv->foo_state->bar.
>> >>
>> >> Since it is read-only access, there is no roll-back to worry about for
>> >> test-only or failed atomic_check()s..
>> >
>> > That would be super ugly. We want to access the information the same
>> > way whether it has been modified or not.
>>
>> Well, I mean the whole idea of what you want to do seems a bit super-ugly ;-)
>>
>> I mean, in mdp5 the assigned global resources go in plane/crtc state,
>> and tracking of what is assigned to which plane/crtc is in global
>> state, so it fits nicely in the current locking model.  For i915, I'm
>> not quite sure what is the global state you are concerned about, so it
>> is a bit hard to talk about the best solution in the abstract.  Maybe
>> the better option is to teach modeset-lock how to be a rwlock instead?
>
> The thing I'm thinking is the core display clock (cdclk) frequency which
> we need to consult whenever computing plane states and whatnot. We don't
> want a modeset on one crtc to block a plane update on another crtc
> unless we actually have to bump the cdclk (which would generally require
> all crtcs to undergo a full modeset). Seems like a generally useful
> pattern to me.
>

Hmm.. I suppose either way, you'd have to make modeset-lock have rw
semantics or invent some way to play nicely with acquire_ctx.. once
you have that, I'd have no objection to make private state use rwlock
semantics.  That seems better than having drivers (badly) roll their
own.  And maybe as you say, it would be a useful pattern for other
drivers.

BR,
-R
