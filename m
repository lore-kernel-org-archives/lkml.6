Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB768C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C1220855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C1220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeKZO4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:56:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbeKZO4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:56:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 006713082138;
        Mon, 26 Nov 2018 04:03:50 +0000 (UTC)
Received: from [10.72.12.50] (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCB71600D7;
        Mon, 26 Nov 2018 04:03:42 +0000 (UTC)
Subject: Re: [PATCH net 1/2] virtio-net: disable guest csum during XDP set
To:     David Miller <davem@davemloft.net>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        brouer@redhat.com, pashinho1990@gmail.com, dsahern@gmail.com
References: <20181122063631.14452-1-jasowang@redhat.com>
 <20181123.120119.2279234989819941118.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a0af5216-c0cb-0843-34ec-cf94a765338b@redhat.com>
Date:   Mon, 26 Nov 2018 12:03:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123.120119.2279234989819941118.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 26 Nov 2018 04:03:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/24 上午4:01, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Thu, 22 Nov 2018 14:36:30 +0800
>
>> We don't disable VIRTIO_NET_F_GUEST_CSUM if XDP was set. This means we
>> can receive partial csumed packets with metadata kept in the
>> vnet_hdr. This may have several side effects:
>>
>> - It could be overridden by header adjustment, thus is might be not
>>    correct after XDP processing.
>> - There's no way to pass such metadata information through
>>    XDP_REDIRECT to another driver.
>> - XDP does not support checksum offload right now.
>>
>> So simply disable guest csum if possible in this the case of XDP.
>>
>> Fixes: 3f93522ffab2d ("virtio-net: switch off offloads on demand if possible on XDP set")
>> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>> Cc: Pavel Popa <pashinho1990@gmail.com>
>> Cc: David Ahern <dsahern@gmail.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Applied and queued up for -stable.
>
> We really should have a way to use the checksum provided if the XDP
> program returns XDP_PASS and does not modify the packet contents
> or size.


Yes, I think this may require the assistance of BPF verifier to set a 
flag or other. Then we can assume the metadata is safe to use.

Thanks

