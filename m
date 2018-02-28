Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeB1Kfm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:35:42 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:60753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeB1Kfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:35:40 -0500
Date: Wed, 28 Feb 2018 11:35:32 +0100 (CET)
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
X-X-Sender: rolf@5HSWXM1.fritz.box
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>, kishon@ti.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 0/2] pci: endpoint: Fix double free in
 pci_epf_create()
In-Reply-To: <20180227145231.GC112033@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.LNX.2.20.1802281130190.29501@5HSWXM1.fritz.box>
References: <20180227100231.22561-1-embedded24@evers-fischer.de> <20180227102030.GB26238@e107981-ln.cambridge.arm.com> <20180227145231.GC112033@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Alpine 2.20 (LNX 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Xi7sdsJeaFWqcBHWbOlCZw6kl5PG8E7qW89cQZxiHQWctD1DJRk
 NXA1Dt9FxdhJIbNRmMmJs4GmHR0f4oB5xmhaX0SftT8zG+bpz22KWWr4fU58uJ24q7EfxMy
 M9VKgdLEQkwBNjF09GZUsQWxgdvBPNvcurXihmsOvFw9OT06gKrLS9AkWM/st8WCIbKz/rS
 jz0iFia+AE5+yRhTEzmXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LrIRPr1BD34=:U/o/Wkln0Grw/jGocjfEoI
 4o/PNS1Pz/LFfTxEO0vhbLunvYRGJ+pPKZrmw20S4EYIQfbPyxOPTS29aDZsmB4Jp0UdvGpCL
 +qau+hX5dka2kyWoZrSfPBjxYEGAD+ovowB3XlQryGumpRI0wOv1GSdw9DdtZIcuO92rw8ijs
 TQbMB03s05MOArwG8RFrnUK2Ws/lLUW/d5VT0MGSCMyLQS0Ko5/3Xw8YOOQbgW7By6gg9NO7k
 d2MtyBfBZS740fMAC9h5E2ar4jm2PEyQIjKyx0ieUiNPY2hLb9usG0BaMV+u+jY7yO6ABOEUC
 FDTASbo8wU4k21zu2/IC4H5a/+itKAptJavxwGEOWYqDnGJ8TSCJPlgl4CxUOcicpXndxcAhw
 ykHqpi1iRdQoGGVJgcZpyu/K0lpm5HJ8jTtHE/vEVjk6KQsdrn+/+QI6SfAhB49Z/KQo8caBP
 Mfazjb25h9SD492dENcP2epnWctdCaDkfu1gpOzeE8ZL+BolFy++uFTt2uUEfocv4EunMHWFD
 18ZdQxx6oOyCm8KBdqmrai9mHscQz/UW24Ch3JLtpz1fPMVBuZtUFqmG/JzWHLdu8UkP9aFys
 8FNi+xTlBM1kUOcHwxUJ9HxggNFy7CLXOTmVqmT+M4ma6iae+uTPYf7aD17RFVmY9IhXFBAcd
 UY0Hz6PYhYApBH6ACtY/clql2Pq7BlNVBeTNQzMLMbO85r2Y14m/k3InDtd7XbQ9M9LlQYuYp
 jX8z/h4jRLLQbSBxea1cfpdhKdaVGrRUrUt13LZf/jLkRQtRYUwv/x7uhkA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn!

On Tue, 27 Feb 2018, Bjorn Helgaas wrote:

> On Tue, Feb 27, 2018 at 10:20:30AM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Feb 27, 2018 at 11:02:28AM +0100, Rolf Evers-Fischer wrote:
> > > This is version 3 of a patchset to avoid double free in function
> > > 'pci_epf_create()'.
> > > 
> > > When I accidentally created a new endpoint device with an empty name,
> > > the kernel warned about "attempted to be registered with empty name!"
> > > and crashed afterwards.
> > > 
> > > It turned out that the crash was not caused by the 'device_add()'
> > > function itself, but by a double kfree of 'epf->name' and 'epf'.
> > > 
> > > The first patch just simplifies the code, while the second patch
> > > fixes the problem.
> > > 
> > > Changes in v3:
> > > - Matched to other pending pci endpoint commits (thanks, Bjorn!)
> > > - Added "Fixes" tag in patch 2 (thanks, Andy!)
> > > 
> > > Changes in v2:
> > > - Based on feedback from Lorenzo, Andy and Kishon (thanks!)
> > > - Change IDs removed
> > > - First patch completely reworked in order to eliminate the
> > >   need for the second 'kstrdup' allocation and the 'kfree' of
> > >   the first allocation.
> > >   It was tested with name="pci_epf_test.0" and name="pci_epb":
> > >   The 'epf->name' was "pci_epf_test" or "pci_epb" (=unchanged).
> > > 
> > > Rolf Evers-Fischer (2):
> > >   pci: endpoint: Simplify name allocation for epf device
> > >   pci: endpoint: Fix kernel panic after put_device()
> >     ^^^
> > 
> > s/pci/PCI
> > 
> > Bjorn pointed that out too, I can do it when merging the patches myself
> > just a hint in case you have to respin it again, no problem.
> 
> I wonder if Rolf posted the wrong version accidentally, since he
> mentioned making these match, but I don't see anything different in
> this posting.  Oh, never mind, I see the response about rebasing.
> I should have been more clear about what I was looking for.
> 
> Also s/epf/EPF/, since "epf" isn't a real word.
> 

It was my mistake. I should have asked you to clarify your request - 
especially after detecting that rebasing the commits didn't change 
anything.

Nevertheless, it seems that there will be soon a v4, where the s/pci/PCI 
and the s/epf/EPF can be done along with.

Best regards,
 Rolf
