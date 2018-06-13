Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B2B0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F74F208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F74F208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935832AbeFMOv5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:51:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935656AbeFMOvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:51:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 127A287A7C;
        Wed, 13 Jun 2018 14:51:55 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1A391117645;
        Wed, 13 Jun 2018 14:51:53 +0000 (UTC)
Date:   Wed, 13 Jun 2018 16:51:51 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/8] vfio: ccw: Refactoring the VFIO CCW state
 machine
Message-ID: <20180613165151.056ecaec.cohuck@redhat.com>
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 13 Jun 2018 14:51:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 13 Jun 2018 14:51:55 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 09:56:42 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The goal of the patch serie is to secure the state machine by:
> - centralizing all state changes inside the state machine wrapper
> - make the state change atomic using mutexes
> - refactor the initialization to avoid using a subchannel without a guest
> 
> 
> This series introduces new states and events and suppressed
> others.
> Here the list of states and events used in this serie:

I've tried to come up with some annotations (without looking at the
code :); please correct me if I'm wrong. I want to understand the
design better.

> - VFIO_CCW_STATE_NOT_OPER    : when the Sub-Channel is KO

These are cases of "not operational, we can't even talk to it anymore",
right? If so, the only way out is unregistration of the subchannel,
unless we want to keep it around in case it revives and we get a machine
check. So this is likely a transient state?

> - VFIO_CCW_STATE_STANDBY     : when it is offline

Bound to the driver, but no mdev (and subchannel disabled). The target
states that could happen are either not oper (device gone; we notice
via machine check or when we try to enable the subchannel) or idle (we
enable the subchannel and make it ready for use). Non-transient state
(will stay there until something happens).

> - VFIO_CCW_STATE_IDLE        : when it is ready for I/O

Can go to not oper (device gone), standby (via quiescing?) or busy
(guest does I/O). Non-transient state.

> - VFIO_CCW_STATE_BUSY        : when it is busy doing I/O

Can go to idle (all done), or to not oper, I guess. Transient state.

> - VFIO_CCW_STATE_QUIESCING(N): when it is busy going offline

We're doing cancel/halt/clear. Target is standby, but can go to not
oper if device gone. Transient state.

The boxed state you're removing might have served as a non-transient
equivalent to busy (device does not respond, needs a kick to get out of
the state), but we can re-introduce it if we find it useful in the
future.

> 
> - VFIO_CCW_EVENT_INIT            : the channel setup (admin)

By "admin" you mean "action triggered by admin", right?

> - VFIO_CCW_EVENT_NOT_OPER        : something really wrong happened

That's device gone resp. not operational. Anything else?

I suppose that can only trigger as a reaction to some hardware
reconfiguration or malfunction.

> - VFIO_CCW_EVENT_IO_REQ          : Starting a SSCH request (UAPI)

Triggered by guest action.

> - VFIO_CCW_EVENT_INTERRUPT(N)    : Receiving an interrupt (callback)

Triggered by hardware.

> - VFIO_CCW_EVENT_SCHIB_CHANGED(N): Receiving a channel event (callback)

Also triggered by hardware? Can this also trigger a not oper event?

> 
> The user's ABI do not change.
> 
> 
> 
> Pierre Morel (8):
>   vfio: ccw: Moving state change out of IRQ context
>   vfio: ccw: Transform FSM functions to return state
>   vfio: ccw: new VFIO_CCW_EVENT_SCHIB_CHANGED event
>   vfio: ccw: Only accept SSCH as an IO request
>   vfio: ccw: Suppress unused event parameter
>   vfio: ccw: Make FSM functions atomic
>   vfio: ccw: Introduce the INIT event
>   vfio: ccw: Suppressing the BOXED state
> 
>  drivers/s390/cio/vfio_ccw_drv.c     |  71 ++++++-----------
>  drivers/s390/cio/vfio_ccw_fsm.c     | 147 +++++++++++++++++++++---------------
>  drivers/s390/cio/vfio_ccw_ops.c     |  41 +++++-----
>  drivers/s390/cio/vfio_ccw_private.h |  12 ++-
>  4 files changed, 137 insertions(+), 134 deletions(-)
> 

