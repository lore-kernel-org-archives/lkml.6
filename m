Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D6AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3640E2148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3640E2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeJQHiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:38:54 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59376 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeJQHiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:38:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gCZ2L-0000Hr-68; Tue, 16 Oct 2018 17:46:05 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gCZ2K-0002Go-DS; Tue, 16 Oct 2018 17:46:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, akpm@linux-foundation.org,
        joe.lawrence@redhat.com, longman@redhat.com,
        linux@dominikbrodowski.net, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, linux-api@vger.kernel.org
References: <20181016223322.16844-1-christian@brauner.io>
        <20181016223322.16844-2-christian@brauner.io>
Date:   Tue, 16 Oct 2018 18:45:44 -0500
In-Reply-To: <20181016223322.16844-2-christian@brauner.io> (Christian
        Brauner's message of "Wed, 17 Oct 2018 00:33:21 +0200")
Message-ID: <877eihjw0n.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gCZ2K-0002Go-DS;;;mid=<877eihjw0n.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19GZtdtNAFD3uALoyWqGOAVZI7qHtbdG5Q=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 1/2] sysctl: handle overflow in proc_get_long
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> proc_get_long() is a funny function. It uses simple_strtoul() and for a
> good reason. proc_get_long() wants to always succeed the parse and return
> the maybe incorrect value and the trailing characters to check against a
> pre-defined list of acceptable trailing values.
> However, simple_strtoul() explicitly ignores overflows which can cause
> funny things like the following to happen:
>
> echo 18446744073709551616 > /proc/sys/fs/file-max
> cat /proc/sys/fs/file-max
> 0
>
> (Which will cause your system to silently die behind your back.)
>
> On the other hand kstrtoul() does do overflow detection but does not return
> the trailing characters, and also fails the parse when anything other than
> '\n' is a trailing character whereas proc_get_long() wants to be more
> lenient.
>
> Now, before adding another kstrtoul() function let's simply add a static
> parse strtoul_lenient() which:
> - fails on overflow with -ERANGE
> - returns the trailing characters to the caller
>
> The reason why we should fail on ERANGE is that we already do a partial
> fail on overflow right now. Namely, when the TMPBUFLEN is exceeded. So we
> already reject values such as 184467440737095516160 (21 chars) but accept
> values such as 18446744073709551616 (20 chars) but both are overflows. So
> we should just always reject 64bit overflows and not special-case this
> based on the number of chars.
>
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> v2->v3:
> - (Kees) s/#include <../lib/kstrtox.h>/#include "../lib/kstrtox.h"/g
> - (Kees) document strtoul_lenient()
>
> v1->v2:
> - s/sysctl_cap_erange/sysctl_lenient/g
> - consistenly fail on overflow
>
> v0->v1:
> - s/sysctl_strtoul_lenient/strtoul_cap_erange/g
> - (Al) remove bool overflow return argument from strtoul_cap_erange
> - (Al) return ULONG_MAX on ERANGE from strtoul_cap_erange
> - (Dominik) fix spelling in commit message
> ---
>  kernel/sysctl.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index cc02050fd0c4..102aa7a65687 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -68,6 +68,8 @@
>  #include <linux/mount.h>
>  #include <linux/pipe_fs_i.h>
>  
> +#include "../lib/kstrtox.h"
> +
>  #include <linux/uaccess.h>
>  #include <asm/processor.h>
>  
> @@ -2065,6 +2067,41 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
>  	}
>  }
>  
> +/**
> + * strtoul_lenient - parse an ASCII formatted integer from a buffer and only
> + *                   fail on overflow
> + *
> + * @cp: kernel buffer containing the string to parse
> + * @endp: pointer to store the trailing characters
> + * @base: the base to use
> + * @res: where the parsed integer will be stored
> + *
> + * In case of success 0 is returned and @res will contain the parsed integer,
> + * @endp will hold any trailing characters.
> + * This function will fail the parse on overflow. If there wasn't an overflow
> + * the function will defer the decision what characters count as invalid to the
> + * caller.
> + */
> +static int strtoul_lenient(const char *cp, char **endp, unsigned int base,
> +			   unsigned long *res)
> +{
> +	unsigned long long result;
> +	unsigned int rv;
> +
> +	cp = _parse_integer_fixup_radix(cp, &base);
> +	rv = _parse_integer(cp, base, &result);
> +	if ((rv & KSTRTOX_OVERFLOW) || (result != (unsigned long)result))
> +		return -ERANGE;
> +
> +	cp += rv;
> +
> +	if (endp)
> +		*endp = (char *)cp;
> +
> +	*res = (unsigned long)result;
> +	return 0;
> +}
> +
>  #define TMPBUFLEN 22
>  /**
>   * proc_get_long - reads an ASCII formatted integer from a user buffer
> @@ -2108,7 +2145,8 @@ static int proc_get_long(char **buf, size_t *size,
>  	if (!isdigit(*p))
>  		return -EINVAL;
>  
> -	*val = simple_strtoul(p, &p, 0);
> +	if (strtoul_lenient(p, &p, 0, val))
> +		return -EINVAL;

Is it deliberate that on an error stroul_lenient returns -ERANGE but
then proc_get_long returns -EINVAL?  That feels wrong.  The write system
call does not permit -ERANGE or -EINVAL for the contents of the data
so both options appear equally bad from a standards point of view.

I am just wondering what the thinking is here.

>  	len = p - tmp;
