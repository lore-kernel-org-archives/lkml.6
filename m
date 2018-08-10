Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F23FC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6D2239B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB6D2239B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeHJDVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:21:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeHJDVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:21:13 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11FAAC77;
        Fri, 10 Aug 2018 00:53:49 +0000 (UTC)
Date:   Thu, 9 Aug 2018 17:53:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH] checkpatch: DT bindings should be a separate patch
Message-Id: <20180809175348.aa8a93ab7deb011f39ac2704@linux-foundation.org>
In-Reply-To: <20180809205032.22205-1-robh@kernel.org>
References: <20180809205032.22205-1-robh@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Aug 2018 14:50:32 -0600 Rob Herring <robh@kernel.org> wrote:

> Devicetree bindings should be their own patch as documented in
> Documentation/devicetree/bindings/submitting-patches.txt section I.1.
> This is because bindings are logically independent from a driver
> implementation, they have a different maintainer (even though they often
> are applied via the same tree), and it makes for a cleaner history in
> the DT only tree created with git-filter-branch.
> 
> ...
>
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
> @@ -2485,6 +2486,27 @@ sub process {
>  				$check = $check_orig;
>  			}
>  			$checklicenseline = 1;
> +
> +			if ($realfile !~ /MAINTAINERS/) {
> +				my $mixed = 0;
> +				if ($realfile =~ /(Documentation\/devicetree|include\/dt-bindings).*/) {
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
> +
> +				if ($mixed == 1) {
> +					WARN("DT_SPLIT_BINDING_PATCH",
> +					     "DT binding docs and includes should be a separate patch\n");

A pointer to Documentation/devicetree/bindings/submitting-patches.txt
might be helpful?

> +				}
> +			}
> +
>  			next;
>  		}

