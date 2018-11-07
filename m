Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2142086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2142086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeKHG10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:27:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeKHG1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:27:25 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35F34B7B;
        Wed,  7 Nov 2018 20:55:18 +0000 (UTC)
Date:   Wed, 7 Nov 2018 12:55:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ubsan: don't mark __ubsan_handle_builtin_unreachable
 as noreturn
Message-Id: <20181107125517.b5677f03a9a1978a5d179c9a@linux-foundation.org>
In-Reply-To: <20181107144516.4587-1-aryabinin@virtuozzo.com>
References: <CAOesGMi-vkYPDrL2drJ70zf3_xTMWrsfPoW68TkiRJCj8uWBLg@mail.gmail.com>
        <20181107144516.4587-1-aryabinin@virtuozzo.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 17:45:16 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-8 complains about the prototype for this function:
> 
> lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]
> 
> This is actually a GCC's bug. In GCC internals
> __ubsan_handle_builtin_unreachable() declared with both 'noreturn' and
> 'const' attributes instead of only 'noreturn':
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84210
> 
> Workaround this by removing the noreturn attribute.
> 
> ...
>
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -427,8 +427,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
>  EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
>  
>  
> -void __noreturn
> -__ubsan_handle_builtin_unreachable(struct unreachable_data *data)
> +void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
>  {
>  	unsigned long flags;

This code has been here since 2016 and presumably people will want to
build older kernels with newer gcc's.  So I'll add cc:stable, OK?

