Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10714C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C597E21742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C597E21742
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbeHNPsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:48:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729472AbeHNPsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:48:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76EE5402315B;
        Tue, 14 Aug 2018 13:01:17 +0000 (UTC)
Received: from [10.72.12.152] (ovpn-12-152.pek2.redhat.com [10.72.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9B642156712;
        Tue, 14 Aug 2018 13:01:14 +0000 (UTC)
Subject: Re: [RFC PATCH net-next V2 6/6] virtio-net: support XDP rx handler
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
 <1534130250-5302-7-git-send-email-jasowang@redhat.com>
 <20180814112222.42177a24@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e3e2fe66-c324-9bb2-a289-1cc8fe76147a@redhat.com>
Date:   Tue, 14 Aug 2018 21:01:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814112222.42177a24@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 14 Aug 2018 13:01:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 14 Aug 2018 13:01:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月14日 17:22, Jesper Dangaard Brouer wrote:
> On Mon, 13 Aug 2018 11:17:30 +0800
> Jason Wang<jasowang@redhat.com>  wrote:
>
>> This patch tries to add the support of XDP rx handler to
>> virtio-net. This is straight-forward, just call xdp_do_pass() and
>> behave depends on its return value.
>>
>> Test was done by using XDP_DROP (xdp1) for macvlan on top of
>> virtio-net. PPS of SKB mode was ~1.2Mpps while PPS of native XDP mode
>> was ~2.2Mpps. About 83% improvement was measured.
> I'm not convinced...
>
> Why are you not using XDP_REDIRECT, which is already implemented in
> receive_mergeable (which you modify below).
>
> The macvlan driver just need to implement ndo_xdp_xmit(), and then you
> can redirect (with XDP prog from physical driver into the guest).  It
> should be much faster...
>
>

Macvlan is different from macvtap. For host RX, macvtap deliver the 
packet to a pointer ring which could be accessed through a socket but 
macvlan deliver the packet to the normal networking stack. As an example 
of XDP rx handler, this series just try to make native XDP works for 
macvlan, macvtap path will still go for skb (but it's not hard to add it 
on top).

Consider the case of fast forwarding between host and guest. For TAP, 
XDP_REDIRECT works perfectly since from the host point of view, host RX 
is guest TX and host guest RX is host TX. But for macvtap which is based 
on macvlan, transmitting packet to macvtap/macvlan means transmitting 
packets to under layer device which is either a physical NIC or another 
macvlan device. That's why we can't use XDP_REDIRECT with ndo_xdp_xmit().

Thanks













