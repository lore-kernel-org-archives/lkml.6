Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbeEWLIj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:08:39 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:43874 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932391AbeEWLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:08:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DXAAADSwVb/5ldJa1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNEgV8yg22IBIxjgwiTNxSBZAuEbAIXgg0hNBgBAgEBAQE?=
 =?us-ascii?q?BAQJsKIUpBiMRRRACAQgaAiYCAgIwFRACBA4NhRuqN4IciEOBfIEJhy2BVD+?=
 =?us-ascii?q?EHIRbgxiCVAKHIpE4CQKOT40JkFgCERMBgSQBHDiBUnAVgn+CR44GjTGBGAE?=
 =?us-ascii?q?B?=
X-IronPort-AV: E=Sophos;i="5.49,432,1520899200";
   d="scan'208";a="397633284"
From: "Jon Rosen (jrosen)" <jrosen@cisco.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Mike Maloney" <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
Thread-Topic: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
Thread-Index: AQHT72oCSQesQH+wcU+iC1K5zWLMg6Q5fnUAgAAIkQCAAJ/kcIAAiZoA///PyiCAAaqtgIAA/gyQ
Date: Wed, 23 May 2018 11:08:33 +0000
Message-ID: <e942c1bbe48b451b92620396746986ab@XCH-RTP-016.cisco.com>
References: <1526731655-10087-1-git-send-email-jrosen@cisco.com>
 <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
 <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com>
 <b7f6cc54a9f04132a279b15de0187ddd@XCH-RTP-016.cisco.com>
 <CAF=yD-Kfto4jJYMFzn=PV8OYdhEmdNfW+aakDhRMzRBWhWY0UQ@mail.gmail.com>
 <64c91d04479348cabbcdf1df0ff7d40f@XCH-RTP-016.cisco.com>
 <CAF=yD-KHFwhVt4xzED7FPLd_xej9nLmoZOgZG0PmsVgbrnN0Ng@mail.gmail.com>
In-Reply-To: <CAF=yD-KHFwhVt4xzED7FPLd_xej9nLmoZOgZG0PmsVgbrnN0Ng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.117.112.181]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4NB8jDN022326

> >>> I think the bigger issues as you've pointed out are the cost of
> >>> the additional spin lock and should the additional state be
> >>> stored in-band (fewer cache lines) or out-of band (less risk of
> >>> breaking due to unpredictable application behavior).
> >>
> >> We don't need the spinlock if clearing the shadow byte after
> >> setting the status to user.
> >>
> >> Worst case, user will set it back to kernel while the shadow
> >> byte is not cleared yet and the next producer will drop a packet.
> >> But next producers will make progress, so there is no deadlock
> >> or corruption.
> >
> > I thought so too for a while but after spending more time than I
> > care to admit I relized the following sequence was occuring:
> >
> >    Core A                       Core B
> >    ------                       ------
> >    - Enter spin_lock
> >    -   Get tp_status of head (X)
> >        tp_status == 0
> >    -   Check inuse
> >        inuse == 0
> >    -   Allocate entry X
> >        advance head (X+1)
> >        set inuse=1
> >    - Exit spin_lock
> >
> >      <very long delay>
> >
> >                                 <allocate N-1 entries
> >                                 where N = size of ring>
> >
> >                                 - Enter spin_lock
> >                                 -   get tp_status of head (X+N)
> >                                     tp_status == 0 (but slot
> >                                     in use for X on core A)
> >
> >    - write tp_status of         <--- trouble!
> >      X = TP_STATUS_USER         <--- trouble!
> >    - write inuse=0              <--- trouble!
> >
> >                                 -   Check inuse
> >                                     inuse == 0
> >                                 -   Allocate entry X+N
> >                                     advance head (X+N+1)
> >                                     set inuse=1
> >                                 - Exit spin_lock
> >
> >
> > At this point Core A just passed slot X to userspace with a
> > packet and Core B has just been assigned slot X+N (same slot as
> > X) for it's new packet. Both cores A and B end up filling in that
> > slot.  Tracking ths donw was one of the reasons it took me a
> > while to produce these updated diffs.
> 
> Is this not just an ordering issue? Since inuse is set after tp_status,
> it has to be tested first (and barriers are needed to avoid reordering).

I changed the code as you suggest to do the inuse check first and
removed the extra added spin_lock/unlock and it seems to be working.
I was able to run through the night without an issue (normally I would
hit the ring corruption in 1 to 2 hours).

Thanks for pointing that out, I should have caught that myself.  Next
I'll look at your suggestion for where to put the shadow ring.
