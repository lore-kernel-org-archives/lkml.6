Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B20EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75739222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbfBMM6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:58:10 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38049 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732686AbfBMM6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:58:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id p15so1241298qkl.5;
        Wed, 13 Feb 2019 04:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YzZ2+SgQSwy84SnOV79SobpVyq4HhxYuNdqg2CL408=;
        b=C/TXootOper4gFNyMPqRCkXfkt4jFgltmL46HUMT5FMvndJ8YkHawB1bOdkr2//4+1
         PySX4yxFm5vAnOqKzqMLTaTYqoDwqdXO941fSyFw1NYQGgDd8Qdan1wHlHH6barTlAQv
         DlMJMWObeeIG/ErZtO3AVpr3VGfmHXz/nSXvrqcZ51E+w/9PZp5t3OvpiHdFX6uX70WE
         ftuXzbTL+GglbUYT68Sy6lDtUQNFnzLTOe0U3deY098IH27qw/IsM02YsRlXrWF++97X
         MXja720DMOaaRrcPytm1TQvnYWKiz5aq/uq/01oF5oTh7WCfedqDpKy+uk5trhV7ccjw
         kBpQ==
X-Gm-Message-State: AHQUAuZ0EC7swwp8izL/dIUqPXOlR1zv7eAZk/SaGjfen3hcXhGxrw7w
        w88rjq5nOrDl7sBNmdY02DKqQy5LBR6Yi9wDDarZkQ==
X-Google-Smtp-Source: AHgI3IbDh/aN4uwHc3bgj/wuN5euYJWTa5JODpycyEU4V5s7OSrRKLC0kHhB2OfzwGsDwoNI1PVjQincJRq7Gy2CSH0=
X-Received: by 2002:a37:d492:: with SMTP id s18mr232860qks.343.1550062688184;
 Wed, 13 Feb 2019 04:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20190122141027.70cd9166@canb.auug.org.au> <20190213162212.500a7cd5@canb.auug.org.au>
In-Reply-To: <20190213162212.500a7cd5@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Feb 2019 13:57:51 +0100
Message-ID: <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
 (now block and tip trees)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 6:22 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Tue, 22 Jan 2019 14:10:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the pidfd tree got conflicts in:
> >
> >   arch/x86/entry/syscalls/syscall_32.tbl
> >   arch/x86/entry/syscalls/syscall_64.tbl
> >   include/uapi/asm-generic/unistd.h
> >
> > between commits:
> >
> >   63a96220ad45 ("arch: add split IPC system calls where needed")
> >   0bd4bb9c5612 ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
> >
> > from the y2038 tree and commit:
> >
> >   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
> >
> > from the pidfd tree.
>
> This is now a conflict between the block, tip and pidfd trees.  The
> resolution now looks like below.

Checked it again, still looks good. Thanks,

    Arnd
