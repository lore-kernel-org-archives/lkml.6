Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeD3SkL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 14:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753608AbeD3SkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 14:40:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE55B21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 30 Apr 2018 13:40:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] PCI: Introduce devm_of_pci_get_host_bridge_resources
Message-ID: <20180430184007.GC95643@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
 <e387d04ea235c9a4879a897bb730adc383a96635.1524582822.git.jan.kiszka@siemens.com>
 <20180427222427.GB73638@bhelgaas-glaptop.roam.corp.google.com>
 <869a8ad9-dd2f-8462-c0c4-2d8a62d74185@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869a8ad9-dd2f-8462-c0c4-2d8a62d74185@siemens.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 09:28:47AM +0200, Jan Kiszka wrote:
> On 2018-04-28 00:24, Bjorn Helgaas wrote:
> > On Tue, Apr 24, 2018 at 05:13:39PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> of_pci_get_host_bridge_resources allocates the resource structures it
> >> fills dynamically, but none of its callers care to release them so far.
> >> Rather than requiring everyone to do this explicitly, introduce a
> >> managed version of that service. This differs API-wise only in taking a
> >> reference to the associated device, rather than to the device tree node.
> >>
> >> As of_pci_get_host_bridge_resources is an exported interface, we cannot
> >> simply drop it at this point. After converting all in-tree users to the
> >> new API, we could phase out the unmanaged one over some grace period.
> > 
> > It looks like it might be possible to split this into three or four
> > patches:
> > 
> >   1) Factor __of_pci_get_host_bridge_resources() out of
> >      of_pci_get_host_bridge_resources()
> > 
> >   2) Add struct device * argument
> > 
> >   3) Convert pr_info() to dev_info()
> > 
> >   4) Add devm_of_pci_get_host_bridge_resources()
> 
> Will do. I'm even considering
> 
> 5) mark of_pci_get_host_bridge_resources() __deprecated, due to the leak
>    and no remaining in-tree user - what do you think?

Sounds good.

It'd be nice if we had some guideline about deprecation -- whether we
actually need to mark things __deprecated, and then how long to wait
before actually removing them, but I don't see anything in
Documentation/.

Looks like it was added by cbe4097f8ae6 ("of/pci: Add support for
parsing PCI host bridge resources from DT") in v3.18, so it's been
around for a while and I guess it would be nice to have a grace period
before removing it.
