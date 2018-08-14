Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD44C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF9121734
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF9121734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbeHNS1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:27:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:51856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728458AbeHNS1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:27:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B778AECF;
        Tue, 14 Aug 2018 15:39:22 +0000 (UTC)
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
 <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
Date:   Tue, 14 Aug 2018 17:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 05:20 PM, Bart Van Assche wrote:
> On Tue, 2018-08-14 at 09:33 +0200, Hannes Reinecke wrote:
>> +const struct attribute_group *nvme_ns_id_attr_groups[] = {
>> +	&nvme_ns_id_attr_group,
>> +	NULL, /* Will be filled in by lightnvm if present */
>> +	NULL,
>> +};
> [ ... ]
>> -void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
>> -{
>> -	struct nvm_dev *ndev = ns->ndev;
>> -	struct nvm_geo *geo = &ndev->geo;
>> +		return;
>>  
>>  	switch (geo->major_ver_id) {
>>  	case 1:
>> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
>> -					&nvm_dev_attr_group_12);
>> +		nvme_ns_id_attr_groups[1] = &nvm_dev_attr_group_12;
>>  		break;
>>  	case 2:
>> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
>> -					&nvm_dev_attr_group_20);
>> +		nvme_ns_id_attr_groups[1] = &nvm_dev_attr_group_20;
> 
> This patch introduces a really ugly dependency between the NVMe core code and
> the lightnvm code, namely that the lightnvm code has to know at which position
> in the nvme_ns_id_attr_groups it can fill in its attribute group pointer. Have
> you considered to make nvme_nvm_register_sysfs() return an attribute group
> pointer such that the nvme_ns_id_attr_groups can be changed from a global into
> a static array?
> 
Wouldn't help much, as the 'nvme_ns_id_attr_groups' needs to be a global
pointer anyway as it's references from drivers/nvme/host/core.c and
drivers/nvme/host/multipath.c.

While I have considered having nvme_nvm_register_sysfs() returning a
pointer I would then have to remove the 'static' declaration from the
nvm_dev_attr_group_12/20.
Which I didn't really like, either.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
