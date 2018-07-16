Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC832ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F970208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F970208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeGPPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:51:58 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:33881 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727610AbeGPPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:51:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 656EE182244F3;
        Mon, 16 Jul 2018 15:24:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: screw63_5d44301b3da11
X-Filterd-Recvd-Size: 2560
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 16 Jul 2018 15:24:00 +0000 (UTC)
Message-ID: <1d36bef932de0612746088388df793de99d7c129.camel@perches.com>
Subject: Re: [PATCH] checkpatch: if_changed: check for multiple calls in
 targets
From:   Joe Perches <joe@perches.com>
To:     Dirk Gouders <dirk@gouders.net>, Andy Whitcroft <apw@canonical.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 16 Jul 2018 08:23:59 -0700
In-Reply-To: <20180716123902.5337-1-dirk@gouders.net>
References: <20180716123902.5337-1-dirk@gouders.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 14:39 +0200, Dirk Gouders wrote:
> Because the kbuild function if_changed writes the command line to a
> .cmd file for later tests, multiple calls of that function within a
> target would result in overwrites of previous values and effectively
> render the command line test meaningless, resulting in flip-flop
> behaviour.
> 
> Produce an error for targets with multiple calls to if_changed.

Hi.  Some questions:

How is the existing use in arch/microblaze/boot/Makefile incorrect?

$(obj)/simpleImage.%: vmlinux FORCE
	$(call if_changed,cp,.unstrip)
	$(call if_changed,objcopy)
	$(call if_changed,uimage)
	$(call if_changed,strip,.strip)
	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2911,6 +2911,14 @@ sub process {
>  			     "Use of $flag is deprecated, please use \`$replacement->{$flag} instead.\n" . $herecurr) if ($replacement->{$flag});
>  		}
>  i
> +		# Check for multiple calls of if_changed within a target in Makefiles
> +		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&

Why is any Kbuild file check useful?

> +		    ($prevline =~ /^[ +]\t\$\(call if_changed,/) &&
> +		    ($line =~ /^[ +]\t\$\(call if_changed,/)) {

What about if_changed_dep and if_changed_rule?

> +				ERROR("MULTIPLE_IF_CHANGED",
> +				      "Multiple calls of if_changed within a target.\n" . $herecurr);
> +		}

And some more style things:

There are instances with multiple tabs so probably
these should use '\t*' or '\s*' and not '\t'.

This should probably not require a single space after
if_changed so likely:

	'call\s+if_changed'

