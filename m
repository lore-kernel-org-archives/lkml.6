Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F93C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD52B204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SCUSCH0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD52B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeJJGv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:51:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45295 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeJJGv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:51:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so3595582wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLVKTERspw8fCwtE8+37/mCCbYEqp/w/KXPsh8x9uZg=;
        b=SCUSCH0PHwTXUFiUFvH6qgyCI1aYMrAg4/WT0eRHZu9N7+9A2hZrSHSzUTRyOECJ5m
         14F1x4jY2lTCqCKkFdPAc9zv99Vr+ltT82uJGPUv/zbvGZtgENWJcvVgQrgkzHLAaxK5
         /+UIDs5jm7H5A+WB/EkVzExH4CrzVoHwIAbVkJYmL3tHO8B4bKo/wCQqn2Xm557BWHP3
         DePTufL83gSXe/kOq5Le/Gf9UV5ODq46u0FB5NoaDOH3s/RtfuW5drX7Gd+75N1C8jF+
         up2XpeFEI7de8rtJvLmqr6THdnVSoFIdumru9k9AkjgFn9+WxQDMlIRpHoUfCBhC+Owe
         dRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLVKTERspw8fCwtE8+37/mCCbYEqp/w/KXPsh8x9uZg=;
        b=lInWYnbYq8ZqMwOe0NZFyYXVEJvRvLaQOdU1qhJCPHKuQhTGspGvje+asQMY/ZacoE
         oZmKhG5xzkWkZHU2m9AHuewN/judRZeH/zZtP6iEc12I7XEmGkaAW3r7z9ymWUDSLmxp
         okiKKRdUhhq193XlDupGK5mb+6stCbejpE6ByM3jPkexmtVB9IKh1+GBVQDbbzJGH5GH
         lkSmzS17JgLW3fcSpd3GhcuWrs6IDbBdDn+v41gf2sYmtX01qOFJvLRiby1hcAyxY/jl
         uTZjPrHO+t/AcJQx0qr9C/GCm2YZCZnMOvUwE8F9oDEKbsmvX+yPkG1DBfWj/VxRcSfL
         7N6w==
X-Gm-Message-State: ABuFfojQeynmbRDag8qFXrFngKtro47CN/RLU1FedtmYYGSwYLXVVp/D
        cJ0J0AcFRun1Rb/335KDZ0r3IHKp
X-Google-Smtp-Source: ACcGV62s41i7y6qRKALSPiaBr5RUeW97j2ThRGUurmWYZNfwJuE+0MovOEr1+RtN/bGpNBBkQpGweg==
X-Received: by 2002:adf:9592:: with SMTP id p18-v6mr22812819wrp.202.1539127956048;
        Tue, 09 Oct 2018 16:32:36 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.125.110])
        by smtp.googlemail.com with ESMTPSA id r128-v6sm11925555wma.40.2018.10.09.16.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 16:32:35 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Azat Khuzhin <a3at.mail@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <54d8d7e9-a80d-dc2b-5628-22f9dc14e2ee@maciej.szmigiero.name>
 <535f42c7-6c3b-8e5a-49de-5dc975879b21@googlemail.com>
 <98680351-5123-761f-982a-726098da9716@gmail.com>
 <9980dcc1-f7fe-5de7-75be-99b1592c9206@googlemail.com>
 <6b1685ce-22ac-2c71-e1d4-b05748a7d977@googlemail.com>
 <bed5c327-6a2a-99da-8b86-16f897b32548@maciej.szmigiero.name>
 <7199b1e4-ce40-60ae-2a6a-ef7e95e563ea@googlemail.com>
 <e11f8eae-2bca-037b-9a7e-43c4276a2be6@gmail.com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <4e33341b-8805-80dd-26fb-1b1a4d2a3eb9@googlemail.com>
