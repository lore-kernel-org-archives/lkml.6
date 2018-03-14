Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCNMP3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:15:29 -0400
Received: from smtp-out6.electric.net ([192.162.217.183]:58664 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:15:27 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Logan Gunthorpe'" <logang@deltatee.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        "Jens Axboe" <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Alex Williamson" <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Topic: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Index: AQHTuyWoALnmQYmLREKJSwTnAPFHM6PPnIJg
Date: Wed, 14 Mar 2018 12:16:05 +0000
Message-ID: <6e36d43b0493455a8547bc50c8ec77ba@AcuMS.aculab.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <016dc910-f96a-8a60-4bda-fa24eea98ea5@codeaurora.org>
 <2b152932-2f44-408b-e3ed-b4608d95f82e@deltatee.com>
 <156c24fb-6e27-28f6-0b36-7fd83311ce37@codeaurora.org>
 <932bbf48-9d86-97ec-17bb-052099aff99e@deltatee.com>
In-Reply-To: <932bbf48-9d86-97ec-17bb-052099aff99e@deltatee.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2ECFbOK001520

From: Logan Gunthorpe
> Sent: 13 March 2018 23:46
...
> As Stephen pointed out, it's a requirement of the PCIe spec that a
> switch supports P2P. If you want to sell a switch that does P2P with bad
> performance then that's on you to deal with.

That surprises me (unless I missed something last time I read the spec).
While P2P writes are relatively easy to handle, reads and any other TLP that
require acks are a completely different proposition.
There are no additional fields that can be set in the read TLP and will be
reflected back in the ack(s) than can be used to route the acks back to the
correct initiator.

I'm pretty sure that to support P2P reads a switch would have to save
the received read TLP and (possibly later on) issue read TLP of its own
for the required data.
I'm not even sure it is easy to interleave the P2P reads with those
coming from the root.
That requires a potentially infinite queue of pending requests.

Some x86 root ports support P2P writes (maybe with a bios option).
It would be a shame not to be able to do P2P writes on such systems
even though P2P reads won't work.

(We looked at using P2P transfers for some data, but in the end used
a different scheme.
For our use case P2P writes were enough.
An alternative would be to access the same host memory buffer from
two different devices - but there isn't an API that lets you do that.)

	David
