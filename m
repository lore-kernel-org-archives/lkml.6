Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB9BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCA224724
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCA224724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934450AbeGCSTc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:19:32 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:48597 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934381AbeGCSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:19:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 67E21837F24D;
        Tue,  3 Jul 2018 18:19:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lead82_8cfdd5665a841
X-Filterd-Recvd-Size: 2555
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Jul 2018 18:19:28 +0000 (UTC)
Message-ID: <7cce1fcb751a2ffe89af02bcb05f295879ed1040.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Check for illegal return codes
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Patrick Pannuto <ppannuto@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>
Date:   Tue, 03 Jul 2018 11:19:27 -0700
In-Reply-To: <1530641369-31098-1-git-send-email-pheragu@codeaurora.org>
References: <1530641369-31098-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 11:09 -0700, Prakruthi Deepak Heragu wrote:
> The only legal integer return is 0, anything else
> following "return" should be -ERRCODE or a function.
> 
> http://lkml.org/lkml/2010/7/23/318
>   There's lots of "return -1;" statements in this patch - it's obscene
>   that this is used to indicate "some error occurred" in kernel space
>   rather than a real errno value - even when an existing function
>   (eg, request_irq) gave you an error code already.
> 
> Signed-off-by: Patrick Pannuto <ppannuto@codeaurora.org>
> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a9c0550..260d252 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6197,6 +6197,12 @@ sub process {
>  			     "switch default: should use break\n" . $herectx);
>  		}
>  
> +# check for return codes on error paths
> +		if ($line =~ /\breturn\s+-\d+/) {
> +			ERROR("NO_ERROR_CODE",
> +			      "illegal return value, please use an error code");
> +		}
> +

Substitute illegal to invalid as this wouldn't be illegal.
It might be invalid and this needs a newline and $herecurr

I'm not sure this is even useful.

There are _way_ too many of these already existing
and simple return identifiers can be OK.

$ git grep -P '\breturn\s*\-(?!0)\d+' | wc -l
10193

and

$ git grep -P '\breturn\s*\-(?!1)\d+' | wc -l
240

