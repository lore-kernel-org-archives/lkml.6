Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CB8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C694D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C694D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeLKDBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:01:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbeLKDBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:01:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EE0236883;
        Tue, 11 Dec 2018 03:01:41 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B312B101963B;
        Tue, 11 Dec 2018 03:01:30 +0000 (UTC)
Subject: Re: [PATCH net 0/4] Fix various issue of vhost
To:     David Miller <davem@davemloft.net>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181210094454.21144-1-jasowang@redhat.com>
 <20181210.114702.127499839186553253.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <cb539329-170c-c297-eb6e-3921852f1d1f@redhat.com>
Date:   Tue, 11 Dec 2018 11:01:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210.114702.127499839186553253.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 11 Dec 2018 03:01:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/11 上午3:47, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Mon, 10 Dec 2018 17:44:50 +0800
>
>> This series tries to fix various issues of vhost:
>>
>> - Patch 1 adds a missing write barrier between used idx updating and
>>    logging.
>> - Patch 2-3 brings back the protection of device IOTLB through vq
>>    mutex, this fixes possible use after free in device IOTLB entries.
>> - Patch 4 fixes the diry page logging when device IOTLB is
>>    enabled. We should done through GPA instead of GIOVA, this was done
>>    through logging through iovec and traversing GPA->HPA list for the
>>    GPA.
>>
>> Please consider them for -stable.
> Looks like the kbuild robot found some problems.
>
> ->used is a pointer (which might be 32-bit) and you're casting it to
> a u64 in the translate_desc() calls of patch #4.
>
> Please make sure that you don't actually require the full domain of
> a u64 in these values, as obviously if vq->used is a pointer you will
> only get a 32-bit domain on 32-bit architectures.


It seems the reason is that I cast from plain void pointer directly. Let 
me cast it to uintptr_t first.

Thanks


>
