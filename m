Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6A6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBBA21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBBA21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbeIXS2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:28:22 -0400
Received: from shell.v3.sk ([90.176.6.54]:59517 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbeIXS2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:28:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2E400BA2BE;
        Mon, 24 Sep 2018 14:26:25 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1s9V2I8mGPUd; Mon, 24 Sep 2018 14:26:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 969D4BA2C7;
        Mon, 24 Sep 2018 14:26:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3quoi8CC8HyA; Mon, 24 Sep 2018 14:26:21 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B7FE4BA2BE;
        Mon, 24 Sep 2018 14:26:20 +0200 (CEST)
Message-ID: <36648a680e0e7ebd4ce77f3a13056f38ac7ade36.camel@v3.sk>
Subject: Re: [PATCH 2/2] keys: Fix the use of the C++ keyword "private" in
 uapi/linux/keyctl.h
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     David Howells <dhowells@redhat.com>, jmorris@namei.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Sep 2018 14:26:19 +0200
In-Reply-To: <153779152340.28003.6461494237075964365.stgit@warthog.procyon.org.uk>
References: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
         <153779152340.28003.6461494237075964365.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.0 (3.30.0-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 13:18 +0100, David Howells wrote:
> The keyctl_dh_params struct in uapi/linux/keyctl.h contains the
> symbol
> "private" which means that the header file will cause compilation
> failure
> if #included in to a C++ program.  Further, the patch that added the
> same
> struct to the keyutils package named the symbol "priv", not
> "private".
> 
> The previous attempt to fix this (commit 8a2336e549d3) did so by
> simply
> renaming the kernel's copy of the field to dh_private, but this then
> breaks
> existing userspace and as such has to be reverted (which is done by
> the
> preceding patch).
> 
> [And note, to those who think that wrapping the struct in extern "C"
> {}
>  will work: it won't; that only changes how symbol names are
> presented to
>  the assembler and linker.].
> 
> Instead, insert an anonymous union around the "private" member and
> add a
> second member in there with the name "priv" to match the one in the
> keyutils package.  The "private" member is then wrapped in
> !__cplusplus
> cpp-conditionals to hide it from C++.
> 
> Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")
> Fixes: 8a2336e549d3 ("uapi/linux/keyctl.h: don't use C++ reserved
> keyword as a struct member name")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Randy Dunlap <rdunlap@infradead.org>
> cc: Lubomir Rintel <lkundrak@v3.sk>
> cc: James Morris <jmorris@namei.org>
> cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> cc: Stephan Mueller <smueller@chronox.de>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: stable@vger.kernel.org
> ---
> 
>  include/uapi/linux/keyctl.h |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/keyctl.h
> b/include/uapi/linux/keyctl.h
> index 7b8c9e19bad1..0f3cb13db8e9 100644
> --- a/include/uapi/linux/keyctl.h
> +++ b/include/uapi/linux/keyctl.h
> @@ -65,7 +65,12 @@
>  
>  /* keyctl structures */
>  struct keyctl_dh_params {
> -	__s32 private;
> +	union {
> +#ifndef __cplusplus
> +		__s32 private;
> +#endif
> +		__s32 priv;
> +	};
>  	__s32 prime;
>  	__s32 base;
>  };
> 

Thank you, checked that this works fine for libell build.

Tested-by: Lubomir Rintel <lkundrak@v3.sk>

Perhaps you may want to call the C++ friendly field "dh_private",
because there might be C++ users that utilize it already. (The chance
might be negligible though.).

Lubo

