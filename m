Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8696C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9678C20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RfAXzpUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfBEQhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:37:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35255 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEQhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:37:42 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so4542914qtc.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 08:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IrIiRZr4Bnb8UsADj+9gJXt7XSlyw7YRnrJhcYbXoEc=;
        b=RfAXzpUbO+RDhCb5DMyUVG3U5qOtq7asD7BZpXWxD+IMwyHyaD6TDpLQqUm/aVNC5G
         6Or3VpkwBWQ57QRkDqQpVcTA1mmfVMwUeykA+3LPVcA9HnZyBCMONmD966PoIGxC58PL
         Um5RU+2CtMz+9QYKF/WeUIPurJTaeBC2mEioA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IrIiRZr4Bnb8UsADj+9gJXt7XSlyw7YRnrJhcYbXoEc=;
        b=rqxsisUbVc5ptjoIF3AYjClVFq/1/L5gnUcnoK+6n9QiWrBkbeLMrNYXyAseQREzPB
         J2L6koW74Eq5jDkFW2Mv6+ku2B4dBgJPJPd1/QHG0qUeSqGG8poe3nDX5u6AGIFDLv+B
         SMD5izRrQNxYFpTANZ7hmwx5UIgLw7IgWajGqsVMkSqKTzd7NWc19kpAxMMMOSW35G87
         MzD4RhLF177T2zwjvB/7SOsZow0V7P1pByTRBVTh/0H9MOVklEApQVHPszztCVrojQH7
         V9C4HTrG4xaQkgO4GESRfpoG82wlJNVJT4GfHrS9nV2jKRzW68arlBn3TFnFMd+/cXEK
         WmdA==
X-Gm-Message-State: AHQUAuaEL9Fqm5oeJO6a25ofdpx3BU7RNQJ+ZGCgOmrjlNUXzqGL5uKu
        E5ErinjamKLTNZV60PF9aCqQQQ==
X-Google-Smtp-Source: AHgI3Ib9bwSvTXWPc+EwmnWS2AxaZ1bHIWGG52EtGTz7umQDf6qcSM3v9ZBVX1c5u8Wf/0Ssrvu4Tw==
X-Received: by 2002:a0c:e610:: with SMTP id z16mr4449698qvm.81.1549384661472;
        Tue, 05 Feb 2019 08:37:41 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id j129sm7919883qkd.18.2019.02.05.08.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 08:37:40 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:37:39 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/wait: use freezable_schedule when possible
Message-ID: <20190205163739.GD46829@google.com>
References: <cover.1548998323.git.hle@owl.eu.com>
 <d9b2ed186ed6fcacaaecd876bb66dca8fa329d8b.1548998323.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b2ed186ed6fcacaaecd876bb66dca8fa329d8b.1548998323.git.hle@owl.eu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 06:38:05AM +0100, Hugo Lefeuvre wrote:
> Replace schedule(); try_to_freeze() by freezable_schedule().
> 
> Tasks calling freezable_schedule() set the PF_FREEZER_SKIP flag
> before calling schedule(). Unlike tasks calling schedule();
> try_to_freeze() tasks calling freezable_schedule() are not awaken by
> try_to_freeze_tasks(). Instead they call try_to_freeze() when they
> wake up if the freeze is still underway.
> 
> It is not a problem since sleeping tasks can't do anything which isn't
> allowed for a frozen task while sleeping.
> 
> The result is a potential performance gain during freeze, since less
> tasks have to be awaken.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---
>  include/linux/wait.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index ed7c122cb31f..5f3efabc36f4 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -308,7 +308,7 @@ do {										\
>  
>  #define __wait_event_freezable(wq_head, condition)				\
>  	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,		\
> -			    schedule(); try_to_freeze())
> +			    freezable_schedule())
>  
>  /**
>   * wait_event_freezable - sleep (or freeze) until a condition gets true
> @@ -367,7 +367,7 @@ do {										\
>  #define __wait_event_freezable_timeout(wq_head, condition, timeout)		\
>  	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
>  		      TASK_INTERRUPTIBLE, 0, timeout,				\
> -		      __ret = schedule_timeout(__ret); try_to_freeze())
> +		      __ret = freezable_schedule_timeout(__ret))
>  
>  /*
>   * like wait_event_timeout() -- except it uses TASK_INTERRUPTIBLE to avoid
> @@ -588,7 +588,7 @@ do {										\
>  
>  #define __wait_event_freezable_exclusive(wq, condition)				\
>  	___wait_event(wq, condition, TASK_INTERRUPTIBLE, 1, 0,			\
> -			schedule(); try_to_freeze())
> +			freezable_schedule())
>  
>  #define wait_event_freezable_exclusive(wq, condition)				\
>  ({										\
> -- 
> 2.20.1
