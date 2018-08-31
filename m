Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D220C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208D92077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208D92077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeHaTu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:50:28 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46842 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeHaTu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:50:28 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fvlYk-00049p-By; Fri, 31 Aug 2018 09:42:07 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Steve Wise <swise@opengridcomputing.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-14-logang@deltatee.com>
 <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ee3d5c87-4dff-edfb-1f85-958571cb1fef@deltatee.com>
Date:   Fri, 31 Aug 2018 09:41:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: swise@opengridcomputing.com, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, keith.busch@intel.com, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 13/13] nvmet: Optionally use PCI P2P memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, for the review.

On 30/08/18 06:25 PM, Sagi Grimberg wrote:
>> +	if (req->port->p2p_dev) {
>> +		if (!pci_p2pdma_assign_provider(req->port->p2p_dev,
>> +						&ctrl->p2p_clients)) {
>> +			pr_info("peer-to-peer memory on %s is not supported\n",
>> +				pci_name(req->port->p2p_dev));
>> +			goto free_devices;
>> +		}
>> +		ctrl->p2p_dev = pci_dev_get(req->port->p2p_dev);
>> +	} else {
> 
> When is port->p2p_dev == NULL? a little more documentation would help 
> here...

In the configfs functions, if the user enables p2p (port->use_p2pmem)
using 'auto' or 'y' then port->p2p_dev will be NULL. If the user sets a
specific p2p_dev to use, port->p2p_dev will be set to that device. I can
add a couple comments in the next version.

Logan

