Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeEVPre (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:47:34 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43839 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeEVPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:47:31 -0400
X-Google-Smtp-Source: AB8JxZoxiKuzmu13vucjqE49H9g42HSzPC3IwKIxWVJPL0yZr/4KepRLWyHTBOUmC63OB3A12o2wCIb04BF4Cuw6c3o=
MIME-Version: 1.0
In-Reply-To: <00de829386b04823bb58a555fb620317@XCH-RTP-016.cisco.com>
References: <1526731655-10087-1-git-send-email-jrosen@cisco.com>
 <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
 <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com>
 <b7f6cc54a9f04132a279b15de0187ddd@XCH-RTP-016.cisco.com> <CAF=yD-Kfto4jJYMFzn=PV8OYdhEmdNfW+aakDhRMzRBWhWY0UQ@mail.gmail.com>
 <00de829386b04823bb58a555fb620317@XCH-RTP-016.cisco.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 22 May 2018 11:46:49 -0400
Message-ID: <CAF=yD-LjLRfBvBzaNq+G3Z74RVZ9fOW6A+CvK2gQfrOvn5smCQ@mail.gmail.com>
Subject: Re: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
To: "Jon Rosen (jrosen)" <jrosen@cisco.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Mike Maloney <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 10:12 AM, Jon Rosen (jrosen) <jrosen@cisco.com> wrote:
> On Monday, May 21, 2018 2:17 PM, Jon Rosen (jrosen) <jrosen@cisco.com> wrote:
>> On Monday, May 21, 2018 1:07 PM, Willem de Bruijn
>> <willemdebruijn.kernel@gmail.com> wrote:
>>> On Mon, May 21, 2018 at 8:57 AM, Jon Rosen (jrosen) <jrosen@cisco.com> wrote:
>
> ...snip...
>
>>>
>>> A setsockopt for userspace to signal a stricter interpretation of
>>> tp_status to elide the shadow hack could then be considered.
>>> It's not pretty. Either way, no full new version is required.
>>>
>>>> As much as I would like to find a solution that doesn't require
>>>> the spin lock I have yet to do so. Maybe the answer is that
>>>> existing applications will need to suffer the performance impact
>>>> but a new version or option for TPACKET_V1/V2 could be added to
>>>> indicate strict adherence of the TP_STATUS_USER bit and then the
>>>> original diffs could be used.
>
> It looks like adding new socket options is pretty rare so I
> wonder if a better option might be to define a new TP_STATUS_XXX
> bit which would signal from a userspace application to the kernel
> that it strictly interprets the TP_STATUS_USER bit to determine
> ownership.
>
> Todays applications set tp_status = TP_STATUS_KERNEL(0) for the
> kernel to pick up the entry.  We could define a new value to pass
> ownership as well as one to indicate to other kernel threads that
> an entry is inuse:
>
>         #define TP_STATUS_USER_TO_KERNEL        (1 << 8)
>         #define TP_STATUS_INUSE                 (1 << 9)
>
> If the kernel sees tp_status == TP_STATUS_KERNEL then it should
> use the shadow method for tacking ownership. If it sees tp_status
> == TP_STATUS_USER_TO_KERNEL then it can use the TP_STATUS_INUSE
> method.

Interesting idea. Userspace would have to consistently follow the
new behavior for all slots, which is hard to enforce. And as this is
checked at runtime, the kernel always has to defensively allocate
the shadow memory. I do think that a per-ring option set before
ring allocation is simpler. Either way, this optimization would be a
separate follow-on patch.
