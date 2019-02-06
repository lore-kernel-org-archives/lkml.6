Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FD1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB944218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cGgUY88L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBFUsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:48:41 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:41333 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbfBFUsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:48:40 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 30216DCE;
        Wed,  6 Feb 2019 12:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1549486119;
        bh=pcY9jD3wDNJYbDLBwpjIybMFG4GTkwcVbeNcztM0INU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cGgUY88LPGQY4TBkfnBHgxBET9vvEyzSKZkJoJEIwFCM+QxpK/uWE4F5syb7FDe2b
         yn2/RoQ1ehal/fD9/wiJTSYPNWh6hR4O2ANrf+LweofV5exYjMrGDPqmoQ/Dtl5MTn
         tbdZtGvKKmA1qIvc/K4FpDKuuKnhc7VlWwExq3Xa8blR8oeo+d7KJZHxwkHaLkxafL
         fhTKIzv7rUE1jDr4FU134DV+6IRH0R/+z80+Hnk2mL1vUQ0rVZGDcWCzaPs8CmYsk9
         IZcO+K37/XU3/4HME3hdXapzmXP7GtFFHdP+EhEN3q8peEpHP/nkBtUPbRU+pTSxc+
         rzyjI+MIqMqTg==
Received: from [10.80.4.127] (unknown [10.80.4.127])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id D5388D1F;
        Wed,  6 Feb 2019 12:48:38 -0800 (PST)
Subject: Re: [PATCH net] sctp: make sctp_setsockopt_events() less strict about
 the option length
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        nhorman@tuxdriver.com, vyasevich@gmail.com, lucien.xin@gmail.com
References: <20190206201430.18830-1-julien@arista.com>
 <20190206203754.GC13621@localhost.localdomain>
From:   Julien Gomes <julien@arista.com>
Message-ID: <c13067c0-f127-50a0-9ae0-4be7f0399c0d@arista.com>
Date:   Wed, 6 Feb 2019 12:48:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206203754.GC13621@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/19 12:37 PM, Marcelo Ricardo Leitner wrote:
> On Wed, Feb 06, 2019 at 12:14:30PM -0800, Julien Gomes wrote:
>> Make sctp_setsockopt_events() able to accept sctp_event_subscribe
>> structures longer than the current definitions.
>>
>> This should prevent unjustified setsockopt() failures due to struct
>> sctp_event_subscribe extensions (as in 4.11 and 4.12) when using
>> binaries that should be compatible, but were built with later kernel
>> uapi headers.
> 
> Not sure if we support backwards compatibility like this?
> 
> My issue with this change is that by doing this, application will have
> no clue if the new bits were ignored or not and it may think that an
> event is enabled while it is not.
> 
> A workaround would be to do a getsockopt and check the size that was
> returned. But then, it might as well use the right struct here in the
> first place.
> 
> I'm seeing current implementation as an implicitly versioned argument:
> it will always accept setsockopt calls with an old struct (v4.11 or
> v4.12), but if the user tries to use v3 on a v1-only system, it will
> be rejected. Pretty much like using a newer setsockopt on an old
> system.

With the current implementation, given sources that say are supposed to
run on a 4.9 kernel (no use of any newer field added in 4.11 or 4.12),
we can't rebuild the exact same sources on a 4.19 kernel and still run
them on 4.9 without messing with structures re-definition.

I understand your point, but this still looks like a sort of uapi
breakage to me.


I also had another way to work-around this in mind, by copying optlen
bytes and checking that any additional field (not included in the
"current" kernel structure definition) is not set, returning EINVAL in
such case to keep a similar to current behavior.
The issue with this is that I didn't find a suitable (ie not totally
arbitrary such as "twice the existing structure size") upper limit to
optlen.

> 
>>
>> Signed-off-by: Julien Gomes <julien@arista.com>
>> ---
>>  net/sctp/socket.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
>> index 9644bdc8e85c..f9717e2789da 100644
>> --- a/net/sctp/socket.c
>> +++ b/net/sctp/socket.c
>> @@ -2311,7 +2311,7 @@ static int sctp_setsockopt_events(struct sock *sk, char __user *optval,
>>  	int i;
>>  
>>  	if (optlen > sizeof(struct sctp_event_subscribe))
>> -		return -EINVAL;
>> +		optlen = sizeof(struct sctp_event_subscribe);
>>  
>>  	if (copy_from_user(&subscribe, optval, optlen))
>>  		return -EFAULT;
>> -- 
>> 2.20.1
>>

