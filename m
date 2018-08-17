Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2697BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C570D2185B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C570D2185B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeHQGpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:45:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:48106 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbeHQGpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:45:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7H3gvfk015006;
        Thu, 16 Aug 2018 22:42:58 -0500
Message-ID: <0ec65b10f5e414e387bd368aa816900fedcaddcc.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] pci: Proof of concept at fixing
 pci_enable_device/bridge races
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
Date:   Fri, 17 Aug 2018 13:42:57 +1000
In-Reply-To: <20180817030741.GC10316@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
         <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
         <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
         <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
         <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
         <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
         <20180817030741.GC10316@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 22:07 -0500, Bjorn Helgaas wrote:
> [+cc Srinath, Guenter, Jens, Lukas, Konstantin, Marta, Pierre-Yves]
> 
> On Thu, Aug 16, 2018 at 07:50:13AM +1000, Benjamin Herrenschmidt wrote:
> > [Note: This isn't meant to be merged, it need splitting at the very
> > least, see below]
> > 
> > This is something I cooked up quickly today to test if that would fix
> > my problems with large number of switch and NVME devices on POWER.
> > 
> > So far it does...
> > 
> > The issue (as discussed in the Re: PCIe enable device races thread) is
> > that pci_enable_device and related functions along with pci_set_master
> > and pci_enable_bridge are fundamentally racy.
> > 
> > There is no lockign protecting the state of the device in pci_dev and
> > if multiple devices under the same bridge try to enable it simultaneously
> > one some of them will potentially start accessing it before it has actually
> > been enabled.
> > 
> > Now there are a LOT more fields in pci_dev that aren't covered by any
> > form of locking.
> 
> Most of the PCI core relies on the assumption that only a single
> thread touches a device at a time.  This is generally true of the core
> during enumeration because enumeration is single-threaded.  It's
> generally true in normal driver operation because the core shouldn't
> touch a device after a driver claims it.

Mostly :-) There are a few exceptions though.

> But there are several exceptions, and I think we need to understand
> those scenarios before applying locks willy-nilly.

We need to stop creating ad-hoc locks. We have a good handle already on
the main enable/disable and bus master scenario, and the race with
is_added.

Ignore the patch itself, it has at least 2 bugs with PM, I'll send a
series improving things a bit later.

> One big exception is that enabling device A may also touch an upstream
> bridge B.  That causes things like your issue and Srinath's issue
> where drivers simultaneously enabling two devices below the same
> bridge corrupt the bridge's state [1].  Marta reported essentially the
> same issue [2].
> 
> Hari's issue [3] seems related to a race between a driver work queue
> and the core enumerating the device.  I should have pushed harder to
> understand this; I feel like we papered over the immediate problem
> without clearing up the larger issue of why the core enumeration path
> (pci_bus_add_device()) is running at the same time as a driver.

It's not. What is happening is that is_added is set by
pci_bus_add_device() after it has bound the driver. An easy fix would
have been to move it up instead:

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 737d1c52f002..ff4d536d43fc 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -323,16 +323,16 @@ void pci_bus_add_device(struct pci_dev *dev)
        pci_proc_attach_device(dev);
        pci_bridge_d3_update(dev);
 
+       dev->is_added = 1;
        dev->match_driver = true;
        retval = device_attach(&dev->dev);
        if (retval < 0 && retval != -EPROBE_DEFER) {
+               dev->is_added = 0;
                pci_warn(dev, "device attach failed (%d)\n", retval);
                pci_proc_detach_device(dev);
                pci_remove_sysfs_dev_files(dev);
                return;
        }
-
-       dev->is_added = 1;
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);

(Untested).

Note: another advantage of the above is that the current code has an
odd asymetry: is_added is currently set after we attach but also
cleared after we detatch.

If we want to keep the flag being set after attaching, then we do
indeed need to protect it against concurrent access to other fields.

The easiest way to do that would have been to remove the :1 as this:

-	unsigned int	is_added:1;
+	unsigned int	is_added;

Again, none of these approach involves the invasive patch your merged
which uses that atomic operation which provides the false sense of
security that your are somewhat "protected" while in fact you only
protect the field itself, but provide no protection about overall
concurrency of the callers which might clash in different ways.

Finally, we could also move is_added under the protection of the new
mutex I propose adding, but that would really only work as long as
we move all the :1 fields protected by that mutex together inside
the struct pci_dev structure as to avoid collisions with other fields
being modified.

All of the above are preferable to what you merged.

> DPC/AER error handling adds more cases where the core potentially
> accesses devices asynchronously to the driver.
>
> User-mode sysfs controls like ASPM are also asynchronous to drivers.
> 
> Even setpci is a potential issue, though I don't know how far we want
> to go to protect it.  I think we should make setpci taint the kernel
> anyway.

I wouldn't bother too much about it.

> It might be nice if we had some sort of writeup of the locking
> strategy as a whole.
> 
> [1] https://lkml.kernel.org/r/1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com
> [2] https://lkml.kernel.org/r/744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu
> [3] https://lkml.kernel.org/r/1530608741-30664-2-git-send-email-hari.vyas@broadcom.com

Rather than not having one ? :)

This is what I'm proposing here. Let me send patch series demonstrating
the start of this, which also fix both above issues and completely
remove that rather annoying atomic priv_flags.

I would also like to get rid of the atomic enable_cnt but that will
need a bit more churn through archs and drivers.

Cheers,
Ben.


