Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813FCC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EFA223A9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EFA223A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHJDfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:35:18 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:58099 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726953AbeHJDfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:35:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C91E81801A0B6;
        Fri, 10 Aug 2018 01:07:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glass58_272327c675f19
X-Filterd-Recvd-Size: 2662
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Aug 2018 01:07:48 +0000 (UTC)
Message-ID: <13b3efc8ba75f3e857934580effcdc8675bad6c8.camel@perches.com>
Subject: Re: [PATCH] checkpatch: DT bindings should be a separate patch
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Thu, 09 Aug 2018 18:07:47 -0700
In-Reply-To: <20180809205032.22205-1-robh@kernel.org>
References: <20180809205032.22205-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 14:50 -0600, Rob Herring wrote:
> Devicetree bindings should be their own patch as documented in
> Documentation/devicetree/bindings/submitting-patches.txt section I.1.
> This is because bindings are logically independent from a driver
> implementation, they have a different maintainer (even though they often
> are applied via the same tree), and it makes for a cleaner history in
> the DT only tree created with git-filter-branch.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2236,6 +2236,7 @@ sub process {
>  	our $clean = 1;
>  	my $signoff = 0;
>  	my $is_patch = 0;
> +	my $is_binding_patch = -1;
>  	my $in_header_lines = $file ? 0 : 1;
>  	my $in_commit_log = 0;		#Scanning lines before patch
>  	my $has_commit_log = 0;		#Encountered lines before patch
> @@ -2485,6 +2486,27 @@ sub process {
>  				$check = $check_orig;
>  			}
>  			$checklicenseline = 1;
> +
> +			if ($realfile !~ /MAINTAINERS/) {

Should probably be /^MAINTAINERS/

> +				my $mixed = 0;
> +				if ($realfile =~ /(Documentation\/devicetree|include\/dt-bindings).*/) {

This should have a ^ for the start of the filename and
generally, this is easier to read using m@...@ like:

				if ($realfile =~ m@^(?:Documentation/devicetree/|include/dt-bindings/)@) {

> +					if ($is_binding_patch == 0) {
> +						$mixed = 1;
> +					}
> +					$is_binding_patch = 1;
> +				} else {
> +					if ($is_binding_patch == 1) {
> +						$mixed = 1;
> +					}
> +					$is_binding_patch = 0;
> +				}

Perhaps there is simpler logic using an xor.

> +				if ($mixed == 1) {
> +					WARN("DT_SPLIT_BINDING_PATCH",
> +					     "DT binding docs and includes should be a separate patch\n");
> +				}

Perhaps add 'see: Documentation/devicetree/bindings/submitting-patches.txt'

> +			}