Date:   Wed, 10 Oct 2018 00:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e11f8eae-2bca-037b-9a7e-43c4276a2be6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2018 22:39, Heiner Kallweit wrote:
> On 09.10.2018 16:40, Chris Clayton wrote:
>> Thanks to Maciej and Heiner for their replies.
>>
>> On 09/10/2018 13:32, Maciej S. Szmigiero wrote:
>>> On 07.10.2018 21:36, Chris Clayton wrote:
>>>> Hi again,
>>>>
>>>> I didn't think there was anything in 4.19-rc7 to fix this regression, but tried it anyway. I can confirm that the
>>>> regression is still present and my network still fails when, after a resume from suspend (to ram or disk), I open my
>>>> browser or my mail client. In both those cases the failure is almost immediate - e.g. my home page doesn't get displayed
>>>> in the browser. Pinging one of my ISPs name servers doesn't fail quite so quickly but the reported time increases from
>>>> 14-15ms to more than 1000ms.
>>>
>>> You can try comparing chip registers (ethtool -d eth0) in the working
>>> state (before a suspend) and in the broken state (after a resume).
>>> Maybe there will be some obvious in the difference.
>>>
>>> The same goes for the PCI configuration (lspci -d :8168 -vv).
>>>
>> Maciej suggested comparing the output from lspci -vv for the ethernet device. They are identical.
>>
>> Both Maciej and Heiner suggested comparing the output from "ethtool -d" pre and post suspend. Again, they are identical.
>> Heiner specifically suggested looking at the RxConfig. The value of that is 0x0002870e both pre and post suspend.
>>
>> I've attached files I redirected the outputs to.
>>
>> Please don't hesitate to ask for any other information needed to solve this problem. In the meantime, I've now got
>> scripts that stop the network during suspend and restart it during resume. (Those scripts were removed whilst I gathered
>> the diagnostics shown in the attachments.)
>>
> I'd like to check whether it may be a timing issue. The following experimental patch
> adds a PCI commit after writing register ChipCmd. Could you please check whether
> it changes anything?
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 7d3f671e1..f3c359492 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -4641,6 +4641,7 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
>  	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
>  	RTL_R8(tp, IntrMask);
>  	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
> +	RTL_R8(tp, ChipCmd);
>  	rtl_init_rxcfg(tp);
>  	rtl_set_tx_config_registers(tp);
>  
> 

Sorry, this patch doesn't make any difference - my network still fails. After a suspend/resume my browsers (chromium
and firefox) both fail to open my home page (https://www.google.co.uk). The ping time for one of my ISP's name servers
increases from 14-15ms to more than 1000ms, although it after a few pings it does reduce. As the screen grab below
shows, the network does eventually fail

$ ping NS1
PING ns1 (90.207.238.97): 56 data bytes
64 bytes from 90.207.238.97: icmp_seq=0 ttl=251 time=1017.289 ms
64 bytes from 90.207.238.97: icmp_seq=1 ttl=251 time=1018.051 ms
64 bytes from 90.207.238.97: icmp_seq=2 ttl=251 time=1015.271 ms
64 bytes from 90.207.238.97: icmp_seq=3 ttl=251 time=1015.495 ms
64 bytes from 90.207.238.97: icmp_seq=6 ttl=251 time=1015.646 ms
64 bytes from 90.207.238.97: icmp_seq=7 ttl=251 time=1022.609 ms
64 bytes from 90.207.238.97: icmp_seq=8 ttl=251 time=1015.612 ms
64 bytes from 90.207.238.97: icmp_seq=10 ttl=251 time=1015.551 ms
64 bytes from 90.207.238.97: icmp_seq=12 ttl=251 time=1015.446 ms
64 bytes from 90.207.238.97: icmp_seq=13 ttl=251 time=1015.657 ms
64 bytes from 90.207.238.97: icmp_seq=14 ttl=251 time=1015.614 ms
64 bytes from 90.207.238.97: icmp_seq=15 ttl=251 time=1015.651 ms
64 bytes from 90.207.238.97: icmp_seq=17 ttl=251 time=1015.459 ms
64 bytes from 90.207.238.97: icmp_seq=18 ttl=251 time=1015.443 ms
64 bytes from 90.207.238.97: icmp_seq=19 ttl=251 time=1015.936 ms
64 bytes from 90.207.238.97: icmp_seq=20 ttl=251 time=1015.681 ms
64 bytes from 90.207.238.97: icmp_seq=22 ttl=251 time=1015.410 ms
64 bytes from 90.207.238.97: icmp_seq=23 ttl=251 time=1015.487 ms
64 bytes from 90.207.238.97: icmp_seq=24 ttl=251 time=1016.169 ms
64 bytes from 90.207.238.97: icmp_seq=25 ttl=251 time=1015.659 ms
64 bytes from 90.207.238.97: icmp_seq=26 ttl=251 time=14.606 ms
64 bytes from 90.207.238.97: icmp_seq=30 ttl=251 time=32.765 ms
64 bytes from 90.207.238.97: icmp_seq=31 ttl=251 time=115.052 ms
64 bytes from 90.207.238.97: icmp_seq=33 ttl=251 time=757.115 ms
64 bytes from 90.207.238.97: icmp_seq=34 ttl=251 time=176.696 ms
64 bytes from 90.207.238.97: icmp_seq=35 ttl=251 time=1017.462 ms
64 bytes from 90.207.238.97: icmp_seq=36 ttl=251 time=16.394 ms
64 bytes from 90.207.238.97: icmp_seq=37 ttl=251 time=20.402 ms
64 bytes from 90.207.238.97: icmp_seq=38 ttl=251 time=37.795 ms
64 bytes from 90.207.238.97: icmp_seq=39 ttl=251 time=141.997 ms
92 bytes from laptop.local.lan (192.168.0.20): Destination Host Unreachable
92 bytes from laptop.local.lan (192.168.0.20): Destination Host Unreachable
...


Chris
