Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00213C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83B12070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mJSmQKnn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dxjwamaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeLSTvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:51:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60100 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeLSTvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:51:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 623C060591; Wed, 19 Dec 2018 19:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545249080;
        bh=VHZONW94vpYDHpBgGNvLYtF8q29VTjx+UYGnR6dinHw=;
        h=Date:From:To:Cc:Subject:From;
        b=mJSmQKnnX4ldHW1V7PMYV7YfRDtY6e/RtFGRQoIb8QXtE0iRkTGiKUArqswWeu1uM
         ntt58bmxbI4JfvM+s3W/kqkRmm/b5IaPDvo/7BAvyXSVQGmc49BnDsq0M+trFBVAXn
         cOOIt31y7xIB1cac0MetLbLZz6Y0mokDTJVYDlz8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C1D9760591;
        Wed, 19 Dec 2018 19:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545249079;
        bh=VHZONW94vpYDHpBgGNvLYtF8q29VTjx+UYGnR6dinHw=;
        h=Date:From:To:Cc:Subject:From;
        b=dxjwamaQR1qgYBdpr5AoiMFh6GjwacpmZ0yd8H8+O9qqc8MIreTGoL9utxpSLXrK4
         vuCM5mdfPnbUAsW9e5YDq1H7f5A0Mkdm6iOMlOZdqqMmXzI8pRK51+3QWzFktTMqb3
         OeUa3yl+lkmvU8t63d/B7l2FOccM00ICnUMaNFjo=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 19 Dec 2018 11:51:19 -0800
From:   rishabhb@codeaurora.org
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Linux-arm Kernel <linux-arm-kernel@lists.infradead.org>
Cc:     tsoni@codeaurora.org, ckadabi@codeaurora.org
Subject: usercopy_warn in __copy_to_user
Message-ID: <ecb306ea6f4a83302e78884713ad7823@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the 4.19 kernel, we are seeing a USERCOPY_WARN in __copy_to_user 
during bootup.
The code-flow is something like this:

(arch/arm64/kernel/signal.c)
struct sigset_t *set;
__copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set))

(include/linux/uaccess.h)
__copy_to_user(void __user *to, const void *from, unsigned long n)
{
                 might_fault();
                 kasan_check_read(from, n);
                 check_object_size(from, n, true);
                 return raw_copy_to_user(to, from, n);
}

(include/linux/thread_info.h)
static __always_inline void check_object_size(const void *ptr,
                                  unsigned long n, bool to_user)
{
                 if (!__builtin_constant_p(n))
                                 __check_object_size(ptr, n, to_user);
}

Since sizeof(*set) is constant, __builtin_constant_p(n) should return 
true.
But we are seeing that its returning the value as false. Because of 
which
the code goes on to __check_object_size and generates a USERCOPY_WARN
("usercopy: WARN() on slab cache usercopy
region violations").

We are using LLVM clang version 6.0 to compile the kernel and not gcc.
In clang, __builtin_constant_p is evaluated immediately, before inlining
or other optimizations run, gcc evaluates it later.
We believe that maybe causing __builtin_constant_p(n) to return false.
There’s upstream work to change LLVM, so __builtin_constant_p works more
like gcc when optimization is enabled, but its still in progress.


For this scenario is there a way to avoid the warning? Should the code 
be
written in a different to avoid dependency on compiler?

Thanks,
Rishabh
