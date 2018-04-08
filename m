Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeDHRnE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 13:43:04 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:34252 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeDHRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 13:43:03 -0400
X-Google-Smtp-Source: AIpwx49C4O+b9QQA6hDlRZMwhNkvdGLMHfyjKbvBYYepYxOAf+SJWj4rjdC+ct9Zhs5G1ECChY2qmvHGjH/HTzn8ZyE=
MIME-Version: 1.0
In-Reply-To: <1523196560.6192.3.camel@btinternet.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
 <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
 <1523120055.31267.13.camel@btinternet.com> <CA+55aFxo4Z3S7qG66esSL_qxg5jwzcFgZpYR0gRpto4Z_yghTQ@mail.gmail.com>
 <162a54f1470.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com> <1523196560.6192.3.camel@btinternet.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 9 Apr 2018 01:43:01 +0800
Message-ID: <CADvbK_eFNkA5uJ36sBEFxWnWXLOPwKyvgUuTHJG96g0zxOwPLg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v4.17
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: Paul Moore <paul@paul-moore.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 10:09 PM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Sun, 2018-04-08 at 08:50 -0400, Paul Moore wrote:
>> On April 7, 2018 1:03:57 PM Linus Torvalds <torvalds@linux-foundation
>> .org> wrote:
>> On Sat, Apr 7, 2018 at 9:54 AM, Richard Haines
>> <richard_c_haines@btinternet.com> wrote:
>>
>> So please check my resolution, but also somebody should tell me
>> "Linus, you're a cretin, sctp_connect() doesn't want that
>> security_sctp_bind_connect() at all because it was already done by
>> XYZ"
>>
>> sctp_connect() or __sctp_connect() do not need to call
>> security_sctp_bind_connect(). This is because the connect(2) call
>> will
>> handle the checks required via security_socket_connect():
>>
>> Ok, thanks, that's exactly what I wanted to get.
>>
>> Anyway, somebody should still verify that it all looks good in my
>> tree, but I don't actually expect the merge to have had any issues
>> even if the refactoring made it a bit more complex than most merges
>> are.
>>
>> Thanks for the quick response Richard.
>>
>> Xin Long looked it over and gave it the thumbs up, I'll take a look
>> too, but to be honest I trust his SCTP understanding much more than
>> mine.  I also do weekly tests of each rcX release at a minimum so if
>> something odd pops up I'll make sure you get a fix.
>>
>> Thanks again everyone.
>
> I built the kernel this morning and sorry to spoil the party, but I've
> run into a problem with lksctp-tools when running the func_tests:
>
> make v6test
> ..
> ..
> ./test_timetolive_v6
> test_timetolive.c  0 INFO : Creating fillmsg of size 3087
> test_timetolive.c  1 PASS : Send a message with timeout
> test_timetolive.c  2 PASS : Send a message with no timeout
> test_timetolive.c  3 PASS : Send a fragmented message with timeout
> test_timetolive.c  0 INFO :  **  SLEEPING for 3 seconds **
> test_timetolive.c  4 BROK : Got a datamsg of unexpected length:23,
> expected length:27
> DUMP_CORE sctputil.c: 247
> /bin/sh: line 1: 30981 Segmentation fault      (core dumped) ./$a
> test_timetolive_v6 fails
>
> make v4 test fails the same way. I'm using lksctp-tools from [1]. I
> have not investigated the cause yet as just found this and thought I
> should flag first just in case someone has the answer !!!
test_timetolive(_v6) works for me, In lksctp-tools/src/func_tests, I had
another case failed,./test_1_to_1_events,  it's caused by:
commit 30f6ebf65bc46161c5aaff1db2e6e7c76aa4a06b
Author: Xin Long <lucien.xin@gmail.com>
Date:   Wed Mar 14 19:05:34 2018 +0800

    sctp: add SCTP_AUTH_NO_AUTH type for AUTHENTICATION_EVENT

It's not kernel's issue, after that commit, ./test_1_to_1_events should
have been improved. or avoid it by 'sysctl -w net.sctp.auth_enable=1'

I'm not sure why test_timetolive(_v6) is not working in your env.

>
> On the bright side, I've run the sctp-tests from [2] with no problems
> and also the selinux-testsuite with my SCTP patch from [3] using an
> updated Fedora policy from [4] (with sctp support added), all in
> enforcing mode.
>
> Also the LTP test passed:
> cd /opt/ltp/
> cat runtest/syscalls |grep connect01>runtest/connect-syscall
> ./runltp -pq -f connect-syscall
> ....
>
> [1] https://github.com/sctp/lksctp-tools
> [2] https://github.com/sctp/sctp-tests
> [3] https://marc.info/?l=selinux&m=152156947715709&w=2
> [4] https://github.com/fedora-selinux/selinux-policy
>
>
>>
>> --
>> paul moore
>> www.paul-moore.com
>>
>>
>>
