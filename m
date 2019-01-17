Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911E2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0F520675
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547688409;
	bh=RyPanycLaJ/RXEO3osGmkdwvnpLCMMfE4OANJIcg9kg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=VnttkXeIWajI1AWbZA8yCizTYaHHY4uMr22I7y+liTyAs0GTm7o4M2poB/8s+Cfth
	 PopVTUc4tUHs8PV1Xhxiqedsjepo2Kd8ft5HHlEwFMWIiYbH05aMHnEWN6CC9U3m7+
	 +TouWfto5LQcRIMSMOKIT8kz8YxLAq7H07yjIGe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfAQB0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:26:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfAQB0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:26:46 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13D4205C9;
        Thu, 17 Jan 2019 01:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547688405;
        bh=RyPanycLaJ/RXEO3osGmkdwvnpLCMMfE4OANJIcg9kg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qG8a/J+IIjsUwpVszcz2XA+iVNT7ORfOGWQLAuSdL8NSlS/ZkDlZ5SFOIWewlkEXZ
         Jn7ou2sXUqUXsOkL3d2qxPEoUXHxH3q7w0L4BkXuc/KGULOUHrNAPXWNjH4OguvBr0
         MA90uMWTGVLoz8awx6EZTZ1KBERK3bZCuDkKaPlk=
Subject: Re: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
To:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
 <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
 <20190117004416.GA17449@cisco>
From:   shuah <shuah@kernel.org>
Message-ID: <f665bb74-293b-d627-2605-5b8de7671743@kernel.org>
Date:   Wed, 16 Jan 2019 18:26:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117004416.GA17449@cisco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 5:44 PM, Tycho Andersen wrote:
> On Wed, Jan 16, 2019 at 04:30:26PM -0800, Kees Cook wrote:
>> On Wed, Jan 16, 2019 at 4:01 PM shuah <shuah@kernel.org> wrote:
>>>
>>> Hi Kees and James,
>>>
>>> seccomp_bpf test hangs right after the following test passes
>>> with EBUSY. Please see log at the end.
>>>
>>> /* Installing a second listener in the chain should EBUSY */
>>>           EXPECT_EQ(user_trap_syscall(__NR_getpid,
>>>                                       SECCOMP_FILTER_FLAG_NEW_LISTENER),
>>>                     -1);
>>>           EXPECT_EQ(errno, EBUSY);
>>>
>>>
>>> The user_notification_basic test starts running I assume and then
>>> the hang.
>>>
>>> The only commit I see that could be suspect is the following as
>>> it talks about adding SECCOMP_RET_USER_NOTIF
>>>
>>> commit d9a7fa67b4bfe6ce93ee9aab23ae2e7ca0763e84
>>> Merge: f218a29c25ad 55b8cbe470d1
>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>> Date:   Wed Jan 2 09:48:13 2019 -0800
>>>
>>>       Merge branch 'next-seccomp' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
>>>
>>>       Pull seccomp updates from James Morris:
>>>
>>>        - Add SECCOMP_RET_USER_NOTIF
>>>
>>>        - seccomp fixes for sparse warnings and s390 build (Tycho)
>>>
>>>       * 'next-seccomp' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security:
>>>         seccomp, s390: fix build for syscall type change
>>>         seccomp: fix poor type promotion
>>>         samples: add an example of seccomp user trap
>>>         seccomp: add a return code to trap to userspace
>>>         seccomp: switch system call argument type to void *
>>>         seccomp: hoist struct seccomp_data recalculation higher
>>>
>>>
>>> Any ideas on how to proceed? Here is the log. The following
>>> reproduces the problem.
>>>
>>> make -C tools/testing/selftests/seccomp/ run_tests
>>>
>>>
>>> seccomp_bpf.c:2947:global.get_metadata:Expected 0 (0) ==
>>> seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_LOG, &prog)
>>> (18446744073709551615)
>>> seccomp_bpf.c:2959:global.get_metadata:Expected 1 (1) == read(pipefd[0],
>>> &buf, 1) (0)
>>> global.get_metadata: Test terminated by assertion
>>> [     FAIL ] global.get_metadata
>>> [ RUN      ] global.user_notification_basic
>>> seccomp_bpf.c:3036:global.user_notification_basic:Expected 0 (0) ==
>>> WEXITSTATUS(status) (1)
>>> seccomp_bpf.c:3039:global.user_notification_basic:Expected
>>> seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
>>> seccomp_bpf.c:3040:global.user_notification_basic:Expected
>>> seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
>>> seccomp_bpf.c:3041:global.user_notification_basic:Expected
>>> seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
>>> seccomp_bpf.c:3042:global.user_notification_basic:Expected
>>> seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
>>> seccomp_bpf.c:3047:global.user_notification_basic:Expected listener
>>> (18446744073709551615) >= 0 (0)
>>> seccomp_bpf.c:3053:global.user_notification_basic:Expected errno (13) ==
>>> EBUSY (16)
>>
>> Looks like the test is unfriendly when running the current selftest on
>> an old kernel version. A quick look seems like it's missing some
>> ASSERT_* cases where EXPECT_* is used. I'll send a patch.
> 
> ASSERT will kill the test case though right? I thought we were
> supposed to use EXPECT when we wanted it to keep going. In particular,
> it looks like in the get_metadata test, we should be using expect
> instead of assert in some places, so we can get to the write() that
> does the synchronization. Something like,
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 067cb4607d6c..4d2508af2483 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -2943,11 +2943,11 @@ TEST(get_metadata)
>   		};
>   
>   		/* one with log, one without */
> -		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
> +		EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
>   				     SECCOMP_FILTER_FLAG_LOG, &prog));
> -		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
> +		EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
>   
> -		ASSERT_EQ(0, close(pipefd[0]));
> +		EXPECT_EQ(0, close(pipefd[0]));
>   		ASSERT_EQ(1, write(pipefd[1], "1", 1));
>   		ASSERT_EQ(0, close(pipefd[1]));
>   
> 
> But also, is running new tests on an old kernel expected to work? I
> didn't know that :).
> 

I am running Linux 5.0-rc2 and not an older kernel.

thanks,
-- Shuah

