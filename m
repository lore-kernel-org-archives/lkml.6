Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7726C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EDE20835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EDE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeHaE35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:29:57 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41565 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaE34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:29:56 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so18739830oiw.8;
        Thu, 30 Aug 2018 17:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rb3UGBPkEDyecYE/cuaRbgmLSsgTxk5r2Ov/Wx0S79o=;
        b=Ax6DYKX4QL43MXoyWn4AzJ3hman1WpiV3qRxp8kt7t/cq4k1da9cTBoc9oE9TV0hrd
         kJnwRHzSNC6gIqyGociED2OXaOsLyP7SjDD1qQ8HaZpjY87OHKmEnbRZyGnIM0EbIv6Y
         QzVgCdpPKd0X1rU9nRz4yvgmmvEtS/9leO38tVZuKj9BzF6x8rK6p+ZUjHqmvBWJWe92
         6Hsg6IybFWGT/UFcwgfYxakwe+IsXOJMHEcbxGNzxohdCpI8AWCKNGfidYC4VlGIyX09
         TLurd3NmDqBsYyl2V6mQYunY5Jib4rC1gGlwayPXaUAOSLLFDhmGKYQOXEIl35qhgIyg
         dYWQ==
X-Gm-Message-State: APzg51AJphC0a8Ch/u/WqAgV3CZr2bFD3vEVB9989EUSK61/CJYrMGYm
        7TFboLO8Fuk9YZ12GS6FdmSySHmc
X-Google-Smtp-Source: ANB0VdY+0MCbpydiuetBBY79acxbg6PFmCjTRxE3CluADJC+oey9BDJJ6s1jCYTCFFEtexyb0mIuUA==
X-Received: by 2002:aca:42c4:: with SMTP id p187-v6mr4766066oia.315.1535675112243;
        Thu, 30 Aug 2018 17:25:12 -0700 (PDT)
Received: from [192.168.16.57] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id r10-v6sm9556347oif.37.2018.08.30.17.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 17:25:11 -0700 (PDT)
Subject: Re: [PATCH v5 13/13] nvmet: Optionally use PCI P2P memory
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
Date:   Thu, 30 Aug 2018 17:25:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-14-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +/*
> + * If allow_p2pmem is set, we will try to use P2P memory for the SGL lists for
> + * Ι/O commands. This requires the PCI p2p device to be compatible with the
> + * backing device for every namespace on this controller.
> + */
> +static void nvmet_setup_p2pmem(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
> +{
> +	struct nvmet_ns *ns;
> +	int ret;
> +
> +	if (!req->port->use_p2pmem || !req->p2p_client)
> +		return;
> +
> +	mutex_lock(&ctrl->subsys->lock);
> +
> +	ret = pci_p2pdma_add_client(&ctrl->p2p_clients, req->p2p_client);
> +	if (ret) {
> +		pr_err("failed adding peer-to-peer DMA client %s: %d\n",
> +		       dev_name(req->p2p_client), ret);
> +		goto free_devices;
> +	}
> +
> +	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
> +		ret = nvmet_p2pdma_add_client(ctrl, ns);
> +		if (ret)
> +			goto free_devices;
> +	}
> +
> +	if (req->port->p2p_dev) {
> +		if (!pci_p2pdma_assign_provider(req->port->p2p_dev,
> +						&ctrl->p2p_clients)) {
> +			pr_info("peer-to-peer memory on %s is not supported\n",
> +				pci_name(req->port->p2p_dev));
> +			goto free_devices;
> +		}
> +		ctrl->p2p_dev = pci_dev_get(req->port->p2p_dev);
> +	} else {

When is port->p2p_dev == NULL? a little more documentation would help 
here...
