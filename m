Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FE7C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A4C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A4C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeLMC1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:27:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLMC1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:27:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06E0480F91;
        Thu, 13 Dec 2018 02:27:38 +0000 (UTC)
Received: from [10.72.12.167] (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4CBE614C1;
        Thu, 13 Dec 2018 02:27:32 +0000 (UTC)
Subject: Re: [PATCH net V2 3/4] Revert "net: vhost: lock the vqs one by one"
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>
References: <20181212100819.21295-1-jasowang@redhat.com>
 <20181212100819.21295-4-jasowang@redhat.com>
 <20181212092102-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6988960f-68da-af52-21b6-9cdf8bddca0c@redhat.com>
Date:   Thu, 13 Dec 2018 10:27:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212092102-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Dec 2018 02:27:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/12 下午10:24, Michael S. Tsirkin wrote:
> On Wed, Dec 12, 2018 at 06:08:18PM +0800, Jason Wang wrote:
>> This reverts commit 78139c94dc8c96a478e67dab3bee84dc6eccb5fd. We don't
>> protect device IOTLB with vq mutex, which will lead e.g use after free
>> for device IOTLB entries. And since we've switched to use
>> mutex_trylock() in previous patch, it's safe to revert it without
>> having deadlock.
>>
>> Fixes: commit 78139c94dc8c ("net: vhost: lock the vqs one by one")
>> Cc: Tonghao Zhang<xiangxia.m.yue@gmail.com>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Acked-by: Michael S. Tsirkin<mst@redhat.com>
>
> I'd try to put this in 4.20 if we can
> and it's needed for -stable I think.
>
> Also looks like we should allow iotlb entries per vq
> to improve locking. What do you think?
>

Yes, we can do it for -next.

Thanks

