Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D188BFC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3A20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB3A20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeINIX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:23:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbeINIX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:23:57 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70B6E81DE9;
        Fri, 14 Sep 2018 03:11:34 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 827D78B721;
        Fri, 14 Sep 2018 03:11:21 +0000 (UTC)
Subject: Re: [PATCH net-next V2 11/11] vhost_net: batch submitting XDP buffers
 to underlayer sockets
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180912031709.14112-1-jasowang@redhat.com>
 <20180912031709.14112-12-jasowang@redhat.com>
 <20180913140332-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <dfc04379-125b-dd4e-b903-4b9323a25506@redhat.com>
Date:   Fri, 14 Sep 2018 11:11:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913140332-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 14 Sep 2018 03:11:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月14日 02:04, Michael S. Tsirkin wrote:
> On Wed, Sep 12, 2018 at 11:17:09AM +0800, Jason Wang wrote:
>> +static void vhost_tx_batch(struct vhost_net *net,
>> +			   struct vhost_net_virtqueue *nvq,
>> +			   struct socket *sock,
>> +			   struct msghdr *msghdr)
>> +{
>> +	struct tun_msg_ctl ctl = {
>> +		.type = TUN_MSG_PTR,
>> +		.num = nvq->batched_xdp,
>> +		.ptr = nvq->xdp,
>> +	};
>> +	int err;
>> +
>> +	if (nvq->batched_xdp == 0)
>> +		goto signal_used;
>> +
>> +	msghdr->msg_control = &ctl;
>> +	err = sock->ops->sendmsg(sock, msghdr, 0);
>> +	if (unlikely(err < 0)) {
>> +		vq_err(&nvq->vq, "Fail to batch sending packets\n");
>> +		return;
>> +	}
>> +
>> +signal_used:
>> +	vhost_net_signal_used(nvq);
>> +	nvq->batched_xdp = 0;
>> +}
>> +
> Given it's all tun-specific now, how about just exporting tap_sendmsg
> and calling that? Will get rid of some indirection too.
>

Yes we can do it on top in the future.

Thanks
