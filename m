Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C10C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FF82084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfAKENu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 23:13:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbfAKENt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 23:13:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6400C37E66;
        Fri, 11 Jan 2019 04:13:49 +0000 (UTC)
Received: from [10.72.12.143] (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B5E5D6A9;
        Fri, 11 Jan 2019 04:13:39 +0000 (UTC)
Subject: Re: [PATCH] vhost/vsock: fix vhost vsock cid hashing inconsistent
To:     Zha Bin <zhabin@linux.alibaba.com>, stefanha@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gerry@linux.alibaba.com,
        kata-dev@lists.katacontainers.io
References: <20190108080703.70050-1-zhabin@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ebcc2c6c-d188-fe0f-2d24-0997203484f7@redhat.com>
Date:   Fri, 11 Jan 2019 12:13:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108080703.70050-1-zhabin@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 11 Jan 2019 04:13:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/8 下午4:07, Zha Bin wrote:
> The vsock core only supports 32bit CID, but the Virtio-vsock spec define
> CID (dst_cid and src_cid) as u64 and the upper 32bits is reserved as
> zero. This inconsistency causes one bug in vhost vsock driver. The
> scenarios is:
>
>    0. A hash table (vhost_vsock_hash) is used to map an CID to a vsock
>    object. And hash_min() is used to compute the hash key. hash_min() is
>    defined as:
>    (sizeof(val) <= 4 ? hash_32(val, bits) : hash_long(val, bits)).
>    That means the hash algorithm has dependency on the size of macro
>    argument 'val'.
>    0. In function vhost_vsock_set_cid(), a 64bit CID is passed to
>    hash_min() to compute the hash key when inserting a vsock object into
>    the hash table.
>    0. In function vhost_vsock_get(), a 32bit CID is passed to hash_min()
>    to compute the hash key when looking up a vsock for an CID.
>
> Because the different size of the CID, hash_min() returns different hash
> key, thus fails to look up the vsock object for an CID.
>
> To fix this bug, we keep CID as u64 in the IOCTLs and virtio message
> headers, but explicitly convert u64 to u32 when deal with the hash table
> and vsock core.
>
> Fixes: 834e772c8db0 ("vhost/vsock: fix use-after-free in network stack callers")
> Link: https://github.com/stefanha/virtio/blob/vsock/trunk/content.tex
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
> ---
>   drivers/vhost/vsock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index bc42d38ae031..3fbc068eaa9b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -642,7 +642,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>   		hash_del_rcu(&vsock->hash);
>   
>   	vsock->guest_cid = guest_cid;
> -	hash_add_rcu(vhost_vsock_hash, &vsock->hash, guest_cid);
> +	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
>   	mutex_unlock(&vhost_vsock_mutex);
>   
>   	return 0;


Acked-by: Jason Wang <jasowang@redhat.com>


