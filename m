Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FDC2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FDC2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeIJIjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:39:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbeIJIjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:39:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83A7A26A81;
        Mon, 10 Sep 2018 03:47:25 +0000 (UTC)
Received: from [10.72.12.30] (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE1612156889;
        Mon, 10 Sep 2018 03:47:20 +0000 (UTC)
Subject: Re: [PATCH net-next 11/11] vhost_net: batch submitting XDP buffers to
 underlayer sockets
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-12-jasowang@redhat.com>
 <20180906122857-mutt-send-email-mst@kernel.org>
 <ffb802e6-1505-e01e-f6d5-11cde8dace9b@redhat.com>
 <20180907121148-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <56dadae0-439c-5694-f2a4-1b4e20f19f62@redhat.com>
Date:   Mon, 10 Sep 2018 11:47:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907121148-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 03:47:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 03:47:25 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月08日 00:13, Michael S. Tsirkin wrote:
> On Fri, Sep 07, 2018 at 03:41:52PM +0800, Jason Wang wrote:
>>>> @@ -556,10 +667,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>>>>    	size_t len, total_len = 0;
>>>>    	int err;
>>>>    	int sent_pkts = 0;
>>>> +	bool bulking = (sock->sk->sk_sndbuf == INT_MAX);
>>> What does bulking mean?
>> The name is misleading, it means whether we can do batching. For simplicity,
>> I disable batching is sndbuf is not INT_MAX.
> But what does batching have to do with sndbuf?

If we want to do batching with sndbuf, sockets needs to return the 
number of packets that was successfully sent. And vhost need to examine 
the value.

Consider performance won't be good if sndbuf is limited, I don't 
implement this for simplicity.

>
>>>>    	for (;;) {
>>>>    		bool busyloop_intr = false;
>>>> +		if (nvq->done_idx == VHOST_NET_BATCH)
>>>> +			vhost_tx_batch(net, nvq, sock, &msg);
>>>> +
>>>>    		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
>>>>    				   &busyloop_intr);
>>>>    		/* On error, stop handling until the next kick. */
>>>> @@ -577,14 +692,34 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>>>>    			break;
>>>>    		}
>>>> -		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
>>>> -		vq->heads[nvq->done_idx].len = 0;
>>>> -
>>>>    		total_len += len;
>>>> -		if (tx_can_batch(vq, total_len))
>>>> -			msg.msg_flags |= MSG_MORE;
>>>> -		else
>>>> -			msg.msg_flags &= ~MSG_MORE;
>>>> +
>>>> +		/* For simplicity, TX batching is only enabled if
>>>> +		 * sndbuf is unlimited.
>>> What if sndbuf changes while this processing is going on?
>> We will get the correct sndbuf in the next run of handle_tx(). I think this
>> is safe.
> If it's safe why bother with special-casing INT_MAX?
>

The difference is handle_tx() won't loop forever and will recognize the 
new value next time, we have a quota to limit this.

Thanks

