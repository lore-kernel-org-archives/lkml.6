Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714E5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3519620890
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3519620890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeGNNQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:16:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeGNNQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:16:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9926DCFB;
        Sat, 14 Jul 2018 12:57:51 +0000 (UTC)
Date:   Sat, 14 Jul 2018 14:57:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     toddpoynor@gmail.com, rspringer@google.com, jnjoseph@google.com,
        benchan@chromium.org, frankhu@chromium.org,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        toddpoynor@google.com
Subject: Re: [PATCH 06/18] staging: gasket: fix deadlock in pci driver
 unregister path
Message-ID: <20180714125749.GA19498@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
 <20180714055816.223754-7-toddpoynor@gmail.com>
 <CAE_wzQ9BCLryFUrytYEJ+tSsog4nUXEr4cbtYNgbq3w7U-qezQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE_wzQ9BCLryFUrytYEJ+tSsog4nUXEr4cbtYNgbq3w7U-qezQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 11:07:21AM +0300, Dmitry Torokhov wrote:
> On Sat, Jul 14, 2018 at 8:58 AM Todd Poynor <toddpoynor@gmail.com> wrote:
> >
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > g_mutex held across pci_unregister_driver() call, also held in
> > gasket_pci_remove(), which deadlocks.
> >
> > Reported-by: Dmitry Torokhov <dtor@chromium.org>
> > Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> > Signed-off-by: Todd Poynor <toddpoynor@google.com>
> > ---
> >  drivers/staging/gasket/gasket_core.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> > index 3bdf7d36b397..6d240dc59557 100644
> > --- a/drivers/staging/gasket/gasket_core.c
> > +++ b/drivers/staging/gasket/gasket_core.c
> > @@ -668,13 +668,10 @@ static void gasket_pci_remove(struct pci_dev *pci_dev)
> >         struct gasket_dev *gasket_dev = NULL;
> >         const struct gasket_driver_desc *driver_desc;
> >         /* Find the device desc. */
> > -       mutex_lock(&g_mutex);
> > +       __must_hold(&g_mutex);
> 
> And what exactly ensures that mutex is held here? Yes, we are holding
> the mutex when we unload the driver, but PCI hot-unplug or unbinding
> the device though sysfs do not go through module unload code path, so
> you'll end up here without holding the mutex.

Which is a huge reason the whole "wrap the pci core calls" is not going
to work here at all.  The device ownership rules are all wonky because
of this.  Unwinding that is key to getting all of this right.

thanks,

greg k-h
