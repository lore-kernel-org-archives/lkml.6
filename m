Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2F0C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E96E20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E96E20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeGZClY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:41:24 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:46443 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728523AbeGZClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:41:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C893118021DA9;
        Thu, 26 Jul 2018 01:27:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mine37_3d5a5cb248031
X-Filterd-Recvd-Size: 2394
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Jul 2018 01:27:01 +0000 (UTC)
Message-ID: <2a56b48632fe8982735769b52aafe721b29b1bcf.camel@perches.com>
Subject: Re: [PATCH v1] checkpatch: check for #if 0/#if 1
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Date:   Wed, 25 Jul 2018 18:27:00 -0700
In-Reply-To: <1532560446-15827-1-git-send-email-pheragu@codeaurora.org>
References: <1532560446-15827-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 16:14 -0700, Prakruthi Deepak Heragu wrote:
> The #if 0 or #if 1 is used to toggle features. Warn if #if 0 or #if 1
> is present and suggest that they can be removed.
> 
> Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> ---
> Changes in v1:
> - Rephrase the warning message to fit in a single line without 
>   80 column limit
> 
>  scripts/checkpatch.pl | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3394ed8..72513c2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5383,9 +5383,14 @@ sub process {
>  
>  # warn about #if 0
>  		if ($line =~ /^.\s*\#\s*if\s+0\b/) {
> -			CHK("REDUNDANT_CODE",
> -			    "if this code is redundant consider removing it\n" .
> -				$herecurr);
> +			WARN("IF_0",
> +			     "Consider removing the #if 0 and its #endif\n".  $herecurr);

No, this wording is not correct at all.

The entire block, i.e.: 'this code' should be considered
to be removed, not just the #if 0 and its #endif.

For #if 1 code, then just the #if 1 and the #endif should
be removed.

> +		}
> +
> +# warn about #if 1
> +		if ($line =~ /^.\s*\#\s*if\s+1\b/) {
> +			WARN("IF_1",
> +			     "Consider removing the #if 1 and its #endif\n".  $herecurr);
>  		}
>  
>  # check for needless "if (<foo>) fn(<foo>)" uses
