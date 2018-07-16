Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C129ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD42208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA9K6yL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD42208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeGPKpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:45:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33317 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeGPKpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:45:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id t21-v6so29424638lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pocjnIHCOUX8aSFZ6IfYXqrdDf/Y9thHpzKuLgTX7Ms=;
        b=EA9K6yL7hG7YywBQ3eT2CPY9p7rDJLwNDGAtWEV5TUt7gLDx1MAUFbIOSPKWYMcG/I
         /SNHG7t8jR8rXxuGh2tbNfR3/6Mj0pl1VygwIBwG/CdZl0zSElNpuYnXGE8FS2vIxrv7
         y/8I3i99HtOfXJSRxtMDwH56w0PrxL9HXcqDOOOTrc5sIazTagsYHmYWKKZdKiDgOnMP
         VUc6z7XO/YOjNDqXaGKz5wLwwM1PsqUrzAnqnp7L37xp23GeTcUXQ85jWqD+D9aPDq48
         zU1OhdLIQFv0lpJjiHxDFMVgGP/9xOkvvKxLKrx2qEOJLqGw7/3F53q04GdciRqZtrsG
         IVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pocjnIHCOUX8aSFZ6IfYXqrdDf/Y9thHpzKuLgTX7Ms=;
        b=JNyXu3WcEVprE9wYFonSYhS5afZ/Z58wlYnEr/NDOHhPVM/+BmN63L//gClEZBKHf1
         niSUEwJaBCENJi+0FY5eNvbmeLZ5ftypj3+LqahZTtLxzXvl/1noCja9FHMxTsH8Tpq+
         +ipjIB0ubeesrfb4WYkBMy7hBi239B1ZTQGjRwW7guUU8DyACqqv90VpzKlTKppu9dyM
         kB1rSNM13BuGkZa12WOLFkvOo6MNMhgRGsw9fU/lm+n5+SkTDT61o2G1SmjXuekze9L5
         BGB359PLeC3hGOyMJXYZy8YCzCuoCypS/6kuK7dnuPJyDXiOKTXri6+h1OTzpFwEFyly
         4fzg==
X-Gm-Message-State: AOUpUlEChJXEV0pSuvotOPbhc75cf/mpPTYzTHgzRfxV85m9zOD/KirF
        /DTfZ3JrGQmayeyE+hebzsm5Ciex
X-Google-Smtp-Source: AAOMgpdEfkk0CaJuy02Fxmbd8eVYmR9cvu/5qXp2L4ONgc+0rvOF00R2yQ2lzDZzH4gRNjGTSC4I5Q==
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr10510945ljj.53.1531736313142;
        Mon, 16 Jul 2018 03:18:33 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id j140-v6sm591924lfg.16.2018.07.16.03.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 03:18:32 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ff0aG-0007By-51; Mon, 16 Jul 2018 12:18:24 +0200
Date:   Mon, 16 Jul 2018 12:18:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tty: support CIBAUD without BOTHER
Message-ID: <20180716101824.GK10204@localhost>
References: <20180715133935.24964-1-johan@kernel.org>
 <20180715133935.24964-4-johan@kernel.org>
 <20180716100028.GA20101@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716100028.GA20101@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:00:28PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 15, 2018 at 03:39:35PM +0200, Johan Hovold wrote:
> > Since commit edc6afc54968 ("[PATCH] tty: switch to ktermios and new
> > framework") arbitrary baud rates can be requested using BOTHER and input
> > rates can be requested using the termios CIBAUD bits (CBAUD shifted
> > IBSHIFT bits).
> > 
> > This functionality has been conditionally compiled depending on whether
> > an architecture defines BOTHER and IBSHIFT respectively, but would in
> > fact fail to compile unless both symbols were defined due to cross
> > dependencies.
> > 
> > Relax the IBSHIFT => BOTHER dependency so that an architecture could
> > theoretically support CIBAUD without the Linux-specific BOTHER, while
> > hopefully making the current conditional-compilation directives a bit
> > less confusing.
> > 
> > Note that the long-term goal is still to have all architectures support
> > both features, so an alternative could just be to have the lot depend on
> > BOTHER.
> 
> I thought we had all arches converted to use BOTHER already, what ones
> are not yet done?  It's hard to unwind the asm-generic use of termbits.h
> to obviously see which ones are not doing this yet, any ideas?

It looks like alpha does not yet define BOTHER at least.

> Oh, and thanks for fixing this all up, odd that no one has noticed it
> before.

Probably due to there being no in-tree drivers that support separate
input rates. And with no glibc support for BOTHER (still), it's somewhat
less likely that people will trigger the bug that could end up setting
CIBAUD for them.

Thanks,
Johan
