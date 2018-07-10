Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389DCC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9744920881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9744920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeGJFuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:50:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751005AbeGJFuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:50:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 170C3402312B;
        Tue, 10 Jul 2018 05:50:11 +0000 (UTC)
Received: from [10.72.12.151] (ovpn-12-151.pek2.redhat.com [10.72.12.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 676612026D6B;
        Tue, 10 Jul 2018 05:50:06 +0000 (UTC)
Subject: Re: [PATCH net-next v1 4/5] virtio_ring: add event idx support in
 packed ring
To:     Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com
References: <20180709072241.8886-1-tiwei.bie@intel.com>
 <20180709072241.8886-5-tiwei.bie@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9ee31221-9f4a-f1c5-0f0b-8d178bb536e9@redhat.com>
Date:   Tue, 10 Jul 2018 13:50:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709072241.8886-5-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 10 Jul 2018 05:50:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 10 Jul 2018 05:50:11 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月09日 15:22, Tiwei Bie wrote:
> @@ -1059,9 +1059,19 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>   	 * suppressions. */
>   	virtio_mb(vq->weak_barriers);
>   
> +	old = vq->next_avail_idx - vq->num_added;
> +	new = vq->next_avail_idx;
> +	vq->num_added = 0;
> +
>   	snapshot = *(u32 *)vq->vring_packed.device;

I think we should use READ_ONCE() to prevent compiler from re-reading.

> +	off_wrap = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot & 0xffff));
>   	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
>   
> +	wrap_counter = off_wrap >> 15;
> +	event_idx = off_wrap & ~(1 << 15);
> +	if (wrap_counter != vq->avail_wrap_counter)
> +		event_idx -= vq->vring_packed.num;

Thanks

