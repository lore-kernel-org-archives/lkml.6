Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BBC13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F2220894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F2220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeG3JwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:52:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeG3JwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7343B40216FC;
        Mon, 30 Jul 2018 08:18:15 +0000 (UTC)
Received: from dhcp-2-242.nay.redhat.com (dhcp-2-242.nay.redhat.com [10.66.2.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09A12112D175;
        Mon, 30 Jul 2018 08:18:12 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen-netfront: wait xenbus state change when
 load module manually
To:     David Miller <davem@davemloft.net>
Cc:     jgross@suse.com, netdev@vger.kernel.org,
        boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20180727095608.25210-1-xiliang@redhat.com>
 <20180729.083040.53901922165497594.davem@davemloft.net>
From:   Xiao Liang <xiliang@redhat.com>
Message-ID: <60e93e09-7dc2-d2f6-379d-c1d086aa1f49@redhat.com>
Date:   Mon, 30 Jul 2018 16:18:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729.083040.53901922165497594.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 30 Jul 2018 08:18:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 30 Jul 2018 08:18:15 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiliang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, David

On 07/29/2018 11:30 PM, David Miller wrote:
> From: Xiao Liang <xiliang@redhat.com>
> Date: Fri, 27 Jul 2018 17:56:08 +0800
>
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
> What performs the wakeups that will trigger for this sleep site?
In my understanding, backend leaving closed/unknow state can trigger the 
wakeups. I mean to make sure both sides are ready for creating connection.

Thanks,
Liang
>
> Thank you.
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel

