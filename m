Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED673C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E26218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeLRPPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:15:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41280 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeLRPPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:15:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so16618987qtf.8;
        Tue, 18 Dec 2018 07:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecrRTW8cnwJLggp6bmuNjzdzyOyHWgpci+BQNwnWe/4=;
        b=FsdnmZOfRblz8dw2/RrMbJucGAGMiJ9z4ZqY9KMYd1XH6nX1/jNS97F/ozt6FMRcJL
         PUzNIc94GCpZznIJnXdbn1rBvy/WJx/5W+LtaVCV6aPuSX2Iz9yzYHb0++7Qrx50Haue
         O757JxgtANQ47R1HdryHedHY/F1Np64IrNEVW+0mKcFHzXaDtFp02yDdwQz7CVVEGXBV
         lL6lfUkFuD9naoVaOftdpc6/wYvR7rCy4tD/b85aqocZLFmWNQjjziiu+TkieyvLejgM
         b31Ak5xxlZSP8qBRYuIqvihMx2A/bOsvsxF+NwpcbVBJD4ZcdD85W2nw7ovGdGnFaY4H
         5q3Q==
X-Gm-Message-State: AA+aEWaeKaBsVp2jD+MhI30lLP5OLCRP3wtpTcydRsWQSbmpG0LoTizg
        8V2tYOBNzYvk8VOBz6x89KoRSHRMa+MwGot4gHs=
X-Google-Smtp-Source: AFSGD/Vomr7uJnASNHKb8D15NyrhrJDg36EUHBf+0iF/Grllnv0IbJpNWUXLWj77k3YegABlY1jvuB+HOhrPrCcNlC8=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr17657446qte.212.1545146104039;
 Tue, 18 Dec 2018 07:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20181217130646.GB3560@osiris> <CAK8P3a0kLHcfAtVVuVBqwcQJE+qk6LAO9TBJO2Sb2_m6z5cn8g@mail.gmail.com>
 <CAK8P3a3buLM8aKdN8PATzx_mQqFrrLcJmPjbeiJ8uCzx2GwS2Q@mail.gmail.com> <20181218075653.GB3590@osiris>
In-Reply-To: <20181218075653.GB3590@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Dec 2018 16:14:47 +0100
Message-ID: <CAK8P3a239wziapVWTuPN09-FZ-fip_f3uhFD6B0=92Rw+=zWzw@mail.gmail.com>
Subject: Re: [-next] strace tests fail because of "y2038: socket: Add compat_sys_recvmmsg_time64"
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 8:57 AM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Mon, Dec 17, 2018 at 11:05:06PM +0100, Arnd Bergmann wrote:
> > On Mon, Dec 17, 2018 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Mon, Dec 17, 2018 at 2:06 PM Heiko Carstens
> > > <heiko.carstens@de.ibm.com> wrote:
> > > >
> > > > Hi Arnd,
> > > >
> > > > in linux-next as of today 16 strace self tests fail on s390. I could
> > > > bisect this to b136972b063b ("y2038: socket: Add compat_sys_recvmmsg_time64").
> > > >
> > > > The following tests fail:
> > >
> > > Hi Heiko,
> > >
> > > Thanks for the report and sorry I broke things. I'll have a closer look
> > > tomorrow if I don't find it right away. I suppose the regression was in
> > > native system calls, not the compat syscalls with 31-bit user space,
> > > right?
>
> Yes, I was talking about 64 bit native system calls.
>
> > I found a bug in my patch by inspection. Can you try if the patch
> > below makes it all work (apologies for the garbled whitespace),
> > I'm considering a rewrite of that function now (to split it into two
> > again), but want to make sure there isn't another problem in my
> > original patch.
>
> With your patch below applied, the tests pass again.

Ok, thanks for testing, I've pushed out the fixed version of that
branch now.

       Arnd
