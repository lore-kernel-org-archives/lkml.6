Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeBHQjP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:39:15 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37056 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbeBHQjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:39:14 -0500
X-Google-Smtp-Source: AH8x226jCy5OTs4xjPVsb8BTC1Enif6AzgyPIq47O4U94Q1ZMvx2Gtv5OXU0x/wsPW4844Kl6VAUuA==
Subject: Re: [PATCH V2]nvme-pci: Fixes EEH failure on ppc
To: Keith Busch <keith.busch@intel.com>, wenxiong@linux.vnet.ibm.com
Cc: axboe@fb.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, wenxiong@us.ibm.com
References: <1518034178-26176-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20180207211202.GD1337@localhost.localdomain>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <75ec663f-1598-7ad8-a23a-0524edc6e575@grimberg.me>
Date: Thu, 8 Feb 2018 18:39:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180207211202.GD1337@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>   	struct nvme_command cmd;
>>   	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>>   
>> +	/* If PCI error recovery process is happening, we cannot reset or
>> +	 * the recovery mechanism will surely fail.
>> +	 */
>> +	if (pci_channel_offline(to_pci_dev(dev->dev)))
>> +		return BLK_EH_RESET_TIMER;
> 
> So reading csts is what triggers EEH to be detected and get the channel
> set offline? If so, don't we need a memory barrier before calling
> pci_channel_offline? Otherwise it looks like the compiler optimization
> could reorder these.

I think you're right.
