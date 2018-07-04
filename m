Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB40C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65D524449
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65D524449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeGDBk7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:40:59 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:50214 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932263AbeGDBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:40:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C7FBB18224D93;
        Wed,  4 Jul 2018 01:40:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ocean31_426aebf250844
X-Filterd-Recvd-Size: 3026
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Jul 2018 01:40:56 +0000 (UTC)
Message-ID: <907f271cbeabec61b796ed220d425eb2ce2499db.camel@perches.com>
Subject: Re: [PATCH v1] checkpatch: Check for invalid return codes
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        bryanh@codeaurora.org, tsoni@codeaurora.org,
        Patrick Pannuto <ppannuto@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>
Date:   Tue, 03 Jul 2018 18:40:54 -0700
In-Reply-To: <1530661305-11959-1-git-send-email-pheragu@codeaurora.org>
References: <1530661305-11959-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 16:41 -0700, Prakruthi Deepak Heragu wrote:
> The only valid integer return is 0, anything else
> following "return" should be -ERRCODE or a function.

Integer return values can be positive constant and correct.

So perhaps better:

Negative integer return codes should prefer to use #define -<ERRNO>
values instead of negative numbers.

> Also, display context
> so that the user knows where the return value is incorrect.
> 
> http://lkml.org/lkml/2010/7/23/318
>   There's lots of "return -1;" statements in this patch - it's obscene
>   that this is used to indicate "some error occurred" in kernel space
>   rather than a real errno value - even when an existing function
>   (eg, request_irq) gave you an error code already.

This bit is superfluous and if you are going to quote
someone in a patch commit, it's nice to cc: them.

> Signed-off-by: Patrick Pannuto <ppannuto@codeaurora.org>
> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>

Does it really take 3 people to sign-off on this patch?

> ---
> Changes in v1:
> - Use CHK instead of ERROR
> - Rephrase the warning message
> - Provide the file name and line number where return value is incorrect
> 
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a9c0550..2808c27 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6197,6 +6197,12 @@ sub process {
>  			     "switch default: should use break\n" . $herectx);
>  		}
>  
> +# check for return codes on error paths



> +		if ($line =~ /\breturn\s+-\d+/) {
> +			CHK("NO_ERROR_CODE",

NO_ERROR_CODE isn't very obvious to me.
How about NEGATIVE_ERRNO or APPROPRIATE_ERRNO

> +			      "invalid return value, please return -<APPROPRIATE_ERRNO>\n" . $herecurr);
> +		}
> +
>  # check for gcc specific __FUNCTION__
>  		if ($line =~ /\b__FUNCTION__\b/) {
>  			if (WARN("USE_FUNC",
