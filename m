Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62DFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB36020867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB36020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeLAEIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:08:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:37198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726732AbeLAEIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:08:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B728DB0B7;
        Fri, 30 Nov 2018 16:58:24 +0000 (UTC)
Date:   Fri, 30 Nov 2018 17:58:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Perches <coupons@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RFC: script to convert vsprintf uses of %pf to %ps and %pF to %pS
Message-ID: <20181130165823.pmqw6l4fldfmwd2a@pathway.suse.cz>
References: <8eb7769cb8550e82105b71ba67fd603394e23b1e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb7769cb8550e82105b71ba67fd603394e23b1e.camel@perches.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2018-11-25 01:13:51, Joe Perches wrote:
> commit 04b8eb7a4ccd ("symbol lookup: introduce dereference_symbol_descriptor()}"
> 
> deprecated vsprintf extension %pf and %pF.
> 
> so a script to convert all the %pf uses to %ps and %pF uses to %pS
> could be useful.
> 
> There are a few files that appear should not be converted.
> 
> $ git grep -w --name-only -i '%pf'| \
>   grep -vP '^(?:Documentation|tools|include/linux/freezer.h)'| \
>   xargs sed -i -e 's/%pf/%ps/g' -e 's/%pF/%pS/g'
> 
> If that script above is run, it leaves the following patch
> to be applied:

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 37a54a6dd594..393002bf5298 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1872,8 +1870,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  	}
>  
>  	switch (*fmt) {
> -	case 'F':
> -	case 'f':

Please, keep handling these modifiers so that they do not get reused
anytime soon.

The pointer modifiers are evil. Any misuse can easily lead to a crash.
Any mistakes with upstreaming 3rd party patches or backporting stable
fixes would be hard to notice.

Well, it is perfectly fine to just explicitly fallback to
the default %p behavior. I mean something like:

	case 'F':
	case 'f':
		/* Replaced by %ps and %pS and removed in 4.21 */
		break;

Best Regards,
Petr
