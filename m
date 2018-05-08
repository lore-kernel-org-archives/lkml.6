Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755433AbeEHTqS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 15:46:18 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60686 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbeEHTqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 15:46:16 -0400
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
Date: Tue, 8 May 2018 13:45:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508133407.57a46902@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, christian.koenig@amd.com, alex.williamson@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/18 01:34 PM, Alex Williamson wrote:
> They are not so unrelated, see the ACS Direct Translated P2P
> capability, which in fact must be implemented by switch downstream
> ports implementing ACS and works specifically with ATS.  This appears to
> be the way the PCI SIG would intend for P2P to occur within an IOMMU
> managed topology, routing pre-translated DMA directly between peer
> devices while requiring non-translated requests to bounce through the
> IOMMU.  Really, what's the value of having an I/O virtual address space
> provided by an IOMMU if we're going to allow physical DMA between
> downstream devices, couldn't we just turn off the IOMMU altogether?  Of
> course ATS is not without holes itself, basically that we trust the
> endpoint's implementation of ATS implicitly.  Thanks,

I agree that this is what the SIG intends, but I don't think hardware
fully supports this methodology yet. The Direct Translated capability
just requires switches to forward packets that have the AT request type
set. It does not require them to do the translation or to support ATS
such that P2P requests can be translated by the IOMMU. I expect this is
so that an downstream device can implement ATS and not get messed up by
an upstream switch that doesn't support it.

Logan
