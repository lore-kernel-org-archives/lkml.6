Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F743206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="CHWLpeyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfBZLUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:20:42 -0500
Received: from tomli.me ([153.92.126.73]:38860 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBZLUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:20:41 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 89f549eb;
        Tue, 26 Feb 2019 11:20:38 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Tue, 26 Feb 2019 11:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=od79MgRNLQHpoFHbjY64kZqrjOPpe+TZRYWaYOGlWvM=; b=CHWLpeyK8h3gDHAr5sHY2x7PHXOLIXuA50uMVCMT0QdICXgrhSZTZzvSvXejLKfUadhwKJXdOvUVfzWqCYi2/NHOnDURfQb/t65rteYPzSesXNPReJs6bP4UnT91+OATMNnwMOpyW6V++4ms05Jr8Sqe+JqIEyqfSYiGaYojXJs8vKKMhvtsb9njokIOJozD9WU30TuQXA9cxJLBus/EJTMD8wsSTVgvi7MY5O2ArC3F9bRdyrlQnCqvxOuZZOF2e/OHKS5QABlhrq3Ud3NgUcQepwtYRWalQbX0pC2itIVUbf3l7I0YyOTEUaZD5gSgSkjmzIbMM/0DOZhO9Lcg9g==
Date:   Tue, 26 Feb 2019 19:20:26 +0800
From:   Tom Li <tomli@tomli.me>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Yifeng Li <tomli@tomli.me>,
        Mike Frysinger <vapier@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC 1/1] tty: vt.c: Fix TIOCL_BLANKSCREEN VT console blanking
 if blankinterval == 0
Message-ID: <20190226112026.GA21300@localhost.localdomain>
References: <20190225164346.1359-1-tomli@tomli.me>
 <20190225164346.1359-2-tomli@tomli.me>
 <nycvar.YSQ.7.76.1902251314490.1971@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1902251314490.1971@knanqh.ubzr>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't this problem be fixed simply by the following:
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 9646ff63e7..41b17c4b5a 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4151,8 +4151,6 @@ void do_blank_screen(int entering_gfx)
>  		return;
>  	}
>  
> -	if (blank_state != blank_normal_wait)
> -		return;
>  	blank_state = blank_off;
>  
>  	/* don't blank graphics */
> 
> I just can't find a logical reason for that conditional return.
> 
> 
> Nicolas

I see. I was concerned about the possibly unwanted effect if the function
is reentered, but it seems that there's no logic reason to worry at all.

I'll send a new patch according to your suggestion.

Thanks,
Tom Li
