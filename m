Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747052083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747052083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966558AbeFSOAw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:00:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966077AbeFSOAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31603400B458;
        Tue, 19 Jun 2018 14:00:49 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02A572156880;
        Tue, 19 Jun 2018 14:00:47 +0000 (UTC)
Date:   Tue, 19 Jun 2018 16:00:45 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/8] vfio: ccw: Refactoring the VFIO CCW state
 machine
Message-ID: <20180619160045.13caf12e.cohuck@redhat.com>
In-Reply-To: <bd5fb44e-3395-63bc-23a5-b9b6a8a8f1ef@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
        <20180613165151.056ecaec.cohuck@redhat.com>
        <bd5fb44e-3395-63bc-23a5-b9b6a8a8f1ef@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 19 Jun 2018 14:00:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 19 Jun 2018 14:00:49 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 10:06:31 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> I tried to make a better description to add later in documentation
> or in the next cover-letter.
> 
> Note that in the current patch series I did not implement online/offline
> events but just kept the previous state changes.
> Not sure if it was a good idea, the goal was to be as simple as possible
> for this iteration.
> If you think it is worth to continue in this direction I will re-introduce
> these as events.

I'm still trying to figure out what we want from the state machine.
I've tried sketching your fsm proposal as outlined by you below for
myself and I have some remarks :)

> 
> ======================
> 
> 1) In CCW VFIO, Finite State Machine is used to clarify the VFIO CCW driver
> actions to be take depending on the events occurring in a device.
> 
> To protect the state transitions, a mutex protect the action
> started when an event occurs in a specific state.
> 
> The actions must never sleep or keep the mutex a long timer.
> 
> To be able to take the mutex when hardware events occur we start
> a work on a dedicated workqueue, posting the event from inside the
> workqueue.
> 
> The state machine has very few states describing the device driver life.
> 
> ------------------------------------------------------------
> | NOT_OPERATIONAL  | No guest is associated with the device|

I don't think that this is the right description. It is either the
initial state, or something has happened that rendered the device
inaccessible.

Also, we need to be careful with the virtual machine vs. guest
terminology. The only thing that has an impact from the guest is when
it does I/O and when an interrupt is generated as a result (i.e., the
IDLE/BUSY transitions). The other transitions are triggered by virtual
machine setup.

> ------------------------------------------------------------
> | STANDBY          | A guest is associated but not started |

This is basically "device is bound to driver, but no mdev has been set
up". In my understanding, we need to get the device to IDLE state
before the vm can present it to the guest (be it before the machine is
up or during hotplug).

> ------------------------------------------------------------
> | IDLE             | Guest started device ready            |

Agree with "device ready", disagree with "guest started" (see above).
"Device ready, accepting I/O requests"?

> ------------------------------------------------------------
> | BUSY             | The device is busy doing IO           |
> ------------------------------------------------------------
> | QUIESCING        | The driver is releasing the device    |

Now you are talking about the driver :) This should probably be done
for the other states as well.

Isn't that state for waiting for outstanding I/O to be terminated
before the mdev is destroyed? IOW, the device may stay bound to the
driver afterwards?

> ------------------------------------------------------------
> 
> 
> 2) The following Events may apply to the state machine:
> 
> If the event is not described, it means it has no influence
> on the state and that no action is required.
> 
> 2.1) FSM in state NOT_OPERATIONAL
> ------------------------------------------------------------
> | INIT             | a guest will drive the SC             |

Better to write out "subchannel", I could not figure out the
abbreviation immediately.

Also, doesn't the event really mean "we're initializing the device"?
The ultimate intention is of course for a guest to use the device, but
the immediate intention is just "get the device through the first
initialization steps".

> | |                                       |
> |                  | triggered by: mdev_open               |
> |                  | action: initialize driver structures  |
> |                  | action: register IOMMU notifier       |
> |                  | state on success: STANDBY             |
> |                  | state on error  : NOT_OPERATIONAL     |
> ------------------------------------------------------------
> 
> 2.2) FSM in state STANDBY
> 
> ------------------------------------------------------------
> | ONLINE           | The host wants the SC online          |

Isn't that rather "an mdev is created"?

> | |                                       |
> |                  | triggered by: vfio_reset              |
> |                  | action: enable SC                     |
> |                  | state on success: IDLE                |
> |                  | state on error  : STANDBY             |

What happens if the subchannel is not operational when we try to get it
ready? Can it go to NOT_OPERATIONAL in that case?

