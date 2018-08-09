Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4A5C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B6C21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkgNVTUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B6C21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeHIWLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:11:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50963 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeHIWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:11:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so1377409wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mm01IoHXXVERPSaGMICeshLu7dRmAV07N77DiJfEoko=;
        b=qkgNVTUiXgQT2wrTyBykqn5mghMEMDv/YXM8t/4K5r++7Wi/E/4WsI5dvXohaTlNnS
         nol/VDF046hWjZVTZN8pa/otHmdBncNC3s39qIaS62codAC0aoumvzzv2Cvaf1Yn+meG
         OqRrZuNRWLSdfPvW7zzm2pwMkDHotpqOOARkbZLz8+/ABO6M94jJCH2vLmpX5dDW7NDk
         Cw44bZeicnQDhRGRT7nNYLt92Mi02hmYIkgEULntQ5db3bU9FTMfH/ZurHDuKaUL/5ox
         OPoTQd+YQyvIL6kcladCgnT9QMqNIglWWSIvMWoAjWmLtgLogn6h0gY4LIdQT1oWd4xy
         CP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mm01IoHXXVERPSaGMICeshLu7dRmAV07N77DiJfEoko=;
        b=dSf/DvCFh2DRSYGC65lolbS1Xn45KkjOts3d/i/lsP0QnWVeT3kkxb1DDort4+TThu
         PRNVja2ZwtVTQV2ljkSacufWrcsNWcFuaIke/UUK9qGCtUScPaBVlNmFJltMqVJuFLo8
         yC3ZTxWkGPJray0ZGbrZaRBWhJodubx/+2ZCaQSnhtbcWuAEX0VnoxPY953lnw/igchG
         AFj9E+vXZ5rtP+CPz8KWCTzgm5/vriFg1UkP5xMZS++st2x2Q8w8x31rY8Ur7PTuHD1O
         KDGV3gHWPcF46+F4ibAQ5Egm0uh7SBY1HgaMkjjuhoAvF8plvEqRP8YmBTN6m+rAsn8P
         9HPg==
X-Gm-Message-State: AOUpUlGeh1khsnlEDc3eOan9mwL8pLeaWKH+SP0XjNyiiLp5xtEeB6wU
        UpDZjQ/EF2yi7xwoWapsbMZ4lDw1
X-Google-Smtp-Source: AA+uWPxAGMDXvy2CHOGPoJadjSnOkwgDpoAGXvPrek0SLzO3JbwtOJvSVN0WTw1BRBJZxr/BAVijmg==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr2342146wme.109.1533843898769;
        Thu, 09 Aug 2018 12:44:58 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id q8-v6sm6064965wrj.97.2018.08.09.12.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:44:58 -0700 (PDT)
Subject: Re: [PATCH 3/5] staging: rtl8188eu: use is_multicast_ether_addr in
 rtw_xmit.c
From:   Michael Straube <straube.linux@gmail.com>
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180809170131.29279-1-straube.linux@gmail.com>
 <20180809170131.29279-3-straube.linux@gmail.com>
 <e1c49e8a5c93b07542899f1e8b238a70ec89801b.camel@perches.com>
 <d1f2ab32-ff10-9575-ad61-0286ee3811ae@gmail.com>
 <cf3e257702a93e4fcfab666e42e49f363eb447f7.camel@perches.com>
 <6da72965-8228-46bf-9c5b-981d761836bb@gmail.com>
Message-ID: <a640bab5-af3e-6d65-e34c-1dbcdaa9851a@gmail.com>
Date:   Thu, 9 Aug 2018 21:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6da72965-8228-46bf-9c5b-981d761836bb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/18 8:03 PM, Michael Straube wrote:
> On 8/9/18 7:51 PM, Joe Perches wrote:
>> On Thu, 2018-08-09 at 19:42 +0200, Michael Straube wrote:
>>> On 8/9/18 7:13 PM, Joe Perches wrote:
>>>> On Thu, 2018-08-09 at 19:01 +0200, Michael Straube wrote:
>>>>> Use is_multicast_ether_addr instead of custom IS_MCAST in
>>>>> core/rtw_xmit.c.
>>>>
>>>> Have you verified that all accesses are __aligned(2) ?
>>>>
>>>> If so, please state that in the patch description.
>>>>
>>>>> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
>>>>
>>>> []
>>>>> @@ -460,10 +460,10 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
>>>>>        if ((pattrib->ether_type == ETH_P_ARP) || (pattrib->ether_type == ETH_P_PAE) || (pattrib->dhcp_pkt == 1))
>>>>>            rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SPECIAL_PACKET, 1);
>>>>> -    bmcast = IS_MCAST(pattrib->ra);
>>>>> +    mcast = is_multicast_ether_addr(pattrib->ra);
>>>>
>>>> i.e.:  is pattrib->ra __aligned(2) ?
>>>>
>>>> etc...
>>>>
>>>
>>> Hi Joe,
>>>
>>> I looked at the function comment for is_multicast_ether_addr in etherdevice.h.
>>> There is not mentioned that __aligned(2) is required. If it is, I will check.
>>>
>>> So, is it required although it's not mentioned for is_multicast_ether_addr?
>>
>> Well, it wasn't required initially, but
>>
>> commit d54385ce68cd18ab002b46f61246ad197cec92de
>> Author: Alexander Duyck <alexander.h.duyck@redhat.com>
>> Date:   Thu Apr 30 14:53:54 2015 -0700
>>
>>      etherdev: Process is_multicast_ether_addr at same size as other operations
>>      This change makes it so that we process the address in
>>      is_multicast_ether_addr at the same size as the other calls.  This allows
>>      us to avoid duplicate reads when used with other calls such as
>>      is_zero_ether_addr or eth_addr_copy.  In addition I have added a 64 bit
>>      version of the function so in eth_type_trans we can process the destination
>>      address as a 64 bit value throughout.
>>      Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
>>      Signed-off-by: David S. Miller <davem@davemloft.net>
>>
>> changed it without adding a note in the kernel-doc.
>>
>> So this is likely appropriate to avoid unaligned access traps:
>> ---
>>   include/linux/etherdevice.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
>> index 572e11bb8696..0f7086b4836a 100644
>> --- a/include/linux/etherdevice.h
>> +++ b/include/linux/etherdevice.h
>> @@ -115,6 +115,8 @@ static inline bool is_zero_ether_addr(const u8 *addr)
>>    *
>>    * Return true if the address is a multicast address.
>>    * By definition the broadcast address is also a multicast address.
>> + *
>> + * Please note: addr must be aligned to u16.
>>    */
>>   static inline bool is_multicast_ether_addr(const u8 *addr)
>>   {
>>
> 
> Ok, then I will check and resend the series.
> Thanks again.

I looked at it and I'm not sure about this one:
(where precv_frame->pkt is a sk_buff)

     is_multicast_ether_addr(GetAddr1Ptr(precv_frame->pkt->data))

and the macro GetAddr1Ptr:

     #define GetAddr1Ptr(pbuf)  ((unsigned char *)((size_t)(pbuf) + 4))

Is the memory pointed to by sk_buff->data (always) __aligned(2) ?
