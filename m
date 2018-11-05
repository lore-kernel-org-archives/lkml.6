Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5835C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803F420827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803F420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeKEMSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:18:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKEMSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:18:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 919AC3084293;
        Mon,  5 Nov 2018 03:00:40 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC6C71726F;
        Mon,  5 Nov 2018 03:00:28 +0000 (UTC)
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
Date:   Mon, 5 Nov 2018 11:00:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102182123.29420-1-v.mayatskih@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 05 Nov 2018 03:00:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/3 上午2:21, Vitaly Mayatskikh wrote:
> vhost_blk is a host-side kernel mode accelerator for virtio-blk. The
> driver allows VM to reach a near bare-metal disk performance. See IOPS
> numbers below (fio --rw=randread --bs=4k).
>
> This implementation uses kiocb interface. It is slightly slower than
> going directly through bio, but is simpler and also works with disk
> images placed on a file system.
>
> # fio num-jobs
> # A: bare metal over block
> # B: bare metal over file
> # C: virtio-blk over block
> # D: virtio-blk over file
> # E: vhost-blk bio over block
> # F: vhost-blk kiocb over block
> # G: vhost-blk kiocb over file
> #
> #  A     B     C    D    E     F     G
>
> 1  171k  151k  148k 151k 195k  187k  175k
> 2  328k  302k  249k 241k 349k  334k  296k
> 3  479k  437k  179k 174k 501k  464k  404k
> 4  622k  568k  143k 183k 620k  580k  492k
> 5  755k  697k  136k 128k 737k  693k  579k
> 6  887k  808k  131k 120k 830k  782k  640k
> 7  1004k 926k  126k 131k 926k  863k  693k
> 8  1099k 1015k 117k 115k 1001k 931k  712k
> 9  1194k 1119k 115k 111k 1055k 991k  711k
> 10 1278k 1207k 109k 114k 1130k 1046k 695k
> 11 1345k 1280k 110k 108k 1119k 1091k 663k
> 12 1411k 1356k 104k 106k 1201k 1142k 629k
> 13 1466k 1423k 106k 106k 1260k 1170k 607k
> 14 1517k 1486k 103k 106k 1296k 1179k 589k
> 15 1552k 1543k 102k 102k 1322k 1191k 571k
> 16 1480k 1506k 101k 102k 1346k 1202k 566k
>
> Vitaly Mayatskikh (1):
>    Add vhost_blk driver
>
>   drivers/vhost/Kconfig  |  13 ++
>   drivers/vhost/Makefile |   3 +
>   drivers/vhost/blk.c    | 510 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 526 insertions(+)
>   create mode 100644 drivers/vhost/blk.c
>

Hi:

Thanks for the patches.

This is not the first attempt for having vhost-blk:

- Badari's version: https://lwn.net/Articles/379864/

- Asias' version: https://lwn.net/Articles/519880/

It's better to describe the differences (kiocb vs bio? performance?). 
E.g if my memory is correct, Asias said it doesn't give much improvement 
compared with userspace qemu.

And what's more important, I believe we tend to use virtio-scsi nowdays. 
So what's the advantages of vhost-blk over vhost-scsi?

Thanks

