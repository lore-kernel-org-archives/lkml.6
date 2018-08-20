Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE0BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12859208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12859208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeHTO1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:27:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:50140 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTO1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:27:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7KBC7DX031088;
        Mon, 20 Aug 2018 06:12:08 -0500
Message-ID: <61e3dfcf831fab4443b86579f39d4f08c6200c41.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 Aug 2018 21:12:07 +1000
In-Reply-To: <20180820071703.hnsyhb5pz4svb7jg@wunner.de>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
         <20180817044902.31420-2-benh@kernel.crashing.org>
         <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
         <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
         <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com>
         <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
         <20180820071703.hnsyhb5pz4svb7jg@wunner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-20 at 09:17 +0200, Lukas Wunner wrote:
> On Mon, Aug 20, 2018 at 12:10:59PM +1000, Benjamin Herrenschmidt wrote:
> > I chose to create a new mutex which we should be able to address other
> > similar races if we find them. The other solutions that I dismissed
> > were:
> > 
> >  - Using the device_lock. A explained previously, this is tricky, I
> > prefer not using this for anything other than locking against
> > concurrent add/remove. The main issue is that drivers will be sometimes
> > called in context where that's already held, so we can't take it inside
> > pci_enable_device() and I'd rather not add new constraints such as
> > "pci_enable_device() must be only called from probe() unless you also
> > take the device lock". It would be tricky to audit everybody...
> > 
> >  - Using a global mutex. We could move the bridge lock from AER to core
> > code for example, and use that. But it doesn't buy us much, and
> > slightly redecuces parallelism. It also makes it a little bit more
> > messy to walk up the bridge chain, we'd have to do a
> > pci_enable_device_unlocked or something, messy.
> 
> +1 from my side for adding a struct mutex to struct pci_dev to protect
> state changes.

Ok thanks. This is what my patch proposes. We can use it later to
protect more things if we wish to do so.

> The device_lock() primarily protects binding / unbinding of the device
> and pci_dev state may have to be changed while binding / unbinding.

Yup, precisely.

> A global lock invites deadlocks if multiple devices are added / removed
> concurrently where one is a parent of the other.  (Think hot-removal of
> multiple devices on a Thunderbolt daisy-chain.)

Yes.

> As said I'd also welcome folding PCI_DEV_DISCONNECTED into enum
> pci_channel_state, either as an additional state or by using
> pci_channel_io_perm_failure.

Ok. I have that in my tentative series but I think for robustness, I
should make the error_state field atomically updated in order to ensure
that no transition out of "disconnected" can happen while racing with
concurrent error_state updates at interrupt time (at least with EEH, it
can be updated from any read{b,w,l,q}).

I'll do a bit more work on the patches this week as time permits and
send a non-RFC series.

Cheers,
Ben. 

> Thanks,
> 
> Lukas

