Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AEEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE562080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE562080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeJ3Fjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:39:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46293 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeJ3Fjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:39:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id c16-v6so10953514qtj.13;
        Mon, 29 Oct 2018 13:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApDkxuOM7fn2XcxxiAZ7zTo+9s3XBeFqvEvzWi8ciMs=;
        b=rGyTcMDCVXZm3L1WPmHLKeZZ3HwEh3tH6JnsknLndFxVndNo4ublLY7KLdu5gVK0hK
         dXgdipjRt39GgC0CjfWarg4PwjwrXO7h6qLcBTqbysuxqbN9h01bpUDu5uCdrJkK/tIF
         WuGm5mI59abZo2A53bp7xHKdVxKtz2jDp4YXIoM4xidEoQTY4UXW9VtcVr3G0mYTB+RP
         kHh9O67yvDtMGs7MQOAylfCLXyvB0e5NzzXtOELeikf8p8+gh4wr9xozKDVN21gT8qQy
         n079DVzLqvrwGYWlC5ulhI9jM3SdKgV7cj2atkgCTojJ8gXT3p1Nj0WU1yRmQA1xy2nR
         JZVA==
X-Gm-Message-State: AGRZ1gIZfYXJhOoSfjyoXi97kaLrKCqExXWEfKv5v3JN2VNnbn+iC3b9
        a6AXNnVR0l0T0FUzhN1c9fB7OJm8J32QizBuIns=
X-Google-Smtp-Source: AJdET5e1iZ1teaMutcRu+QbiI5v/iNBkHPdMEjcpjolTyd6l3Iv76n+UErA0oAUKd1sUqh9Um7KHNJ1/XfpTm+nKmAA=
X-Received: by 2002:ac8:2c16:: with SMTP id d22-v6mr14647754qta.152.1540846158466;
 Mon, 29 Oct 2018 13:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20170630073448.GA9546@unicorn.suse.cz> <20180831111436.GA23780@dell5510>
 <CAK8P3a2yfZKMtE16DNCjZBOQ1R5=uXD16k43eJ=najJBh7H85Q@mail.gmail.com> <20181029163331.GA31059@dell5510>
In-Reply-To: <20181029163331.GA31059@dell5510>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 21:48:57 +0100
Message-ID: <CAK8P3a1q32spcF445Zhw-KMXG2VwFZuMw5C1sYFk3qLXz3HB5w@mail.gmail.com>
Subject: Re: RFC: changed error code when binding unix socket twice
To:     pvorel@suse.cz
Cc:     mkubecek@suse.cz, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        rweikusat@mobileactivedefense.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
        junchi.chen@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 5:33 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Fri, Aug 31, 2018 at 1:17 PM Petr Vorel <pvorel@suse.cz> wrote:
> > > > commit 0fb44559ffd6 ("af_unix: move unix_mknod() out of bindlock") moves
> > > > the special file creation in unix_bind() before u->bindlock is taken in
> > > > order to avoid an ABBA deadlock with do_splice(). As a side effect, it
> > > > also moves the check for existence of the special file (which would
> > > > result in -EADDRINUSE) before the check of u->addr (which would result
> > > > in -EINVAL if socket is already bound). This means that the error
> > > > returned for an attempt to bind a unix socket to the same path twice
> > > > changed from -EINVAL to -EADDRINUSE with this commit.
>
> > > > One way to restore the old error code is indicated below but before
> > > > submitting it, I would like to ask if we need/want it.
>
> > > > Pro:
> > > >   - in general, we do not want to change return code for given testcase
> > > >   - old error (-EINVAL) is consistent with AF_INET(6)
> > > > Con:
> > > >   - both POSIX and Linux man page only list error conditions without
> > > >     stating which should take precedence if more of them apply so
> > > >     neither of them seems wrong, strictly speaking
>
> > > I'd be for restoring the original behavior (be conservative + looks like as not intended).
>
> > > Any comment from netdev maintainers?
>
> > Naresh noticed that LTP now has a version check to  detect linux-4.10+ and
> > expect a different return code from previous versions, but the 0fb44559ffd6
> > commit that changed the behavior got backported to stable linux-4.4 and 4.9,
> > so now LTP complains about those:
>
> > https://bugs.linaro.org/show_bug.cgi?id=4042
> Thanks for report.
>
> > I don't care much which error code gets returned here, but I think we
> > should either handle this consistently in all kernel versions and check for
> > the one that is deemed the correct one on all versions, or change LTP
> > again to accept either return code.
> Do you mean to apply this patch to 3.16.y? (The only still maintained LTS branch
> which miss this fix). Although the patch don't apply and it's very old branch,
> it'd be easy to adjust it and it looks to me deadlock can happen there as well.

I forgot that 4.1 has ended a while ago. Greg also sometimes still takes patches
for 3.18, so that might be a candidate aside from 3.18

> I guess we need to adjust LTP test to accept either return code as EOL longterm
> branches probably will not take this patch.

I'd argue that if we decide that EADDRINUSE is the intended return value,
it would be appropriate for LTP to warn about kernels that never got the
backport.

The alternative would be to not backport the patch further, and then change LTP
to no longer warn. Note that the bug that got fixed by the 0fb44559ffd6 patch
is probably more important than the return code, so I would say
we want the patch backported to anything that people still run anyway,
especially if they are running LTP to make sure it works correctly.

        Arnd
