Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBEVhT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:37:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:38925 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752358AbeBEVhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:37:07 -0500
Message-ID: <1517866584.2312.140.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ryder Lee <ryder.lee@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Date: Tue, 06 Feb 2018 08:36:24 +1100
In-Reply-To: <1517563970.24622.9.camel@mtkswgap22>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
         <CAL_JsqLZqrxxpuEnoWEGkT2WCuyjqn0bM1DP8PdAwnQsso8kOA@mail.gmail.com>
         <1517563970.24622.9.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 17:32 +0800, Ryder Lee wrote:
> On Wed, 2018-01-31 at 10:02 -0600, Rob Herring wrote:
> > On Wed, Jan 31, 2018 at 1:41 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> > > A root complex usually consist of a host bridge and multiple P2P bridges,
> > > and someone may express that in the form of a root node with many subnodes
> > > and list all four interrupts for each slot (child node) in the root node
> > > like this:
> > > 
> > >          pcie-controller {
> > >                  ...
> > >                  interrupt-map-mask = <0xf800 0 0 7>;
> > >                  interrupt-map = <0x0000 0 0 {INTx} &{interrupt parent} ...>
> > >                                   0x0800 0 0 {INTx} &{interrupt parent} ...>;
> > > 
> > >                  pcie@0,0 {
> > >                          reg = <0x0000 0 0 0 0>;
> > >                          ...
> > >                  };
> > > 
> > >                  pcie@1,0 {
> > >                          reg = <0x0800 0 0 0 0>;
> > >                          ...
> > >                  };
> > >          };
> > > 
> > > As shown above, we'd like to propagate IRQs from a root port to the devices
> > > in the hierarchy below it in this way.  However, it seems that the current
> > > parser couldn't handle such cases and will get something unexpected below:
> > > 
> > >          pcieport 0000:00:01.0: assign IRQ: got 213
> > >          igb 0000:01:00.0: assign IRQ: got 212
> > > 
> > > There is a device which is connected to 2nd slot, but the port doesn't share
> > > the same IRQ with its downstream devices.  The problem here is that, if the
> > > loop found a P2P bridge, it wouldn't check whether the reg property exists
> > > in ppnode or not but just pass the subordinate devfn to of_irq_parse_raw(),
> > > thus the subsequent flow couldn't correctly resolve them.

I don't really understand the problem explanation here. Something
doesn't look right as you shouldn't have to change that function, but I
just don't get what you a

Cheers,
Ben.
