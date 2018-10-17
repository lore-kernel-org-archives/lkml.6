Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FE8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D332150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D332150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJQUpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:45:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:54540 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbeJQUpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:45:47 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B25A2750;
        Wed, 17 Oct 2018 12:50:12 +0000 (UTC)
Date:   Wed, 17 Oct 2018 06:50:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] docs: Introduce deprecated APIs list
Message-ID: <20181017065011.40ad8b24@lwn.net>
In-Reply-To: <20181017021708.GA22211@beast>
References: <20181017021708.GA22211@beast>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 19:17:08 -0700
Kees Cook <keescook@chromium.org> wrote:

> As discussed in the "API replacement/deprecation" thread[1], this
> makes an effort to document what things shouldn't get (re)added to the
> kernel, by introducing Documentation/process/deprecated.rst. It also
> adds the overflow kerndoc to ReST output, and tweaks the struct_size()
> documentation to parse correctly.

Seems like a good idea overall...a couple of quick comments

> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-September/005282.html
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/driver-api/basics.rst  |  3 +
>  Documentation/process/deprecated.rst | 99 ++++++++++++++++++++++++++++
>  Documentation/process/index.rst      |  1 +

I wonder if "process" is the right place, or core-api?  I guess we have a
lot of similar stuff in process now.

[...]

> +open-coded arithmetic in allocator arguments
> +--------------------------------------------
> +Dynamic size calculations (especially multiplication)
> +should not be performed in memory allocator (or similar)
> +function arguments.
> +
> +For example, do not use ``rows * cols`` as an argument, as in:
> +``kmalloc(rows * cols, GFP_KERNEL)``.
> +Instead, the 2-factor form of the allocator should be used:
> +``kmalloc_array(rows, cols, GFP_KERNEL)``.
> +If no 2-factor form is available, the saturate-on-overflow helpers should
> +be used:
> +``vmalloc(array_size(rows, cols))``.
> +
> +See :c:func:`array_size`, :c:func:`array3_size`, and :c:func:`struct_size`,
> +for more details as well as the related :c:func:`check_add_overflow` and
> +:c:func:`check_mul_overflow` family of functions.

I think this should say *why* developers are being told not to do it.  Does
this advice hold even in cases where the dimensions are known, under the
kernel's control, and guaranteed not to overflow even on Alan's port to
eight-bit CPUs?

To me it's also a bit confusing to present the arguments to kmalloc_array()
as "rows" and "cols" when they are really "n" and "size".

Thanks,

jon
