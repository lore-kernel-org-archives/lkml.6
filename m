Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B56C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD82121470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD82121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeHPCeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:34:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:50312 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbeHPCeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:34:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7FNcgZG008323;
        Wed, 15 Aug 2018 18:38:46 -0500
Message-ID: <947d07eb6bc64eefe5cfd9a08420a33f855cbe2c.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] pci: Proof of concept at fixing
 pci_enable_device/bridge races
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 16 Aug 2018 09:38:41 +1000
In-Reply-To: <20180815224028.GA12104@roeck-us.net>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
         <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
         <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
         <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
         <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
         <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
         <20180815224028.GA12104@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-15 at 15:40 -0700, Guenter Roeck wrote:
> On Thu, Aug 16, 2018 at 07:50:13AM +1000, Benjamin Herrenschmidt wrote:
> > (Resent with lkml on copy)
> > 
> > [Note: This isn't meant to be merged, it need splitting at the very
> > least, see below]
> > 
> > This is something I cooked up quickly today to test if that would fix
> > my problems with large number of switch and NVME devices on POWER.
> > 
> 
> Is that a problem that can be reproduced with a qemu setup ?

With difficulty... mt-tcg might help, but you need a rather large
systems to reproduce it.

My repro-case is a 2 socket POWER9 system (about 40 cores off the top
of my mind, so 160 threads) with 72 NVME devices underneath a tree of
switches (I don't have the system at hand today to check how many).

It's possible to observe it I suppose on a smaller system (in theory a
single bridge with 2 devices is enough) but in practice the timing is
extremely hard to hit.

You need a combination of:

  - The bridges come up disabled (which is the case when Linux does the
resource assignment, such as on POWER but not on x86 unless it's
hotplug)

  - The nvme devices try to enable them simultaneously

Also the resulting error is a UR, I don't know how well qemu models
that.

On the above system, I get usually *one* device failing due to the race
out of 72, and not on every boot.

However, the bug is known (see Bjorn's reply to the other thread) "Re:
PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
happening due to race condition)" on linux-pci, so I'm not the only one
with a repro-case around.

Cheers,
Ben.


