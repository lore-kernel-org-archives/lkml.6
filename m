Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755707AbeEHUTb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 16:19:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60920 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752259AbeEHUT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 16:19:29 -0400
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
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
Date: Tue, 8 May 2018 14:19:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508141331.7cd737cb@w520.home>
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



On 08/05/18 02:13 PM, Alex Williamson wrote:
> Well, I'm a bit confused, this patch series is specifically disabling
> ACS on switches, but per the spec downstream switch ports implementing
> ACS MUST implement direct translated P2P.  So it seems the only
> potential gap here is the endpoint, which must support ATS or else
> there's nothing for direct translated P2P to do.  The switch port plays
> no part in the actual translation of the request, ATS on the endpoint
> has already cached the translation and is now attempting to use it.
> For the switch port, this only becomes a routing decision, the request
> is already translated, therefore ACS RR and EC can be ignored to
> perform "normal" (direct) routing, as if ACS were not present.  It would
> be a shame to go to all the trouble of creating this no-ACS mode to find
> out the target hardware supports ATS and should have simply used it, or
> we should have disabled the IOMMU altogether, which leaves ACS disabled.

Ah, ok, I didn't think it was the endpoint that had to implement ATS.
But in that case, for our application, we need NVMe cards and RDMA NICs
to all have ATS support and I expect that is just as unlikely. At least
none of the endpoints on my system support it. Maybe only certain GPUs
have this support.

Logan
