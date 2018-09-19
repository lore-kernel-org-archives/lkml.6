Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBAFECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69F82098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69F82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prnet.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbeISJtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:49:04 -0400
Received: from extserverfr1.prnet.org ([188.165.208.21]:33626 "EHLO
        extserverfr1.prnet.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:49:04 -0400
Received: from extserver.intern.prnet.org (extserver.prnet.org [192.168.11.1])
        by extserverfr1.prnet.org (8.14.9/8.14.9) with ESMTP id w8J4Ct6g009759;
        Wed, 19 Sep 2018 06:12:55 +0200
Received: from [IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28] ([IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28])
        (authenticated bits=0)
        by extserver.intern.prnet.org (8.14.9/8.14.9) with ESMTP id w8J4CsDE015709
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Wed, 19 Sep 2018 06:12:54 +0200
Subject: Re: kernel 4.18.5 Realtek 8111G network adapter stops responding
 under high system load
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
References: <20180918102349.Horde.yHctatUod-_SC696oYKmySa@cloud.luxmemories.lu>
 <039cc66f-13b0-e745-b6ec-68f4580e90ef@maciej.szmigiero.name>
From:   David Arendt <admin@prnet.org>
Message-ID: <0e865e74-e587-61b7-d319-9afe0a5e8828@prnet.org>
Date:   Wed, 19 Sep 2018 06:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <039cc66f-13b0-e745-b6ec-68f4580e90ef@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch.

I just applied it and the TxConfig register now contains 0x4f000f80.
The next day will show if it really solves the problem.

Thanks in advance,
David Arendt

On 9/19/18 12:30 AM, Maciej S. Szmigiero wrote:
> Hi,
>
> On 18.09.2018 12:23, David Arendt wrote:
>> Hi,
>>
>> Today I had the network adapter problems again.
>> So the patch doesn't seem to change anything regarding this problem.
>> This week my time is unfortunately very limited, but I will try to
>> find some time next weekend to look a bit more into the issue.
> If the problem is caused by missing TXCFG_AUTO_FIFO bit in TxConfig,
> as the register difference would suggest, then you can try applying
> the following patch (hack) on top of 4.18.8 that is already patched
> with commit f74dd480cf4e:
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -5043,7 +5043,8 @@
>  {
>  	/* Set DMA burst size and Interframe Gap Time */
>  	RTL_W32(tp, TxConfig, (TX_DMA_BURST << TxDMAShift) |
> -		(InterFrameGap << TxInterFrameGapShift));
> +		(InterFrameGap << TxInterFrameGapShift)
> +		| TXCFG_AUTO_FIFO);
>  }
>  
>  static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>
> This hack will probably only work properly on RTL_GIGA_MAC_VER_40 or
> later NICs.
>
> Before running any tests please verify with "ethtool -d enp3s0" that
> TxConfig register now contains 0x4f000f80, as it did in the old,
> working driver version.
>
> If this does not help then a bisection will most likely be needed.
>
>> Thanks in advance,
>> David Arendt
> Maciej


