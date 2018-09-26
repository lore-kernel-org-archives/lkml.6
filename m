Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6734C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8382151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8382151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prnet.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeIZW6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:58:35 -0400
Received: from extserverfr1.prnet.org ([188.165.208.21]:34114 "EHLO
        extserverfr1.prnet.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZW6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:58:35 -0400
Received: from extserver.intern.prnet.org (extserver.prnet.org [192.168.11.1])
        by extserverfr1.prnet.org (8.14.9/8.14.9) with ESMTP id w8QGiMRC004278;
        Wed, 26 Sep 2018 18:44:23 +0200
Received: from [IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28] ([IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28])
        (authenticated bits=0)
        by extserver.intern.prnet.org (8.14.9/8.14.9) with ESMTP id w8QGiK0R003529
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Wed, 26 Sep 2018 18:44:20 +0200
Subject: Re: kernel 4.18.5 Realtek 8111G network adapter stops responding
 under high system load
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Gabriel C <nix.or.die@gmail.com>,
        =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <odi@odi.ch>
Cc:     linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        netdev@vger.kernel.org
References: <20180918102349.Horde.yHctatUod-_SC696oYKmySa@cloud.luxmemories.lu>
 <039cc66f-13b0-e745-b6ec-68f4580e90ef@maciej.szmigiero.name>
 <0e865e74-e587-61b7-d319-9afe0a5e8828@prnet.org>
 <968f03ee-a271-242b-d90a-5c70ea72ce3b@gmail.com>
From:   David Arendt <admin@prnet.org>
Message-ID: <ef0d0fb2-f4f1-8fae-6f84-3ed0d6dc92fc@prnet.org>
Date:   Wed, 26 Sep 2018 18:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <968f03ee-a271-242b-d90a-5c70ea72ce3b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks.

I have just applied Heiner Kallweit's patch on top of kernel 4.18.10 and
the TxConfig register contains 0x4f000f80.

I will give it 24 hours under high load and report back if the patch
really solves the problem.

Bye,
David Arendt

On 9/25/18 11:03 PM, Heiner Kallweit wrote:
> On 19.09.2018 06:12, David Arendt wrote:
>> Hi,
>>
>> Thanks for the patch.
>>
>> I just applied it and the TxConfig register now contains 0x4f000f80.
>> The next day will show if it really solves the problem.
>>
>> Thanks in advance,
>> David Arendt
>>
>> On 9/19/18 12:30 AM, Maciej S. Szmigiero wrote:
>>> Hi,
>>>
>>> On 18.09.2018 12:23, David Arendt wrote:
>>>> Hi,
>>>>
>>>> Today I had the network adapter problems again.
>>>> So the patch doesn't seem to change anything regarding this problem.
>>>> This week my time is unfortunately very limited, but I will try to
>>>> find some time next weekend to look a bit more into the issue.
>>> If the problem is caused by missing TXCFG_AUTO_FIFO bit in TxConfig,
>>> as the register difference would suggest, then you can try applying
>>> the following patch (hack) on top of 4.18.8 that is already patched
>>> with commit f74dd480cf4e:
>>> --- a/drivers/net/ethernet/realtek/r8169.c
>>> +++ b/drivers/net/ethernet/realtek/r8169.c
>>> @@ -5043,7 +5043,8 @@
>>>  {
>>>  	/* Set DMA burst size and Interframe Gap Time */
>>>  	RTL_W32(tp, TxConfig, (TX_DMA_BURST << TxDMAShift) |
>>> -		(InterFrameGap << TxInterFrameGapShift));
>>> +		(InterFrameGap << TxInterFrameGapShift)
>>> +		| TXCFG_AUTO_FIFO);
>>>  }
>>>  
>>>  static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>>>
>>> This hack will probably only work properly on RTL_GIGA_MAC_VER_40 or
>>> later NICs.
>>>
>>> Before running any tests please verify with "ethtool -d enp3s0" that
>>> TxConfig register now contains 0x4f000f80, as it did in the old,
>>> working driver version.
>>>
>>> If this does not help then a bisection will most likely be needed.
>>>
>>>> Thanks in advance,
>>>> David Arendt
>>> Maciej
>>
>>
> @Gabriel:
> Thanks for the hint, I wasn't fully aware of this thread.
> @Maciej:
> Thanks for the analysis.
>
> It seems that all chip versions from 34 (= RTL8168E-VL) with the
> exception of version 39 (= RTL8106E, first sub-version) need
> bit TXCFG_AUTO_FIFO.
>
> And indeed, due to reordering of calls this bit is overwritten.
> Following patch moves setting the bit from the chip-specific
> hw_start function to rtl_set_tx_config_registers().
>
> Whoever is hit by the issue and has the option to build a kernel,
> could you please test whether the patch fixes the issue for you?
>
> Thanks, Heiner
>
> ---
>  drivers/net/ethernet/realtek/r8169.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index f882be49f..ae8abe900 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -4514,9 +4514,14 @@ static void rtl8169_hw_reset(struct rtl8169_private *tp)
>  
>  static void rtl_set_tx_config_registers(struct rtl8169_private *tp)
>  {
> -	/* Set DMA burst size and Interframe Gap Time */
> -	RTL_W32(tp, TxConfig, (TX_DMA_BURST << TxDMAShift) |
> -		(InterFrameGap << TxInterFrameGapShift));
> +	u32 val = TX_DMA_BURST << TxDMAShift |
> +		  InterFrameGap << TxInterFrameGapShift;
> +
> +	if (tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
> +	    tp->mac_version != RTL_GIGA_MAC_VER_39)
> +		val |= TXCFG_AUTO_FIFO;
> +
> +	RTL_W32(tp, TxConfig, val);
>  }
>  
>  static void rtl_set_rx_max_size(struct rtl8169_private *tp)
> @@ -5011,7 +5016,6 @@ static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
>  
>  	rtl_disable_clock_request(tp);
>  
> -	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
>  	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
>  
>  	/* Adjust EEE LED frequency */
> @@ -5045,7 +5049,6 @@ static void rtl_hw_start_8168f(struct rtl8169_private *tp)
>  
>  	rtl_disable_clock_request(tp);
>  
> -	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
>  	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
>  	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
>  	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
> @@ -5090,8 +5093,6 @@ static void rtl_hw_start_8411(struct rtl8169_private *tp)
>  
>  static void rtl_hw_start_8168g(struct rtl8169_private *tp)
>  {
> -	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
> -
>  	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x080002, ERIAR_EXGMAC);
>  	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
>  	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
> @@ -5189,8 +5190,6 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
>  
> -	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
> -
>  	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
>  	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
>  	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
> @@ -5273,8 +5272,6 @@ static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
>  {
>  	rtl8168ep_stop_cmac(tp);
>  
> -	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
> -
>  	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
>  	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x2f, ERIAR_EXGMAC);
>  	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x5f, ERIAR_EXGMAC);
> @@ -5596,7 +5593,6 @@ static void rtl_hw_start_8402(struct rtl8169_private *tp)
>  	/* Force LAN exit from ASPM if Rx/Tx are not idle */
>  	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
>  
> -	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
>  	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
>  
>  	rtl_ephy_init(tp, e_info_8402, ARRAY_SIZE(e_info_8402));


