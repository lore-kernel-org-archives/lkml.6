Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F858C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2823720894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2823720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbeHADOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:14:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731999AbeHADOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:14:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EA5640214E2;
        Wed,  1 Aug 2018 01:31:53 +0000 (UTC)
Received: from [10.72.12.57] (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBC3B215670D;
        Wed,  1 Aug 2018 01:31:50 +0000 (UTC)
Subject: Re: [PATCH net-next 1/2] virtio-net: correctly update XDP_TX counters
To:     Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
 <2cdb8081-90a8-3a87-b6a6-4395825594a1@lab.ntt.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ffbfa3ba-3019-5324-4ecb-eb7a2699a4e8@redhat.com>
Date:   Wed, 1 Aug 2018 09:31:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2cdb8081-90a8-3a87-b6a6-4395825594a1@lab.ntt.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 01:31:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 01:31:53 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月31日 17:57, Toshiaki Makita wrote:
> On 2018/07/31 18:43, Jason Wang wrote:
>> Commit 5b8f3c8d30a6 ("virtio_net: Add XDP related stats") tries to
>> count TX XDP stats in virtnet_receive(). This will cause several
>> issues:
>>
>> - virtnet_xdp_sq() was called without checking whether or not XDP is
>>    set. This may cause out of bound access when there's no enough txq
>>    for XDP.
>> - Stats were updated even if there's no XDP/XDP_TX.>
>> Fixing this by reusing virtnet_xdp_xmit() for XDP_TX which can counts
>> TX XDP counter itself and remove the unnecessary tx stats embedded in
>> rx stats.
> Thanks for fixing this.
> I wanted to avoid calling u64_stats_update_begin() (i.e. smp_wmb() in 32
> bit systems) for every packet. So I'd like to keep sq stats in
> virtnet_rx_stats.
>

We can optimize this by adding batching on top. (virtnet_xdp_xmit() 
accepts an array of xdp frames). If you like, please send a patch for this.

Thanks

