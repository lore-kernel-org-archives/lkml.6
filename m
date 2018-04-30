Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754711AbeD3PrX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:47:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753334AbeD3PrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:47:22 -0400
Date: Mon, 30 Apr 2018 17:47:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 09/10] vfio: ccw: Suppressing the BOXED state
Message-ID: <20180430174718.7b1e5651.cohuck@redhat.com>
In-Reply-To: <32efd6b2-78b0-ae44-3a64-a092f9d412fe@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-10-git-send-email-pmorel@linux.vnet.ibm.com>
        <20180425104429.582618f8.cohuck@redhat.com>
        <32efd6b2-78b0-ae44-3a64-a092f9d412fe@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018 15:55:51 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 25/04/2018 10:44, Cornelia Huck wrote:
> > On Thu, 19 Apr 2018 16:48:12 +0200
> > Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> >  
> >> VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY are the same
> >> states.
> >> Let's only keep one: VFIO_CCW_STATE_BUSY
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >> ---
> >>   drivers/s390/cio/vfio_ccw_fsm.c     | 9 ---------
> >>   drivers/s390/cio/vfio_ccw_private.h | 1 -
> >>   2 files changed, 10 deletions(-)  
> > I think they were initially supposed to cover two different things:
> > - BUSY: we're currently dealing with an I/O request
> > - BOXED: the device currently won't talk to us or we won't talk to it
> >
> > It seems we never really did anything useful with BOXED; but should we?
> >  
> I do not know what.

The BUSY state is something we know that we'll get out of soon-ish
(when the I/O request has finished). We could conceivably use a timeout
and drop to the BOXED state if we don't get an answer.

I think this plays also into the reserve/release and path handling
questions. One of the more common reasons for devices to become boxed
I've seen is another system doing a reserve on a dasd.
