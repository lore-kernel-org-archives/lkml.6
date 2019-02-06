Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF480C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8464D217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jzNuoFxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfBFV05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:26:57 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:16838 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbfBFV05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:26:57 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 2ADFDE17;
        Wed,  6 Feb 2019 13:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1549488416;
        bh=696+KVgwPrp7PxvftSIpNZoSqmQd3F0nzrrHrJrTU44=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jzNuoFxw8j/39qyemel6mxnFq9I4KhUJcxxqg5D9yRvjrn7POBZgC8y6zqT/4c9d4
         qZqAeXxZCxEnC+S3UMP6dN1GrPCflsMiaeZO2jXad56pa+2J/zK0bVEuHO/1gTbIJV
         4c6+NZihVtTY/T5diLEwd7baCcMlEGZyPrP4TYJC/jcfx+Eiwhwo/lBCNj7vrW8XFF
         iySEK6o3RCqFsZlKEDNeitcJryWSwQ6N7ubSdv8yaw989giZ3yAytoq/BMDpooigku
         rsx7crPMfh633X2z+yLF6PKDNSUu6ALDkFe7SQKskp3qGHaouZ4BfYVR1kiuJJCmcC
         MxwEKPT/BDBcA==
Received: from [10.80.4.127] (unknown [10.80.4.127])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id B2AE8E0F;
        Wed,  6 Feb 2019 13:26:55 -0800 (PST)
Subject: Re: [PATCH net] sctp: make sctp_setsockopt_events() less strict about
 the option length
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        nhorman@tuxdriver.com, vyasevich@gmail.com, lucien.xin@gmail.com
References: <20190206201430.18830-1-julien@arista.com>
 <20190206203754.GC13621@localhost.localdomain>
 <c13067c0-f127-50a0-9ae0-4be7f0399c0d@arista.com>
 <20190206210723.GD13621@localhost.localdomain>
From:   Julien Gomes <julien@arista.com>
Message-ID: <274c48cb-7590-682b-f4de-f5c4ce2d2144@arista.com>
Date:   Wed, 6 Feb 2019 13:26:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206210723.GD13621@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/19 1:07 PM, Marcelo Ricardo Leitner wrote:
> On Wed, Feb 06, 2019 at 12:48:38PM -0800, Julien Gomes wrote:
>>
>>
>> On 2/6/19 12:37 PM, Marcelo Ricardo Leitner wrote:
>>> On Wed, Feb 06, 2019 at 12:14:30PM -0800, Julien Gomes wrote:
>>>> Make sctp_setsockopt_events() able to accept sctp_event_subscribe
>>>> structures longer than the current definitions.
>>>>
>>>> This should prevent unjustified setsockopt() failures due to struct
>>>> sctp_event_subscribe extensions (as in 4.11 and 4.12) when using
>>>> binaries that should be compatible, but were built with later kernel
>>>> uapi headers.
>>>
>>> Not sure if we support backwards compatibility like this?
>>>
>>> My issue with this change is that by doing this, application will have
>>> no clue if the new bits were ignored or not and it may think that an
>>> event is enabled while it is not.
>>>
>>> A workaround would be to do a getsockopt and check the size that was
>>> returned. But then, it might as well use the right struct here in the
>>> first place.
>>>
>>> I'm seeing current implementation as an implicitly versioned argument:
>>> it will always accept setsockopt calls with an old struct (v4.11 or
>>> v4.12), but if the user tries to use v3 on a v1-only system, it will
>>> be rejected. Pretty much like using a newer setsockopt on an old
>>> system.
>>
>> With the current implementation, given sources that say are supposed to
>> run on a 4.9 kernel (no use of any newer field added in 4.11 or 4.12),
>> we can't rebuild the exact same sources on a 4.19 kernel and still run
>> them on 4.9 without messing with structures re-definition.
> 
> Maybe what we want(ed) here then is explicit versioning, to have the 3
> definitions available. Then the application is able to use, say struct
> sctp_event_subscribe, and be happy with it, while there is struct
> sctp_event_subscribe_v2 and struct sctp_event_subscribe_v3 there too.
> 
> But it's too late for that now because that would break applications
> already using the new fields in sctp_event_subscribe.

Right.

> 
>>
>> I understand your point, but this still looks like a sort of uapi
>> breakage to me.
> 
> Not disagreeing. I really just don't know how supported that is.
> Willing to know so I can pay more attention to this on future changes.
> 
> Btw, is this the only occurrence?

Can't really say, this is one I witnessed, I haven't really looked for
others.

> 
>>
>>
>> I also had another way to work-around this in mind, by copying optlen
>> bytes and checking that any additional field (not included in the
>> "current" kernel structure definition) is not set, returning EINVAL in
>> such case to keep a similar to current behavior.
>> The issue with this is that I didn't find a suitable (ie not totally
>> arbitrary such as "twice the existing structure size") upper limit to
>> optlen.
> 
> Seems interesting. Why would it need that upper limit to optlen?
> 
> Say struct v1 had 4 bytes, v3 now had 12. The user supplies 12 bytes
> to the kernel that only knows about 4 bytes. It can check that (12-4)
> bytes in the end, make sure no bit is on and use only the first 4.
> 
> The fact that it was 12 or 200 shouldn't matter, should it? As long as
> the (200-4) bytes are 0'ed, only the first 4 will be used and it
> should be ok, otherwise EINVAL. No need to know how big the current
> current actually is because it wouldn't be validating that here: just
> that it can safely use the first 4 bytes.

The upper limit concern is more regarding the call to copy_from_user
with an unrestricted/unchecked value.
I am not sure of how much of a risk/how exploitable this could be,
that's why I cautiously wanted to limit it in the first place just in case.

> 
>>
>>>
>>>>
>>>> Signed-off-by: Julien Gomes <julien@arista.com>
>>>> ---
>>>>  net/sctp/socket.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
>>>> index 9644bdc8e85c..f9717e2789da 100644
>>>> --- a/net/sctp/socket.c
>>>> +++ b/net/sctp/socket.c
>>>> @@ -2311,7 +2311,7 @@ static int sctp_setsockopt_events(struct sock *sk, char __user *optval,
>>>>  	int i;
>>>>  
>>>>  	if (optlen > sizeof(struct sctp_event_subscribe))
>>>> -		return -EINVAL;
>>>> +		optlen = sizeof(struct sctp_event_subscribe);
>>>>  
>>>>  	if (copy_from_user(&subscribe, optval, optlen))
>>>>  		return -EFAULT;
>>>> -- 
>>>> 2.20.1
>>>>
>>

-- 
Julien Gomes
