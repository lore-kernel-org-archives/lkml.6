Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50781C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F08F218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548443519;
	bh=jytltsqdKFJ6gX+xv2KY9bztv4rQoHN77Jz0ySH86DE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=REd62n3cl8kOCgEIK2l9anr9yvtazRIFMDhnDjfxO3tiD+sJASyVjv2JVXKgbaVAq
	 GwlRJ0QR8YHCgDtpU8fK2p5Mos4KZo+TIERoHiLlsuEVf5aOpsHXGrL6zKzCQaVndz
	 zep/A0VgyLh6u7eEG/qe+Grrsv8veQ5JI7PZtNbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAYTL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfAYTL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:11:56 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2CA218B0;
        Fri, 25 Jan 2019 19:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548443515;
        bh=jytltsqdKFJ6gX+xv2KY9bztv4rQoHN77Jz0ySH86DE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=adVkPqxd7A/XX7P0u85sRlPnZMcObujpONUpOxkmOhillbOAKX5tVt4J8j0F6ImtY
         9upfKUNzGD2sC5zjUOOAYErtE/C3MQXpuQgWEzqXoqhGw43sSsg0H3lT5BmOoQ3rOK
         a7IpaxBhlFNfwLkMGZiSSJfFtN5fOsQLTa8+3uGU=
Subject: Re: [PATCH] selftests/seccomp: Enhance per-arch ptrace syscall skip
 tests
To:     Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20190125183359.GA8524@beast>
 <b4d7a57b-349b-d095-2f5e-3beef86cd2c0@canonical.com>
 <CAGXu5jLUixGHcU3fZe2e8H53QbvEuSNmHyjMZXnrjP26dSWMoA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <bf579b2d-9515-ea5b-d2a5-4f148964eca2@kernel.org>
