Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA54FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EDD20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EDD20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeIFBS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:18:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40213 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeIFBS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:18:56 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so9794376qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnxxs4krt+qXYasdHSYyuOvxtPV3NHTPevWFFyt8bWU=;
        b=tpQh+T4iJHdAO/RW6cS558u5PVcIaczJ2OFMsYsDNgxTYfF4YikQZvHIxi6XJ8HH/0
         b/zU5tHzk/AjOv/+MYiE862GPcvaHv1CvyyJNoLrE32CVk4vWTEMbI+njGyK6rp+glpY
         zNUHM7e+6f0S4SWGe3jyrxjfIJZCHzXIhKchZPLZNKOXjwWBd32OMG2Pf4D9YDy6TxlK
         rMx728mDIXwKZjgEKiRz1U2ZmFXZh0hYgDtpnfABZLG+bIfNeMrwsoMfDEbeO4DXMwAz
         ArGg/86zi2JEaRt8Cdg5U0e0XHH7l/DpfEkJJlMEw7vZ6NqZ75b8X8JVrFwIm3ECwBDm
         0Xlg==
X-Gm-Message-State: APzg51Ah8HZ1ASXHFyyQ6mBzG1/KdtmvumdQawnykcj87wi14pVIKZIx
        S+mMOAz6tvcdIB6EvkBTY1Ny/T1Uqs5FyJuxnzu5zQ==
X-Google-Smtp-Source: ANB0VdYvL3YjM77UDno8AT7SaJ3UdSnohjC1IK+kv0VmftT+1Cl4Jf0ML9/8nHi0M1510W0KZ+sL14u91wV8196riXg=
X-Received: by 2002:a0c:885b:: with SMTP id 27-v6mr34959279qvm.115.1536180422084;
 Wed, 05 Sep 2018 13:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <1536158166-3397-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1536158166-3397-1-git-send-email-linux@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 5 Sep 2018 22:46:44 +0200
Message-ID: <CAK8P3a1cM_StS=mrUCu=-3vahUX=oBa-4t=qvuvjRiC37+Tm=Q@mail.gmail.com>
Subject: Re: [PATCH -next] RISC-V: Request newstat syscalls
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 4:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Since commit 82b355d161c9 ("y2038: Remove newstat family from default
> syscall set"), riscv images fail to boot with the following error.
>
> /sbin/init: error while loading shared libraries: libc.so.6:
>         cannot stat shared object: Error 38
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>
> Explicitly request newstat syscalls to fix the problem.
>
> Fixes: 82b355d161c9 ("y2038: Remove newstat family from default syscall set")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I would suggest to merge this patch with the offending patch.

Looks good, thanks for the fix!

Sorry about taking too long to respond to your original bug report. I
applied the patch on top of the rest of the series  and pushed it out
to my public tree for tomorrow's linux-next.

       Arnd
