Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52986FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF7A20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF7A20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeG3JRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:17:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbeG3JRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:17:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2ED0340216FC;
        Mon, 30 Jul 2018 07:43:52 +0000 (UTC)
Received: from dhcp-2-242.nay.redhat.com (dhcp-2-242.nay.redhat.com [10.66.2.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B79D32156701;
        Mon, 30 Jul 2018 07:43:48 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen-netfront: wait xenbus state change when
 load module manually
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        davem@davemloft.net, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org
References: <20180727095608.25210-1-xiliang@redhat.com>
 <4dfca465-8da3-7ebf-aac1-08ffe34a74ac@oracle.com>
From:   Xiao Liang <xiliang@redhat.com>
Message-ID: <41022efa-141a-01d9-3084-8460b5017592@redhat.com>
Date:   Mon, 30 Jul 2018 15:43:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4dfca465-8da3-7ebf-aac1-08ffe34a74ac@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 30 Jul 2018 07:43:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 30 Jul 2018 07:43:52 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiliang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Boris

Please see my reply inline.


On 07/28/2018 02:40 AM, Boris Ostrovsky wrote:
> On 07/27/2018 05:56 AM, Xiao Liang wrote:
>> When loading module manually, after call xenbus_switch_state to initializes
>> the state of the netfront device, the driver state did not change so fast
>> that may lead no dev created in latest kernel. This patch adds wait to make
>> sure xenbus knows the driver is not in closed/unknown state.
>>
>> Current state:
>> [vm]# ethtool eth0
>> Settings for eth0:
>> 	Link detected: yes
>> [vm]# modprobe -r xen_netfront
>> [vm]# modprobe  xen_netfront
>> [vm]# ethtool eth0
>> Settings for eth0:
>> Cannot get device settings: No such device
>> Cannot get wake-on-lan settings: No such device
>> Cannot get message level: No such device
>> Cannot get link status: No such device
>> No data available
>>
>> With the patch installed.
>> [vm]# ethtool eth0
>> Settings for eth0:
>> 	Link detected: yes
>> [vm]# modprobe -r xen_netfront
>> [vm]# modprobe xen_netfront
>> [vm]# ethtool eth0
>> Settings for eth0:
>> 	Link detected: yes
>>
>> Signed-off-by: Xiao Liang <xiliang@redhat.com>
>> ---
>>   drivers/net/xen-netfront.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
>> index a57daecf1d57..2d8812dd1534 100644
>> --- a/drivers/net/xen-netfront.c
>> +++ b/drivers/net/xen-netfront.c
>> @@ -87,6 +87,7 @@ struct netfront_cb {
>>   /* IRQ name is queue name with "-tx" or "-rx" appended */
>>   #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
>>   
>> +static DECLARE_WAIT_QUEUE_HEAD(module_load_q);
>>   static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
>>   
>>   struct netfront_stats {
>> @@ -1330,6 +1331,11 @@ static struct net_device *xennet_create_dev(struct xenbus_device *dev)
>>   	netif_carrier_off(netdev);
>>   
>>   	xenbus_switch_state(dev, XenbusStateInitialising);
>> +	wait_event(module_load_q,
>> +			   xenbus_read_driver_state(dev->otherend) !=
>> +			   XenbusStateClosed &&
>> +			   xenbus_read_driver_state(dev->otherend) !=
>> +			   XenbusStateUnknown);
>>   	return netdev;
>>   
>>    exit:
>
> Should we have a wake_up somewhere?
In my understanding, netback_changed handles it if dev state is in 
XenbusStateInitialising and otherend is in XenbusStateInitWait, and then 
create connection to backend.
But in most cases, it breaks out as dev->state not in 
XenbusStateInitialising. So I added a wait here.
> And what about other states --- is,
> for example, XenbusStateClosing a valid reason to continue?
I think XenbusStateClosing should not be a valid reason to continue.
My purpose is waiting otherend status to be XenbusStateInitWait(after 
new dev created).To avoid unnecessary impact, I  only check it leaves 
closed and unknow state in this patch.

In my testing, hotplug vifs from guest in host or load/unload module in 
guest over 100 times, only waiting XenbusStateInitWait or as this patch 
does, both are working.
vifs can be created each time successfully.

Thanks,
Xiao Liang

>
>
> -boris
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel

