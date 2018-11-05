Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40544C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078A920869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf3ngnmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078A920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeKEUHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:07:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35088 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKEUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:07:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id v68-v6so13799000qka.2;
        Mon, 05 Nov 2018 02:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VGy21yXs7PqriFmcuGpTYyN0BAsMXNv4ABiMrfybyEA=;
        b=mf3ngnmATrKKwFeuTibz6HaKqRIVUINfgzLlQTGqgaU0EN8Nalt+Yr73vg33MFKibw
         YPLSA9yH9NlCJGN4Lc2vq4FrBP0ZL3GS75VzZimcu+xgZsaSQSEiC1hv/PflKSRQ/tj/
         w9sV2uH5EcMSc1E8vKlhn6zYypcYQP5/sz89tz+c/57F9ffyffzK7iAt5w/uBHMBFCjO
         H2fKtlF+CZaJos2GS196Jgbbi0n3k/q8Se5xvtgUrXPFKb0toFUOerLUiAHyS50QThmU
         +4l8Ptmter8a/xf+O7QuGwnSyb9FErjrTkduB3NU0ikEbvdBr2IpEr0nT8OJ4IH9ledC
         15sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VGy21yXs7PqriFmcuGpTYyN0BAsMXNv4ABiMrfybyEA=;
        b=hhpvN12hn/eZUOK5DbtH4QW+upqbY4e7Y36fy9+BTKutvoMAYT62kKWCRqqSFlHFjj
         8SExvDdRJIIL+8Ax8L0zmZFUYNF/rqgue1ncRyq3j+WWo28FgxzTdrkW/t/20mdzkn40
         PHLNUSCRBEn1D8PzIUDn57K9UrmJ5U6qNN5A2MNpKYUeLyEKHbV4DvNk4zFM75TNakgT
         2JlYa+7rhBcs1wC/Rt3eou2VWQgDBVFoI+SVQMBcBiVUaeUQb7pI0BtY+RgnpJnFgU79
         MdT1w3ZkYenxCvdhKkRRg1pSNXYQZZs6BKZFdlALxuB0wMrtEs4lg43ZEEwkFzZJQs+N
         TM4Q==
X-Gm-Message-State: AGRZ1gLs2dgTe+jrEbfDmz+FdiWDHQaLXse5sfGMgM1jJj1jY1EcecXt
        wpN3SkFlwgDSyrB7sZkrWaKxBeOVJEPxh9S/VTc=
X-Google-Smtp-Source: AJdET5er5q3f4zriGMKLpSX3hKR7fJDyyR+DUyHRfF9mLBghFPE1C19FdWDxQKMDyM2+5PbYp9K2YN5WM3LujShGVIs=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr20334936qte.212.1541414924152;
 Mon, 05 Nov 2018 02:48:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 02:48:43 -0800 (PST)
In-Reply-To: <20181101.133315.47887636039827313.davem@davemloft.net>
References: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
 <1541080391-3890-4-git-send-email-firoz.khan@linaro.org> <20181101.133315.47887636039827313.davem@davemloft.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Nov 2018 11:48:43 +0100
X-Google-Sender-Auth: YLE8SQ_d1M_BdaD0kmnQ_yRDsMk
Message-ID: <CAK8P3a0XOzuMxv5wJpd=jhronFJQ=PwCZ58VgxSkL_sSPV+CZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sparc: add system call table generation support
To:     David Miller <davem@davemloft.net>
Cc:     firoz.khan@linaro.org, sparclinux@vger.kernel.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18, David Miller <davem@davemloft.net> wrote:
> From: Firoz Khan <firoz.khan@linaro.org>
> Date: Thu,  1 Nov 2018 19:23:10 +0530
>
>> +141	common	getpeername		sys_getpeername			sys_nis_syscall
>  ...
>> +150	common	getsockname		sys_getsockname			sys_nis_syscall
>
> The sys_nis_syscall in these two entries is incorrect, see the patch
> below.
>
> One of my worst fears about this change has been realized, that
> instead of helping us find problems, it is so automated to the point
> that it fails to question issues like this.
>
> If sys_nis_syscall for the compat syscall shows up in a situation where the
> native 32-bit syscall does have an entry, that's a BUG and the script
> should
> point this out so that the bug can be fixed.

I see this as a multi-step process. Unfortunately, some architectures have
multiple issues in their system call tables, most importantly the ones that
include system call numbers on some architectures but have had them
removed when the implementation got removed.

The sparc sys_nis_syscall is another such issue: we don't have anything
like that on other architectures, so I think we should either move it to
kernel/sys_ni.c for everyone, or use the normal sys_ni_syscall().

Then there is inconsistency between the set of system calls per architecture,
e.g. some have both socketcall()/ipc() and the individual socket syscalls
from those multiplexors, some only have one of the two sets.
Here, I think we may want to move to the separate system calls on all
architectures and only keep the multiplexors for backwards compatibility.
A future glibc may then remove the support for socketcall() and ipc()
once they require linux-5.x or higher and always have the separate calls.

However, for all of those, I want the /format/ of the tables to be consistent
so we can create the tooling around it to find and fix the issues. The work
that Firoz is doing for now just makes sure that the /contents/ of the tables
don't change at all, which is hard enough to do (the current version gets
it all right afaict, but the previous versions missed some details).

      Arnd
