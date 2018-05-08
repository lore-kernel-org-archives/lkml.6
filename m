Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756067AbeEHXPq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 19:15:46 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33946 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754148AbeEHXPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 19:15:43 -0400
To: Dan Williams <dan.j.williams@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Stephen Bates <sbates@raithlin.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <20180508163206.7d3bf383@w520.home>
 <CAPcyv4i1ksiu1pExF=EE21P2Wz1a9LaDaG247oG_WSbYgcR93g@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2ce7908d-1422-55f8-aeba-94ccce2cb484@deltatee.com>
Date: Tue, 8 May 2018 17:15:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i1ksiu1pExF=EE21P2Wz1a9LaDaG247oG_WSbYgcR93g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: benh@kernel.crashing.org, jglisse@redhat.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, christian.koenig@amd.com, sbates@raithlin.com, alex.williamson@redhat.com, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/18 05:00 PM, Dan Williams wrote:
>> I'd advise caution with a user supplied BDF approach, we have no
>> guaranteed persistence for a device's PCI address.  Adding a device
>> might renumber the buses, replacing a device with one that consumes
>> more/less bus numbers can renumber the buses, motherboard firmware
>> updates could renumber the buses, pci=assign-buses can renumber the
>> buses, etc.  This is why the VT-d spec makes use of device paths when
>> describing PCI hierarchies, firmware can't know what bus number will be
>> assigned to a device, but it does know the base bus number and the path
>> of devfns needed to get to it.  I don't know how we come up with an
>> option that's easy enough for a user to understand, but reasonably
>> robust against hardware changes.  Thanks,
> 
> True, but at the same time this feature is for "users with custom
> hardware designed for purpose", I assume they would be willing to take
> on the bus renumbering risk. It's already the case that
> /sys/bus/pci/drivers/<x>/bind takes BDF, which is why it seemed to
> make a similar interface for the command line. Ideally we could later
> get something into ACPI or other platform firmware to arrange for
> bridges to disable ACS by default if we see p2p becoming a
> common-off-the-shelf feature. I.e. a BIOS switch to enable p2p in a
> given PCI-E sub-domain.

Yeah, I'm having a hard time coming up with an easy enough solution for
the user. I agree with Dan though, the bus renumbering risk would be
fairly low in the custom hardware seeing the switches are likely going
to be directly soldered to the same board with the CPU.

That being said, I supposed we could allow the command line to take both
a BDF or a BaseBus/DF/DF/DF path. Though, implementing this sounds like
a bit of a challenge.

Logan
