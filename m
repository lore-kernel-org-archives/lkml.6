Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5F4C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F4B2488E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F4B2488E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFVU00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:26:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeFVU0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20845401EF2B;
        Fri, 22 Jun 2018 20:26:25 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EF862026D6C;
        Fri, 22 Jun 2018 20:26:22 +0000 (UTC)
Date:   Fri, 22 Jun 2018 16:24:36 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: use ktime_get_coarse_ts64() for time access
Message-ID: <20180622202436.tlowdotb2xo4pc6l@madcap2.tricolour.ca>
References: <20180618145954.785509-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618145954.785509-1-arnd@arndb.de>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 22 Jun 2018 20:26:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 22 Jun 2018 20:26:25 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-18 16:58, Arnd Bergmann wrote:
> The API got renamed for consistency with the other time accessors,
> this changes the audit caller as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This looks reasonable to me.
Not that I think it matters, but any reason it was swapped in a
different code location other than aesthetics?  Time and serial are
usually used together in our code.

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  kernel/audit.c   | 2 +-
>  kernel/auditsc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index e7478cb58079..3e34b9f03cfe 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1724,7 +1724,7 @@ static inline void audit_get_stamp(struct audit_context *ctx,
>  				   struct timespec64 *t, unsigned int *serial)
>  {
>  	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
> -		*t = current_kernel_time64();
> +		ktime_get_coarse_ts64(t);
>  		*serial = audit_serial();
>  	}
>  }
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ceb1c4596c51..dbbf02f513a8 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1540,10 +1540,10 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
>  	context->argv[2]    = a3;
>  	context->argv[3]    = a4;
>  	context->serial     = 0;
> -	context->ctime = current_kernel_time64();
>  	context->in_syscall = 1;
>  	context->current_state  = state;
>  	context->ppid       = 0;
> +	ktime_get_coarse_ts64(&context->ctime);
>  }
>  
>  /**
> -- 
> 2.9.0
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
