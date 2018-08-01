Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9BBC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4D720844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4D720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lab.ntt.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbeHAD02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:26:28 -0400
Received: from tama50.ecl.ntt.co.jp ([129.60.39.147]:41376 "EHLO
        tama50.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732901AbeHAD02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:26:28 -0400
Received: from vc1.ecl.ntt.co.jp (vc1.ecl.ntt.co.jp [129.60.86.153])
        by tama50.ecl.ntt.co.jp (8.13.8/8.13.8) with ESMTP id w711hKL8028947;
        Wed, 1 Aug 2018 10:43:20 +0900
Received: from vc1.ecl.ntt.co.jp (localhost [127.0.0.1])
        by vc1.ecl.ntt.co.jp (Postfix) with ESMTP id 77F82EA754E;
        Wed,  1 Aug 2018 10:43:20 +0900 (JST)
Received: from jcms-pop21.ecl.ntt.co.jp (jcms-pop21.ecl.ntt.co.jp [129.60.87.134])
        by vc1.ecl.ntt.co.jp (Postfix) with ESMTP id 6AA4FEA7517;
        Wed,  1 Aug 2018 10:43:20 +0900 (JST)
Received: from [IPv6:::1] (unknown [129.60.241.146])
        by jcms-pop21.ecl.ntt.co.jp (Postfix) with ESMTPSA id 5E38A4006C4;
        Wed,  1 Aug 2018 10:43:20 +0900 (JST)
Subject: Re: [PATCH net-next 1/2] virtio-net: correctly update XDP_TX counters
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
 <2cdb8081-90a8-3a87-b6a6-4395825594a1@lab.ntt.co.jp>
 <ffbfa3ba-3019-5324-4ecb-eb7a2699a4e8@redhat.com>
From:   Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <496cdc80-aa31-1061-4af3-3606b1a69202@lab.ntt.co.jp>
Date:   Wed, 1 Aug 2018 10:42:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ffbfa3ba-3019-5324-4ecb-eb7a2699a4e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CC-Mail-RelayStamp: 1
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/01 10:31, Jason Wang wrote:
> On 2018年07月31日 17:57, Toshiaki Makita wrote:
>> On 2018/07/31 18:43, Jason Wang wrote:
>>> Commit 5b8f3c8d30a6 ("virtio_net: Add XDP related stats") tries to
>>> count TX XDP stats in virtnet_receive(). This will cause several
>>> issues:
>>>
>>> - virtnet_xdp_sq() was called without checking whether or not XDP is
>>>    set. This may cause out of bound access when there's no enough txq
>>>    for XDP.
>>> - Stats were updated even if there's no XDP/XDP_TX.>
>>> Fixing this by reusing virtnet_xdp_xmit() for XDP_TX which can counts
>>> TX XDP counter itself and remove the unnecessary tx stats embedded in
>>> rx stats.
>> Thanks for fixing this.
>> I wanted to avoid calling u64_stats_update_begin() (i.e. smp_wmb() in 32
>> bit systems) for every packet. So I'd like to keep sq stats in
>> virtnet_rx_stats.
>>
> 
> We can optimize this by adding batching on top. (virtnet_xdp_xmit()
> accepts an array of xdp frames). If you like, please send a patch for this.

Yes, that sounds like a better optimization. will think about it...

Thanks,
Toshiaki Makita

