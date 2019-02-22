Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8402DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5118D2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfBVXQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:16:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59654 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:16:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 47A7414AD91EC;
        Fri, 22 Feb 2019 15:16:09 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:16:06 -0800 (PST)
Message-Id: <20190222.151606.344940961752699587.davem@davemloft.net>
To:     jannh@google.com
Cc:     alexei.starovoitov@gmail.com, torvalds@linux-foundation.org,
        mhiramat@kernel.org, rostedt@goodmis.org, luto@amacapital.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, stable@vger.kernel.org,
        changbin.du@gmail.com, keescook@chromium.org, luto@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAG48ez0nMEMP5-eSFWmLKs30zApgZ57zqU1Od9cROBYQvoJxsg@mail.gmail.com>
References: <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
        <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
        <CAG48ez0nMEMP5-eSFWmLKs30zApgZ57zqU1Od9cROBYQvoJxsg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Feb 2019 15:16:09 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>
Date: Sat, 23 Feb 2019 00:11:58 +0100

> I think what Linus is saying is: There are some scenarios (like a
> system with the old 4G/4G X86 patch) where *the same* address can
> refer to two different pieces of memory, depending on whether you
> interpret it as a kernel pointer or a user pointer.

Exactly.

On sparc64 the kernel is mapped exactly at the same virtual addresses
as userspace processes usually are mapped, even 32-bit ones.  The
difference is the MMU context only.