Date:   Fri, 25 Jan 2019 12:11:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLUixGHcU3fZe2e8H53QbvEuSNmHyjMZXnrjP26dSWMoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/19 11:46 AM, Kees Cook wrote:
> On Sat, Jan 26, 2019 at 7:42 AM Colin Ian King <colin.king@canonical.com> wrote:
>>
>> On 25/01/2019 18:33, Kees Cook wrote:
>>> Passing EPERM during syscall skipping was confusing since the test wasn't
>>> actually exercising the errno evaluation -- it was just passing a literal
>>> "1" (EPERM). Instead, expand the tests to check both direct value returns
>>> (positive, 45000 in this case), and errno values (negative, -ESRCH in this
>>> case) to check both fake success and fake failure during syscall skipping.
>>>
>>> Reported-by: Colin Ian King <colin.king@canonical.com>
>>> Fixes: a33b2d0359a0 ("selftests/seccomp: Add tests for basic ptrace actions")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> Colin, does this end up working on s390? Based on your bug report, I
>>> suspect the positive value tests will fail, but the errno tests will
>>> pass. If that's true, I think something is wrong in the s390 handling.
>>> (And it may just be that the ptrace code to rewrite syscalls on s390
>>> in the test is wrong...) But splitting these tests up should tell us more.
>>> ---
>>>   tools/testing/selftests/seccomp/seccomp_bpf.c | 72 +++++++++++++++----
>>>   1 file changed, 57 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
>>> index 496a9a8c773a..7e632b465ab4 100644
>>> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
>>> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
>>> @@ -1608,7 +1608,16 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>>>   #ifdef SYSCALL_NUM_RET_SHARE_REG
>>>   # define EXPECT_SYSCALL_RETURN(val, action)  EXPECT_EQ(-1, action)
>>>   #else
>>> -# define EXPECT_SYSCALL_RETURN(val, action)  EXPECT_EQ(val, action)
>>> +# define EXPECT_SYSCALL_RETURN(val, action)          \
>>> +     do {                                            \
>>> +             errno = 0;                              \
>>> +             if (val < 0) {                          \
>>> +                     EXPECT_EQ(-1, action);          \
>>> +                     EXPECT_EQ(-(val), errno);       \
>>> +             } else {                                \
>>> +                     EXPECT_EQ(val, action);         \
>>> +             }                                       \
>>> +     } while (0)
>>>   #endif
>>>
>>>   /* Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
>>> @@ -1647,7 +1656,7 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
>>>
>>>   /* Architecture-specific syscall changing routine. */
>>>   void change_syscall(struct __test_metadata *_metadata,
>>> -                 pid_t tracee, int syscall)
>>> +                 pid_t tracee, int syscall, int result)
>>>   {
>>>        int ret;
>>>        ARCH_REGS regs;
>>> @@ -1706,7 +1715,7 @@ void change_syscall(struct __test_metadata *_metadata,
>>>   #ifdef SYSCALL_NUM_RET_SHARE_REG
>>>                TH_LOG("Can't modify syscall return on this architecture");
>>>   #else
>>> -             regs.SYSCALL_RET = EPERM;
>>> +             regs.SYSCALL_RET = result;
>>>   #endif
>>>
>>>   #ifdef HAVE_GETREGS
>>> @@ -1734,14 +1743,19 @@ void tracer_syscall(struct __test_metadata *_metadata, pid_t tracee,
>>>        case 0x1002:
>>>                /* change getpid to getppid. */
>>>                EXPECT_EQ(__NR_getpid, get_syscall(_metadata, tracee));
>>> -             change_syscall(_metadata, tracee, __NR_getppid);
>>> +             change_syscall(_metadata, tracee, __NR_getppid, 0);
>>>                break;
>>>        case 0x1003:
>>> -             /* skip gettid. */
>>> +             /* skip gettid with valid return code. */
>>>                EXPECT_EQ(__NR_gettid, get_syscall(_metadata, tracee));
>>> -             change_syscall(_metadata, tracee, -1);
>>> +             change_syscall(_metadata, tracee, -1, 45000);
>>>                break;
>>>        case 0x1004:
>>> +             /* skip openat with error. */
>>> +             EXPECT_EQ(__NR_openat, get_syscall(_metadata, tracee));
>>> +             change_syscall(_metadata, tracee, -1, -ESRCH);
>>> +             break;
>>> +     case 0x1005:
>>>                /* do nothing (allow getppid) */
>>>                EXPECT_EQ(__NR_getppid, get_syscall(_metadata, tracee));
>>>                break;
>>> @@ -1774,9 +1788,11 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>>>        nr = get_syscall(_metadata, tracee);
>>>
>>>        if (nr == __NR_getpid)
>>> -             change_syscall(_metadata, tracee, __NR_getppid);
>>> +             change_syscall(_metadata, tracee, __NR_getppid, 0);
>>> +     if (nr == __NR_gettid)
>>> +             change_syscall(_metadata, tracee, -1, 45000);
>>>        if (nr == __NR_openat)
>>> -             change_syscall(_metadata, tracee, -1);
>>> +             change_syscall(_metadata, tracee, -1, -ESRCH);
>>>   }
>>>
>>>   FIXTURE_DATA(TRACE_syscall) {
>>> @@ -1793,8 +1809,10 @@ FIXTURE_SETUP(TRACE_syscall)
>>>                BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1002),
>>>                BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_gettid, 0, 1),
>>>                BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1003),
>>> -             BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
>>> +             BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_openat, 0, 1),
>>>                BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1004),
>>> +             BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
>>> +             BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1005),
>>>                BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
>>>        };
>>>
>>> @@ -1842,15 +1860,26 @@ TEST_F(TRACE_syscall, ptrace_syscall_redirected)
>>>        EXPECT_NE(self->mypid, syscall(__NR_getpid));
>>>   }
>>>
>>> -TEST_F(TRACE_syscall, ptrace_syscall_dropped)
>>> +TEST_F(TRACE_syscall, ptrace_syscall_errno)
>>> +{
>>> +     /* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
>>> +     teardown_trace_fixture(_metadata, self->tracer);
>>> +     self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
>>> +                                        true);
>>> +
>>> +     /* Tracer should skip the open syscall, resulting in ESRCH. */
>>> +     EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
>>> +}
>>> +
>>> +TEST_F(TRACE_syscall, ptrace_syscall_faked)
>>>   {
>>>        /* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
>>>        teardown_trace_fixture(_metadata, self->tracer);
>>>        self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
>>>                                           true);
>>>
>>> -     /* Tracer should skip the open syscall, resulting in EPERM. */
>>> -     EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_openat));
>>> +     /* Tracer should skip the gettid syscall, resulting fake pid. */
>>> +     EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
>>>   }
>>>
>>>   TEST_F(TRACE_syscall, syscall_allowed)
>>> @@ -1883,7 +1912,21 @@ TEST_F(TRACE_syscall, syscall_redirected)
>>>        EXPECT_NE(self->mypid, syscall(__NR_getpid));
>>>   }
>>>
>>> -TEST_F(TRACE_syscall, syscall_dropped)
>>> +TEST_F(TRACE_syscall, syscall_errno)
>>> +{
>>> +     long ret;
>>> +
>>> +     ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>>> +     ASSERT_EQ(0, ret);
>>> +
>>> +     ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
>>> +     ASSERT_EQ(0, ret);
>>> +
>>> +     /* openat has been skipped and an errno return. */
>>> +     EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
>>> +}
>>> +
>>> +TEST_F(TRACE_syscall, syscall_faked)
>>>   {
>>>        long ret;
>>>
>>> @@ -1894,8 +1937,7 @@ TEST_F(TRACE_syscall, syscall_dropped)
>>>        ASSERT_EQ(0, ret);
>>>
>>>        /* gettid has been skipped and an altered return value stored. */
>>> -     EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_gettid));
>>> -     EXPECT_NE(self->mytid, syscall(__NR_gettid));
>>> +     EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
>>>   }
>>>
>>>   TEST_F(TRACE_syscall, skip_after_RET_TRACE)
>>>
>> Works perfectly. Thanks Kees.
>>
>> Tested-by: Colin Ian King <colin.king@canonical.com>
> 
> Oh excellent! Thanks. :) Shuah can you queue this up?
> 

Yup will do - I am planning to apply bunch of fixes this afternoon.
Hoping to get them into rc5

thanks,
-- Shuah
