Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeEVPm2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:42:28 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41892 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeEVPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:42:23 -0400
X-Google-Smtp-Source: AB8JxZqXx8ahriWJ/40Zzto8AIHYhk9yvQzBdk20yfbChNDhbyEuxMpajKw86x20K6cLavMfRJWrC94gp2ZBVKWIlB8=
MIME-Version: 1.0
In-Reply-To: <64c91d04479348cabbcdf1df0ff7d40f@XCH-RTP-016.cisco.com>
References: <1526731655-10087-1-git-send-email-jrosen@cisco.com>
 <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
 <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com>
 <b7f6cc54a9f04132a279b15de0187ddd@XCH-RTP-016.cisco.com> <CAF=yD-Kfto4jJYMFzn=PV8OYdhEmdNfW+aakDhRMzRBWhWY0UQ@mail.gmail.com>
 <64c91d04479348cabbcdf1df0ff7d40f@XCH-RTP-016.cisco.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 22 May 2018 11:41:41 -0400
Message-ID: <CAF=yD-KHFwhVt4xzED7FPLd_xej9nLmoZOgZG0PmsVgbrnN0Ng@mail.gmail.com>
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

>>> I think the bigger issues as you've pointed out are the cost of
>>> the additional spin lock and should the additional state be
>>> stored in-band (fewer cache lines) or out-of band (less risk of
>>> breaking due to unpredictable application behavior).
>>
>> We don't need the spinlock if clearing the shadow byte after
>> setting the status to user.
>>
>> Worst case, user will set it back to kernel while the shadow
>> byte is not cleared yet and the next producer will drop a packet.
>> But next producers will make progress, so there is no deadlock
>> or corruption.
>
> I thought so too for a while but after spending more time than I
> care to admit I relized the following sequence was occuring:
>
>    Core A                       Core B
>    ------                       ------
>    - Enter spin_lock
>    -   Get tp_status of head (X)
>        tp_status == 0
>    -   Check inuse
>        inuse == 0
>    -   Allocate entry X
>        advance head (X+1)
>        set inuse=1
>    - Exit spin_lock
>
>      <very long delay>
>
>                                 <allocate N-1 entries
>                                 where N = size of ring>
>
>                                 - Enter spin_lock
>                                 -   get tp_status of head (X+N)
>                                     tp_status == 0 (but slot
>                                     in use for X on core A)
>
>    - write tp_status of         <--- trouble!
>      X = TP_STATUS_USER         <--- trouble!
>    - write inuse=0              <--- trouble!
>
>                                 -   Check inuse
>                                     inuse == 0
>                                 -   Allocate entry X+N
>                                     advance head (X+N+1)
>                                     set inuse=1
>                                 - Exit spin_lock
>
>
> At this point Core A just passed slot X to userspace with a
> packet and Core B has just been assigned slot X+N (same slot as
> X) for it's new packet. Both cores A and B end up filling in that
> slot.  Tracking ths donw was one of the reasons it took me a
> while to produce these updated diffs.

Is this not just an ordering issue? Since inuse is set after tp_status,
it has to be tested first (and barriers are needed to avoid reordering).
