Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1019C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17AB20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17AB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeK3OyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:54:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44129 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeK3OyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:54:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so2085076pfh.11;
        Thu, 29 Nov 2018 19:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mc2dHtJ5JW2Av4BDEJuLIpJVpsCh+RHJ6osld42rtz8=;
        b=i809+lhOqsEUrh9THOqnNMZ/hpH6Ag+ujZBAXUxllSROZ6fKc6kBFwARAgNPOkBaKQ
         V3EIuFJnG4FwTYPfrtu++lzSlCFDSB+0bd+pMSwv01zjBw7EaeHGlcX7Q5MYsSPJmXRM
         BVuaUivHxCXoZo7aMLfAez4ocewRBRo1NtuxuLVTOJTmwC1jbInuK2DZNoa5Ildc+1Uc
         6V7VuFbtFmEfqRe6JYd9VudLElpZYcSjP+4FLQtdZB45NKORTGA6SE+mK7fiLInuCGUs
         NtN17iN0CC8v2Zj5LGnQiopLjd3XnS/pA7TFCg8pgKDaZShsMV9gFOwok9pC643qO+Nz
         lCjw==
X-Gm-Message-State: AA+aEWZSfa/u6tY9vZHDp0wJ/gTEnnyh0z3Wbag1jJJj5dfnF821JNsE
        5qMXnB7gES0iqzU5SYA7yvo=
X-Google-Smtp-Source: AFSGD/X2akLhed6Ax/HPPRBINiTJIWyKcYYN6yd6JIEr09JfBxRCGznzoNwSC9pL8J+fNlKjRg+niw==
X-Received: by 2002:a62:7dcb:: with SMTP id y194mr4069225pfc.113.1543549587368;
        Thu, 29 Nov 2018 19:46:27 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id d16sm3906075pgj.21.2018.11.29.19.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:46:26 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:46:23 -0800
Date:   Thu, 29 Nov 2018 19:46:23 -0800
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
Subject: Re: [RFC v3 16/19] arch: um: make UML unflatten device tree when
 testing
Message-ID: <20181130034623.GQ18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-17-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-17-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:36:33AM -0800, Brendan Higgins wrote:
> Make UML unflatten any present device trees when running KUnit tests.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/um/kernel/um_arch.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index a818ccef30ca2..bd58ae3bf4148 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/task.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/of_fdt.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
> @@ -347,6 +348,9 @@ void __init setup_arch(char **cmdline_p)
>  	read_initrd();
>  
>  	paging_init();
> +#if IS_ENABLED(CONFIG_OF_UNITTEST)
> +	unflatten_device_tree();
> +#endif

*Why?*

  Luis
