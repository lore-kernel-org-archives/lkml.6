Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965644AbeEIQpr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:45:47 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38978 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935232AbeEIQpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:45:43 -0400
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
Date: Wed, 9 May 2018 10:45:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: benh@kernel.crashing.org, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, alex.williamson@redhat.com, jglisse@redhat.com, sbates@raithlin.com, christian.koenig@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/18 07:40 AM, Christian König wrote:
> The key takeaway is that when any device has ATS enabled you can't 
> disable ACS without breaking it (even if you unplug and replug it).

I don't follow how you came to this conclusion...
 The ACS bits we'd be turning off are the ones that force TLPs addressed
at a peer to go to the RC. However, ATS translation packets will be
addressed to an untranslated address which a switch will not identify as
a peer address so it should send upstream regardless the state of the
ACS Req/Comp redirect bits.

Once the translation comes back, the ATS endpoint should send the TLP to
the peer address with the AT packet type and it will be directed to the
peer provided the Direct Translated bit is set (or the redirect bits are
unset).

I can't see how turning off the Req/Comp redirect bits could break
anything except for the isolation they provide.

Logan
