Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC99CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94911218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfBUJPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:15:01 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:7241 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:15:01 -0500
X-IronPort-AV: E=Sophos;i="5.58,394,1544486400"; 
   d="scan'208";a="86249110"
Date:   Thu, 21 Feb 2019 10:14:31 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Julien Grall <julien.grall@gmail.com>
CC:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jan Beulich <JBeulich@suse.com>,
        Juergen Gross <jgross@suse.com>,
        Julien Grall <julien.grall@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
Message-ID: <20190221091431.vqi53op37mvhi25z@Air-de-Roger>
References: <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <1574a7fe-a5ac-4bc2-d3f0-967d8d01e5f1@oracle.com>
 <1100e6b1-6fa8-06f0-8ecc-b0699a2ce5f4@arm.com>
 <20190221080752.zy2qlzb4vi7tbu3p@Air-de-Roger>
 <CAF3u54Ct7nBjoLw9Vzb=aZVu=N5Ccp5_k6GxLo_ZSA=YCsco6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF3u54Ct7nBjoLw9Vzb=aZVu=N5Ccp5_k6GxLo_ZSA=YCsco6A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 08:38:39AM +0000, Julien Grall wrote:
> Hi Roger,
> 
> On Thu, 21 Feb 2019, 08:08 Roger Pau Monné, <roger.pau@citrix.com> wrote:
> 
> > FWIW, you can also mask the interrupt while waiting for the thread to
> > execute the interrupt handler. Ie:
> >
> 
> Thank you for providing steps, however where would the masking be done? By
> the irqchip or a custom solution?

I'm not familiar with the irqchip infrastructure in Linux, what I
proposed below is what FreeBSD does when running interrupt handlers in
deferred threads IIRC.

If irqchip has a specific handler to dispatch to a thread, then that's
the place where the masking should happen. Likely, the unmasking
should be done by the irq handling infrastructure after the thread
executing the interrupt handler has finished.

Isn't there a similar way to handle interrupts in threads for Linux?

> 
> > 1. Interrupt injected
> > 2. Execute guest event channel callback
> > 3. Scan for pending interrupts
> > 4. Mask interrupt
> > 5. Clear pending field
> > 6. Queue threaded handler
> > 7. Go to 3 until all interrupts are drained
> > [...]
> > 8. Execute interrupt handler in thread
> > 9. Unmask interrupt
> >
> > That should prevent you from stacking interrupts?
> >
> > Roger.
> >
