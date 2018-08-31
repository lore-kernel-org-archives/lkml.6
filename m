Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201BAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4CC20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4CC20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeHaU1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:27:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbeHaU1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:27:41 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B028F447A913;
        Sat,  1 Sep 2018 00:19:21 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Sat, 1 Sep 2018
 00:19:20 +0800
Date:   Fri, 31 Aug 2018 17:19:06 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-rdma@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-block@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180831171906.00002751@huawei.com>
In-Reply-To: <20180830185352.3369-2-logang@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
        <20180830185352.3369-2-logang@deltatee.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 12:53:40 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> Some PCI devices may have memory mapped in a BAR space that's
> intended for use in peer-to-peer transactions. In order to enable
> such transactions the memory must be registered with ZONE_DEVICE pages
> so it can be used by DMA interfaces in existing drivers.
> 
> Add an interface for other subsystems to find and allocate chunks of P2P
> memory as necessary to facilitate transfers between two PCI peers:
> 
> int pci_p2pdma_add_client();
> struct pci_dev *pci_p2pmem_find();
> void *pci_alloc_p2pmem();
> 
> The new interface requires a driver to collect a list of client devices
> involved in the transaction with the pci_p2pmem_add_client*() functions
> then call pci_p2pmem_find() to obtain any suitable P2P memory. Once
> this is done the list is bound to the memory and the calling driver is
> free to add and remove clients as necessary (adding incompatible clients
> will fail). With a suitable p2pmem device, memory can then be
> allocated with pci_alloc_p2pmem() for use in DMA transactions.
> 
> Depending on hardware, using peer-to-peer memory may reduce the bandwidth
> of the transfer but can significantly reduce pressure on system memory.
> This may be desirable in many cases: for example a system could be designed
> with a small CPU connected to a PCIe switch by a small number of lanes
> which would maximize the number of lanes available to connect to NVMe
> devices.
> 
> The code is designed to only utilize the p2pmem device if all the devices
> involved in a transfer are behind the same PCI bridge. This is because we
> have no way of knowing whether peer-to-peer routing between PCIe Root Ports
> is supported (PCIe r4.0, sec 1.3.1). Additionally, the benefits of P2P
> transfers that go through the RC is limited to only reducing DRAM usage
> and, in some cases, coding convenience. The PCI-SIG may be exploring
> adding a new capability bit to advertise whether this is possible for
> future hardware.
> 
> This commit includes significant rework and feedback from Christoph
> Hellwig.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Apologies for being a late entrant to this conversation so I may be asking
about a topic that has been covered in detail in earlier patches!
> ---
...

> +/*
> + * Find the distance through the nearest common upstream bridge between
> + * two PCI devices.
> + *
> + * If the two devices are the same device then 0 will be returned.
> + *
> + * If there are two virtual functions of the same device behind the same
> + * bridge port then 2 will be returned (one step down to the PCIe switch,
> + * then one step back to the same device).
> + *
> + * In the case where two devices are connected to the same PCIe switch, the
> + * value 4 will be returned. This corresponds to the following PCI tree:
> + *
> + *     -+  Root Port
> + *      \+ Switch Upstream Port
> + *       +-+ Switch Downstream Port
> + *       + \- Device A
> + *       \-+ Switch Downstream Port
> + *         \- Device B
> + *
> + * The distance is 4 because we traverse from Device A through the downstream
> + * port of the switch, to the common upstream port, back up to the second
> + * downstream port and then to Device B.
> + *
> + * Any two devices that don't have a common upstream bridge will return -1.
> + * In this way devices on separate PCIe root ports will be rejected, which
> + * is what we want for peer-to-peer seeing each PCIe root port defines a
> + * separate hierarchy domain and there's no way to determine whether the root
> + * complex supports forwarding between them.
> + *
> + * In the case where two devices are connected to different PCIe switches,
> + * this function will still return a positive distance as long as both
> + * switches evenutally have a common upstream bridge. Note this covers
> + * the case of using multiple PCIe switches to achieve a desired level of
> + * fan-out from a root port. The exact distance will be a function of the
> + * number of switches between Device A and Device B.

This feels like a somewhat simplistic starting point rather than a
generally correct estimate to use.  Should we be taking the bandwidth of
those links into account for example, or any discoverable latencies?
Not all PCIe switches are alike - particularly when it comes to P2P.

I guess that can be a topic for future development if it turns out people
have horrible mixed systems.

> + *
> + * If a bridge which has any ACS redirection bits set is in the path
> + * then this functions will return -2. This is so we reject any
> + * cases where the TLPs are forwarded up into the root complex.
> + * In this case, a list of all infringing bridge addresses will be
> + * populated in acs_list (assuming it's non-null) for printk purposes.
> + */

