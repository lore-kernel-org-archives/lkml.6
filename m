Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2222C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B927122449
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B927122449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbeHJUp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:45:58 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:36254 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727545AbeHJUp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:45:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 80201837F242;
        Fri, 10 Aug 2018 18:15:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: oven87_82e4225034d35
X-Filterd-Recvd-Size: 3162
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Aug 2018 18:14:59 +0000 (UTC)
Message-ID: <e2975022a0440b642a7a68e2e5be4764b468143e.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: DT bindings should be a separate patch
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Fri, 10 Aug 2018 11:14:58 -0700
In-Reply-To: <20180810170513.26284-1-robh@kernel.org>
References: <20180810170513.26284-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 11:05 -0600, Rob Herring wrote:
> Devicetree bindings should be their own patch as documented in
> Documentation/devicetree/bindings/submitting-patches.txt section I.1.
> This is because bindings are logically independent from a driver
> implementation, they have a different maintainer (even though they often
> are applied via the same tree), and it makes for a cleaner history in
> the DT only tree created with git-filter-branch.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - Add doc pointer to warning
> - Simplify logic
> 
> Joe, this makes $is_binding_patch an empty value when the regex doesn't 
> match rather than 0 which would be more logical IMO. It seems to work 
> fine, but I'm not sure if there's a better way to do it.

Hi Rob.  This looks fine with a couple nits.

>  scripts/checkpatch.pl | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a9c05506e325..f9aba4bc41ce 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2236,6 +2236,7 @@ sub process {
>  	our $clean = 1;
>  	my $signoff = 0;
>  	my $is_patch = 0;
> +	my $is_binding_patch = -1;
>  	my $in_header_lines = $file ? 0 : 1;
>  	my $in_commit_log = 0;		#Scanning lines before patch
>  	my $has_commit_log = 0;		#Encountered lines before patch
> @@ -2485,6 +2486,19 @@ sub process {
>  				$check = $check_orig;
>  			}
>  			$checklicenseline = 1;
> +
> +			if ($realfile !~ /^MAINTAINERS/) {
> +				my $last_binding_patch = $is_binding_patch;
> +
> +				$is_binding_patch = ($realfile =~ m@^(?:Documentation/devicetree/|include/dt-bindings/)@);

If you want 0/1 you could use:

			$is_binding_patch = () = $realfile =~ m@^(?:Documentation/devicetree/|include/dt-bindings/)@;

(perl syntax is a constant joy)

> +
> +				if (($last_binding_patch != -1) &&
> +				    ($last_binding_patch ^ $is_binding_patch)) {
> +					WARN("DT_SPLIT_BINDING_PATCH",
> +					     "DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt");

This is missing a '\n' newline at the end of the message.

> +				}
> +			}
> +
>  			next;
>  		}
>  
