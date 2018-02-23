Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AG47ELuGeedkQqEkYwIcwFMm4c6dEWBtq61hmmQIwoV75vrSJak8zsjeBq3CVbz9DwxRP/C6NRKP
ARC-Seal: i=1; a=rsa-sha256; t=1519382576; cv=none;
        d=google.com; s=arc-20160816;
        b=IjBe8NYC47F7Akqacm8KhDhl+yRmKZAS8QnDvRuq3l17VrIYMouVpMAcbNgG5YcxT3
         pnNy5CpZm0g3355TwcZ6wmygHNQsIQolqhg8fDYhAvflkVVxli/b9sd1uX1gF79ts6uU
         41bSAFvxk78PM6nCSlUu60pWB5ppeJmGoNLJuwkRJMWHAVrTZghOWszoXfSHXQfAVpGV
         yJQ6fNeDzh6MI4BbgL6sS1/Tq6ncFVxNzTamSY0mzDRc46lZlRqz0JGUltRaKPsLZijC
         8HyFeYY5cISfXfYz103zT3rlVrdjbO89d0wpSG9kVPRNSgznFHZLXx9U7kzPOzoZwC2I
         d0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=oWcaLhcjluvqO3fwhAQJd0XBJhR0/O+CrMNoShwaDUw=;
        b=nbNKuaB/KYmDxrbcwzKEZw5SZfabH56xm8FHeTWWS2koPMjxCZs0zznb5nVy8UkwdY
         bUC3G7pv1cIUk37rfUttWVoCWgXlGIudwh48P6Sj3dgDcgDK8Zs8NXaWW5GN2EK14Gro
         TVeJc1HEtr6+ovCpFcHStXRXiqqu50keyZ1IsUKw1og8RgYz+FaRWe+YDZ7vaBgKD3t1
         xlT+yBmI4IcDQxHhGi01U/oCD+qGiUye9cDHt8mmu7aGZ7bty61UbeU2NCjTEvZQe1LU
         FZOjWEh1Vuqo24G8FU2sA6SdwQCCSyp73b8s2KvZQ5zXaPSOmwBs7msOPZbrVv+XZTfj
         J3CQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Fri, 23 Feb 2018 11:42:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Seunghun Han <kkamagui@gmail.com>, Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86: mce: fix kernel panic when check_interval is changed
Message-ID: <20180223104239.GA4981@pd.tnic>
References: <20180223101350.8344-1-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180223101350.8344-1-kkamagui@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593188104653677420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 07:13:50PM +0900, Seunghun Han wrote:
> I am Seunghun Han and a senior security researcher at National Security
> Research Institute of South Korea.
> 
> I found a critical security issue which can make kernel panic in userspace.
> After analyzing the issue carefully, I found that MCE driver in the kernel
> has a problem which can be occurred in SMP environment.
> 
> The check_interval file in
> /sys/devices/system/machinecheck/machinecheck<cpu number> directory is a
> global timer value for MCE polling. If it is changed by one CPU, MCE driver
> in kernel calls mce_restart() function and broadcasts the event to other

Right, so I'm thinking that doing that per-CPU configuration doesn't
make a whole lot of sense. It is not something that needs to happen very
often and it is done globally anyway.

So what we should do here, IMO, is make mce_restart() grab a mutex and
thus serialize all those sysfs writes. It will naturally also slow down
any hammering from userspace which we should not allow anyway.

Tony, what do you think?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
