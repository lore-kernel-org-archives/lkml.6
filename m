Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3778BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB7D2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB7D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbeIXWzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:55:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:55667 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbeIXWzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:55:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 09:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="75801172"
Received: from mjmartin-mac01.sea.intel.com ([10.241.98.37])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2018 09:52:41 -0700
Date:   Mon, 24 Sep 2018 09:52:41 -0700 (PDT)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
X-X-Sender: mjmartin@mjmartin-mac01.local
To:     David Howells <dhowells@redhat.com>, jmorris@namei.org
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Stephan Mueller <smueller@chronox.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] keys: Fix the use of the C++ keyword "private" in
 uapi/linux/keyctl.h
In-Reply-To: <153779152340.28003.6461494237075964365.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.OSX.2.21.1809240941550.2707@mjmartin-mac01.local>
References: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk> <153779152340.28003.6461494237075964365.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Sep 2018, David Howells wrote:

> The keyctl_dh_params struct in uapi/linux/keyctl.h contains the symbol
> "private" which means that the header file will cause compilation failure
> if #included in to a C++ program.  Further, the patch that added the same
> struct to the keyutils package named the symbol "priv", not "private".
>
> The previous attempt to fix this (commit 8a2336e549d3) did so by simply
> renaming the kernel's copy of the field to dh_private, but this then breaks
> existing userspace and as such has to be reverted (which is done by the
> preceding patch).
>
> [And note, to those who think that wrapping the struct in extern "C" {}
> will work: it won't; that only changes how symbol names are presented to
> the assembler and linker.].
>
> Instead, insert an anonymous union around the "private" member and add a
> second member in there with the name "priv" to match the one in the
> keyutils package.  The "private" member is then wrapped in !__cplusplus
> cpp-conditionals to hide it from C++.
>
> Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")
> Fixes: 8a2336e549d3 ("uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name")
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
> include/uapi/linux/keyctl.h |    7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
> index 7b8c9e19bad1..0f3cb13db8e9 100644
> --- a/include/uapi/linux/keyctl.h
> +++ b/include/uapi/linux/keyctl.h
> @@ -65,7 +65,12 @@
>
> /* keyctl structures */
> struct keyctl_dh_params {
> -	__s32 private;
> +	union {
> +#ifndef __cplusplus
> +		__s32 private;
> +#endif
> +		__s32 priv;
> +	};
> 	__s32 prime;
> 	__s32 base;
> };
>
>

Thanks David. This is an important fix for existing C userspace code, it 
would create a headache now and in to the future if the keyctl.h change 
introduced in v4.19-rc3 made it in to an official release. Please merge, 
James!

Reviewed-By: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel OTC
