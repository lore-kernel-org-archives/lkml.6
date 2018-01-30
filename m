Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeA3KmW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:42:22 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35564 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeA3KmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:42:20 -0500
X-Google-Smtp-Source: AH8x226c3L7C604ZQ7i8Yh2/n2B0akZl9b/7RlaiPKct+PCIvg41Ip2h5HJtmSEfcYlkbcvcfop7og==
Date: Tue, 30 Jan 2018 11:42:16 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: christian.koenig@amd.com, Michal Hocko <mhocko@kernel.org>,
        dri-devel@lists.freedesktop.org, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [RFC] Per file OOM badness
Message-ID: <20180130104216.GR25930@phenom.ffwll.local>
Mail-Followup-To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        christian.koenig@amd.com, Michal Hocko <mhocko@kernel.org>,
        dri-devel@lists.freedesktop.org, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        amd-gfx@lists.freedesktop.org
References: <20180123153631.GR1526@dhcp22.suse.cz>
 <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
 <20180124092847.GI1526@dhcp22.suse.cz>
 <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
 <20180124110141.GA28465@dhcp22.suse.cz>
 <36b49523-792d-45f9-8617-32b6d9d77418@daenzer.net>
 <20180124115059.GC28465@dhcp22.suse.cz>
 <381a868c-78fd-d0d1-029e-a2cf4ab06d37@gmail.com>
 <20180130093145.GE25930@phenom.ffwll.local>
 <3db43c1a-59b8-af86-2b87-c783c629f512@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3db43c1a-59b8-af86-2b87-c783c629f512@daenzer.net>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 10:43:10AM +0100, Michel Dänzer wrote:
> On 2018-01-30 10:31 AM, Daniel Vetter wrote:
> > On Wed, Jan 24, 2018 at 01:11:09PM +0100, Christian König wrote:
> >> Am 24.01.2018 um 12:50 schrieb Michal Hocko:
> >>> On Wed 24-01-18 12:23:10, Michel Dänzer wrote:
> >>>> On 2018-01-24 12:01 PM, Michal Hocko wrote:
> >>>>> On Wed 24-01-18 11:27:15, Michel Dänzer wrote:
> >>> [...]
> >>>>>> 2. If the OOM killer kills a process which is sharing BOs with another
> >>>>>> process, this should result in the other process dropping its references
> >>>>>> to the BOs as well, at which point the memory is released.
> >>>>> OK. How exactly are those BOs mapped to the userspace?
> >>>> I'm not sure what you're asking. Userspace mostly uses a GEM handle to
> >>>> refer to a BO. There can also be userspace CPU mappings of the BO's
> >>>> memory, but userspace doesn't need CPU mappings for all BOs and only
> >>>> creates them as needed.
> >>> OK, I guess you have to bear with me some more. This whole stack is a
> >>> complete uknonwn. I am mostly after finding a boundary where you can
> >>> charge the allocated memory to the process so that the oom killer can
> >>> consider it. Is there anything like that? Except for the proposed file
> >>> handle hack?
> >>
> >> Not that I knew of.
> >>
> >> As I said before we need some kind of callback that a process now starts to
> >> use a file descriptor, but without anything from that file descriptor mapped
> >> into the address space.
> > 
> > For more context: With DRI3 and wayland the compositor opens the DRM fd
> > and then passes it to the client, which then starts allocating stuff. That
> > makes book-keeping rather annoying.
> 
> Actually, what you're describing is only true for the buffers shared by
> an X server with an X11 compositor. For the actual applications, the
> buffers are created on the client side and then shared with the X server
> / Wayland compositor.
> 
> Anyway, it doesn't really matter. In all cases, the buffers are actually
> used by all parties that are sharing them, so charging the memory to all
> of them is perfectly appropriate.
> 
> 
> > I guess a good first order approximation would be if we simply charge any
> > newly allocated buffers to the process that created them, but that means
> > hanging onto lots of mm_struct pointers since we want to make sure we then
> > release those pages to the right mm again (since the process that drops
> > the last ref might be a totally different one, depending upon how the
> > buffers or DRM fd have been shared).
> > 
> > Would it be ok to hang onto potentially arbitrary mmget references
> > essentially forever? If that's ok I think we can do your process based
> > account (minus a few minor inaccuracies for shared stuff perhaps, but no
> > one cares about that).
> 
> Honestly, I think you and Christian are overthinking this. Let's try
> charging the memory to every process which shares a buffer, and go from
> there.

I'm not concerned about wrongly accounting shared buffers (they don't
matter), but imbalanced accounting. I.e. allocate a buffer in the client,
share it, but then the compositor drops the last reference.

If we store the mm_struct pointer in drm_gem_object, we don't need any
callback from the vfs when fds are shared or anything like that. We can
simply account any newly allocated buffers to the current->mm, and then
store that later for dropping the account for when the gem obj is
released. This would entirely ignore any complications with shared
buffers, which I think we can do because even when we pass the DRM fd to a
different process, the actual buffer allocations are not passed around
like that for private buffers. And private buffers are the only ones that
really matter.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
