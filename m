Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56015C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE2C205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE2C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeIGIKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:10:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725743AbeIGIKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:10:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EC61807A0D0;
        Fri,  7 Sep 2018 03:31:45 +0000 (UTC)
Received: from [10.72.12.125] (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6275D7D4C9;
        Fri,  7 Sep 2018 03:31:39 +0000 (UTC)
Subject: Re: [PATCH net-next 07/11] tuntap: move XDP flushing out of
 tun_do_xdp()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-8-jasowang@redhat.com>
 <20180906132209-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <25e6c109-69bd-ca10-3322-0e3d3b23f5dd@redhat.com>
Date:   Fri, 7 Sep 2018 11:31:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906132209-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 03:31:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 03:31:45 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月07日 01:48, Michael S. Tsirkin wrote:
> On Thu, Sep 06, 2018 at 12:05:22PM +0800, Jason Wang wrote:
>> This will allow adding batch flushing on top.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/net/tun.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 21b125020b3b..ff1cbf3ebd50 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1646,7 +1646,6 @@ static u32 tun_do_xdp(struct tun_struct *tun,
>>   	switch (act) {
>>   	case XDP_REDIRECT:
>>   		*err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
>> -		xdp_do_flush_map();
>>   		if (*err)
>>   			break;
>>   		goto out;
>> @@ -1735,6 +1734,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   		act = tun_do_xdp(tun, tfile, xdp_prog, &xdp, &err);
>>   		if (err)
>>   			goto err_xdp;
>> +
>> +		if (act == XDP_REDIRECT)
>> +			xdp_do_flush_map();
>>   		if (act != XDP_PASS)
>>   			goto out;
> At this point the switch statement which used to contain all XDP things
> seems to be gone completely. Just rewrite with a bunch of if statements
> and all xdp handling spread out to where it makes sense?

But tun_do_xdp() will be reused in the batching path.

Thanks

>
>> -- 
>> 2.17.1

