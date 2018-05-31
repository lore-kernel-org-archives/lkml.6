Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbeEaJY6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:24:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54577 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754092AbeEaJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:24:55 -0400
X-Google-Smtp-Source: ADUXVKKuFFc8bl97cZA8rOiH44HQdsGYH3tdKnZ9yQODRYgztaf7wfa7AhCPjGSe3jOv1hjkml8pHA==
Subject: Re: [PATCH 2/5] nvme: don't hold nvmf_transports_rwsem for more than
 transport lookups
To: Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-3-jthumshirn@suse.de> <20180515074826.GA23659@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8577e467-ad74-d9bd-8f49-3ace18fc1126@grimberg.me>
Date: Thu, 31 May 2018 12:24:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515074826.GA23659@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 7ae732a77fe8..febf82639b40 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -957,16 +957,17 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
>>   
>>   	down_read(&nvmf_transports_rwsem);
>>   	ops = nvmf_lookup_transport(opts);
>> +	up_read(&nvmf_transports_rwsem);
> 
> And what protects us from the transport getting unregister right here
> from anothet thread waiting to acquire nvmf_transports_rwsem?

I think having the module_get inside as well would protect against it.
