Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC48C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D574B20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D574B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeIFAZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:25:43 -0400
Received: from ale.deltatee.com ([207.54.116.67]:53662 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeIFAZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:25:43 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fxds1-00058e-Jo; Wed, 05 Sep 2018 13:53:46 -0600
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
 <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
 <20180901082812.GB670@lst.de>
 <5f79c012-c6e1-56bb-62fd-0689181fb2c9@deltatee.com>
 <59b28977-8f2a-6228-2050-03fae6bdbedd@kernel.dk>
 <1b4283da-44df-4a02-3167-e295243cef78@deltatee.com>
 <09258b9b-3aed-9890-b31a-bd70a133966c@kernel.dk>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5e2c8d24-fe09-ad4a-9b11-9238e176be58@deltatee.com>
Date:   Wed, 5 Sep 2018 13:53:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <09258b9b-3aed-9890-b31a-bd70a133966c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, axboe@kernel.dk
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/18 01:45 PM, Jens Axboe wrote:
> The point is that the caller doesn't necessarily know where the bio
> will end up, hence the caller can't fully check if the whole stack
> supports P2P.
> 
> What happens if a P2P request ends up with a driver that doesn't
> support it?

Yes, that's the whole point this check. Although we expect the caller to
do other checks before submitting a P2P request to a queue, so if a
driver does submit a P2P request to an unsupported queue, it is
definitely a problem in the driver (which is why we want to WARN).

Queues that support P2P (only PCI NVMe at this time, see patch 10) must
set QUEUE_FLAG_PCI_P2PDMA to indicate it. The check we are adding in
blk-core is meant to ensure any broken drivers that submit requests with
P2P memory do not get sent to a queue that doesn't indicate support.

On top of that, the code in NVMe target ensures that all namespaces on a
port are backed by queues that support P2P and, if not, it never
allocates any P2P SGLs.

Logan

