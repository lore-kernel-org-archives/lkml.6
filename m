Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3DD23C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DF1208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DF1208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755379AbeFNQCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:02:36 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:51210 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755069AbeFNQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:02:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id B444AC0B0C;
        Thu, 14 Jun 2018 16:02:33 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H7ler5TaCIXZ; Thu, 14 Jun 2018 16:02:33 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 68E9CC0683;
        Thu, 14 Jun 2018 16:02:24 +0000 (UTC)
Subject: Re: [PATCH] selftests: kselftest_harness: return Kselftest Skip code
 for skipped tests
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20180614013445.6120-1-shuah@kernel.org>
 <CAGXu5jLXAQxo7mUJThXCOMPEC3yvGU5_wLqjU_YKGtd6sFfuUw@mail.gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <dd086a7d-36fe-b6f5-3257-c30898cc8a34@kernel.org>
Date:   Thu, 14 Jun 2018 10:02:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLXAQxo7mUJThXCOMPEC3yvGU5_wLqjU_YKGtd6sFfuUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 10:06 PM, Kees Cook wrote:
> On Wed, Jun 13, 2018 at 6:34 PM, Shuah Khan (Samsung OSG)
> <shuah@kernel.org> wrote:
>> When a test is skipped because of unmet dependencies and/or unsupported
>> configuration, kselftest_harness exits with error which is treated as a
>> fail by the Kselftest framework. This leads to false negative result even
>> when the test could not be run.
>>
>> Change it to return kselftest skip code when a test gets skipped to
>> clearly report that the test could not be run. This change add skip
>> handling to kselftest_harness with minimal changes adding a new skipped
>> field to struct __test_metadata and using it to recognize KSFT_SKIP exit
>> from the test function (t->fn) to __run_test() to the test_harness_run()
>> to return the right skip code to Kselftest framework.
>>
>> Kselftest framework SKIP code is 4 and the framework prints appropriate
>> messages to indicate that the test is skipped.
> 
> Unfortunately this will not work: test step # is used as the failure
> code to let test runners know where a child failed. KSFT_SKIP is 4, so
> every test failing in step 4 would be seen as a skip instead of a
> fail.
> 

Yeah. That is correct. __bail() does exit with step which could be step #4

> Tests must not exit on their own with this harness: only the existing
> ASSERT/EXPECT macros can be used. uevent test should never be doing
> this:
> 
>         if (geteuid()) {
>                 TH_LOG("Uevent filtering tests require root
> privileges. Skipping test");
>                 _exit(KSFT_SKIP);
>         }
> 
> Nor the _exit(EXIT_FAILURE) calls. Those must all be ASSERT() instead.

It did look like an improper use of the harness by this test. Okay that
makes sense.

> 
> Perhaps a new signal could be used, but the return codes are already being used.
> 

A a new harness hook for KSFT_SKIP case so tests can call that explicitly would
solve the problem once the problem of conflict with step #4.

Since he harness step metadata doesn't have special meaning than keeping track of
how far test ran, harness could be changed to treat step #4 as a special value and
not use it for step to solve the conflict between ksft and kselftest_harness.

thanks,
-- Shuah






