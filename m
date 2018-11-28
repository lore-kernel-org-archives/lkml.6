Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE43C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88C22145D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MYfWu/ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88C22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeK2JJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:09:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35412 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeK2JJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:09:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so10112280pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YIRWX8HfezgQR+9EQQES7Z/KXWx7Tuf/kx19LqqRruw=;
        b=MYfWu/ey04TPJAI8Zt09WEoL6rOdVOYOyysShRoiBq2bmHXlkOwy500Ak+nnB6cP9C
         1HEW3mP/FU8IhpQGzW3dTTCuyIJNh8CW1Pc+PejKkDnDQ7YotsGFIdJw3gn3ZuOkezlL
         aWGgXRqMGFHiHDJ82AZVrkxsXLXsnx8w48brA6EOuCw6VKgiEgrz5fnkPcgpN7R1tzao
         wodVYBUnIT8yjKy2yWBPDyBXzX7I2F9iqkz99nO5LwG9M9skrwlGAddtllXK49Kb6VbE
         F/bQsuQilNzieG4uPUua2LA0xROeCPFyHhHimkW0IQYKFWRx5odBjHc4F9KexOzEgteL
         Nw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YIRWX8HfezgQR+9EQQES7Z/KXWx7Tuf/kx19LqqRruw=;
        b=Ls5RUhobE/w85y1+6AKKkmn4AtYo3SbgIykgFi8LLdcVFqITCbglAXMHrgnzHWI+pF
         SXCcQ8PdYTdOMTvHhbd5uax3nPfhUvNUF6eJwY4dZ5d7B75a9DtSDoELOHhkSS9Yni9W
         nZspqxKpYPPOHm9vAFIZ13c/Fua2MW+eEbWFlDjwP0Y7ymNxl+Mo7l2r/dygMoG/kFce
         HXSjjUDkAFnxqtwU3iBC4nGXGi6de6e8D/pd294Pr3HrVXgLlTX7R7S2Az6IKRInQtgY
         jjxtY8/rgQHkQvbKBJrr8AprSi0VQ2jNDew3iekzkHriXLRluteIu/bjwmqeOsic5Z/g
         /7zA==
X-Gm-Message-State: AGRZ1gKBLwMluAH3Iu9/j/hPPin1W7KUs63eCCKuSZvYSTK+L52d+gXd
        MzIgMR+a7GR69p3nyUf4sV8zMA==
X-Google-Smtp-Source: AJdET5dWk+dfUhvdoSbp2gGrSV7wfZGuK19Ot1uDUg61FeasNdf5jnOQOTbrnLzSbDvJx7LO6/tJKg==
X-Received: by 2002:a62:824c:: with SMTP id w73mr39066971pfd.150.1543442758958;
        Wed, 28 Nov 2018 14:05:58 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id m17-v6sm9831262pfi.102.2018.11.28.14.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 14:05:58 -0800 (PST)
Date:   Wed, 28 Nov 2018 23:05:49 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181128220545.fplqmbkfhxowx3lf@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181128214534.xxqoyy7mi5dw54kj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181128214534.xxqoyy7mi5dw54kj@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:45:34AM -1000, Joey Pabalinas wrote:
> On Mon, Nov 19, 2018 at 11:32:39AM +0100, Christian Brauner wrote:
> > +	if (info) {
> > +		ret = __copy_siginfo_from_user(sig, &kinfo, info);
> > +		if (unlikely(ret))
> > +			goto err;
> 

I think you're misreading here. It jumps to:

err:
        fdput(f);
	return ret;

and does propagate the error. This is also an old iteration of the patch.

Christian

> What's the reason you don't propagate up the errors from __copy_siginfo_from_user()?
> Granted, I admit that -E2BIG is kind of weird to return, but -EFAULT seems like a
> fairly sane error.
> 
> Or is there some reason it's more useful to just return -EINVAL for all of the
> failure cases here?
> 
> -- 
> Cheers,
> Joey Pabalinas


