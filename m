Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000E2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C393720870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfALBtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:49:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39464 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfALBtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:49:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DC28714CCB476;
        Fri, 11 Jan 2019 17:49:04 -0800 (PST)
Date:   Fri, 11 Jan 2019 17:48:42 -0800 (PST)
Message-Id: <20190111.174842.384650779633296454.davem@davemloft.net>
To:     zhabin@linux.alibaba.com
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        gerry@linux.alibaba.com, kata-dev@lists.katacontainers.io
Subject: Re: [PATCH] vhost/vsock: fix vhost vsock cid hashing inconsistent
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190108080703.70050-1-zhabin@linux.alibaba.com>
References: <20190108080703.70050-1-zhabin@linux.alibaba.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 11 Jan 2019 17:49:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zha Bin <zhabin@linux.alibaba.com>
Date: Tue,  8 Jan 2019 16:07:03 +0800

> The vsock core only supports 32bit CID, but the Virtio-vsock spec define
> CID (dst_cid and src_cid) as u64 and the upper 32bits is reserved as
> zero. This inconsistency causes one bug in vhost vsock driver. The
> scenarios is:
> 
>   0. A hash table (vhost_vsock_hash) is used to map an CID to a vsock
>   object. And hash_min() is used to compute the hash key. hash_min() is
>   defined as:
>   (sizeof(val) <= 4 ? hash_32(val, bits) : hash_long(val, bits)).
>   That means the hash algorithm has dependency on the size of macro
>   argument 'val'.
>   0. In function vhost_vsock_set_cid(), a 64bit CID is passed to
>   hash_min() to compute the hash key when inserting a vsock object into
>   the hash table.
>   0. In function vhost_vsock_get(), a 32bit CID is passed to hash_min()
>   to compute the hash key when looking up a vsock for an CID.
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

Applied, thank you.
