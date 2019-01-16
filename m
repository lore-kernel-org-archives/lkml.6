Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCCFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DA2206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547676225;
	bh=+GmFIO2ktfneyK9yXcBx76rxJd35xh8Y81NaBsZmyy0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=JNsk+zYM5dh6lddW6tXXt4ZgeYP028DnfYUipIk57kugkhWfS73mv08VjBsSnSB8j
	 mwUAMAOWDhTbFgZO7HE4DL43/IktUmYLF98AQVSLh6YrsI5gPDXKKai52grgOj81FP
	 fkBw3mFwVetA6ohHDBdWXM9SFnWHFgF411idGZu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbfAPWDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732373AbfAPWDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:03:43 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA3C20651;
        Wed, 16 Jan 2019 22:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547676222;
        bh=+GmFIO2ktfneyK9yXcBx76rxJd35xh8Y81NaBsZmyy0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iIGs/WTehkh8isSmcT891+Yt+IbLfZnCdRfi5Y9mYCVkZOl5j3BUq7dMrXjpkvywY
         NyI2taNV/3KGkXueiEHPg5y/HsKqyCPllocH9EEz8/v3lE6t+xgZqLpI+gLNgQUd4i
         8uAqd44/EzKwqY+ztl2pxYu0mvZh6Q05lRo2BmTw=
Subject: Re: [PATCH 01/12] selftests: gpio-mockup-chardev: Check asprintf()
 for error
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190114135144.26096-1-geert+renesas@glider.be>
 <20190114135144.26096-2-geert+renesas@glider.be>
From:   shuah <shuah@kernel.org>
Message-ID: <7a3ce526-aefc-c2f1-9b11-215d609952b3@kernel.org>
Date:   Wed, 16 Jan 2019 15:03:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114135144.26096-2-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 6:51 AM, Geert Uytterhoeven wrote:
> With gcc 7.3.0:
> 
>      gpio-mockup-chardev.c: In function ‘get_debugfs’:
>      gpio-mockup-chardev.c:62:3: warning: ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Wunused-result]
>         asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Handle asprintf() failures to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   tools/testing/selftests/gpio/gpio-mockup-chardev.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
> index f8d468f54e986dd0..aaa1e9f083c37215 100644
> --- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
> +++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
> @@ -37,7 +37,7 @@ static int get_debugfs(char **path)
>   	struct libmnt_table *tb;
>   	struct libmnt_iter *itr = NULL;
>   	struct libmnt_fs *fs;
> -	int found = 0;
> +	int found = 0, ret;
>   
>   	cxt = mnt_new_context();
>   	if (!cxt)
> @@ -58,8 +58,11 @@ static int get_debugfs(char **path)
>   			break;
>   		}
>   	}
> -	if (found)
> -		asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
> +	if (found) {
> +		ret = asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
> +		if (ret < 0)
> +			err(EXIT_FAILURE, "failed to format string");
> +	}
>   
>   	mnt_free_iter(itr);
>   	mnt_free_context(cxt);
> 

Thanks for the patch. Applied to linux-kselftest fixes for 5.0-rc4

thanks,
-- Shuah
