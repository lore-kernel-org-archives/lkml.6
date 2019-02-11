Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45462C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010F521B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549914632;
	bh=cTSfTmrXKbjwGlk3PXgEVSHqQvL60jdktl1m//LP/NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T1B8GJsEC4Dcvpo96Ovy8Pd4ahT05LXUZHRVgdSBF4w0cJO9LYIkDnm/kHT89Uh9u
	 JbufOLQsczVJN+MJ9fAHGsEHd8nWuTA8hrRxj+JvuWAtGxq6o2mu9yaVjix9FEJeAg
	 l6PLgJmlU73mB44kw1jGXoaD/aOuOxI0xxLNSKIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbfBKTub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:50:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37264 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbfBKTua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:50:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so53833plr.4;
        Mon, 11 Feb 2019 11:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1xTbOvp0CNfc2jRAYxJz0bPq5I66ptN0UIEJ1EbUoE=;
        b=RU5+Z9F3CS0CO+oG0k0GaDzOpLFUYKwsEsXai9tnGXnOtlUr39eEWTU5cIWO7mZ6Vv
         u+sLsxGykZ1MCWlYfbi8Dw/i555g9IqcOWcQ3FvzANewnwRBtKrjngPb4DW5AqwSUEGp
         grWLVDfFy03Mr7HKhL/clXUxohoJ0otJ2l7dMJXBwz3gDA8EDIFlM2iz6Q/tEl4ZyM0r
         ptHF6t9QVxB+Z8KBzEIQ8/ieHkuQ7sPA3EhFOIa9H9UIiO6BV1zhxC+LcI0un+qecsnG
         9z6zPbwwHZCDYiwMicMqZBhP7Io9X9qkxfLY4pqVWM4xviODyZi2/vPANigggO8rNWdK
         CKOw==
X-Gm-Message-State: AHQUAuYlpzuqfXHIUjFJMR347pCyScI0xSXR183v+90cVYcaZJdG57+b
        TIhLZFjXwK+ogD9xUM1rhgs=
X-Google-Smtp-Source: AHgI3IYi8U4iRDr6fbyQWunqOO9QH8V7hup8MCtqg9rXHoRP3vi8OnyBHwtWmEqOGZjD3ZpsxfBCsQ==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr38838533pla.136.1549914630092;
        Mon, 11 Feb 2019 11:50:30 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id v9sm12447460pgs.3.2019.02.11.11.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 11:50:28 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 11 Feb 2019 11:50:25 -0800
Date:   Mon, 11 Feb 2019 11:50:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        joe.lawrence@redhat.com, longman@redhat.com,
        linux@dominikbrodowski.net, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/3] sysctl: return -EINVAL if val violates minmax
Message-ID: <20190211195025.GT11489@garbanzo.do-not-panic.com>
References: <20190210203943.8227-1-christian@brauner.io>
 <20190210203943.8227-4-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210203943.8227-4-christian@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 09:39:43PM +0100, Christian Brauner wrote:
> Currently when userspace gives us a values that overflow e.g. file-max and
> other callers of __do_proc_doulongvec_minmax() we simply
> ignore the new value and leave the current value untouched. This can be
> problematic as it gives the illusion that the limit has indeed be bumped
> when in fact it failed.
> This commit makes sure to return EINVAL when an overflow is detected.
> Please note that this is a userspace facing change.
> 

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> /* Changelog */
> v4:
> - patch introduced
> 
> v1-v3:
> - patch not present
> ---
>  kernel/sysctl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index c4a44b7ccb8a..516bc8a2812d 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2846,8 +2846,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
>  			if (neg)
>  				continue;
>  			val = convmul * val / convdiv;
> -			if ((min && val < *min) || (max && val > *max))
> -				continue;
> +			if ((min && val < *min) || (max && val > *max)) {
> +				err = -EINVAL;
> +				break;
> +			}
>  			*i = val;
>  		} else {
>  			val = convdiv * (*i) / convmul;
> -- 
> 2.20.1
> 
