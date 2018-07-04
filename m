Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533B0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0FD24363
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0FD24363
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeGDSbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:31:00 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:33077 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752401AbeGDSa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:30:59 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id D3C8B8009669
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jul 2018 18:30:58 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 004C2837F24A;
        Wed,  4 Jul 2018 18:30:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: snow33_811f550f725b
X-Filterd-Recvd-Size: 2457
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Jul 2018 18:30:55 +0000 (UTC)
Message-ID: <173cc189627e0d6618b535fcd1ce6a4c90ce2ad0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add warnings for use of mdelay()
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        apw@canonical.com, Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <error27@gmail.com>
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Israel Schlesinger <israels@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>
Date:   Wed, 04 Jul 2018 11:30:53 -0700
In-Reply-To: <1530728333-31590-1-git-send-email-pheragu@codeaurora.org>
References: <1530728333-31590-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 11:18 -0700, Prakruthi Deepak Heragu wrote:
> mdelay() is not a preferred API to be used to insert delay in the kernel
> code unless the context is atomic. Instead, msleep() API can be used.
> This patch introduces this warning.

[]

> Signed-off-by: Israel Schlesinger <israels@codeaurora.org>
> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>

Really? 3 sign-offs for one trivial patch while
getting simple whitespace issues wrong?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5572,6 +5572,12 @@ sub process {
>  			     "Comparing get_jiffies_64() is almost always wrong; prefer time_after64, time_before64 and friends\n" . $herecurr);
>  		}
>  
> +# check the patch for use of mdelay
> +		if ($line =~ /\bmdelay\s*\(/) {
> +			WARN("MDELAY",
> +			     "use of mdelay() found: msleep() is the preferred API.\n" . $herecurr );

No space after $herecurr

> +		}
> +

NACK - I think this is unreasonable.

checkpatch is stupid and can only remain that way.

It cannot check for any particular use in atomic
that is appropriate and should not warn with a
false positive when the use is appropriate.

$ git grep -w mdelay | wc -l
2700

How many of those are correct?

If you want a check like this to be useful, write
something for coccinelle or smatch.

