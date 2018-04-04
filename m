Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDDO7w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:59:52 -0400
Received: from alln-iport-1.cisco.com ([173.37.142.88]:48075 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDDO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:59:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DNAAAK6MRa/4kNJK1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNCgVAoCoNViACNCIF0gQ+SVYElA1ILhQMCGoQmITQYAQI?=
 =?us-ascii?q?BAQEBAQECbCiFIgEBAQEDIwQNRRACAQgYAgImAgICMBUQAgQOBQiFBatzgWk?=
 =?us-ascii?q?ziEGCJYEJhlmBVD+EEIUGgmmCVAKQSIZ2CAKOJ4xEK48rAhETAYEkARw4M4E?=
 =?us-ascii?q?fcBWCfYJIjgZvjFqBFwEB?=
X-IronPort-AV: E=Sophos;i="5.48,406,1517875200";
   d="scan'208";a="94056467"
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
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] packet: mark ring entry as in-use inside spin_lock to
 prevent RX ring overrun
Thread-Topic: [RFC PATCH] packet: mark ring entry as in-use inside spin_lock
 to prevent RX ring overrun
Thread-Index: AQHTy5aFtVi5IJ8ejEig7CpBQEL4WqPw40yA///J04A=
Date: Wed, 4 Apr 2018 14:59:48 +0000
Message-ID: <057239cdf1c34bc69636009c9e099214@XCH-RTP-016.cisco.com>
References: <20180403215526.15934-1-jrosen@cisco.com>
 <CAF=yD-L8DaS7LW4SAaTRd2RPxVnfrdiVLCdWJxxaTu3Hn8ORSA@mail.gmail.com>
In-Reply-To: <CAF=yD-L8DaS7LW4SAaTRd2RPxVnfrdiVLCdWJxxaTu3Hn8ORSA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.82.254.164]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w34ExvTY025068

On Wednesday, April 04, 2018 9:49 AM, Willem de Bruijn <willemb@google.com> wrote:
> 
> On Tue, Apr 3, 2018 at 11:55 PM, Jon Rosen <jrosen@cisco.com> wrote:
> > Fix PACKET_RX_RING bug for versions TPACKET_V1 and TPACKET_V2 which
> > casues the ring to get corrupted by allowing multiple kernel threads
> > to claim ownership of the same ring entry, Mark the ring entry as
> > already being used within the spin_lock to prevent other kernel
> > threads from reusing the same entry before it's fully filled in,
> > passed to user space, and then eventually passed back to the kernel
> > for use with a new packet.
> >
> > Note that the proposed change may modify the semantics of the
> > interface between kernel space and user space in a way which may cause
> > some applications to no longer work properly.
> 
> As long as TP_STATUS_USER (1) is not set, userspace should ignore
> the slot..
> 
> >    One issue with the above proposed change to use TP_STATUS_IN_PROGRESS
> >    is that the documentation of the tp_status field is somewhat
> >    inconsistent.  In some places it's described as TP_STATUS_KERNEL(0)
> >    meaning the entry is owned by the kernel and !TP_STATUS_KERNEL(0)
> >    meaning the entry is owned by user space.  In other places ownership
> >    by user space is defined by the TP_STATUS_USER(1) bit being set.
> 
> But indeed this example in packet_mmap.txt is problematic
> 
>     if (status == TP_STATUS_KERNEL)
>         retval = poll(&pfd, 1, timeout);
> 
> It does not really matter whether the docs are possibly inconsistent and
> which one is authoritative. Examples like the above make it likely that
> some user code expects such code to work.

Yes, that's exactly my concern.  Yet another troubling example seems to be
lipbcap which also is looking specifically for status to be anything other than
TP_STATUS_KERNEL(0) to indicate a frame is available in user space.

Either way things are broken. They are broken as they stand now because the
ring can get overrun and the kernel and user space tracking of the ring can
get out of sync.  And they are broken with the below change because some user
space applications will be looking for anything other than TP_STATUS_KERNEL,
so again the ring will get out of sync.

The difference here being that the way it is today is on average (across all environments
and across all user space apps) less likely to occur while with the change below it is
much more likely to occur.

Maybe the right answer here is to implement a fix that is compatible for existing
applications and accept any potential performance impacts and then add yet another
version (TPACKET_V4?) which more strictly requires the TP_STATUS_USER bit for
passing ownership.

> 
> > +++ b/net/packet/af_packet.c
> > @@ -2287,6 +2287,15 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> >                 if (po->stats.stats1.tp_drops)
> >                         status |= TP_STATUS_LOSING;
> >         }
> > +
> > +        /*
> > +         * Mark this entry as TP_STATUS_IN_PROGRESS to prevent other
> > +         * kernel threads from re-using this same entry.
> > +         */
> > +#define TP_STATUS_IN_PROGRESS TP_STATUS_LOSING
> 
> No need to reinterpret existing flags. tp_status is a u32 with
> sufficient undefined bits.

Agreed.

> 
> > +       if (po->tp_version <= TPACKET_V2)
> > +            __packet_set_status(po, h.raw, TP_STATUS_IN_PROGRESS);
> > +
> >         po->stats.stats1.tp_packets++;
> >         if (copy_skb) {
> >                 status |= TP_STATUS_COPY;
> > --
> > 2.10.3.dirty
> >

Thanks for the feedback!
Jon.
