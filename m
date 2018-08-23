Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A587B2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A587B2152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbeHWOqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:46:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbeHWOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:46:45 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2A5D5BAE;
        Thu, 23 Aug 2018 11:17:30 +0000 (UTC)
Date:   Thu, 23 Aug 2018 13:17:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4.14 210/217] PCI: OF: Fix I/O space page leak
Message-ID: <20180823111728.GA2945@kroah.com>
References: <20180823075505.090246914@linuxfoundation.org>
 <20180823075515.152259931@linuxfoundation.org>
 <fa1a9728-8deb-867d-04b1-a9959ab48d24@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1a9728-8deb-867d-04b1-a9959ab48d24@cogentembedded.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 01:57:35PM +0300, Sergei Shtylyov wrote:
> On 08/23/2018 10:55 AM, Greg Kroah-Hartman wrote:
> 
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > commit a5fb9fb023a1435f2b42bccd7f547560f3a21dc3 upstream.
> > 
> > When testing the R-Car PCIe driver on the Condor board, if the PCIe PHY
> > driver was left disabled, the kernel crashed with this BUG:
> > 
> >   kernel BUG at lib/ioremap.c:72!
> >   Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> >   Modules linked in:
> >   CPU: 0 PID: 39 Comm: kworker/0:1 Not tainted 4.17.0-dirty #1092
> >   Hardware name: Renesas Condor board based on r8a77980 (DT)
> >   Workqueue: events deferred_probe_work_func
> >   pstate: 80000005 (Nzcv daif -PAN -UAO)
> >   pc : ioremap_page_range+0x370/0x3c8
> >   lr : ioremap_page_range+0x40/0x3c8
> >   sp : ffff000008da39e0
> >   x29: ffff000008da39e0 x28: 00e8000000000f07
> >   x27: ffff7dfffee00000 x26: 0140000000000000
> >   x25: ffff7dfffef00000 x24: 00000000000fe100
> >   x23: ffff80007b906000 x22: ffff000008ab8000
> >   x21: ffff000008bb1d58 x20: ffff7dfffef00000
> >   x19: ffff800009c30fb8 x18: 0000000000000001
> >   x17: 00000000000152d0 x16: 00000000014012d0
> >   x15: 0000000000000000 x14: 0720072007200720
> >   x13: 0720072007200720 x12: 0720072007200720
> >   x11: 0720072007300730 x10: 00000000000000ae
> >   x9 : 0000000000000000 x8 : ffff7dffff000000
> >   x7 : 0000000000000000 x6 : 0000000000000100
> >   x5 : 0000000000000000 x4 : 000000007b906000
> >   x3 : ffff80007c61a880 x2 : ffff7dfffeefffff
> >   x1 : 0000000040000000 x0 : 00e80000fe100f07
> >   Process kworker/0:1 (pid: 39, stack limit = 0x        (ptrval))
> >   Call trace:
> >    ioremap_page_range+0x370/0x3c8
> >    pci_remap_iospace+0x7c/0xac
> >    pci_parse_request_of_pci_ranges+0x13c/0x190
> >    rcar_pcie_probe+0x4c/0xb04
> >    platform_drv_probe+0x50/0xbc
> >    driver_probe_device+0x21c/0x308
> >    __device_attach_driver+0x98/0xc8
> >    bus_for_each_drv+0x54/0x94
> >    __device_attach+0xc4/0x12c
> >    device_initial_probe+0x10/0x18
> >    bus_probe_device+0x90/0x98
> >    deferred_probe_work_func+0xb0/0x150
> >    process_one_work+0x12c/0x29c
> >    worker_thread+0x200/0x3fc
> >    kthread+0x108/0x134
> >    ret_from_fork+0x10/0x18
> >   Code: f9004ba2 54000080 aa0003fb 17ffff48 (d4210000)
> > 
> > It turned out that pci_remap_iospace() wasn't undone when the driver's
> > probe failed, and since devm_phy_optional_get() returned -EPROBE_DEFER,
> > the probe was retried, finally causing the BUG due to trying to remap
> > already remapped pages.
> > 
> > Introduce the devm_pci_remap_iospace() managed API and replace the
> > pci_remap_iospace() call with it to fix the bug.
> > 
> > Fixes: dbf9826d5797 ("PCI: generic: Convert to DT resource parsing API")
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > [lorenzo.pieralisi@arm.com: split commit/updated the commit log]
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > [Backport just for the new api which other patches need - gregkh]
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> >  drivers/pci/pci.c   |   38 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h |    2 ++
> >  2 files changed, 40 insertions(+)
> 
>   You missed a chnage to drivers/pci/host/pci-host-common.c (and 
> also drivers/pci/host/pcie-rcar.c which wasn't using the generic mode back
> then)...

Yes I totally messed this up, let me fix it...
