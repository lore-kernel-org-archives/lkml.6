Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C21820874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545072171;
	bh=gzqs6JBKwSOGMO8JIn1W7gPySqQTM3E2rzkOHDbpBVY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=f+jvtvpY+alKJcBmUcHZ+8UQbpWLqHcolCWp2s+bYfiZUlFOgEUK4hhXSrC0e5hjF
	 d3b65zAfydgsV/FCfMKTlTCwIJRQh6Axsu21UOH7VhuZ9jSkwSfhqddV7hVTkV7gBS
	 pRpZF5hnha7ySLSjmDUwu1m/RpvAAIdxLbVIb/io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389137AbeLQSmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbeLQSmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:42:49 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461DA20874;
        Mon, 17 Dec 2018 18:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545072168;
        bh=gzqs6JBKwSOGMO8JIn1W7gPySqQTM3E2rzkOHDbpBVY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1zYfLEgyKITYXanJmjzsi8W1Px1RZaeYEz8KzcdzIQVJl3KQlWZSACIvJ+H7KwsqE
         Hh5fz0m2wq9I5oZos8CFtQCLxxGxLAOFICcQXzxyEK/kwtRatpKIrKSIwBz+2Q57U+
         IEeXGXWMCulVwXzq8XINlIeKi/d1SZTG1CgW0DlA=
Subject: Re: selftests/net: udpgso: LTS kernels supportability ?
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        shuah <shuah@kernel.org>
References: <bbabafb5-e16c-4025-31d0-d9e5feb5f39a@linaro.org>
From:   shuah <shuah@kernel.org>
Message-ID: <1d2c9a10-6caf-49ff-b921-8b93dbe96f78@kernel.org>
Date:   Mon, 17 Dec 2018 11:42:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bbabafb5-e16c-4025-31d0-d9e5feb5f39a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 12/17/18 10:53 AM, Rafael David Tinoco wrote:
> Shuah,
> 
> I was recently investigating some errors coming out of our functional
> tests and we, Dan and I, came up with a discussion that might not be new
> for you, but, interests us, in defining how to better use kselftests as
> a regression mechanism/tool in our LKFT (https://lkft.linaro.org).
> 
> David / Willem,
> 
> I'm only using udpgso as an example for what I'd like to ask Shuah. Feel
> free to jump in in the discussion if you think its worth.
> 
> All,
> 
> Regarding: udpgso AND https://bugs.linaro.org/show_bug.cgi?id=3980
> 
> udpgso tests are failing in kernels bellow 4.18 because of 2 main reasons:
> 
> 1) udp4_ufo_fragment does not seem to demand the GSO SKB to be > than
> the MTU for older kernels (4th test case in udpgso.c).
> 
> 2) setsockopt(...UDP_SEGMENT) support is not present for older kernels.
> (commits "udp: generate gso with UDP_SEGMENT" and its fixes seem to be
> needed).

This case is easy right? Based on the test output below , I can see that 
the failure is due to

./udpgso: setsockopt udp segment: Protocol not available. setsockopt() 
is returning an error to clearly indicate that this options isn't 
supported. This will be a test change to say test is a skip as opposed 
to fail.

We have a solution for this - test should SKIP as opposed to FAIL.

> With that explained, finally the question/discussion:
> 
> Shouldn't we enforce a versioning mechanism for tests that are testing
> recently added features ? I mean, some of the tests inside udpgso
> selftest are good enough for older kernels...

Right - we do have generic way to handle that by detecting if feature is 
supported and skip instead of using Kernel version which is going to be 
hard to maintain.

> 
> But, because we have no control over "kernel features" and "supported
> test cases", we, Linaro, have to end up blacklisting all selftests that
> have new feature oriented tests, because one or two test cases only.
> 
> This has already been solved in other functional tests projects:
> allowing to check the running kernel version and deciding which test
> cases to run.
> 

I would like to see effort going into fixing tests to skip when a 
feature isn't supported. I think that is the solution that will be 
maintainable in the long run.

> Would that be something we should pursue ? (We could try to make patches
> here and there, like this case, whenever we face this). Or... should we
> stick with mainline/next only when talking about kselftest and forget
> about LTS kernels ?
> 

There is a middle of the road solution to run Kselftest from the same 
kernel release on LTS kernels and report the results as it is turning 
out be adding overhead in interpreting results when mainline/next 
Kselftest are run on LTS.

Kselftest mainline/next tends to be in a state where there could be bugs 
in tests like the one you are finding in the example you used to 
describe the problem. As we find them we fix them. That is just the 
nature of mainline/next

Maybe for LTS kernels it is better for you to stay with Kselftest from 
the same release or close to it. For example, running 4.20 Kselftest on 
4.4 is going to result in more skips/(false fails) than running 4.4 
Kselftest on 4.4 even though it might provide better coverage. It is a 
judgment call on the overhead vs. advantage running newer Kselftest from 
mainline/next on LTS.

I don't think versioning (skip or release based) can fully address the 
problem you are seeing considering the fluid nature of mainline/next.

thanks,
-- Shuah
