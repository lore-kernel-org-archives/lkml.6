Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9E9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E279F214DB
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E279F214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeKKFTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 00:19:30 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:41680 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeKKFTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 00:19:30 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wAAJXMBY021221;
        Sat, 10 Nov 2018 20:33:22 +0100
Date:   Sat, 10 Nov 2018 20:33:22 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181110193322.GB21185@1wt.eu>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110190132.GA21185@1wt.eu>
 <CAKOZuevup11kuHGb3QD5GuA1c7_B=Nnq-kDEB5Hbv=OqXVotQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevup11kuHGb3QD5GuA1c7_B=Nnq-kDEB5Hbv=OqXVotQQ@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 11:06:45AM -0800, Daniel Colascione wrote:
> Reminds me of LSS: https://chromium.googlesource.com/linux-syscall-support/

Interesting, thanks for the link, I would probably not have started mine
had I known this one :-)

> I'm not a fan of this approach for general-purpose use. There's value
> in having *some* common function-level indirection before actually
> issuing system calls, e.g., for LD_PRELOAD stuff.

I'm not speaking about general purpose replacement but more about
general purpose low level functions that glibc wrappers can safely
use and expose by default. This way general purpose applications
would still use glibc and those willing to use a lower level could
do it more easily by accessing the lower layer, without having to
define their own syscalls. If I could do something like this in my
code :

  #ifndef HAVE_SYSCALL_SPLICE  // exposed by glibc
  # ifdef __linux_splice       // exposed by kernel header
  #  define splice __linux_splice
  # else
  #  error "no splice exposed by either libc or kernel headers"
  # endif
  #endif

It would be easier, safer and cleaner than what I've used to do before :

  #if !defined(HAVE_SYSCALL_SPLICE) && defined(__NR_splice)
  static inline _syscall6(int, splice, int, fdin, loff_t *, off_in, int, fdout, loff_t *, off_out, size_t, len, unsigned long, flags);
  #endif

Willy
