Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7647C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E87206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E87206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeK2BH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:07:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44365 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbeK2BHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:07:24 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so25893388qte.11;
        Wed, 28 Nov 2018 06:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rzq5N94s70tXhIMAw3ttjqt1+LFE5cKMB+Wk9rvOGcM=;
        b=uMIbT6tr79OGkNVQTpgs1qpdeZYVHvfZDJOiR2hJdWDStk7AGrVNwexExvUUR+wCdV
         XTxnODZYnsUBLKD69gQUKXjlPuHhnqkeezc3+dGNxmpDgdHRJdSz8fv60bI9IDsGevkq
         TB7eY21pJRqHPMG0ObZrV3l62WcagmY8Cs/ISWVuiS4L7XjwdsioeANkGjrrx+ndPveJ
         pzJ6cTDgvme9xWq67F/Wot+jJfHgugE1EOS5D/n8O87tU2s6Ohc1fSUsBX2qcg5zrOxE
         wRVy/yBekisZdlgXT8rOh0grTAhpNIAp0xFE8+eJDnTJDwdv1aS7QAUtLb7EsiCRUByb
         JcFw==
X-Gm-Message-State: AGRZ1gKt22o5APbR2LkjDbqWOWDSly694Y2sMZCgM5NJzjJlj/+adJz/
        DweBaiFbKNiJKzuJSbgXoPVXSb8wroU+EAzJ7bo=
X-Google-Smtp-Source: AJdET5erjVuqZZTx8r+OYJfZWOXtwDft+mDVu2UYwQ0X5/cAEvsJM+CXbJTkQOIEW4I4cElP/N6doZasT5prwEEUXCE=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr34911227qte.212.1543413937310;
 Wed, 28 Nov 2018 06:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io>
In-Reply-To: <20181120105124.14733-1-christian@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Nov 2018 15:05:19 +0100
Message-ID: <CAK8P3a2eB59EQsjKH50CQV6OtvsJfG++JaF5z7Krvk2tjrMotQ@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     christian@brauner.io
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:54 AM Christian Brauner <christian@brauner.io> wrote:
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   2 +
>  fs/proc/base.c                         |  11 ++-
>  fs/proc/internal.h                     |   5 -
>  include/linux/proc_fs.h                |  12 +++
>  include/linux/syscalls.h               |   2 +
>  include/uapi/asm-generic/unistd.h      |   4 +-
>  kernel/signal.c                        | 127 +++++++++++++++++++++++--
>  8 files changed, 151 insertions(+), 13 deletions(-)

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>

I checked that the system call wired up correctly in a way that
works on all architectures using the generic syscall table.
