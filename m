Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032512089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/fJTMCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfBUACw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:02:52 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35493 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfBUACw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:02:52 -0500
Received: by mail-vs1-f68.google.com with SMTP id e81so11998548vsd.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 16:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkDCp+S+wJaiuTIbj8NEcrkctWvFiARuERNSk6RuTzw=;
        b=W/fJTMCYU3IiWb+8DmM8RoU8ReES9GesubFdoMIRsFjAsoaD7MkhEfA5NbP2m2gsFL
         /+bqCONH5JgaoTNOKn5qUYB84YhEgWQH1ptxaOPvbTVTX36yP+RRV95LFfi2zVSpY142
         7KB5sWflzuaQQfNmA5ZERsSNefBXTfPK3pSXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkDCp+S+wJaiuTIbj8NEcrkctWvFiARuERNSk6RuTzw=;
        b=qWiNIRWnipfkjczMnfdUO1Yz7Y9g8dJ/AQyMotMSK469w6OHhyG3U2inbab5sQ+xfH
         JfFm26vUandt80aM5RPTUYGj3OUK37lhkIk3zNDmKPq1WEUcPC61LlWz/my8QgwV/Sbr
         Ac6zRx9n5H/XJA2LvWkVVnfj39nejA3mzwH9HHOz4sJs5DS0OW02CUZRZwDnW+VWGTDa
         6qDpchmPHd0TjeSEg+RI7GNFDlBU0tJZoxfLYuCrY4qh0liLtqY8UNn/jKV4d5taXj/m
         c3FN3Q2NhOaTIT6jV7iGGoI27JXxeRy3YbPxQFMWjDa1vpKY4zELdJknQVsMq0b3phKw
         vPgg==
X-Gm-Message-State: AHQUAuZIa1W9Ddy0D2UTSZbRCXNIzopo2tW5bTXkCsJop4UhGCJw5VKf
        FJ2cOohzIW/Bcu8bdQtp3fWvRWw7h3Y=
X-Google-Smtp-Source: AHgI3IZWOC6a88GaYZVvVsPbHEuO0jPDYn0HOW79IvrohftIt6ZO7Yk3kJCgmpIBB38TxREvhRTsuw==
X-Received: by 2002:a05:6102:150:: with SMTP id a16mr8899147vsr.134.1550707370561;
        Wed, 20 Feb 2019 16:02:50 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id j131sm1683909vkf.20.2019.02.20.16.02.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:02:49 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id w14so8154606vso.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 16:02:49 -0800 (PST)
X-Received: by 2002:a67:ec81:: with SMTP id h1mr19265474vsp.188.1550707369050;
 Wed, 20 Feb 2019 16:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-3-tobin@kernel.org>
In-Reply-To: <20190218232308.11241-3-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 16:02:37 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJcf8S3vS5d7B9oC2V7F6Gjbeu5vUCQiAFXTzeXcrno0w@mail.gmail.com>
Message-ID: <CAGXu5jJcf8S3vS5d7B9oC2V7F6Gjbeu5vUCQiAFXTzeXcrno0w@mail.gmail.com>
Subject: Re: [PATCH 2/6] lib/string: Fix erroneous 'overflow' documentation
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
>
> Current documentation uses 'overflow' to describe a situation where less
> data is written to a buffer than buffer size not more.  'overflow' is
> the wrong word here - since we don't typically say 'underflow' change
> the whole sentence.
>
> Fix erroneous 'overflow' documentation for under filled buffer.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  lib/string.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/string.c b/lib/string.c
> index 38e4ca08e757..7f1d72db53c5 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -173,8 +173,8 @@ EXPORT_SYMBOL(strlcpy);
>   *
>   * Preferred to strncpy() since it always returns a valid string, and
>   * doesn't unnecessarily force the tail of the destination buffer to be
> - * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
> - * with an overflow test, then just memset() the tail of the dest buffer.
> + * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy(),
> + * check the return size, then just memset() the tail of the dest buffer.
>   */

I'd just fold this patch into the strscpy_zeroed() patch. No need for
a kind of "no op" change here when we'll just change it again with a
better advice ("use strscpy_zeroed()!")

-- 
Kees Cook
