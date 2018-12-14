Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AA8C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCA52080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCA52080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeLNDmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:42:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLNDmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:42:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34DE1BDEA;
        Fri, 14 Dec 2018 03:42:25 +0000 (UTC)
Received: from [10.72.12.142] (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33ECE5C1A1;
        Fri, 14 Dec 2018 03:42:20 +0000 (UTC)
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213102315-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9459e227-a943-8553-732b-d7f5225a0f22@redhat.com>
Date:   Fri, 14 Dec 2018 11:42:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213102315-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 14 Dec 2018 03:42:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/13 下午11:27, Michael S. Tsirkin wrote:
> On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
>> Hi:
>>
>> This series tries to access virtqueue metadata through kernel virtual
>> address instead of copy_user() friends since they had too much
>> overheads like checks, spec barriers or even hardware feature
>> toggling.
> Userspace accesses through remapping tricks and next time there's a need
> for a new barrier we are left to figure it out by ourselves.


I don't get here, do you mean spec barriers? It's completely unnecessary 
for vhost which is kernel thread. And even if you're right, vhost is not 
the only place, there's lots of vmap() based accessing in kernel. Think 
in another direction, this means we won't suffer form unnecessary 
barriers for kthread like vhost in the future, we will manually pick the 
one we really need (but it should have little possibility).

Please notice we only access metdata through remapping not the data 
itself. This idea has been used for high speed userspace backend for 
years, e.g packet socket or recent AF_XDP. The only difference is the 
page was remap to from kernel to userspace.


>    I don't
> like the idea I have to say.  As a first step, why don't we switch to
> unsafe_put_user/unsafe_get_user etc?


Several reasons:

- They only have x86 variant, it won't have any difference for the rest 
of architecture.

- unsafe_put_user/unsafe_get_user is not sufficient for accessing 
structures (e.g accessing descriptor) or arrays (batching).

- Unless we can batch at least the accessing of two places in three of 
avail, used and descriptor in one run. There will be no difference. E.g 
we can batch updating used ring, but it won't make any difference in 
this case.


> That would be more of an apples to apples comparison, would it not?


Apples to apples comparison only help if we are the No.1. But the fact 
is we are not. If we want to compete with e.g dpdk or AF_XDP, vmap() is 
the fastest method AFAIK.


Thanks


>
>
>> Test shows about 24% improvement on TX PPS. It should benefit other
>> cases as well.
>>
>> Please review
>>
>> Jason Wang (3):
>>    vhost: generalize adding used elem
>>    vhost: fine grain userspace memory accessors
>>    vhost: access vq metadata through kernel virtual address
>>
>>   drivers/vhost/vhost.c | 281 ++++++++++++++++++++++++++++++++++++++----
>>   drivers/vhost/vhost.h |  11 ++
>>   2 files changed, 266 insertions(+), 26 deletions(-)
>>
>> -- 
>> 2.17.1
