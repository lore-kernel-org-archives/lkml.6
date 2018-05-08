Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbeEHXcJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 19:32:09 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34120 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754148AbeEHXcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 19:32:07 -0400
To: Alex Williamson <alex.williamson@redhat.com>,
        Stephen Bates <sbates@raithlin.com>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508144341.0441b676@w520.home>
 <a524127a-3557-3dff-971c-dfe94ba5a01c@deltatee.com>
 <20180508152631.50fd583c@w520.home>
 <354F7407-0DC7-470C-B9AA-74FDF9C46B08@raithlin.com>
 <20180508160336.0935ddde@w520.home>
 <20905682-9440-7d4b-0260-99d3dc794c3d@deltatee.com>
 <C3CEE4DB-A001-4E4C-B9B9-4B160E4C5367@raithlin.com>
 <20180508171150.0e8fd291@w520.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0a0a1782-04b2-c571-63c7-bfff68312946@deltatee.com>
Date: Tue, 8 May 2018 17:31:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508171150.0e8fd291@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, christian.koenig@amd.com, sbates@raithlin.com, alex.williamson@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/18 05:11 PM, Alex Williamson wrote:
> On to the implementation details... I already mentioned the BDF issue
> in my other reply.  If we had a way to persistently identify a device,
> would we specify the downstream points at which we want to disable ACS
> or the endpoints that we want to connect?  The latter has a problem
> that the grouping upstream of an endpoint is already set by the time we
> discover the endpoint, so we might need to unwind to get the grouping
> correct.  The former might be more difficult for users to find the
> necessary nodes, but easier for the kernel to deal with during
> discovery.  

I was envisioning the former with kernel helping by printing a dmesg in
certain circumstances to help with figuring out which devices need to be
specified. Specifying a list of endpoints on the command line and having
the kernel try to figure out which downstream ports need to be adjusted
while we are in the middle of enumerating the bus is, like you said, a
nightmare.

> A runtime, sysfs approach has some benefits here,
> especially in identifying the device assuming we're ok with leaving
> the persistence problem to userspace tools.  I'm still a little fond of
> the idea of exposing an acs_flags attribute for devices in sysfs where
> a write would do a soft unplug and re-add of all affected devices to
> automatically recreate the proper grouping.  Any dynamic change in
> routing and grouping would require all DMA be re-established anyway and
> a soft hotplug seems like an elegant way of handling it.  Thanks,

This approach sounds like it has a lot more issues to contend with:

For starters, a soft unplug/re-add of all the devices behind a switch is
going to be difficult if a lot of those devices have had drivers
installed and their respective resources are now mounted or otherwise in
use.

Then, do we have to redo a the soft-replace every time we change the ACS
bit for every downstream port? That could mean you have to do dozens
soft-replaces before you have all the ACS bits set which means you have
a storm of drivers being added and removed.

This would require some kind of fancy custom setup software that runs at
just the right time in the boot sequence or a lot of work on the users
part to unbind all the resources, setup the ACS bits and then rebind
everything (assuming the soft re-add doesn't rebind it every time you
adjust one ACS bit). Ugly.

IMO, if we need to do the sysfs approach then we need to be able to
adjust the groups dynamically in a sensible way and not through the
large hammer that is soft-replaces. I think this would be great but I
don't think we will be tackling that with this patch set.

Logan
