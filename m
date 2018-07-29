Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BF9C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D5320894
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D5320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeG2Rai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 13:30:38 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41605 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbeG2Rai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 13:30:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so9763654qtp.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 08:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j/l8yA89Y9s5p2wOXTIGUBE/p32GTB/b98dFNgAcp4g=;
        b=iTu2uHzscRfmZn39HOWc6QMNqgQyA9enYtHZXQV2CToAoxj3ZTyQT8r/0pL0p9Jk6M
         Q2xVpQuJE+GnAfXTjg8VwB8aI3fY2uOPDJFsf3yCia6eJop3Kj8HUkTsv/5rbIAcCxLT
         xiYRtVZJFAbaGbm0EmDfwKq0qdb5Ev9EqGM/dP1ueCuM/hisVJGDUMFiWbFOOXuEyBx/
         QOHKfe3rMKeUju8wbDL1yTpVJZlUwFWZmcJ6dXP9i5DQR3b5Hp3/WwNuSm0/v3ZzO8L+
         T58yQ64smNCiOyd+WO8i6OD2tsvvLmofeidHXJJLMJQl/FGvqtb5RokAQWBcGOK+JWL1
         ZhdA==
X-Gm-Message-State: AOUpUlHMGPfQUWkBVTGiSU5hMIh3SXtVI7v5H6YW9gU/tyY65oSsxKcc
        6ZJ2eYMLWceij2kv6BjhWxu2Dw==
X-Google-Smtp-Source: AAOMgpf8qFYADkTBwaj3r6JsDxfX3xyFRyFe6lXH4RMG8GbQv8Pv6l/2uV+SvO0K957CrXREkljKdA==
X-Received: by 2002:ac8:1c07:: with SMTP id a7-v6mr13817896qtk.348.1532879983640;
        Sun, 29 Jul 2018 08:59:43 -0700 (PDT)
Received: from laptop.jcline.org (075-177-179-204.res.spectrum.com. [75.177.179.204])
        by smtp.gmail.com with ESMTPSA id i32-v6sm5793685qtb.21.2018.07.29.08.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 08:59:43 -0700 (PDT)
Subject: Re: [PATCH 2/2] net: socket: Fix potential spectre v1 gadget in
 sock_is_registered
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180727224302.5503-1-jcline@redhat.com>
 <20180727224302.5503-3-jcline@redhat.com>
 <20180729135906.lgqo5ue6it3hl2da@treble>
From:   Jeremy Cline <jcline@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jcline@redhat.com; keydata=
 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
 X/87hZ4pdW/aOXUAgQ==
Message-ID: <914d34af-ba80-93b9-6f17-413eef8bf210@redhat.com>
Date:   Sun, 29 Jul 2018 11:59:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729135906.lgqo5ue6it3hl2da@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/2018 09:59 AM, Josh Poimboeuf wrote:
> On Fri, Jul 27, 2018 at 10:43:02PM +0000, Jeremy Cline wrote:
>> 'family' can be a user-controlled value, so sanitize it after the bounds
>> check to avoid speculative out-of-bounds access.
>>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jeremy Cline <jcline@redhat.com>
>> ---
>>  net/socket.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index f15d5cbb3ba4..608e29ae6baf 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -2672,7 +2672,8 @@ EXPORT_SYMBOL(sock_unregister);
>>  
>>  bool sock_is_registered(int family)
>>  {
>> -	return family < NPROTO && rcu_access_pointer(net_families[family]);
>> +	return family < NPROTO &&
>> +		rcu_access_pointer(net_families[array_index_nospec(family, NPROTO)]);
>>  }
>>  
>>  static int __init sock_init(void)
> 
> This is another one where I think it would be better to do the nospec
> clamp higher up the call chain.  The untrusted 'family' value comes from
> __sock_diag_cmd():
> 
> __sock_diag_cmd
>   sock_load_diag_module
>     sock_is_registered
> 
> That function has a bounds check, and also uses the value in some other
> array accesses:
> 
> 	if (req->sdiag_family >= AF_MAX)
> 		return -EINVAL;
> 
> 	if (sock_diag_handlers[req->sdiag_family] == NULL)
> 		sock_load_diag_module(req->sdiag_family, 0);
> 
> 	mutex_lock(&sock_diag_table_mutex);
> 	hndl = sock_diag_handlers[req->sdiag_family];
> 	...
> 
> So I think clamping 'req->sdiag_family' right after the bounds check
> would be the way to go.
> 

Indeed, the clamp there would cover this clamp. I had a scheme that I
quickly fix all the gadgets in functions with local comparisons, but
clearly that's going to result in call chains with multiple clamps.

I can fix this in a follow-up with a clamp here, or respin this patch
set, whatever is easier for David.

Thanks for the review!
