Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B579EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787292080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="DrhQbYyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787292080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbeLBIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:52:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42048 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeLBIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:52:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so4355499pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RMrIen/LRHOl2HZrbqYZRWmFC7QRASiww05V4sz6XEI=;
        b=DrhQbYywoKHUAG2EE73CFiKsxuqdQ0SzEScsLyFBzd06H/LEJSpj+ObA4PhUz1ev5l
         Fu4g5c4mccTqKC1JA0AWCqOk/pKeLVU8awhZ0+TCPCnctBj6610UKMB7AS92F0/5FwJm
         A9Ydl0J3IQ+Ce4FzDIF7ryBkuNr/s7Gc0LE+GU3pSy584O+/VU5UzApo3N5ubF/Je4HS
         cmrLeB8yv6F4pLKUKMdG8i/BAMi1WghJI0vbv8uBYN19HB0Xr2FXTak4Hy+JxFOFCwqF
         Pwni2M9WOQMkyQaHf7jiVgTZK9t4sT3Hsc8h+dNkNT505EAHNyd+DgquaeN/9TnZKPWR
         tU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RMrIen/LRHOl2HZrbqYZRWmFC7QRASiww05V4sz6XEI=;
        b=a8mK2NZkKWqV6wEBvTGxWIPAQ3zXrudD1DpDoW2dOFVUF0nDcO1vUd89obhLTAy8Rz
         H2nztd4Z+QntAQHuYp/YLGs4WAnCCH5tzTK2VMjM5rEEVJIdgrRV4dYVrSfTgTqvlJeZ
         gyKP8npJpXSgywxVVuiqRXbkqMxuAMnENo7goHOy5JivrohBasL9d2lYZHQbXKvcH8HS
         PlpvXBytJPGJstNmF3qjd1+f6F3zeqZcBu/KaAQdoObEsCqM5zXB3gsOcKMWR8jHZ5GV
         FBaqQJuHqOJIqiWkOAHF6Ywn9TNvR5EM6Xe3aaW6cJ8sYf9EJzlQWNisZEbXnDmAnJa8
         rnTQ==
X-Gm-Message-State: AA+aEWbN5ZWCO0JWyB1boI4wzpXuv07ZykmhJJYEfTjIdQ3ShJGlWnQy
        EjVeFK6aaa47pWl06RxJAwdIBQ==
X-Google-Smtp-Source: AFSGD/X6A7c+k+9p1w1KCh5o3RYXZ0rNvrWzm6lTs3k9SqhVxKH+yogX9DowopbyX1WmfI6BgO+G5w==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr8618065pgk.147.1543740759354;
        Sun, 02 Dec 2018 00:52:39 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:ad2e:14cc:5849:819])
        by smtp.gmail.com with ESMTPSA id d25sm13866300pfe.40.2018.12.02.00.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 00:52:38 -0800 (PST)
Date:   Sun, 2 Dec 2018 09:52:29 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
Message-ID: <20181202085227.6krrxtxermxd7pcq@brauner.io>
References: <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io>
 <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
 <87y39b2lm2.fsf@xmission.com>
 <20181130065606.kmilbbq46oeycjp5@brauner.io>
 <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com>
 <87y399s3sc.fsf@xmission.com>
 <87tvjxp8pc.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvjxp8pc.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 09:28:47AM -0600, Eric W. Biederman wrote:
> 
> It just occurs to me that the simple way to implement
> procfd_sigqueueinfo info is like:
> 
> int copy_siginfo_from_user_any(kernel_siginfo_t *info, siginfo_t *uinfo)
> {
> #ifdef CONFIG_COMPAT
> 	if (in_compat_syscall)
> 		return copy_siginfo_from_user32(info, uinfo);

Right, though that would require a cast afaict.

static int __copy_siginfo_from_user_generic(int signo, kernel_siginfo_t *kinfo,
                                           siginfo_t *info)
{
#ifdef CONFIG_COMPAT
       if (in_compat_syscall())
               return __copy_siginfo_from_user32(
                       signo, kinfo, (struct compat_siginfo __user *)info);
#endif
       return __copy_siginfo_from_user(signo, kinfo, info);
}

It seems that a cast to (compat_siginfo __user *) should be safe in this
context? I've at least seen similar things done for __sys_sendmsg().

> #endif
> 	return copy_siginfo_from_user(info, uinfo);                        
> }
> 
> long procfd_sigqueueinfo(int fd, siginfo_t *uinfo)

**bikeshedding**
Not a fan of that name. I'm going to go with procfd_send_signal().
sigqueue gives non-native speakers a lot of room for spelling errors and
it always seemed opaque to me what this function is doing without
consulting the manpage. :)

> {
> 	kernel_siginfo info;
> 
>         if (copy_siginfo_from_user_any(&info, uinfo))
>         	return -EFAULT;
> 	...;                
> }
> 
> It looks like there is already a place in ptrace.c that already
> hand rolls copy_siginfo_from_user_any.
> 
> So while I would love to figure out the subset of siginfo_t tha we can
> just pass through, as I think that would make a better more forward
> compatible copy_siginfo_from_user32.  I think for this use case we just
> add the in_compat_syscall test and then we just need to ensure this new
> system call is placed in the proper places in the syscall table.
> 
> Because we will need 3 call sights: x86_64, x32 and ia32.  As the layout
> changes between those three subarchitecuters.
> 
> Eric
> 
