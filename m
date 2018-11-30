Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F26C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E1C20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E1C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeK3OmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:42:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45576 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3OmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:42:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so2070949plm.12;
        Thu, 29 Nov 2018 19:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MnXZg5AtwlXWTftPArgKc5HGnCu1D67n4ZGGVgcUZhQ=;
        b=UgzskekssHA2U+YlcF+KmlLwpcFrSb6yX2WQz96t00yRC484uPMcvSzd2hIuK0h8sK
         5WIIjjEQlnkSlxYt93Zt9FLq/9Ga8oV4+ZE20mwu+i7Eya0SzxDRejZlx6tRu+QCxb0n
         oV+hqcOwL57x+tDlQsrPQBt16rZ3ecyqQIUK10CMwR1evPzCwiL+Pp+KuSRmMive3T/D
         i/deawD7abiWhyeJSCRP6zAjgx38vLk5LTiceRgK4cG2IZsIYuPGaN9u46VlxnzgrTAd
         Fl6pNLqoE//XyXVYhwlyhzdfCd3iJ8UplHk7+A2JsG46IJmBk+4qe/EjIHgkB7ZK/RbK
         cbBg==
X-Gm-Message-State: AA+aEWZs+ORgXjHYX0v0TI0wFyQ0IXPLxPy19n+qmgd2gtr5x8QdcXWa
        51gVeBtnaMSo2SeewVCN6Ik=
X-Google-Smtp-Source: AFSGD/VmEJoNziTJpcsjF8+VjcHCdzxNWiQdBr2oM4cCtSOrtNh/vnkG4OYGS76WL8HtRRecg4QEVw==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr3030934plb.104.1543548873616;
        Thu, 29 Nov 2018 19:34:33 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id n22sm5965128pfh.166.2018.11.29.19.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:34:32 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:34:29 -0800
Date:   Thu, 29 Nov 2018 19:34:29 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, keescook@google.com, shuah@kernel.org,
        joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com
Subject: Re: [RFC v3 08/19] arch: um: add shim to trap to allow installing a
 fault catcher for tests
Message-ID: <20181130033429.GK18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-9-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:36:25AM -0800, Brendan Higgins wrote:
> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index cced829460427..bf90e678b3d71 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -201,6 +201,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>  	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
>  }
>  
> +static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
> +{
> +	current->thread.fault_addr = fault_addr;
> +	UML_LONGJMP(catcher, 1);
> +}
> +
>  /*
>   * We give a *copy* of the faultinfo in the regs to segv.
>   * This must be done, since nesting SEGVs could overwrite
> @@ -219,7 +225,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>  	if (!is_user && regs)
>  		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
>  
> -	if (!is_user && (address >= start_vm) && (address < end_vm)) {
> +	catcher = current->thread.fault_catcher;

This and..

> +	if (catcher && current->thread.is_running_test)
> +		segv_run_catcher(catcher, (void *) address);
> +	else if (!is_user && (address >= start_vm) && (address < end_vm)) {
>  		flush_tlb_kernel_vm();
>  		goto out;
>  	}

*not this*

> @@ -246,12 +255,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>  		address = 0;
>  	}
>  
> -	catcher = current->thread.fault_catcher;
>  	if (!err)
>  		goto out;
>  	else if (catcher != NULL) {
> -		current->thread.fault_addr = (void *) address;
> -		UML_LONGJMP(catcher, 1);
> +		segv_run_catcher(catcher, (void *) address);
>  	}
>  	else if (current->thread.fault_addr != NULL)
>  		panic("fault_addr set but no fault catcher");

But with this seems one atomic change which should be submitted
separately, its just a helper. Think it would make the actual
change needed easier to review, ie, your needed changes would
be smaller and clearer for what you need.

  Luis
