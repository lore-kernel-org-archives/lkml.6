Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF77C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E30B21735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E30B21735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeH0LHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:07:53 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:48344 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726882AbeH0LHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:07:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2BD22100E86C3;
        Mon, 27 Aug 2018 07:22:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: form49_4f9a6980d761e
X-Filterd-Recvd-Size: 2363
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Aug 2018 07:22:26 +0000 (UTC)
Message-ID: <cf176d1aecc2590f0bfe8c4f22d968452392bd75.camel@perches.com>
Subject: Re: [PATCH] checkpatch: remove GCC_BINARY_CONSTANT warning
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 27 Aug 2018 00:22:25 -0700
In-Reply-To: <392eeae782302ee8812a3c932a602035deed1609.1535351453.git.christophe.leroy@c-s.fr>
References: <392eeae782302ee8812a3c932a602035deed1609.1535351453.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 06:59 +0000, Christophe Leroy wrote:
> This warning was there to avoid the use of 0bxxx values
> as they are not supported by gcc prior to v4.3
> 
> Since commit cafa0010cd51f ("Raise the minimum required gcc
> version to 4.6"), it's not an issue anymore and using
> such values can increase readability of code.

Seems sensible as the other compilers also support binary literals
from relatively old versions.
http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2012/n3472.pdf
https://software.intel.com/en-us/articles/c14-features-supported-by-intel-c-compiler

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  scripts/checkpatch.pl | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 5219280bf7ff..d98650790722 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4933,17 +4933,6 @@ sub process {
>  		while ($line =~ m{($Constant|$Lval)}g) {
>  			my $var = $1;
>  
> -#gcc binary extension
> -			if ($var =~ /^$Binary$/) {
> -				if (WARN("GCC_BINARY_CONSTANT",
> -					 "Avoid gcc v4.3+ binary constant extension: <$var>\n" . $herecurr) &&
> -				    $fix) {
> -					my $hexval = sprintf("0x%x", oct($var));
> -					$fixed[$fixlinenr] =~
> -					    s/\b$var\b/$hexval/;
> -				}
> -			}
> -
>  #CamelCase
>  			if ($var !~ /^$Constant$/ &&
>  			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
