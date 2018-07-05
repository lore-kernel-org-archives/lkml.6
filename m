Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B55C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2235720849
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2235720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeGEVOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:14:33 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:41972 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753928AbeGEVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:14:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 51DDC18025DDD;
        Thu,  5 Jul 2018 21:14:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: arch69_273d951eaa70f
X-Filterd-Recvd-Size: 2336
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Jul 2018 21:14:29 +0000 (UTC)
Message-ID: <f3ce3ca8741f774b63e8a67a278384747b1de522.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add exceptions for dsb keyword usage
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        apw@canonical.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org
Date:   Thu, 05 Jul 2018 14:14:28 -0700
In-Reply-To: <1530814776-16988-1-git-send-email-pheragu@codeaurora.org>
References: <1530814776-16988-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 11:19 -0700, Prakruthi Deepak Heragu wrote:
> mb() API can relpace the dsb() API in the kernel code. So, dsb() usage
> is discouraged. However, there are exceptions when dsb is used in a
> variable or a function name. Exceptions are when 'dsb' is prefixed with
> class [-_>*\.] and/or suffixed with class [-_\.;].
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5372,6 +5372,12 @@ sub process {
>  			     "Avoid line continuations in quoted strings\n" . $herecurr);
>  		}
>  
> +# dsb is too ARMish, and should usually be mb.
> +        if ($line =~ /[^-_>*\.]\bdsb\b[^-_\.;]/) {
> +            WARN("ARM_BARRIER",
> +                 "Use of dsb is discouranged: prefer mb.\n" .
> +                 $herecurr);
> +		}

This patch is whitespace damaged with a spelling error.

Also, if this is reasonable test, and I don't know
that it is, it should be cc'd to the linux-arm list
linux-arm-kernel@lists.infradead.org

Also, I suggest 2 tests, one for .S files and
another for .[ch] files, and this be made specific
to arch/arm... files

Something like:

	if ($realfile =~ @^arch/arm@ &&
	    ($realfile =~ /\.S$/ && $line =~ /\bdsb\b/) ||
	    ($realfile =~ /\.[ch]$/ && $line =~ /\bdsb\s*\(/)) {
		WARN("ARM_DSB",
		     "Prefer mb over dsb as an ARM memory barrier\n" . $herecurr);
	}

ARM people, is this reasonable?