> ------------------------------------------------------------
> 
> Some operations may be intercepted by the state machine but
> will not induce a state change:
> OFFLINE: re-issue the disabling of the SC

Should that even be possible? If we're still busy tearing it down,
shouldn't we be in QUIESCING state?

> IRQ    : re-issue the disabling of the SC

Either we should have cleared the subchannel out during QUIESCING, or
we got an unsolicited interrupt. The latter can be avoided if we make
sure that the device is disabled when we go to STANDBY.

> 
> 2.3) FSM in state IDLE
> 
> ------------------------------------------------------------
> | SSCH             | The guest issue the ssch instruction  |
> | |                                       |
> |                  | triggered by: vfio_write SSCH=1       |
> |                  | action: start an IO request           |
> |                  | state on success: BUSY                |
> |                  | state on error  : IDLE                |

Should there be any way to drop to NOT_OPERATIONAL as well? We'll
probably get a notification from the common I/O layer if that happens,
though.

> ------------------------------------------------------------
> 2.4) FSM in states IDLE or BUSY
> 
> ------------------------------------------------------------
> | IRQ              | The hardware issue an interrupt       |

I think we can get this in QUIESCING as well, and it is an indication
that QUIESCING is done (for final states).

If the subchannel is enabled while in STANDBY, we could get an
interrupt there as well.

> | |                                       |
> |                  | triggered by: vfio_ccw_sch_irq        |
> |                  | action: update SCSW forward IRQ       |
> |                  | state on success: IDLE                |

One thing to consider (and I'm not sure we're handling it correctly
right now): What if we don't have a final status for the I/O yet, i.e.
there will be another interrupt for the I/O? Should we stay in BUSY in
that case?

> |                  | state on error  : IDLE                |

Hm, what error?

> ------------------------------------------------------------
> 
> ------------------------------------------------------------
> | OFFLINE          | The host wants the SC offline         |

That's mdev teardown, I guess?

> | |                                       |
> |                  | triggered by: css remove              |
> |                  | triggered by: css shutdown            |

These as well.

> |                  | action: disable SC                    |
> |                  | state on success: STANDBY             |

If it's really a css remove (unbind from driver or device removal), it
should not really have a target state, as the vfio-ccw device will be
gone, no? This is only correct for mdev removal.

> |                  | state on error  : NOT_OPERATIONAL     |
> ------------------------------------------------------------
> 
> ------------------------------------------------------------
> | STORE_SCHIB      | The hardware issue "schib updated"    |

This is the common I/O layer's sch_event callback. That can mean
different things:
- Something regarding the paths to the device changed. We can translate
  that to "schib updated".
- Device is gone. This is a different situation; we may either try to
  implement the disconnected state, or we may give up the device.

Also, can't we get this event in QUIESCING or STANDBY as well?

> | |                                       |
> |                  | triggered by: sch_event               |
> |                  | action: Store the SCHIB in IO region  |
> |                  | state on success: no change           |

As said, we may want some different handling for "device gone"
situations.

Also, what happens if we get that event in BUSY? Is the I/O still
running?

> |                  | state on error  : NOT_OPERATIONAL     |
> ------------------------------------------------------------
> 
> NOTE 1:
>     All out of band IO related instructions, XSCH, CSCH, HSCH
>     can be started in both states IDLE and BUSY.

Hm. What do you mean by "out of band"?

You can, of course, get all of the instructions above in both IDLE and
BUSY states. The question is what we want to do with them. Do we want
to put them through to the hardware in any case? If we do e.g. a hsch
and get a cc 2, we don't want to drop to IDLE, but stay in BUSY (as the
start function is likely still running).

What about RSCH?

> 
> NOTE 2:
>     Currently IRQ means solicited interrupt, but handle both
>     solicited and unsolicited interrupts.
>     The unsolicited interrupt event may be implemented separatly.

We need to be ready for unsolicited interrupts at any point in time. It
mainly depends on the state whether we want to forward them to the
guest (BUSY, IDLE) or not (QUIESCING, STANDBY).

> 
> 2.5) FSM in any state
> 
> ------------------------------------------------------------
> | NOT_OPERATIONAL  | The device is released                |
> | |                                       |
> |                  | triggered by: mdev_release            |
> |                  | action: unregister IOMMU notifier     |
> |                  | state on success: NOT_OPERATIONAL     |
> ------------------------------------------------------------

Confused. Isn't that "device gone or not operational" as well?
