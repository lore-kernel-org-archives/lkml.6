Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B45C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C215208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhNBvjx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C215208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeK2Hw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:52:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeK2Hw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:52:59 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01FBC20832;
        Wed, 28 Nov 2018 20:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543438203;
        bh=kMR29eF5WCE2KzsX5DX3Uj+WdaPC90IxY947g5YyhYw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FhNBvjx9wViVfwfydq9/dAgxHMAJSFwa/NVrJpw+0DayFDi+v2rskybDoGiEwFosL
         yWHJ0IGowrec1GBPuq3Ox1oQrd3bdxR6XzvykpfDTYUf5nV/UMbABFCu+lY2RH9wfT
         TJZGMt2u2HAh3R2d7reZ32k9kNHWk24m4TLBnMT4=
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Knut Omang <knut.omang@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        brakmo@fb.com, richard@nod.at, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, mpe@ellerman.id.au, Tim.Bird@sony.com,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rostedt@goodmis.org, kieran.bingham@ideasonboard.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        Joel Stanley <joel@jms.id.au>, linux-kselftest@vger.kernel.org,
        khilman@baylibre.com, joe@perches.com, dan.j.williams@intel.com,
        jdike@addtoit.com, kunit-dev@googlegroups.com,
        hidenori.yamaji@sony.com, alan.maguire@oracle.com, shuah@kernel.org
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <1543036529.4680.655.camel@oracle.com>
 <CAFd5g45oPSp870hJLDSHiMfU7Mh-EvpYcFdAaOQxecXNde5PSw@mail.gmail.com>
 <1543434888.4680.862.camel@oracle.com>
From:   shuah <shuah@kernel.org>
Message-ID: <abf3aff0-dfb3-717e-f14f-02dbe5574f49@kernel.org>
Date:   Wed, 28 Nov 2018 13:50:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543434888.4680.862.camel@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/18 12:54 PM, Knut Omang wrote:
> On Mon, 2018-11-26 at 17:41 -0800, Brendan Higgins wrote:
>> On Fri, Nov 23, 2018 at 9:15 PM Knut Omang <knut.omang@oracle.com> wrote:
>>>
>>> On Tue, 2018-10-23 at 16:57 -0700, Brendan Higgins wrote:
>> <snip>
>>>
>>> Brendan, I regret you weren't at this year's testing and fuzzing workshop at
>>> LPC last week so we could have continued our discussions from last year there!
>>
>> Likewise! Unfortunately, I could not make it. So it goes.
>>
>>>
>>> I hope we can work on this for a while longer before anything gets merged.
>>> Maybe it can be topic for a longer session in a future test related workshop?
>>
>> I don't see why we cannot just discuss it here as we are already
>> doing.
> 
> Yes, as long as we are not wasting all the Cc:'ed people's valuable time.
> 
>> Besides, you are mostly interested in out of tree testing,
>> right? I don't see how this precludes anything that you are trying to
>> do with KTF.
> 
> Both approaches provide assertion macros for running tests inside the kernel,
> I doubt the kernel community would like to see yet two such sets of macros,
> with differing syntax merged. One of the good reasons to have a *framework*
> is that it is widely used and understood, so that people coming from one part of the
> kernel can easily run, understand and relate to selected tests from another part.
> 
> The goal with KTF is to allow this for any kernel, old or new, not just kernels
> built specifically for testing purposes. We felt that providing it as a separate git
> module (still open source, for anyone to contribute to) is a more efficient approach
> until we have more examples and experience with using it in different parts
> of the kernel. We can definitely post the kernel side of KTF as a patch series fairly soon
> if the community wants us to. Except for hybrid tests, the ktf.ko module works fine
> independently of any user side support, just using the debugfs interface to run and
> examine tests.
> 

Having test framework in the kernel sources tree has benefits. It allows
us (kernel developers) to do co-development of kernel features and tests
for these features.

It encourages developers to write regression tests. More importantly,
kernel features and tests for these features are included in the same
release in most cases and/or allows us freedom to do so if test 
framework and tests are part of the kernel sources.

We have seen this with our experience with kselftest. It would not have
see the same level of attention and growth if it stayed outside the
kernel sources.

Most kernel developers would not want to include a externally maintained
module for testing. As a general rule, it has to be easy to run tests.

> I think there are good uses cases for having the ability to maintain a
> single source for tests that can be run against multiple kernels,
> also distro kernels that the test framework cannot expect to be able to modify,
> except from using the module interfaces.

Same reasons as above. Having the tests included in the kernel sources
makes it easier for distros to run those tests and include running them
during their qualification.

> 
> And there are good arguments for having (at least parts of)
> the test framework easily available within the kernel under test.
> 

When Kernel unit, functional, and regressions tests reside in the kernel
sources, they evolve quicker as kernel developers contribute tests as
part of their kernel work-flow. Maintaining tests and framework
separately will make it harder to maintain them and keep them updated
for us the kernel community.

thanks,
-- Shuah
