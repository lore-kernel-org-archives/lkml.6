Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A791AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C6B2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhEG3ZBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfBSDDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:03:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46378 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBSDDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:03:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so9476181pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 19:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AUxYkpUOGVLojnBzMownAJmT4JzMv+qBE9F7iqL0iVA=;
        b=EhEG3ZBdr5KMPHwlgs8yf6x65xyo7j/jwyEiUjomuC3LRBxryAu3H7JUlwydWQ0UWW
         S3UVaafT5AflEbLmT4Ey8bQ4aBKBRL+yE57z0BvDyIf7/26nDamfkGGRRtSEw3uJ8I9s
         QzqXzcvEZkmkjZfDViOrjhaRVUhmY6nWRsvWRS3Ajo40X98mACI5DtIR3cCrylhu8lW0
         s76omqRGoNgOqhsqFXRP9BVdsQAXvS78nsvb9q86ka3nbO/aIGF9bHRB/+VYcrPn5Nhd
         Jh0RYJV5n3pdsNtaNItezixpGBHTtV6uBL4JoT0v2UIJJaxTOYmQmH7bLor7IaMp2U6i
         PYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AUxYkpUOGVLojnBzMownAJmT4JzMv+qBE9F7iqL0iVA=;
        b=Me2w5jIXsRrSNxSVi6KrPqdSMyhQNeiif+DUmG/rhHPbcz/nBdUM6h8l1Zcy7CInjf
         dTHgnQseXr3kKqCju7wXloKZI/JvVTg7fwXBgv51dJ0ylOB4p2M8QgbkTtx9mJflQDmy
         F3EjI984OpH6SCcYrCfxzHuiO3onjxA7C/1IqEuIhaIw9m0rOxVPX95M5Tl7kJDvJ7Bg
         u5YvDJgQMNZH1H8s0kVI5173Duatee19UrdLWoWRaLP/TBg8T3ZNMOaBO2oTmdMikjSY
         uoEiP0d3s9RhWxzrc6D6jMTy6AS3WpXuI1OHUtIDc9f/k1X1Cec3Gm89P7SNX0NxyiTG
         C+PA==
X-Gm-Message-State: AHQUAuYzf9deYgncoGSrgOUmZn4OVZDT2Dv/N6/iXhHyGLoAH2GXVBp6
        h/VzL7tnq0do+pm7tBJbYHs=
X-Google-Smtp-Source: AHgI3IYFEzvQmV2+NSDG8NO+PzEHwvueCAJyYDiz9a4WXoTm+s5pXsI7ZOxGN57Yj1V/BCwzMCP+kg==
X-Received: by 2002:a62:bd17:: with SMTP id a23mr26929404pff.233.1550545431216;
        Mon, 18 Feb 2019 19:03:51 -0800 (PST)
Received: from localhost ([175.223.35.193])
        by smtp.gmail.com with ESMTPSA id e20sm18309778pgg.62.2019.02.18.19.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 19:03:50 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:03:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vsprintf: Avoid confusion between invalid address
 and value
Message-ID: <20190219030300.GA640@jagdpanzerIV>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-10-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208152310.29531-10-pmladek@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/08/19 16:23), Petr Mladek wrote:
[..]
>  Plain Pointers
>  --------------
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3a95b4d1ca2e..e51cbc2be540 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1510,7 +1510,7 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
>  		case AF_INET6:
>  			return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
>  		default:
> -			return string_nocheck(buf, end, "(invalid address)", spec);
> +			return string_nocheck(buf, end, "(einval)", spec);
>  		}}

Hmm... The original code looks "a bit" dangerous.

Suppose, in my driver I want to sprintf() IPv4 address. The longest
possible address is 3 * 4 (%d%d%d) + 3 bytes (dots) + terminating NULL.
E.g. 111.111.111.111

So I can allocate a 16-bytes buffer (stack or slab) and accidentally
do an %piS sprintf() on a corrupted in_addr struct:

		char buf[16];
		sprintf(buf, "%piS", in_addr);

forcing sprintf() to write "(invalid address)" to a 16-bytes buffer,
but the thing is - strlen("(invalid address)") > 16.


We might want to take this change out of this series.

	-ss
