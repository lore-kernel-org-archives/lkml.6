Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC4C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A902146E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A902146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeKKErg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:47:36 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:41670 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeKKErg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:47:36 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wAAJ1WEn021192;
        Sat, 10 Nov 2018 20:01:32 +0100
Date:   Sat, 10 Nov 2018 20:01:32 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181110190132.GA21185@1wt.eu>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 10:52:06AM -0800, Daniel Colascione wrote:
> Now that glibc is basically not adding any new system call wrappers,
> how about publishing an "official" system call glue library as part of
> the kernel distribution, along with the uapi headers? I don't think
> it's reasonable to expect people to keep using syscall(__NR_XXX) for
> all new functionality, especially as the system grows increasingly
> sophisticated capabilities (like the new mount API, and hopefully the
> new process API) outside the strictures of the POSIX process.

It's partly related, but you may be interested in something I did that
is in the the RCU tree. It's called "nolibc", it's a set of syscall
wrappers defined only in include files. It's not complete, but still
enough to boot some small init wrappers. Mine can extract tar files
and do stuff like this with it. Here is the kernel port in the RCU
tree and an example of code using it :

   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/tools/testing/selftests/rcutorture/bin/nolibc.h?h=rcu/next
   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/tools/testing/selftests/rcutorture/bin/mkinitrd.sh?h=rcu/next

The original one is maintained here (not very active since it works
well enough for my use cases now eventhough it's far from being
complete) :

   http://git.formilux.org/?p=people/willy/nolibc.git

Maybe something along this could be done for the vast majority of
syscalls and the thicker stuff be left to glibc ? That would allow
simple userland to build without glibc using only kernel headers,
or by occasionally defining a few extra stuff or glue.

Willy
