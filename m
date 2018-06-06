Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Vc1WMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D2A4606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932562AbeFFTHS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:07:18 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41218 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753043AbeFFTHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:07:16 -0400
X-Google-Smtp-Source: ADUXVKJbkbNLxHS6TqfO0bEydPGaPWpflV6d5KCv+qImgLP7/KQshGh6t81w7MPGg6RLHza6nkUzzF/4c5qqget8U9g=
MIME-Version: 1.0
In-Reply-To: <CALCETrWsWbyyFC9p5POY8-Xbu8Tw-OhhD_m-5P8b4oYseQfYGQ@mail.gmail.com>
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
 <1528302199-29619-8-git-send-email-chang.seok.bae@intel.com> <CALCETrWsWbyyFC9p5POY8-Xbu8Tw-OhhD_m-5P8b4oYseQfYGQ@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 6 Jun 2018 15:07:15 -0400
Message-ID: <CAMzpN2iE1zba6g6Jh5LzzuX1AM+SskiwVtVi8WtcB+4dD2mJGQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] x86/segments/32: Introduce CPU_NUMBER segment
To: Andy Lutomirski <luto@kernel.org>
Cc: "Bae, Chang Seok" <chang.seok.bae@intel.com>,
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

On Wed, Jun 6, 2018 at 1:16 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Jun 6, 2018 at 9:23 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>
>> The new entry will be equivalent to that of x86-64 which
>> stores CPU number. The entry is placed in segment 23 in GDT
>> by bumping down 23-28 by one, which are all kernel-internal
>> segments and so have no impact on user space.
>>
>> CPU_NUMBER segment will always be at '%ss (USER_DS) + 80'
>> for the default (flat, initial) user space %ss.
>
> No, it won't :(  This is because, on Xen PV, user code very frequently
> sees a different, Xen-supplied "flat" SS value.  This is definitely
> true right now on 64-bit, and I'm reasonably confident it's also the
> case on 32-bit.
>
> As it stands, as far as I can tell, we don't have a "cpu number"
> segment on 32-bit kernels.  I see no compelling reason to add one, and
> we should definitely not add one as part of the FSGSBASE series.  I
> think the right solution is to rename the 64-bit segment to
> "CPU_NUMBER" and then have the rearrangement of the initialization
> code as a followup patch.  The goal is to make the patches
> individually reviewable.  As it stands, this patch adds some #defines
> without making them work, which is extra confusing.
>
> Given how many times we screwed it up, I really want the patch that
> moves the initialization of the 64-bit CPU number to be obviously
> correct and to avoid changing the sematics of anything except the
> actual CPU number fields during boot.
>
> So NAK to this patch, at least as part of the FSGSBASE series.
>
> (My apologies -- a bunch of this is because I along with everyone else
> misunderstood the existing code.)

The sole purpose of this segment is for the getcpu() function in the
VDSO.  No other userspace code can rely on its presence or location.

--
Brian Gerst
