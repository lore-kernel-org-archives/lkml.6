Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFBE20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="kKE1s0ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfAQAoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:44:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34613 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfAQAoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:44:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so3608458pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1D3OP4IqORalDdb/H3lnJUZksLU+2GGCWtkQNI3T7/4=;
        b=kKE1s0NDRsu+0TJh7MX1RN7Ye60/B4nylirptvErW1Y/UlJ5VJvJIRcMFD/8e9xRr+
         Kg1u31A6Z4941JPsHpOzMy18yqiTqsYDDKGjD9Y54nnolj1giQavU1hAfzXNaHvKHn9C
         U7mLcAqftQSauqflh5yb/lywn7fULdjeY1cSG3azSpKG8vABOfQpDnL9VEYKNXw6eAVQ
         QDc63yOSG2PHunxHcXxj+74qKc+iROzlg6BTM/5bw4+BiBVZNjjLuV8BB5T33w9xWIub
         MK8K0DaTtzflHY66jDt5otAfbJD3RHCGYKw0d2VINHhgIx+UyvnWnisyxQwjurqnEPFf
         8j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1D3OP4IqORalDdb/H3lnJUZksLU+2GGCWtkQNI3T7/4=;
        b=ch5ytcDDevSJnEFOPT9rpDa/XouSbpJ5/DlCU/fnTkWOEv9fPCOjuRSS+hB2wVuIfE
         3YG3kpwRDJNx3KCDCkvvaPnpFKPsyVlcyWbe7vk/uWnPweiiyYcQ5/8q1d3UOjHKupFU
         zT6ugxAXMSjZqGrRU635qGH45XzCGh3sQmDyUhNTV7WjdComXKL/Atfgia1tA8+8Mpy0
         R6D9Vzseqhqx9VuGKLpLRgIFOK4rAMuYv2/nDVOHvHajCdnXiSowm+xPXoCgXe/clEcU
         C2hYyD0ziSCHzW83e3GwsmRQSMQez1gpAFIs8zFhbquw/UYf406bnomtq0pV6lkvxq7G
         mydg==
X-Gm-Message-State: AJcUukcX/rHa3a28KaoaUvGem2aQuQnpvGdgyo5suDTwTjOdv1njfy3K
        0PiTjDS9tivu0sjRePwlHAiXx3JNrdI=
X-Google-Smtp-Source: ALg8bN5prqdXJhnTBPXH+w7/5RgmVWPBi7jI/2/oW6x7tLSkNsWvK+kZJGtOl8Q2TOGsAARn6sUCXw==
X-Received: by 2002:a63:e711:: with SMTP id b17mr11172803pgi.363.1547685859637;
        Wed, 16 Jan 2019 16:44:19 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:f990:e507:9c40:21df])
        by smtp.gmail.com with ESMTPSA id k191sm1247pgd.9.2019.01.16.16.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 16:44:18 -0800 (PST)
Date:   Wed, 16 Jan 2019 17:44:16 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah <shuah@kernel.org>, James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
Message-ID: <20190117004416.GA17449@cisco>
References: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
 <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:30:26PM -0800, Kees Cook wrote:
> On Wed, Jan 16, 2019 at 4:01 PM shuah <shuah@kernel.org> wrote:
> >
> > Hi Kees and James,
> >
> > seccomp_bpf test hangs right after the following test passes
> > with EBUSY. Please see log at the end.
> >
> > /* Installing a second listener in the chain should EBUSY */
> >          EXPECT_EQ(user_trap_syscall(__NR_getpid,
> >                                      SECCOMP_FILTER_FLAG_NEW_LISTENER),
> >                    -1);
> >          EXPECT_EQ(errno, EBUSY);
> >
> >
> > The user_notification_basic test starts running I assume and then
> > the hang.
> >
> > The only commit I see that could be suspect is the following as
> > it talks about adding SECCOMP_RET_USER_NOTIF
> >
> > commit d9a7fa67b4bfe6ce93ee9aab23ae2e7ca0763e84
> > Merge: f218a29c25ad 55b8cbe470d1
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Wed Jan 2 09:48:13 2019 -0800
> >
> >      Merge branch 'next-seccomp' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
> >
> >      Pull seccomp updates from James Morris:
> >
> >       - Add SECCOMP_RET_USER_NOTIF
> >
> >       - seccomp fixes for sparse warnings and s390 build (Tycho)
> >
> >      * 'next-seccomp' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security:
> >        seccomp, s390: fix build for syscall type change
> >        seccomp: fix poor type promotion
> >        samples: add an example of seccomp user trap
> >        seccomp: add a return code to trap to userspace
> >        seccomp: switch system call argument type to void *
> >        seccomp: hoist struct seccomp_data recalculation higher
> >
> >
> > Any ideas on how to proceed? Here is the log. The following
> > reproduces the problem.
> >
> > make -C tools/testing/selftests/seccomp/ run_tests
> >
> >
> > seccomp_bpf.c:2947:global.get_metadata:Expected 0 (0) ==
> > seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_LOG, &prog)
> > (18446744073709551615)
> > seccomp_bpf.c:2959:global.get_metadata:Expected 1 (1) == read(pipefd[0],
> > &buf, 1) (0)
> > global.get_metadata: Test terminated by assertion
> > [     FAIL ] global.get_metadata
> > [ RUN      ] global.user_notification_basic
> > seccomp_bpf.c:3036:global.user_notification_basic:Expected 0 (0) ==
> > WEXITSTATUS(status) (1)
> > seccomp_bpf.c:3039:global.user_notification_basic:Expected
> > seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> > seccomp_bpf.c:3040:global.user_notification_basic:Expected
> > seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> > seccomp_bpf.c:3041:global.user_notification_basic:Expected
> > seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> > seccomp_bpf.c:3042:global.user_notification_basic:Expected
> > seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> > seccomp_bpf.c:3047:global.user_notification_basic:Expected listener
> > (18446744073709551615) >= 0 (0)
> > seccomp_bpf.c:3053:global.user_notification_basic:Expected errno (13) ==
> > EBUSY (16)
> 
> Looks like the test is unfriendly when running the current selftest on
> an old kernel version. A quick look seems like it's missing some
> ASSERT_* cases where EXPECT_* is used. I'll send a patch.

ASSERT will kill the test case though right? I thought we were
supposed to use EXPECT when we wanted it to keep going. In particular,
it looks like in the get_metadata test, we should be using expect
instead of assert in some places, so we can get to the write() that
does the synchronization. Something like,

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 067cb4607d6c..4d2508af2483 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2943,11 +2943,11 @@ TEST(get_metadata)
 		};
 
 		/* one with log, one without */
-		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
+		EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
 				     SECCOMP_FILTER_FLAG_LOG, &prog));
-		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
+		EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
 
-		ASSERT_EQ(0, close(pipefd[0]));
+		EXPECT_EQ(0, close(pipefd[0]));
 		ASSERT_EQ(1, write(pipefd[1], "1", 1));
 		ASSERT_EQ(0, close(pipefd[1]));
 

But also, is running new tests on an old kernel expected to work? I
didn't know that :).

Tycho
