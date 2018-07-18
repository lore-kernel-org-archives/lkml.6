Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B625ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75FB205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75FB205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGRQ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:29:04 -0400
Received: from smtprelay0064.hostedemail.com ([216.40.44.64]:54985 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731003AbeGRQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:29:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A869C181D3977;
        Wed, 18 Jul 2018 15:50:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grip41_49049f6e1f31
X-Filterd-Recvd-Size: 2041
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Jul 2018 15:50:31 +0000 (UTC)
Message-ID: <1e12a8ef88f4b918b051c064094effde8c4e7a40.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Resolve improper warning for krealloc arg
 reuse
From:   Joe Perches <joe@perches.com>
To:     Manish Narani <manish.narani@xilinx.com>, apw@canonical.com,
        linux-kernel@vger.kernel.org
Cc:     anirudh@xilinx.com, sgoud@xilinx.com, svemula@xilinx.com
Date:   Wed, 18 Jul 2018 08:50:29 -0700
In-Reply-To: <1531922148-7423-1-git-send-email-manish.narani@xilinx.com>
References: <1531922148-7423-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 19:25 +0530, Manish Narani wrote:
> Correct the check for reuse of krealloc. It gives false warning when a
> structure member variable name and krealloc argument name is same.
> 
> For Example:
> {
> 	...
> 	abc.def_var = krealloc(def_var, sizeof(*def_var),
> 				    GFP_KERNEL);
> 	...
> }
> 
> $ ./scripts/checkpatch.pl -f file.c
> 
> WARNING: Reusing the krealloc arg is almost always a bug
> +	abc.def_var = krealloc(def_var, sizeof(*def_var),
> 
> This patch resolves the above false warning.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6119,7 +6119,7 @@ sub process {
>  
>  # check for krealloc arg reuse
>  		if ($^V && $^V ge 5.10.0 &&
> -		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/) {
> +		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/ && $line !~ m/[\.|\-\>].*\s*\=\s*.*/) {

Thanks but nack.
This is more an issue with $Lval.
I'll look around for a solution.

