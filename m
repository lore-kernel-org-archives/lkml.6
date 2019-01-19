Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168ECC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C022084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfASSCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:02:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56552 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbfASSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:02:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B19B114BC61D8;
        Sat, 19 Jan 2019 10:02:00 -0800 (PST)
Date:   Sat, 19 Jan 2019 10:02:00 -0800 (PST)
Message-Id: <20190119.100200.853063369704641480.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com
Subject: Re: [PATCH v2] isdn: avm: Fix string plus integer warning from
 Clang
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190110054107.6069-1-natechancellor@gmail.com>
References: <20190108050649.9962-1-natechancellor@gmail.com>
        <20190110054107.6069-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 19 Jan 2019 10:02:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Wed,  9 Jan 2019 22:41:08 -0700

> A recent commit in Clang expanded the -Wstring-plus-int warning, showing
> some odd behavior in this file.
> 
> drivers/isdn/hardware/avm/b1.c:426:30: warning: adding 'int' to a string does not append to the string [-Wstring-plus-int]
>                 cinfo->version[j] = "\0\0" + 1;
>                                     ~~~~~~~^~~
> drivers/isdn/hardware/avm/b1.c:426:30: note: use array indexing to silence this warning
>                 cinfo->version[j] = "\0\0" + 1;
>                                            ^
>                                     &      [  ]
> 1 warning generated.
> 
> This is equivalent to just "\0". Nick pointed out that it is smarter to
> use "" instead of "\0" because "" is used elsewhere in the kernel and
> can be deduplicated at the linking stage.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/309
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Use "" instead of "\0", as they are equivalent, but "" can be
>   deduplicated by the linker, as pointed out by Nick.

Applied, that was certainly a funny construct....

It obviously is trying to initialize the array elements to pointers
to empty strings.
