Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeDDWbx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 18:31:53 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:40415 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeDDWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 18:31:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BzAgDfUcVa/4oNJK1dGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNCgR8xMoNVlQqDA5JVgXoLhQMCGoQmITUXAQIBAQEBAQE?=
 =?us-ascii?q?CbCiFIwYjEUUQAgEIGgImAgICMBUQAgQODYUFrFGCHIhGgiWBCYZZgVQ/g1w?=
 =?us-ascii?q?0h2+CVAKXPggCiB6GCYxEK48rAhETAYEkAR0BNoFScBWCfoIfFxGOBo1EgRc?=
 =?us-ascii?q?BAQ?=
X-IronPort-AV: E=Sophos;i="5.48,408,1517875200";
   d="scan'208";a="376594628"
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
Thread-Index: AQHTy5aFtVi5IJ8ejEig7CpBQEL4WqPw40yA///J04CAALsRgP//wqYg
Date: Wed, 4 Apr 2018 22:31:49 +0000
Message-ID: <dcd34772073547818c3e1e5d0b4cfaf0@XCH-RTP-016.cisco.com>
References: <20180403215526.15934-1-jrosen@cisco.com>
 <CAF=yD-L8DaS7LW4SAaTRd2RPxVnfrdiVLCdWJxxaTu3Hn8ORSA@mail.gmail.com>
 <057239cdf1c34bc69636009c9e099214@XCH-RTP-016.cisco.com>
 <CAF=yD-LP7RjenkfbFq+dG9XFZx2D7-JwqOeVD+1tLjgXxh8SpA@mail.gmail.com>
In-Reply-To: <CAF=yD-LP7RjenkfbFq+dG9XFZx2D7-JwqOeVD+1tLjgXxh8SpA@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w34MVvEg024446

> >> >    One issue with the above proposed change to use TP_STATUS_IN_PROGRESS
> >> >    is that the documentation of the tp_status field is somewhat
> >> >    inconsistent.  In some places it's described as TP_STATUS_KERNEL(0)
> >> >    meaning the entry is owned by the kernel and !TP_STATUS_KERNEL(0)
> >> >    meaning the entry is owned by user space.  In other places ownership
> >> >    by user space is defined by the TP_STATUS_USER(1) bit being set.
> >>
> >> But indeed this example in packet_mmap.txt is problematic
> >>
> >>     if (status == TP_STATUS_KERNEL)
> >>         retval = poll(&pfd, 1, timeout);
> >>
> >> It does not really matter whether the docs are possibly inconsistent and
> >> which one is authoritative. Examples like the above make it likely that
> >> some user code expects such code to work.
> >
> > Yes, that's exactly my concern.  Yet another troubling example seems to be
> > lipbcap which also is looking specifically for status to be anything other than
> > TP_STATUS_KERNEL(0) to indicate a frame is available in user space.
> 
> Good catch. If pcap-linux.c relies on this then the status field
> cannot be changed. Other fields can be modified freely while tp_status
> remains 0, perhaps that's an option.

Possibly. Someone else suggested something similar but in at least the
one example we thought through it still seemed like it didn't address the problem.

For example, let's say we used tp_len == -1 to indicate to other kernel threads
that the entry was already in progress.  This would require that user space never
set tp_len = -1 before returning the entry back to the kernel.  If it did then no
kernel thread would ever claim ownership and the ring would hang.

Now, it seems pretty unlikely that user space would do such a thing so maybe we
could look past that, but then we run into the issue that there is still a window
of opportunity for other kernel threads to come in and wrap the ring.

The reason is we can't set tp_len to the correct length after setting tp_status because
user space could grab the entry and see tp_len == -1 so we have to set tp_len
before we set tp_status. This means that there is still a window where other
kernel threads could come in and see tp_len as something other than -1 and
a tp_status of TP_STATUS_KERNEL and think it's ok to allocate the entry.
This puts us back to where we are today (arguably with a smaller window,
but a window none the less).

Alternatively we could reacquire the spin_lock to then set tp_len followed by
tp_status.  This would give the necessary indivisibility in the kernel while 
preserving proper order as made visible to user space, but it comes at the cost
of another spin_lock.

Thanks for the suggestion.  If you can think of a way around this I'm all ears.
I'll think on this some more but so far I'm stuck on how to get past having to
broaden the scope of the spin_lock, reacquire the spin_lock, or use some sort
of atomic construct along with a parallel shadow ring structure (still thinking
through that one as well).
