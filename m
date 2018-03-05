Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752814AbeCESKQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:10:16 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34398 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeCESKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:10:13 -0500
To: Sinan Kaya <okaya@codeaurora.org>, Keith Busch <keith.busch@intel.com>,
        Oliver <oohall@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-8-logang@deltatee.com>
 <CAOSf1CEj1vmLLd27-642=XSnL9ODkpEC0qLHA2_W5_7rV5+4Pg@mail.gmail.com>
 <20180305160004.GA30975@localhost.localdomain>
 <3f56c76d-6a5c-7c2f-5442-c9209749b598@deltatee.com>
 <f4f69d48-97b2-ebeb-6c97-83878ea4c419@codeaurora.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <645c0d69-8942-5eb5-99ae-04ae385a32fa@deltatee.com>
Date: Mon, 5 Mar 2018 11:09:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f4f69d48-97b2-ebeb-6c97-83878ea4c419@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, maxg@mellanox.com, bhelgaas@google.com, jgg@mellanox.com, jglisse@redhat.com, alex.williamson@redhat.com, benh@kernel.crashing.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, oohall@gmail.com, keith.busch@intel.com, okaya@codeaurora.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 07/10] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/03/18 11:02 AM, Sinan Kaya wrote:
> writel has a barrier inside on ARM64.
> 
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/include/asm/io.h#L143

Yes, and no barrier inside memcpy_toio as it uses __raw_writes. This 
should be sufficient as we are only accessing addresses that look like 
memory and have no side effects (those enabling doorbell accesses may 
need to worry about this though). Typically, what could happen, in this 
case, is the CPU would issue writes to the BAR normally and the next 
time it programmed the DMA engine it would flush everything via the 
flush in writel.

> Why do you need another barrier?

We don't.

Thanks,

Logan
