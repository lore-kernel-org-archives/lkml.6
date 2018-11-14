Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030AEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B091422507
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mi+nPWfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B091422507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeKOJhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:37:47 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43011 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeKOJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:37:47 -0500
Received: by mail-yw1-f66.google.com with SMTP id l200so2411142ywe.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mt7zswCOJmjgujaGQ7n935OibvJwusx77JYCTL4nvBg=;
        b=Mi+nPWfddbPzxXmjNHzIu+CgxLw8oOwS8l/iHduRmHqzMMqVfglfpF8eJuJPoS2TxU
         7VLE9MetXHgNH0nt8nYaR+RPFk9thAqS6HFJ3zjVc/T4RfHXo5fNzPTOzVeuWzwrTwgC
         UKJNa6pwc/gd9VQ2IUYNe/krVOgMUam+HicHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mt7zswCOJmjgujaGQ7n935OibvJwusx77JYCTL4nvBg=;
        b=O4NlmS23o4rMBftTsJHjzvnD54Mp7zi0rbYDJoAT9Ge5CFLIhyiB8tp0TCYU+h0Fjo
         RoxldiRhsnhmr1QuOwyAnn8X1LggAhs//FgKP9NaZNegMH81z6jU08HrM7Ye3sDchQZm
         g+LQyqOts1II5+6hfZEnvd2vsgiNNvH3wvP3LFtteKEMyYP9O6C+PDbi+7EMQtuzOPnc
         r52vlBvakB6QtF8pmKsYq9fsa+EL840o6JIkfUa8wyxt0xYExLuz9ia69AsKUSg8kJPd
         8glfH8+wYCeNfeUDIQXoHfw2MVI06yZ/ODZhXIHf7xPNujGQIcVh91a5q5lrAC8THNur
         wvAQ==
X-Gm-Message-State: AGRZ1gLJHjmmYCt8/Kb8BteYtMrfyMwDkoOQ4tSa8ifIwoQifPqOpiLJ
        +OTCBK7QGse0WNZY+pspkqeoOurfd7I=
X-Google-Smtp-Source: AJdET5c9N9m0qjBvqROEvyou7kzHypHhl9J7OpJrFYInePE6JyOU0eQcj3q43uOw8IySm/e1ELlhmw==
X-Received: by 2002:a81:5dc3:: with SMTP id r186-v6mr3920096ywb.220.1542238343644;
        Wed, 14 Nov 2018 15:32:23 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id c140sm4662643ywa.74.2018.11.14.15.32.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 15:32:22 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id w17-v6so7639093ybl.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:32:22 -0800 (PST)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr3897359ybi.141.1542238341792;
 Wed, 14 Nov 2018 15:32:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 15:32:21
 -0800 (PST)
In-Reply-To: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org>
References: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 14 Nov 2018 17:32:21 -0600
X-Gmail-Original-Message-ID: <CAGXu5j+pRq1m=UNtkz0U-pvsdf=zT5is0LWdk77QkgGfxK_mGw@mail.gmail.com>
Message-ID: <CAGXu5j+pRq1m=UNtkz0U-pvsdf=zT5is0LWdk77QkgGfxK_mGw@mail.gmail.com>
Subject: Re: [PATCH] mm/usercopy: Use memory range to be accessed for
 wraparound check
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sodagudi Prasad <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 6:51 PM, Isaac J. Manjarres
<isaacm@codeaurora.org> wrote:
> Currently, when checking to see if accessing n bytes starting at
> address "ptr" will cause a wraparound in the memory addresses,
> the check in check_bogus_address() adds an extra byte, which is
> incorrect, as the range of addresses that will be accessed is
> [ptr, ptr + (n - 1)].
>
> This can lead to incorrectly detecting a wraparound in the
> memory address, when trying to read 4 KB from memory that is
> mapped to the the last possible page in the virtual address
> space, when in fact, accessing that range of memory would not
> cause a wraparound to occur.

I'm kind of surprised anything is using the -4K memory range -- this
is ERR_PTR() area and I'd expect there to be an explicit unallocated
memory hole here.

>
> Use the memory range that will actually be accessed when
> considering if accessing a certain amount of bytes will cause
> the memory address to wrap around.
>
> Change-Id: I2563a5988e41122727ede17180f365e999b953e6
> Fixes: f5509cc18daa ("mm: Hardened usercopy")
> Co-Developed-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Cc: stable@vger.kernel.org

Regardless, I'll take it in my tree if akpm doesn't grab it first. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  mm/usercopy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 852eb4e..0293645 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -151,7 +151,7 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
>                                        bool to_user)
>  {
>         /* Reject if object wraps past end of memory. */
> -       if (ptr + n < ptr)
> +       if (ptr + (n - 1) < ptr)
>                 usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);
>
>         /* Reject if NULL or ZERO-allocation. */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>



-- 
Kees Cook
