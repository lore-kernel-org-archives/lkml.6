Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66B0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861F420685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfAISEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:04:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfAISEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:04:16 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79A618D7;
        Wed,  9 Jan 2019 18:04:15 +0000 (UTC)
Date:   Wed, 9 Jan 2019 10:04:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1] seq_file: convert mangle_path() to use
 string_escape_str()
Message-Id: <20190109100414.4de13e06ecbdeb89cb8c4e40@linux-foundation.org>
In-Reply-To: <20190109154022.23551-1-andriy.shevchenko@linux.intel.com>
References: <20190109154022.23551-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jan 2019 17:40:22 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since string_escape_str() does not support overlapping buffer first we check if
> there is enough room in the buffer and then update a path. The side effect of
> this change is in case of failure the buffer is left unchanged.
> 
> ...
>
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -421,21 +421,13 @@ EXPORT_SYMBOL(seq_printf);
>   */
>  char *mangle_path(char *s, const char *p, const char *esc)
>  {
> -	while (s <= p) {
> -		char c = *p++;
> -		if (!c) {
> -			return s;
> -		} else if (!strchr(esc, c)) {
> -			*s++ = c;
> -		} else if (s + 4 > p) {
> -			break;
> -		} else {
> -			*s++ = '\\';
> -			*s++ = '0' + ((c & 0300) >> 6);
> -			*s++ = '0' + ((c & 070) >> 3);
> -			*s++ = '0' + (c & 07);
> -		}
> -	}
> +	size_t len = p + strlen(p) - s;
> +	int ret;
> +
> +	ret = string_escape_str(p, NULL, 0, ESCAPE_OCTAL, esc);
> +	if (ret < len)
> +		return s + string_escape_str(p, s, len, ESCAPE_OCTAL, esc);
> +
>  	return NULL;
>  }
>  EXPORT_SYMBOL(mangle_path);

Confusing.

I think the objective of the patch is to use an existing library
function rather than open-coding, but the library function doesn't
support in-place operation on the string.  So the old mangle_path() was
OK with in-place conversion, but the new mangle_path() is not.  Is that
correct?  Do we know that all existing mangle_path() callers are OK
with this?  Please make all this clear in the changelog.

Also, the identifier `ret' is widely understood to mean "the value
which this function will return", but that is not the case here. 
Please use a more appropriate identifier.

