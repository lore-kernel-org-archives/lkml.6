Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCcLjMfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32B4460263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeFFTYv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752228AbeFFTYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:24:50 -0400
X-Google-Smtp-Source: ADUXVKLleDgLdficpydS/1YjZwo+dXUI/VF1SNHARW5ZZVPEaD5bo6jFYJmsnvf9VZwhYSsCZo/29WBx3jfRJThuApk=
MIME-Version: 1.0
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
 <1528302199-29619-8-git-send-email-chang.seok.bae@intel.com>
 <CALCETrWsWbyyFC9p5POY8-Xbu8Tw-OhhD_m-5P8b4oYseQfYGQ@mail.gmail.com> <CAMzpN2iE1zba6g6Jh5LzzuX1AM+SskiwVtVi8WtcB+4dD2mJGQ@mail.gmail.com>
In-Reply-To: <CAMzpN2iE1zba6g6Jh5LzzuX1AM+SskiwVtVi8WtcB+4dD2mJGQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 6 Jun 2018 12:24:36 -0700
X-Gmail-Original-Message-ID: <CALCETrWdYwCAnnoT+f+8WiwzErKzJuTUrJiu-7+1fwoaxOPJjg@mail.gmail.com>
Message-ID: <CALCETrWdYwCAnnoT+f+8WiwzErKzJuTUrJiu-7+1fwoaxOPJjg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] x86/segments/32: Introduce CPU_NUMBER segment
To: Brian Gerst <brgerst@gmail.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 12:07 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Wed, Jun 6, 2018 at 1:16 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Wed, Jun 6, 2018 at 9:23 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >>
> >> The new entry will be equivalent to that of x86-64 which
> >> stores CPU number. The entry is placed in segment 23 in GDT
> >> by bumping down 23-28 by one, which are all kernel-internal
> >> segments and so have no impact on user space.
> >>
> >> CPU_NUMBER segment will always be at '%ss (USER_DS) + 80'
> >> for the default (flat, initial) user space %ss.
> >
> > No, it won't :(  This is because, on Xen PV, user code very frequently
> > sees a different, Xen-supplied "flat" SS value.  This is definitely
> > true right now on 64-bit, and I'm reasonably confident it's also the
> > case on 32-bit.
> >
> > As it stands, as far as I can tell, we don't have a "cpu number"
> > segment on 32-bit kernels.  I see no compelling reason to add one, and
> > we should definitely not add one as part of the FSGSBASE series.  I
> > think the right solution is to rename the 64-bit segment to
> > "CPU_NUMBER" and then have the rearrangement of the initialization
> > code as a followup patch.  The goal is to make the patches
> > individually reviewable.  As it stands, this patch adds some #defines
> > without making them work, which is extra confusing.
> >
> > Given how many times we screwed it up, I really want the patch that
> > moves the initialization of the 64-bit CPU number to be obviously
> > correct and to avoid changing the sematics of anything except the
> > actual CPU number fields during boot.
> >
> > So NAK to this patch, at least as part of the FSGSBASE series.
> >
> > (My apologies -- a bunch of this is because I along with everyone else
> > misunderstood the existing code.)
>
> The sole purpose of this segment is for the getcpu() function in the
> VDSO.  No other userspace code can rely on its presence or location.
>

Agreed.  But this means that no code whatsoever should use it on a
32-bit kernel, so let's not add support.\
