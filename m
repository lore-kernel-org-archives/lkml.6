Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD991C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CE92080D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfBLLzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:55:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35174 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:55:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id p48so2570507qtk.2;
        Tue, 12 Feb 2019 03:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pt1pIylMphZsqbPnqLVS/36YT2mMK9EUnitZsTxbOM=;
        b=F6w8fcAEgUFiw0dGHMxpg1XiGLL71i1oRRf29K6UG0GeCX1ATDL7nIOkGlyEPRAsmv
         RO2bjwZ4lZU3+r9+UKMkFf4zb6iXgvaYcDkuZJB7aWBwQCdqNs87Lh7/mme+sArXvG9a
         HAT3odC6gHEId1fUOJdZieTggDrv4Zya0hxrjnggNaolu5Gene1l7ONkdoawZCyb2vY3
         ezowg2sogBB+qGg1O/GstbZwQB7Zk8fpMFV5W4FROmFysECmPveHwbzw9O5YWfkjFZwg
         H5c8YhiuQ73ooV/Tk2O09DeqwEj1YXilZn7peSS7zV78cFlABabt5ZrjMsWxOYpO/Ug8
         kkmg==
X-Gm-Message-State: AHQUAuZ8Z+y4AwI0Q8z8N3z3Xpg3EPXYVwoxJ/VXem6jTFATpeXmrQ2A
        U8x//+A/r63yLh9UQ4ZIztHiTx/sZM4tuGbLkyw=
X-Google-Smtp-Source: AHgI3IZ13MnRRWl1eelUQLbHje3lW+kpm9yTVa4UMzyyGlw+WUEpSG5j7qq5itJenvZQcn+v10X/g+Y+hVfEOVsFd3I=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr2365976qtm.96.1549972534781;
 Tue, 12 Feb 2019 03:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20190211174544.4302-1-will.deacon@arm.com> <20190211174544.4302-2-will.deacon@arm.com>
In-Reply-To: <20190211174544.4302-2-will.deacon@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Feb 2019 12:55:17 +0100
Message-ID: <CAK8P3a1gmJTt+jdTbdSYZ0z43qodxf+co757K1-Hq1mj4fCqQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/io: Pass result on inX() accessor to __io_par()
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrew.murray@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 6:45 PM Will Deacon <will.deacon@arm.com> wrote:
>
> The inX() I/O accessors must enforce ordering against subsequent calls
> to the delay() routines, so that a read-back from a device can be used
> to postpone a subsequent write to the same device.
>
> On some architectures, including arm64, this ordering can only be
> achieved by creating a dependency on the value returned by the inX()
> operation, so we need to pass the value we read to the __io_par()
> macro in this case.
>
> Reported-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/asm-generic/io.h | 8 ++++----

For changing the asm-generic file in the arm64 tree,

Acked-by: Arnd Bergmann <arnd@arndb.de>

For all I can see, this should not conflict with the usage of the
same macros on RISC-V, though it does make add a significant
difference, so I'd like to see an Ack from the RISC-V folks as
well (added to Cc), or possibly a change to arch/riscv/include/asm/io.h
to do a corresponding change.

       Arnd
