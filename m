Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C98C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD73720C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD73720C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbeGKQZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:25:27 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:48117 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733247AbeGKQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:25:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id CD3C552B4;
        Wed, 11 Jul 2018 16:20:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cloud99_315070d39231
X-Filterd-Recvd-Size: 3352
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Jul 2018 16:20:21 +0000 (UTC)
Message-ID: <cd7a7d241252bbb6588448ed7f27d51811025c63.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Warn if missing author Signed-off-by
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Date:   Wed, 11 Jul 2018 09:20:19 -0700
In-Reply-To: <20180711151003.6768-1-geert+renesas@glider.be>
References: <20180711151003.6768-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 17:10 +0200, Geert Uytterhoeven wrote:
> Print a warning if none of the Signed-off-by lines cover the patch
> author.
> 
> Non-ASCII quoted printable encoding in From: headers and (lack of)
> double quotes are handled.
> Split From: headers are not fully handled: only the first part is
> compared.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +# Check the patch for a From:
> +		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> +			$author = encode("utf8", $1);
> +			$author =~ s/"//g;
> +		}
> +
>  # Check the patch for a signoff:
>  		if ($line =~ /^\s*signed-off-by:/i) {
>  			$signoff++;
>  			$in_commit_log = 0;
> +			if ($author ne '') {
> +				my $l = $line;
> +				$l =~ s/"//g;
> +				if ($l =~ /^\s*signed-off-by: \Q$author\E/i) {
> +				    $authorsignoff = 1;
> +				}
> +			}
>  		}

I don't see the point of removing the quotes.

If the name and email address don't exactly match,
why shouldn't it be reported?

>  # Check if MAINTAINERS is being updated.  If so, there's probably no need to
> @@ -6487,9 +6503,14 @@ sub process {
>  		ERROR("NOT_UNIFIED_DIFF",
>  		      "Does not appear to be a unified-diff format patch\n");
>  	}
> -	if ($is_patch && $has_commit_log && $chk_signoff && $signoff == 0) {
> -		ERROR("MISSING_SIGN_OFF",
> -		      "Missing Signed-off-by: line(s)\n");
> +	if ($is_patch && $has_commit_log && $chk_signoff) {
> +		if ($signoff == 0) {
> +			ERROR("MISSING_SIGN_OFF",
> +			      "Missing Signed-off-by: line(s)\n");
> +		} elsif (!$authorsignoff) {
> +			WARN("NO_AUTHOR_SIGN_OFF",
> +			     "Missing Signed-off-by: line by patch author\n");

Perhaps better to show the From: line author

		"Missing 'Signed-off-by:' from nomimal patch author '$author'\n");

Another somewhat frequent Signed-off-by: defect pattern
is to have a lower-case name or no name at all used.

Perhaps it'd be useful to add some checks like
a single word for a name and all lower-case names:

e.g.:
	Signed-off-by: joe perches <joe@perches.com>

emits

Unusual lower case name: 'joe perches <joe@perches.com>'

and
	Signed-off-by: root <root@mydomain.net>
and
	Signed-off-by: Root <root@mydomain.net>
and
	Signed-off-by: root@mydomain.net

all emit that a single or missing name is unusual.

