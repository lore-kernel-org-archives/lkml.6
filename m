Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FDFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B0021531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B0021531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeITUgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:36:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44188 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbeITUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:36:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id d131-v6so5127077qke.11;
        Thu, 20 Sep 2018 07:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFGUqvFxzbIhaU83zPWhDHl1/BdgZLhy7pyCrpxunG8=;
        b=SyfeA3thk/0kBaf07b3e5W/JvVo6qNzMSQWIVRa5JC/Xsk3L9C49QsNShYFGUMwSsj
         oTYfZelZc/MLKmoQZ4S1NUS30WfD8J4v63Y1yOVl297mYThsz2/BA8OgGN1U4FzIKAk0
         fj5LSmtzG6UhKwjdGcctGxjM86GUO2rC611p7bOyOxbKM/IZOZBb4/Kf8tlI7PRxTQ6p
         QkbLWLAwuja5XGGVJkjw8V57vCcNHKhjgFJPM78G831kV8HnAaMbFwjDF4xSGXXSfEqA
         Kd2QRXk5JyyJAkAO/glYfCw10PM3TGar2ojh1ylCfP2qHBN1WkZ1Q3/yCxViYB7Ji6u2
         lDaw==
X-Gm-Message-State: ABuFfoglkcSTim/jscAXVOznqU1jomXctF0HPZOO1+1qw4IicOYoRwF9
        Me+yrZX6yzbIVLy6Q/yR2I40p7OdtVT1lotwgr8=
X-Google-Smtp-Source: ANB0VdatjAI8Q+jY0vSItZcKJ+EIA31CTskm+41nJN4JO0R3nyAQqnzfiUC3bQ3JXip0D9TZcalRgRtsQBITyBWHnaw=
X-Received: by 2002:a37:2b12:: with SMTP id r18-v6mr1287870qkh.343.1537455143443;
 Thu, 20 Sep 2018 07:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org> <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
In-Reply-To: <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Sep 2018 07:52:03 -0700
Message-ID: <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
Subject: Re: [PATCH 0/3] System call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     Firoz Khan <firoz.khan@linaro.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:17 AM Paul Burton <paul.burton@mips.com> wrote:
> On Fri, Sep 14, 2018 at 02:08:31PM +0530, Firoz Khan wrote:
> > The purpose of this patch series is:
> > 1. We can easily add/modify/delete system call by changing entry
> > in syscall.tbl file. No need to manually edit many files.
> >
> > 2. It is easy to unify the system call implementation across all
> > the architectures.
> >
> > The system call tables are in different format in all architecture
> > and it will be difficult to manually add or modify the system calls
> > in the respective files manually. To make it easy by keeping a script
> > and which'll generate the header file and syscall table file so this
> > change will unify them across all architectures.
>
> Interesting :)
>
> I actually started on something similar recently with the goals of
> reducing the need to adjust both asm/unistd.h & the syscall entry tables
> when adding syscalls, clean up asm/unistd.h a bit & make it
> easier/cleaner to add support for nanoMIPS & the P32 ABI.
>
> My branch still needed some work but it's here if you're interested:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git wip-mips-syscalls
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=wip-mips-syscalls

This looks like a very nice approach that we would probably prefer if we wanted
to do it only for mips. The way Firoz did it makes sense in the context of doing
it the same way on all architectures, where usually the information is more
accessible to human readers by using the number as the primary key.

Speaking of nanoMIPS, what is your plan for the syscall ABI there?
I can see two ways of approaching it:

a) keep all the MIPSisms in the data structures, and just use a subset of
    o32 that drops all the obsolete entry points
b) start over and stay as close as possible to the generic ABI, using the
    asm-generic versions of both the syscall table and the uapi header
    files instead of the traditional version.

         Arnd

         Arnd
