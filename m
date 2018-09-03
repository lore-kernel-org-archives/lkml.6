Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247E620862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247E620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeICXWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:22:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:49780 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbeICXWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:22:15 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 57FE84B7;
        Mon,  3 Sep 2018 19:00:44 +0000 (UTC)
Date:   Mon, 3 Sep 2018 13:00:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] docs: kernel-doc: fix parsing of function pointers
Message-ID: <20180903130043.059b2e82@lwn.net>
In-Reply-To: <20180903184153.9368-1-xypron.glpk@gmx.de>
References: <20180903184153.9368-1-xypron.glpk@gmx.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Sep 2018 20:41:53 +0200
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> The same script kernel-doc is used by the U-Boot project.

Interesting, I didn't know that.  Please pass on my condolences :)
> 
> kernel-doc fails to parse function definitions like the one below
> 
> efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
> 			      void (EFIAPI *notify_function) (
> 					struct efi_event *event,
> 					void *context),
> 			      void *notify_context, efi_guid_t *group,
> 			      struct efi_event **event)
> {
> 
> due to the "EFIAPI" attribute preceding the function name.

This is a good description of the problem; a proper changelog should
really say what the patch *does* about the problem too.  Especially
since...

> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 31a34ced55a3..597e3223b791 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1381,7 +1381,7 @@ sub create_parameterlist($$$$) {
>  	} elsif ($arg =~ m/\(.+\)\s*\(/) {
>  	    # pointer-to-function
>  	    $arg =~ tr/#/,/;
> -	    $arg =~ m/[^\(]+\(\*?\s*([\w\.]*)\s*\)/;
> +	    $arg =~ m/[^\(]+\([\w\s]*\*?\s*([\w\.]*)\s*\)/;

The meaning of this change doesn't just jump off the screen, even for
folks who are accustomed to reading regexes.  It would be nice to explain
what is actually being changed and what the expected new behavior is.  It
appears to be consuming any normal text/white space prior to the optional
"*".  Are you sure it doesn't overshoot and consume too much if the *
isn't there?

Thanks,

jon
