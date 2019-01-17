Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF5DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246772077B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547683296;
	bh=12iZsJ8d4diKOX55TEYDIzvnGkyDJq8kbSXEYhi2wWQ=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=IkULtLTy9TgRlw/Uic4TwSsryh2B9iY9FO3WKrvCcs/Uzz7Z+DrNvRhtRxWIO1jN1
	 XEIo12CTe290sVItYH4fhj1YJd87BX77zEeIhtf01IEOyfrIye0v33kR7USs/LhnsC
	 VmXcelhWtP35NiI6BRQBS065eR7XnQGG2qpOvx6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfAQABe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfAQABe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:01:34 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D50D62077B;
        Thu, 17 Jan 2019 00:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547683293;
        bh=12iZsJ8d4diKOX55TEYDIzvnGkyDJq8kbSXEYhi2wWQ=;
        h=To:Cc:From:Subject:Date:From;
        b=ajDS3Of2lIaNvobuXkSpPSNj9w/c4i90U1wKh4UcHuKAvXhhkwhauXlWkQdBvi+NG
         GN8AScZDqXNinX8GPHx3Gn7feiXmmerjMUmtb7wIXWttp98MY4aGNtzR7UyVZNPjZZ
         sHH4JtcQEBTP04KYd6uJYP368d1T58b+HDaodwsE=
To:     Kees Cook <keescook@chromium.org>, jmorris@namei.org
Cc:     torvalds@linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
From:   shuah <shuah@kernel.org>
Subject: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
Message-ID: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
Date:   Wed, 16 Jan 2019 17:01:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees and James,

seccomp_bpf test hangs right after the following test passes
with EBUSY. Please see log at the end.

/* Installing a second listener in the chain should EBUSY */
         EXPECT_EQ(user_trap_syscall(__NR_getpid,
                                     SECCOMP_FILTER_FLAG_NEW_LISTENER),
                   -1);
         EXPECT_EQ(errno, EBUSY);


The user_notification_basic test starts running I assume and then
the hang.

The only commit I see that could be suspect is the following as
it talks about adding SECCOMP_RET_USER_NOTIF

commit d9a7fa67b4bfe6ce93ee9aab23ae2e7ca0763e84
Merge: f218a29c25ad 55b8cbe470d1
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jan 2 09:48:13 2019 -0800

     Merge branch 'next-seccomp' of 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security

     Pull seccomp updates from James Morris:

      - Add SECCOMP_RET_USER_NOTIF

      - seccomp fixes for sparse warnings and s390 build (Tycho)

     * 'next-seccomp' of 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security:
       seccomp, s390: fix build for syscall type change
       seccomp: fix poor type promotion
       samples: add an example of seccomp user trap
       seccomp: add a return code to trap to userspace
       seccomp: switch system call argument type to void *
       seccomp: hoist struct seccomp_data recalculation higher


Any ideas on how to proceed? Here is the log. The following
reproduces the problem.

make -C tools/testing/selftests/seccomp/ run_tests


seccomp_bpf.c:2947:global.get_metadata:Expected 0 (0) == 
seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_LOG, &prog) 
(18446744073709551615)
seccomp_bpf.c:2959:global.get_metadata:Expected 1 (1) == read(pipefd[0], 
&buf, 1) (0)
global.get_metadata: Test terminated by assertion
[     FAIL ] global.get_metadata
[ RUN      ] global.user_notification_basic
seccomp_bpf.c:3036:global.user_notification_basic:Expected 0 (0) == 
WEXITSTATUS(status) (1)
seccomp_bpf.c:3039:global.user_notification_basic:Expected 
seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
seccomp_bpf.c:3040:global.user_notification_basic:Expected 
seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
seccomp_bpf.c:3041:global.user_notification_basic:Expected 
seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
seccomp_bpf.c:3042:global.user_notification_basic:Expected 
seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
seccomp_bpf.c:3047:global.user_notification_basic:Expected listener 
(18446744073709551615) >= 0 (0)
seccomp_bpf.c:3053:global.user_notification_basic:Expected errno (13) == 
EBUSY (16)

thanks,
-- Shuah
