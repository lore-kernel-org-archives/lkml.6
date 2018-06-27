Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E787AC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AC1219E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="b4d155ME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AC1219E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755059AbeF0VgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:36:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41126 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754707AbeF0Vf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:35:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id b12-v6so3917203edt.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qKrHruRtmX/K3JImTxwZD4Xgo3ayTe61dWNGXYsufqU=;
        b=b4d155MEPHCWhuKT6kRFAo/r/3ERj9M+ltjh3mD7unoiJM/HtdlpiPK3wbYK1DP10X
         2hg1KDt1omS3qMRBBj6GeZPZiQXUktxrqT4zvNAe4eUEKatZ2Gw3Y25LxZqEFzvi4RFF
         uFIO4cwiYYKvkcTh12a5Fngd+UJE+sQQqeClY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qKrHruRtmX/K3JImTxwZD4Xgo3ayTe61dWNGXYsufqU=;
        b=J4LWfGW6myQahLjn7deeC4LmwxnRnyE5GZRYD9YUrOu2iP+cdzdwd5LgTezjq9BwtU
         rt1/KiZqxmt785YMuctRnzJIO5qAkEXyxYYCBhoJ/5NXPsbEmN0AsU5i4DKVM0Dhme2m
         rLK3FCVzzW8uJ3A/VMsMSwQ4IzuAKjg9te/PSWsRj9rUrbxYaB0IsQrRDLmh2eELNfPz
         N1atXop4c1dfkG+6IcyyPGSXBpjxiUxkS8cNOSOSlfxn98kFfKsU+JCHOe9Tj2GIgjwF
         06VlyRZ3yiVhRw1jyBCNzRMtjGXTSyfIP4Emrev+irnGtOQGYekGllGnhH57DGyIPWPs
         o3Jw==
X-Gm-Message-State: APt69E0PBZtZsXKWyiJwCXiQrmmIwnFNjLaf5gY5trQyQJcZIkCrLTHa
        G7cRrkJ0Go2V6EkuCVqa7AuFMhanNMU=
X-Google-Smtp-Source: AAOMgpdXA7TCXMCoG5Ls10A6TA20hyx5JItfsGCcTEImyOf9xBQrj8Ofpg+X7pkjQKFYsytYFOa6YQ==
X-Received: by 2002:a50:95f0:: with SMTP id x45-v6mr6897207eda.99.1530135357013;
        Wed, 27 Jun 2018 14:35:57 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-124-231.cgn.ip.fibianet.dk. [5.186.124.231])
        by smtp.gmail.com with ESMTPSA id d25-v6sm753326edp.89.2018.06.27.14.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 14:35:56 -0700 (PDT)
Subject: Re: [PATCH rdma-next 08/12] overflow.h: Add arithmetic shift helper
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Hadar Hen Zion <hadarh@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Michael J Ruhl <michael.j.ruhl@intel.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Raed Salem <raeds@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180624082353.16138-1-leon@kernel.org>
 <20180624082353.16138-9-leon@kernel.org>
 <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
 <20180625171157.GE5356@mellanox.com>
 <CAKwiHFiRYbyiJqDYCgKXKZYRr0KjCt8q9AwKwfqoCA1sT2KFyQ@mail.gmail.com>
 <20180626175435.GQ5356@mellanox.com>
 <CAKwiHFgchr+6HYOZ4e4e1vzL9cFabe6eonNNM8NTWZypazcuKA@mail.gmail.com>
 <20180627181012.GM20754@mellanox.com>
 <20180627182220.GV30877@mtr-leonro.mtl.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <118d26e6-7fe4-7001-fe90-da5090579a88@rasmusvillemoes.dk>
Date:   Wed, 27 Jun 2018 23:35:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627182220.GV30877@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-27 20:22, Leon Romanovsky wrote:
> On Wed, Jun 27, 2018 at 12:10:12PM -0600, Jason Gunthorpe wrote:
>> On Wed, Jun 27, 2018 at 11:36:03AM +0200, Rasmus Villemoes wrote:
>>>    Well, the types you can check at compile-time, the values not, so you
>>>    still have to define the result, i.e. contents of *d, for negative
>>>    values (even if we decide that "overflow" should always be signalled in
>>>    that case).
>>
>> Why do a need to define a 'result' beyond whatever the not-undefined
>> behavior shift expression produces?

Well, perhaps you don't, it's just that the other check_*_overflow have
that behaviour (which they inherit from gcc's builtins), and it's a
nice-to-have. But I see that it's hard to come up with something
sensible in all the "doesn't make sense" cases. When writing the tests
for test_overflow.c, you can of course just omit the comparison to
the/an expected result in the overflow case.

>> /*
>>  * Compute *d = (a << s)
>>  *
>>  * Returns true if '*d' cannot hold the result or 'a << s' doesn't make sense.
>>  * - 'a << s' causes bits to be lost when stored in d
>>  * - 's' is garbage (eg negative) or so large that a << s is guarenteed to be 0
>>  * - 'a' is negative
>>  * - 'a << s' sets the sign bit, if any, in '*d'
>>  * *d is not defined if false is returned.
>>  */
>> #define check_shift_overflow(a, s, d)                                          \
>> 	({                                                                     \
>> 		typeof(a) _a = a;                                              \
>> 		typeof(s) _s = s;                                              \
>> 		typeof(d) _d = d;                                              \
>> 		u64 _a_full = _a;                                              \
>> 		unsigned int _to_shift =                                       \
>> 			_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;               \
>>                                                                                \
>> 		*_d = (_a_full << _to_shift);                                  \
>>                                                                                \
>> 		(_to_shift != _s || *_d < 0 || _a < 0 ||                       \
>> 		 (*_d >> _to_shift) != a);                                     \
>> 	})

That last a still needs to be _a. Other than that, I don't see anything
wrong with this version.

>> int main(int argc, const char *argv[])
>> {
>> 	int32_t s32;
>> 	uint32_t u32;
>>
>> 	assert(check_shift_overflow(1, 0, &s32) == false && s32 == (1 << 0));
[...]>> 	assert(check_shift_overflow(0xFFFFFFFF, 1, &s32) == true);

Please add these in some form to test_overflow.c, but do also include
cases where a and *d have different width, e.g. check_shift_overflow(1,
32, &s64) should be ok, while check_shift_overflow(65432, 0, &s16)
should not.

Rasmus
