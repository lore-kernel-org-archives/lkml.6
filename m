Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AB3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED82C208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED82C208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lab.ntt.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeGaLh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:37:28 -0400
Received: from tama50.ecl.ntt.co.jp ([129.60.39.147]:35399 "EHLO
        tama50.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbeGaLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:37:28 -0400
Received: from vc1.ecl.ntt.co.jp (vc1.ecl.ntt.co.jp [129.60.86.153])
        by tama50.ecl.ntt.co.jp (8.13.8/8.13.8) with ESMTP id w6V9vpTw014342;
        Tue, 31 Jul 2018 18:57:51 +0900
Received: from vc1.ecl.ntt.co.jp (localhost [127.0.0.1])
        by vc1.ecl.ntt.co.jp (Postfix) with ESMTP id 81B17EA81AB;
        Tue, 31 Jul 2018 18:57:51 +0900 (JST)
Received: from jcms-pop21.ecl.ntt.co.jp (jcms-pop21.ecl.ntt.co.jp [129.60.87.134])
        by vc1.ecl.ntt.co.jp (Postfix) with ESMTP id 77104EA7FCE;
        Tue, 31 Jul 2018 18:57:51 +0900 (JST)
Received: from [IPv6:::1] (unknown [129.60.241.146])
        by jcms-pop21.ecl.ntt.co.jp (Postfix) with ESMTPSA id 6FE204009C9;
        Tue, 31 Jul 2018 18:57:51 +0900 (JST)
Subject: Re: [PATCH net-next 1/2] virtio-net: correctly update XDP_TX counters
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
From:   Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <2cdb8081-90a8-3a87-b6a6-4395825594a1@lab.ntt.co.jp>
Date:   Tue, 31 Jul 2018 18:57:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CC-Mail-RelayStamp: 1
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/31 18:43, Jason Wang wrote:
> Commit 5b8f3c8d30a6 ("virtio_net: Add XDP related stats") tries to
> count TX XDP stats in virtnet_receive(). This will cause several
> issues:
> 
> - virtnet_xdp_sq() was called without checking whether or not XDP is
>   set. This may cause out of bound access when there's no enough txq
>   for XDP.
> - Stats were updated even if there's no XDP/XDP_TX.>
> Fixing this by reusing virtnet_xdp_xmit() for XDP_TX which can counts
> TX XDP counter itself and remove the unnecessary tx stats embedded in
> rx stats.

Thanks for fixing this.
I wanted to avoid calling u64_stats_update_begin() (i.e. smp_wmb() in 32
bit systems) for every packet. So I'd like to keep sq stats in
virtnet_rx_stats.

-- 
Toshiaki Makita

