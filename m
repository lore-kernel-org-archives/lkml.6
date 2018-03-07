Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvwtgNgLmOpyEASRhCbbYOtqBHfbKTxDW1Npd7oYNPrW4fAwnIcCNVcyF6c2x3PwMJgRLZ/
ARC-Seal: i=1; a=rsa-sha256; t=1520437094; cv=none;
        d=google.com; s=arc-20160816;
        b=gEwNSAbbyhW0xWN6P3VITwn9trfqcUH8iJhjtu8Bw4J9zf1aDLoLuDE7qnXfBqaLPi
         sSQNk0SMmFwojJButosQPYm+MdiuDjFHV5rAIJg5jVPerpmkTy/rLFNeug9C4SnmMQVH
         T715TtgsW2M/qHZ37xpC0Az5jRuf7GJNBCTeg8AR7fxiav8Z8j1ZmHyQ9CtXYRpODzJw
         TPJOEqOqYLPLyedsgOesQIWglVHroPkGXSd58v+awCsbVE/oFgKTprv0pe8BEFk9sOXh
         f3Yu4DIe8Z99YtF6+2t33KLwG92DhM/Lmwa5d8GnUPBZyHscqePz4UER9SLVz6S+j5Qq
         ldCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=GukFIe+4Duk8skONSuultFsO6l0aF8oPJnsmePYm/a0=;
        b=Ta8RadFCkQQmM8ThDN+NMjp1m+rIWENNz/IBIaDNCnti31LXcbpzQHA+1jwgKO6z9I
         5SPBMjosNLtIAKNu/lh6WhdBCLA69ziEZQkwju8bgpcv+/0MkxCHbdaEuCzAF8R7BFC0
         DPYk9qiLup9py6vYXf7P9ggNMrwK0DQr/nxnLCwoU91DC5uZCqXY9iizvOlcSZTVkALy
         tLOC+d3r11j6v3c5xxje+M68JHrk7M1yNpTLppiuRsaDjiSrWcRvVZT01VStNaYsVjKx
         jJzUC+Q26pubx/pdGikO+SnY2LcM0Y2KBVt5aHweiJy6MMXSrC+1UXvw5SJHU5lSPwQa
         JF6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933833AbeCGPiO (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 7 Mar 2018 10:38:14 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:54166 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933749AbeCGPiN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Mar 2018 10:38:13 -0500
Reply-To: shuah@kernel.org
Subject: Re: [PATCH] selftests/size: rework to use main instead of _start
To: Anders Roxell <anders.roxell@linaro.org>, tbird20d@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180307130725.8267-1-anders.roxell@linaro.org>
 <613a519a-9c2b-fb11-ecb9-f3c464d0af43@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f4df30f2-7445-d937-7c36-9b16b1d0415e@kernel.org>
Date: Wed, 7 Mar 2018 08:38:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <613a519a-9c2b-fb11-ecb9-f3c464d0af43@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594284370957041073?=
X-GMAIL-MSGID: =?utf-8?q?1594293847077601399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 08:11 AM, Shuah Khan wrote:
> On 03/07/2018 06:07 AM, Anders Roxell wrote:
>> In a -ffreestanding environment without glibc, we shouldn't be able to
>> call either getenv or printf. It seems that printf() happens to work
>> fine, but it ends up using the glibc getenv(), which doesn't work unless
>> we call the glibc _start() function first.
>> Using _start() was originally meant as an optimization to reduce the
>> memory consumption of the test program itself, in order to get a more
>> accurate representation of the available RAM at system boot time.
>> However, it causes more problems than it helps, especially when run from
>> a shell script that also consumes some memory.
>>
>> get_size[2838]: segfault at ffffffffffffffd0 ip 000000000040538b
>>    sp 00007ffc41980668 error 5 in get_size[400000+b0000]
>> audit: type=1701 audit(1521532923.838:4): auid=0 uid=0 gid=0 ses=2
>>    subj=kernel pid=2838 comm=\"get_size\"
>>    exe=\"/opt/kselftests/next/size/get_size\" sig=11 res=1
>> get_size[2840]: segfault at ffffffffffffffd0 ip 000000000040538b
>>    sp 00007ffdace9b378 error 5 in get_size[400000+b0000]
>> audit: type=1701 audit(1521532932.057:5): auid=0 uid=0 gid=0 ses=2
>>    subj=kernel pid=2840 comm=\"get_size\"
>>    exe=\"/opt/kselftests/next/size/get_size\" sig=11 res=1
>>
>> Rework to get_size test to use main (and printf) instead of _start. All
>> other seftest tests uses main and not _start.
>>
>> Fixes: 0081901af95f ("selftests: size call ksft_print_header() to print TAP header")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Andres,
> 
> Thanks for finding and reporting the problem. This patch is in linux-kselftest next
> for 4.17-rc1. I would rather revert the patch than fix it a this time.
> 
> I knew there was a reason why Tim didn't use printf() in the first, I couldn't
> remember. I won't be sending
> 
> 0081901af95f ("selftests: size call ksft_print_header() to print TAP header")
> 
> for inclusion into 4.17-rc1
> 

Okay. Dropped the problem patch
0081901af95f ("selftests: size call ksft_print_header() to print TAP header")

from linux-kselftest next.

thanks again for finding the problem so quickly.
-- Shuah

