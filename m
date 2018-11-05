Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65001C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1783920685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1783920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeKEMJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:09:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKEMJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:09:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02B3089AC1;
        Mon,  5 Nov 2018 02:52:01 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C80960BEC;
        Mon,  5 Nov 2018 02:51:54 +0000 (UTC)
Subject: Re: [PATCH 0/1] vhost: parallel virtqueue handling
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181102160710.3741-1-v.mayatskih@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <baca6444-0ef8-2b3b-4ff9-84737f4ecd32@redhat.com>
Date:   Mon, 5 Nov 2018 10:51:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102160710.3741-1-v.mayatskih@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 05 Nov 2018 02:52:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/3 上午12:07, Vitaly Mayatskikh wrote:
> Hi,
>
> I stumbled across poor performance of virtio-blk while working on a
> high-performance network storage protocol. Moving virtio-blk's host
> side to kernel did increase single queue IOPS, but multiqueue disk
> still was not scaling well. It turned out that vhost handles events
> from all virtio queues in one helper thread, and that's pretty much a
> big serialization point.
>
> The following patch enables events handling in per-queue thread and
> increases IO concurrency, see IOPS numbers:


Thanks a lot for the patches. Here's some thoughts:

- This is not the first attempt that tries to parallelize vhost workers. 
So we need a comparing among them.

1) Multiple vhost workers from Anthony, 
https://www.spinics.net/lists/netdev/msg189432.html

2) ELVIS from IBM, http://www.mulix.org/pubs/eli/elvis-h319.pdf

3) CMWQ from Bandan, 
http://www.linux-kvm.org/images/5/52/02x08-Aspen-Bandan_Das-vhost-sharing_is_better.pdf

- vhost-net use a different multiqueue model. Each vhost device on host 
is only dealing with a specific queue pair instead of a whole device. 
This allow great flexibility and multiqueue could be implemented without 
touching vhost codes.

- current vhost-net implementation depends heavily on the assumption of 
single thread model especially its busy polling code. It would be broken 
by this attempt. If we decide to go this way, this needs to be fixed. 
And we do need performance result of networking.

- Having more threads is not necessarily a win, at least we need a 
module parameter to other stuffs to control the number of threads I 
believe.


Thanks


>
> # num-queues
> # bare metal
> # virtio-blk
> # vhost-blk
>
> 1  171k  148k 195k
> 2  328k  249k 349k
> 3  479k  179k 501k
> 4  622k  143k 620k
> 5  755k  136k 737k
> 6  887k  131k 830k
> 7  1004k 126k 926k
> 8  1099k 117k 1001k
> 9  1194k 115k 1055k
> 10 1278k 109k 1130k
> 11 1345k 110k 1119k
> 12 1411k 104k 1201k
> 13 1466k 106k 1260k
> 14 1517k 103k 1296k
> 15 1552k 102k 1322k
> 16 1480k 101k 1346k
>
> Vitaly Mayatskikh (1):
>    vhost: add per-vq worker thread
>
>   drivers/vhost/vhost.c | 123 +++++++++++++++++++++++++++++++-----------
>   drivers/vhost/vhost.h |  11 +++-
>   2 files changed, 100 insertions(+), 34 deletions(-)
>
