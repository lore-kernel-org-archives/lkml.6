Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F2C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EB02083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EB02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbeKFMIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:08:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbeKFMIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:08:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7070308FB90;
        Tue,  6 Nov 2018 02:45:19 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 761B71948B;
        Tue,  6 Nov 2018 02:45:10 +0000 (UTC)
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
To:     Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stefanha@redhat.com
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
 <6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
 <CAGF4SLg6+nt+zV4haXys4Wz2dWPDyx7xHXuA+h01NcQ94j0E1A@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <57eefa62-7e66-786d-441c-5dd6b0d451a5@redhat.com>
Date:   Tue, 6 Nov 2018 10:45:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGF4SLg6+nt+zV4haXys4Wz2dWPDyx7xHXuA+h01NcQ94j0E1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 06 Nov 2018 02:45:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/5 上午11:23, Vitaly Mayatskih wrote:
> On Sun, Nov 4, 2018 at 10:00 PM Jason Wang <jasowang@redhat.com> wrote:
>
>>> # fio num-jobs
>>> # A: bare metal over block
>>> # B: bare metal over file
>>> # C: virtio-blk over block
>>> # D: virtio-blk over file
>>> # E: vhost-blk bio over block
>>> # F: vhost-blk kiocb over block
>>> # G: vhost-blk kiocb over file
>>> #
>>> #  A     B     C    D    E     F     G
>>> 16 1480k 1506k 101k 102k 1346k 1202k 566k
>> Hi:
>>
>> Thanks for the patches.
>>
>> This is not the first attempt for having vhost-blk:
>>
>> - Badari's version: https://lwn.net/Articles/379864/
>>
>> - Asias' version: https://lwn.net/Articles/519880/
>>
>> It's better to describe the differences (kiocb vs bio? performance?).
>> E.g if my memory is correct, Asias said it doesn't give much improvement
>> compared with userspace qemu.
>>
>> And what's more important, I believe we tend to use virtio-scsi nowdays.
>> So what's the advantages of vhost-blk over vhost-scsi?
> Hi,
>
> Yes, I saw both. Frankly, my implementation is not that different,
> because the whole thing has only twice more LOC that vhost/test.c.
>
> I posted my numbers (see in quoted text above the 16 queues case),
> IOPS goes from ~100k to 1.2M and almost reaches the physical
> limitation of the backend.
>
> submit_bio() is a bit faster, but can't be used for disk images placed
> on a file system. I have that submit_bio implementation too.
>
> Storage industry is shifting away from SCSI, which has a scaling
> problem.


Know little about storage. For scaling, do you mean SCSI protocol 
itself? If not, it's probably not a real issue for virtio-scsi itself.


>   I can compare vhost-scsi vs vhost-blk if you are curious.


It would be very helpful to see the performance comparison.


Thanks


> Thanks!
