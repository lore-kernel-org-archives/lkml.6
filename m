Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DDBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3939F21527
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="eBzhy34m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3939F21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeLFMyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:54:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32984 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbeLFMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:54:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so146590plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jnhVml/Wvuu6M545Ryvy3sGsPX+FJeAhKdltS70izBQ=;
        b=eBzhy34mQsM0UzyLHWOwfy4NaAYo6VzG3DOazN86pVL6RkIZk9Sy95ZbL5gupBlip+
         itgIc8ZAHlFgvdbn1boPxLMlmBCiAE6xessfW0I9Jr15eHZV0ggLAzKyD4e7eCyoDRzR
         SPRgmOKorMjtUvouprkzb/hneXbbAjKNlX1H/iMulJtrfKKoyv4kHC/Je60u2v5IeODZ
         IA3J2WLjDsEJb6S+nWqZVZOd26XYHAm0xd8mkcfTSnkRC3b49gQf0vSOX3QdILFX/T1L
         Ql8ZMK9VmTDzdsZZY9t+P1hC6WUNVfB6dxKWn8ue1dMcLVGsnVBuOrZyOcFTwCzr3sf8
         8L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jnhVml/Wvuu6M545Ryvy3sGsPX+FJeAhKdltS70izBQ=;
        b=m6FT9J0sqeRjv6siv+EWN5onfEKosoB0zamhUZJAamKcjsZyzz+ZP2BMkPj+5RaGBf
         GkFcrc2FkKfjRePvoqznDAAeO5iYkqYEuC2OUG/Uuynd0jezKOfZegzLM4/6DzGwNh+p
         vat3X0H/lBfcoDxmMnP1p3JvGSNb7wnYWCsZ6+kVW9b9DF2r71/tEZroPkHi1RMOxqAW
         jwS8t6pwShLGqEhhTqc/rCptiYRUOwDgHd9oD33ltKgCbxMibylBnaQdUliu6h2gZTVy
         XuF20s60mu6EDtaKufUMEZgiTuZqJOATyxlzJhlp/eVo8B5FBjdgbfbn1DDoFdH1nbyG
         A/6w==
X-Gm-Message-State: AA+aEWZ+6qQek08gOpYHN5BcakU4848EWeIsFX6ilmGJNJ+8tT4r4wVm
        m8U7LdTu+b9VuJS+1Yqp15cybw==
X-Google-Smtp-Source: AFSGD/Vsopd7FWDOoH+LgCSJ6R6m3dT/AoDOwbMOHzs+JL7TOGt/Mn3rJQYrz0OV6vEFA6peo/k9gA==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr27017811pla.47.1544100847528;
        Thu, 06 Dec 2018 04:54:07 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:b824:a031:b50e:f401])
        by smtp.gmail.com with ESMTPSA id l19sm1600297pfi.71.2018.12.06.04.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:54:06 -0800 (PST)
Date:   Thu, 6 Dec 2018 13:53:57 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        serge@hallyn.com, jannh@google.com, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
Message-ID: <20181206125354.ef3zlg3o75w32ymx@brauner.io>
References: <20181206121858.12215-1-christian@brauner.io>
 <87h8fq7s84.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h8fq7s84.fsf@oldenburg2.str.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:30:19PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > /* zombies */
> > Zombies can be signaled just as any other process. No special error will be
> > reported since a zombie state is an unreliable state (cf. [3]).
> 
> I still disagree with this analysis.  If I know that the target process
> is still alive, and it is not, this is a persistent error condition
> which can be reliably reported.  Given that someone might send SIGKILL
> to the process behind my back, detecting this error condition could be
> useful.

Apart from my objection that this is not actually a reliable state
because of timing issues between e.g. calling wait and a process exiting
I have two more concerns and one helpful suggestion.
First, this is hooking pretty deep into kernel internals. So far
EXIT_ZOMBIE is only exposed in kernel/exit.c and I don't see enough
value to drag all of this into kernel/signal.c
Second, all other signal syscalls don't do report errors when signaling
to zombies as well. It would be odd if this one suddenly did.
Third, if this really becomes such a big issue for userspace in the
future that we want to do that work then we can add a flag like
TASKFD_DETECT_ZOMBIE (or some such name) that will allow userspace to
get an error back when signaling a zombie.
As far as I'm concerned, this is out of scope for an initial
implementation. We are going to use fds for tasks that's enough
excitement for one patchset!

> 
> Rest looks good to me (with the usual caveats).

I take it that's your way of saying Acked-by? :)

Christian
