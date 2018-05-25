Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968504AbeEYUrX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:47:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36401 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968312AbeEYUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:47:21 -0400
X-Google-Smtp-Source: ADUXVKJByyX5izOczvAe3xiMOZRzIJJlocDOxsqgaRhuWtm+MsjKYnI1VmoOKloNlE/n/4IFZAmcJQ==
MIME-Version: 1.0
References: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org>
 <1526552938-21292-4-git-send-email-vviswana@codeaurora.org>
 <CAE=gft4DOJTuZDQDX1PL0fXHKPBsgWRPsO1bgunfO0VZ+pa6zQ@mail.gmail.com> <0baf8584-7833-0917-4432-363b0ee31bbc@codeaurora.org>
In-Reply-To: <0baf8584-7833-0917-4432-363b0ee31bbc@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 25 May 2018 13:46:42 -0700
X-Gmail-Original-Message-ID: <CAE=gft7wmBRA=qy28mSdSCRsVLCkNyMV=uJMk2RpTFHgzS-YTw@mail.gmail.com>
Message-ID: <CAE=gft7wmBRA=qy28mSdSCRsVLCkNyMV=uJMk2RpTFHgzS-YTw@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] mmc: host: Register changes for sdcc V5
To: vviswana@codeaurora.org
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>,
        sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 6:01 AM Vijay Viswanath <vviswana@codeaurora.org>
wrote:



> On 5/22/2018 11:42 PM, Evan Green wrote:
> > Hi Vijay. Thanks for this patch.
> >
> > On Thu, May 17, 2018 at 3:30 AM Vijay Viswanath <vviswana@codeaurora.org

> > wrote:
> >
> >> From: Sayali Lokhande <sayalil@codeaurora.org>
> >
...
> > Nit: host->ioaddr + msm_offset->core_dll_config might benefit from
having
> > its own local, since you use it so much in this function. Same goes for
> > where I've noted below...
> >

> core_dll_config is very much used. But having a local for it feels like
> a bad idea. As different versions come up, the most used register may
> change. So it would be better to stick to a consistent approach to
> accessing every register.


I generally optimize for readability, rather than find/replace-ability. In
my opinion, it's distracting to see that expression copy/pasted so many
times in the same function. But ultimately this is a style preference, so
if you decide not to do it, I'll live.

> >
> >> +                       msm_offset->core_pwrctl_status),
> >> +               msm_host->var_ops->msm_readl_relaxed(host,
> >> +                       msm_offset->core_pwrctl_mask),
> >> +               msm_host->var_ops->msm_readl_relaxed(host,
> >> +                       msm_offset->core_pwrctl_ctl));
> >
> > I think the idea of function pointers is fine, but overall the use of
them
> > everywhere sure is ugly. It makes it really hard to actually see what's
> > happening. I wonder if things might look a lot cleaner with a helper
> > function here. Then instead of:
> >
> > msm_host->var_ops->msm_readl_relaxed(host, msm_offset->core_pwrctl_ctl);
> >
> > You could have
> >
> > msm_core_read(host, msm_offset->core_pwrctl_ctl);
> >

> if we use a helper function, then we will have to pass msm_host into it
> as well. Otherwise there would be the hassle of deriving msm_host
> address from sdhci_host.

> How about using a MACRO here instead for readability ?


The deriving part in the helper would likely get inlined and shared by the
compiler among all call-sites within a function. But yes, a macro would
work too.

Thanks Vijay,
Evan
