Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AEAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E52D20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544086368;
	bh=BzFWBREUrqO0isvyc2ns3PaHQJ2GaGecFlGc9XK0XHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QvQoPcApLH16sC9BeAprt2nD+456zm2VTP3WWJW3lMXzrPGGG2HhPxwc0ZPxMJGit
	 auYcFIQZzRgUsI+VA6Kp4/eVWxHNIFLXvflej/ys1M2deOopz18ProIbPzX3YIL4Jp
	 Y6Yz1jZxFr5e1eSrZtMYlQ/HGt6pU2RAZBU5zJXU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E52D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeLFIwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:52:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43322 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:52:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so10335307pgk.10;
        Thu, 06 Dec 2018 00:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdBsaVY95wa4qiacnYzRDofddx6W9Q6XiFfXLWmnB4Q=;
        b=sJOrGBScWd8KGWpw3qgRbiyvgSgHEjKhm6vLILqzqwmnrr9lTXZjrtIXGZNEawwAuq
         IVNcddiDwIE/XJriTTsBzxIc4WlVzJ9w4Twto4fAorblKWKFPhQYZfCz6DH1LV/z4Eaj
         1zN8JNI7v/JJDFDIa1sRsr5oN1NQV7+QU/4mGU/JXwVG82OsLX/BRw5XMa3GOcIKMyeP
         IWg6FozLX7vVC3sJxppW2BaNl18xO9KiySKhIWeYFNulKo/vZZ9zmfxKYuFrbUtiYUdn
         kikuxb0gHfb4c0c34eGQUDxYV+zEIxkrsv7nWKpm0ZRp5I/KrydPgeq2SkkMU8KG0Nuh
         av0Q==
X-Gm-Message-State: AA+aEWaGNzi6VpdE9es5kcmBXAp8RDV1Usr2sWMOgakyGD8IrtPd8ljg
        3Y+8Bt5aJ/aFmUKKS5EgCyc=
X-Google-Smtp-Source: AFSGD/XZMbhKXsBaF3Mc3Z1M8TMVH9oGTv7eJKSgZElPRw9Bg4MrFlYiARRFOFfeeMF2FAYI6sio7Q==
X-Received: by 2002:a63:5122:: with SMTP id f34mr22435124pgb.218.1544086365322;
        Thu, 06 Dec 2018 00:52:45 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id t2sm38212844pfm.32.2018.12.06.00.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 00:52:44 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 06 Dec 2018 00:52:42 -0800
Date:   Thu, 6 Dec 2018 00:52:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Cheng Lin <cheng.lin130@zte.com.cn>, akpm@linux-foundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH] proc/sysctl: fix return error for proc_doulongvec_minmax
Message-ID: <20181206085242.GG28501@garbanzo.do-not-panic.com>
References: <1544081775-15720-1-git-send-email-cheng.lin130@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544081775-15720-1-git-send-email-cheng.lin130@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:36:15PM +0800, Cheng Lin wrote:
> If the number of input parameters is less than the total
> parameters, an EINVAL error will be returned.
> 
> e.g.
> We use proc_doulongvec_minmax to pass up to two parameters
> with kern_table.
> 
> {
> 	.procname       = "monitor_signals",
> 	.data           = &monitor_sigs,
> 	.maxlen         = 2*sizeof(unsigned long),
> 	.mode           = 0644,
> 	.proc_handler   = proc_doulongvec_minmax,
> },
> 
> Reproduce:
> When passing two parameters, it's work normal. But passing
> only one parameter, an error "Invalid argument"(EINVAL) is
> returned.
> 
> [root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
> [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> 1       2
> [root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
> -bash: echo: write error: Invalid argument
> [root@cl150 ~]# echo $?
> 1
> [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> 3       2
> [root@cl150 ~]#
> 
> The following is the result after apply this patch. No error
> is returned when the number of input parameters is less than
> the total parameters.
> 
> [root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
> [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> 1       2
> [root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
> [root@cl150 ~]# echo $?
> 0
> [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> 3       2
> [root@cl150 ~]#
> 
> There are three processing functions dealing with digital parameters,
> __do_proc_dointvec/__do_proc_douintvec/__do_proc_doulongvec_minmax.
> 
> This patch deals with __do_proc_doulongvec_minmax, just as
> __do_proc_dointvec does, adding a check for parameters 'left'. In
> __do_proc_douintvec, its code implementation explicitly does not
> support multiple inputs.
> 
> static int __do_proc_douintvec(...){
>          ...
>          /*
>           * Arrays are not supported, keep this simple. *Do not* add
>           * support for them.
>           */
>          if (vleft != 1) {
>                  *lenp = 0;
>                  return -EINVAL;
>          }
>          ...
> }
> 
> So, just __do_proc_doulongvec_minmax has the problem. And most use of
> proc_doulongvec_minmax/proc_doulongvec_ms_jiffies_minmax just have one
> parameter.
> 
> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>

Thanks for fixing up the commit log.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

I think we can live with this outside of stable. So stable is not
needed. But I would not be surprised if autosel algorithm will end
up picking it up. And if so.. well, it cannot hurt.

  Luis
