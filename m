Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 92CAFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A0A208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A0A208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964945AbeFNUm5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:42:57 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:36656 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964883AbeFNUmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:42:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id AC986C0D4D;
        Thu, 14 Jun 2018 20:42:53 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rASmbJQZl28v; Thu, 14 Jun 2018 20:42:53 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 6C8F3C0669;
        Thu, 14 Jun 2018 20:42:44 +0000 (UTC)
Subject: Re: Improving kselfests cross compilation
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        bamvor.zhangjian@linaro.org, Shuah Khan <shuah@kernel.org>
References: <19ec8c01-15a0-eca2-cf6c-08c71b670dab@gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <4dd5e859-4d76-0c44-3ca1-1629de9cdc81@kernel.org>
Date:   Thu, 14 Jun 2018 14:42:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <19ec8c01-15a0-eca2-cf6c-08c71b670dab@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 06/13/2018 09:39 PM, Florian Fainelli wrote:
> Hi Shuah,
> 
> I was giving a shot at building the kselftests from within buildroot [1]
> as of Linux be779f03d563981c65cc7417cc5e0dbbc5b89d30 and there are a
> number of things that make it still reasonably hard even today:
> 
> - 3c545084130c1fd5cf873a5fec3ee29070128e06 ("selftests: sparc64: char:
> Selftest for privileged ADI driver") this contains inline assembly that
> can only work when building for sparc64, yet this is still being built
> irrespective of what ARCH is set to

I fixed this problem and sent in a patch couple of days ago.

> 
> - each Makefile that requires knowledge of the architecture seems to
> duplicate what ARCH should be, this cannot be moved to lib.mk since
> Makefiles do expect lib.mk to be included last and/or after they have
> done their own overrides, but something like common.mk which contains
> CC, ARCH etc. could be useful to avoid the repetition of looking at
> uname -m etc. etc.
> 

I think this is a good idea. Is this something you would like to work
on?

> - some tests' Makefile do seem to hardcode paths to the system's include
> instead of accepting a configurable path:
> 
> gpio/Makefile:
> 
> LDLIBS += -lmount -I/usr/include/libmount

gpio test has been a problem from the beginning. It has dependency
on objects that get built in tools/gpio

I think it is mistake on my part to accept this test in the first
place. It is on my todo list to address the problem (not sure how),
but I don't like the dependency. If you want to take a look at the
best way to address, please do.

> 
> I will try to submit patches in the next days that address the most
> obvious issues I listed here

Thanks. I did lot of cleanup on the sparc64 test, you can find them all
at https://patchwork.kernel.org/project/linux-kselftest/list/

but in order for this effort not to be a
> constant whack-a-mole game, there really needs to be at least one or two
> architectures that must attempt to cross-compile (and run) those tests
> and use that as an acceptance criteria.
> 

These problem usually surface in linux-next and get fixed. However since
selftest patches go through other trees (x86, mm, net, bpf) in addition
to kselftest tree, it would be difficult to unless all the maintainers
agree to the acceptance criteria. I try to review the tests from selftest
framework compatibility, however in some cases, patches get pulled in even
before I get a chance to review and I miss things like sparc64 arch handling
So there are some pain points, however, I don't think we can avoid problems all
together with the number of tests that are getting added on a regular basis.

I do think soaking in linux-next is the best way to go.

The example of sparc64 test you mentioned is a new test. I am surprised that
we didn't find this problem in linux-next early on. I found it in my routine
testing I do during the merge window.

David! Did this patch end up in linux-next? I am not sure how net patch flow?

thanks,
-- Shuah

