Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11033C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59BB213A2
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfALRn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:43:26 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34346 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALRnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:43:25 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1giNJb-0002Ii-W5; Sat, 12 Jan 2019 10:43:24 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1giNJb-0003Eo-FK; Sat, 12 Jan 2019 10:43:23 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20190112005305.GB77447@gmail.com>
Date:   Sat, 12 Jan 2019 11:43:01 -0600
In-Reply-To: <20190112005305.GB77447@gmail.com> (Eric Biggers's message of
        "Fri, 11 Jan 2019 16:53:06 -0800")
Message-ID: <87a7k5ai1m.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1giNJb-0003Eo-FK;;;mid=<87a7k5ai1m.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/hSRkQWIbvkvSd08liRDQKHyFI7UmaG4Y=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Bug (since v4.20): integer underflow in known_siginfo_layout() when sig=0
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> Hi Eric,
>
> The following commit, which went into v4.20, introduced undefined behavior when
> sys_rt_sigqueueinfo() is called with sig=0:

Ouch.  Good catch.

It looks like the fix is just to do:

diff --git a/include/linux/signal.h b/include/linux/signal.h
index f428e86f4800..b5d99482d3fe 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -388,7 +388,7 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
 #endif
 
 #define siginmask(sig, mask) \
-       ((sig) < SIGRTMIN && (rt_sigmask(sig) & (mask)))
+       ((sig) > 0 && (sig) < SIGRTMIN && (rt_sigmask(sig) & (mask)))
 
 #define SIG_KERNEL_ONLY_MASK (\
        rt_sigmask(SIGKILL)   |  rt_sigmask(SIGSTOP))


As gcc is smart enough to combine those two range tests into a single
comparison.  That will ensure the undefined behavior does not byte
anyone else.

I will see about whipping up a proper patch.

Eric
