Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE389C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9611B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9611B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJRMAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:00:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbeJRMAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:00:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 792E130DF710;
        Thu, 18 Oct 2018 04:01:24 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8729E76500;
        Thu, 18 Oct 2018 04:01:23 +0000 (UTC)
Date:   Thu, 18 Oct 2018 12:01:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v9 1/8] x86/boot: Introduce cmdline_find_option_arg()to
 detect if option=arg in cmdline
Message-ID: <20181018040120.GB1885@192.168.1.4>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017102012.872-2-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 18 Oct 2018 04:01:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 at 06:20pm, Chao Fan wrote:
> +bool cmdline_find_option_arg(const char *option, const char *arg, int argsize)
> +{
> +	char *buffer = malloc(argsize+1);
> +	bool find = false;
> +	int ret;
> +
> +	ret = cmdline_find_option(option, buffer, argsize+1);
> +	if (ret == argsize && !strncmp(buffer, arg, argsize))
> +		find = true;

Wondering if we really need a wrapper like this. 

> +
> +	free(buffer);
> +	return find;
> +}
>  
>  #endif
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index a1d5918765f3..008fdc47a29c 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -67,6 +67,7 @@ static inline void debug_puthex(const char *s)
>  /* cmdline.c */
>  int cmdline_find_option(const char *option, char *buffer, int bufsize);
>  int cmdline_find_option_bool(const char *option);
> +bool cmdline_find_option_arg(const char *option, const char *arg, int argsize);
>  #endif
>  
>  
> -- 
> 2.17.2
> 
> 
> 
