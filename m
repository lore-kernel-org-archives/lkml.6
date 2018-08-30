Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34BAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8410920843
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8410920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeH3Xe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:34:27 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40724 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeH3Xe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:34:26 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fvSeI-00071q-4U; Thu, 30 Aug 2018 13:30:34 -0600
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830192012.GG3529@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d5d38a3d-ae6f-9995-e818-a8f186a7f346@deltatee.com>
Date:   Thu, 30 Aug 2018 13:30:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830192012.GG3529@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jglisse@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 00/13] Copy Offload in NVMe Fabrics with P2P PCI Memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/18 01:20 PM, Jerome Glisse wrote:
> On Thu, Aug 30, 2018 at 12:53:39PM -0600, Logan Gunthorpe wrote:
> 
> [...]
> 
>>
>> When the PCI P2PDMA config option is selected the ACS bits in every
>> bridge port in the system are turned off to allow traffic to
>> pass freely behind the root port. At this time, the bit must be disabled
>> at boot so the IOMMU subsystem can correctly create the groups, though
>> this could be addressed in the future. There is no way to dynamically
>> disable the bit and alter the groups.

Oh, sorry this paragraph in the cover letter is wrong now. We now rely
on the disable_acs_redir command line option introduced in

aaca43fda742 ("PCI: Add "pci=disable_acs_redir=" parameter for
peer-to-peer support")


> Can you provide an example on how to test this ? Like kernel command
> line option, the doc patch does not have any such example. It would be
> nice to add.

Do you mean to test the patchset or the ACS bits you quoted?

Testing the patchset is a matter of having the right hardware (ie an
RDMA NIC and CMB enabled NVMe behind a PCIe switch, with the ACS bits
set correctly by the above command line option) and setting the p2pmem
configfs attribute in an nvme-of port to 'yes'.


Logan
