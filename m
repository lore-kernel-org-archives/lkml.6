Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F53CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33339206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfAGG6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:58:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfAGG6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 01:58:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CC7374EE1;
        Mon,  7 Jan 2019 06:58:19 +0000 (UTC)
Received: from [10.72.12.209] (ovpn-12-209.pek2.redhat.com [10.72.12.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D48A106222B;
        Mon,  7 Jan 2019 06:58:11 +0000 (UTC)
Subject: Re: [RFC PATCH V3 0/5] Hi:
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net
References: <20181229124656.3900-1-jasowang@redhat.com>
 <20190104163516-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <68727e1b-1d51-0596-29c3-931475dd5dab@redhat.com>
Date:   Mon, 7 Jan 2019 14:58:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190104163516-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 07 Jan 2019 06:58:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/5 上午5:41, Michael S. Tsirkin wrote:
> On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrote:
>> This series tries to access virtqueue metadata through kernel virtual
>> address instead of copy_user() friends since they had too much
>> overheads like checks, spec barriers or even hardware feature
>> toggling.
>
> I think it's a reasonable approach.
> However I need to look at whether and which mmu notifiers are invoked before
> writeback. Do you know?


I don't know but just looking at the MMU notifier ops definition, 
there's no such callback if my understanding is correct.

Thanks


>
>> Test shows about 24% improvement on TX PPS. It should benefit other
>> cases as well.
>>
>> Changes from V2:
>> - fix buggy range overlapping check
>> - tear down MMU notifier during vhost ioctl to make sure invalidation
>>    request can read metadata userspace address and vq size without
>>    holding vq mutex.
>> Changes from V1:
>> - instead of pinning pages, use MMU notifier to invalidate vmaps and
>>    remap duing metadata prefetch
>> - fix build warning on MIPS
>>
>> Jason Wang (5):
>>    vhost: generalize adding used elem
>>    vhost: fine grain userspace memory accessors
>>    vhost: rename vq_iotlb_prefetch() to vq_meta_prefetch()
>>    vhost: introduce helpers to get the size of metadata area
>>    vhost: access vq metadata through kernel virtual address
>>
>>   drivers/vhost/net.c   |   4 +-
>>   drivers/vhost/vhost.c | 416 +++++++++++++++++++++++++++++++++++++-----
>>   drivers/vhost/vhost.h |  15 +-
>>   3 files changed, 384 insertions(+), 51 deletions(-)
>>
>> -- 
>> 2.17.1
