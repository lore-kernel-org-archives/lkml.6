Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E845C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA1820837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA1820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933576AbeFUNGZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:06:25 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:64675 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933096AbeFUNGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:06:23 -0400
X-IronPort-AV: E=Sophos;i="5.51,252,1526342400"; 
   d="scan'208";a="58221534"
Subject: Re: [PATCH 4.4 059/268] xen-netfront: Fix race between device setup
 and open
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
CC:     <stable@vger.kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100208.647996715@linuxfoundation.org>
 <1528727372.2289.120.camel@codethink.co.uk>
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <c7846023-b7cd-2c65-7203-f5a0b44a7c98@citrix.com>
Date:   Thu, 21 Jun 2018 14:05:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1528727372.2289.120.camel@codethink.co.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 03:29 PM, Ben Hutchings wrote:
> On Mon, 2018-05-28 at 12:00 +0200, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Ross Lagerwall <ross.lagerwall@citrix.com>
>>
>> [ Upstream commit f599c64fdf7d9c108e8717fb04bc41c680120da4 ]
> [...]
>> --- a/drivers/net/xen-netfront.c
>> +++ b/drivers/net/xen-netfront.c
> [...]
>> @@ -1839,6 +1824,7 @@ static int talk_to_netback(struct xenbus
>>   		goto out;
> 
> This "goto out" is outside the locked section...
> 
>>   	}
>>   
>> +	rtnl_lock();
>>   	if (info->queues)
>>   		xennet_destroy_queues(info);
>>   
>> @@ -1849,6 +1835,7 @@ static int talk_to_netback(struct xenbus
>>   		info->queues = NULL;
>>   		goto out;
>>   	}
>> +	rtnl_unlock();
>>   
>>   	/* Create shared ring, alloc event channel -- for each queue */
>>   	for (i = 0; i < num_queues; ++i) {
>> @@ -1945,8 +1932,10 @@ abort_transaction_no_dev_fatal:
>>   	xenbus_transaction_end(xbt, 1);
>>    destroy_ring:
>>   	xennet_disconnect_backend(info);
>> +	rtnl_lock();
>>   	xennet_destroy_queues(info);
>>    out:
>> +	rtnl_unlock();
> 
> ...so this will be an unmatched unlock.
> 
> You need to add another label below the rtnl_unlock().
> 

Thanks for spotting this. I've sent patches to the list to fix this and 
another issue with the original patch.

Regards,
-- 
Ross Lagerwall
