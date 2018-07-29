Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06399C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 13:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A4F20873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 13:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeG2P34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 11:29:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbeG2P34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 11:29:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D8EE40216FD;
        Sun, 29 Jul 2018 13:59:22 +0000 (UTC)
Received: from treble (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02DCC2166BA2;
        Sun, 29 Jul 2018 13:59:21 +0000 (UTC)
Date:   Sun, 29 Jul 2018 08:59:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] net: socket: fix potential spectre v1 gadget in
 socketcall
Message-ID: <20180729135920.a2zo6de4f7chszgd@treble>
References: <20180727224302.5503-1-jcline@redhat.com>
 <20180727224302.5503-2-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180727224302.5503-2-jcline@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 29 Jul 2018 13:59:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 29 Jul 2018 13:59:22 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:43:01PM +0000, Jeremy Cline wrote:
> 'call' is a user-controlled value, so sanitize the array index after the
> bounds check to avoid speculating past the bounds of the 'nargs' array.
> 
> Found with the help of Smatch:
> 
> net/socket.c:2508 __do_sys_socketcall() warn: potential spectre issue
> 'nargs' [r] (local cap)
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  net/socket.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 3015ddace71e..f15d5cbb3ba4 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -89,6 +89,7 @@
>  #include <linux/magic.h>
>  #include <linux/slab.h>
>  #include <linux/xattr.h>
> +#include <linux/nospec.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
> @@ -2504,6 +2505,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
>  
>  	if (call < 1 || call > SYS_SENDMMSG)
>  		return -EINVAL;
> +	call = array_index_nospec(call, SYS_SENDMMSG + 1);
>  
>  	len = nargs[call];
>  	if (len > sizeof(a))

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
