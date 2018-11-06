Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A64C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2228D2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2228D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeKFMLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:11:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbeKFMLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:11:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31E6C81DEA;
        Tue,  6 Nov 2018 02:48:59 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 089E019748;
        Tue,  6 Nov 2018 02:48:53 +0000 (UTC)
Subject: Re: [PATCH 1/1] vhost: add per-vq worker thread
To:     Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181102160710.3741-1-v.mayatskih@gmail.com>
 <20181102160710.3741-2-v.mayatskih@gmail.com>
 <fe79c7fd-1e9f-dab8-3c65-8151181c922c@redhat.com>
 <CAGF4SLgDk+48aLKHhA_ZgRc6D30tGdnB89b5m5bZKwzyoDb0dQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <617e0c54-7d11-09b6-21e5-968260107872@redhat.com>
Date:   Tue, 6 Nov 2018 10:48:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGF4SLgDk+48aLKHhA_ZgRc6D30tGdnB89b5m5bZKwzyoDb0dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 06 Nov 2018 02:48:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/5 上午11:28, Vitaly Mayatskih wrote:
> On Sun, Nov 4, 2018 at 9:53 PM Jason Wang <jasowang@redhat.com> wrote:
>
>> I wonder whether or not it's better to allow the device to specific the
>> worker here instead of forcing a per vq worker model. Then we can keep
>> the behavior of exist implementation and do optimization on top?
> I was thinking about that too, but for the sake of simplicity it
> sounds valid that if the user wanted 8 parallel queues for the disk,
> they better be parallel, i.e. worker per queue. The rest of disks that
> don't need high-performance, can have 1 queue specified.
>

If you allow device to specify the worker itself, you can do any kinds 
of mapping bettween work and worker kthread I think. The advantage of 
doing this is that you can keep the vhost-net untouched. This makes 
things a little bit easier and proving two kthreads is better than one 
for -net workload is probably not as easy as it looks. We may get boost 
in some cases but degradation for the rest.


Thanks

