Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F1FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0C720852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="T71ul4hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0C720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbeGQKEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:04:32 -0400
Received: from services.gouders.net ([141.101.32.176]:47224 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeGQKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:04:32 -0400
Received: from localhost ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w6H9WdIS002013
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 11:32:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1531819960; bh=lrvWjK+xX82nxezrHASg44ObuZ8v6HogBe7L70OUlQs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=T71ul4hSHuOXg/AswMaFutPHws/c2CE7h6orjkjgxF3HnOJMXk3yknD1DeY6aMg7d
         WVM1xWG7I27pckpA/75OuTifpfRmI7sac6iO8JnthmbRTWLrUbo0dhBobQUOmIMbUe
         VIWY3bSDdd0JkdIcyQw2MQV6SweO09qG5Fsx2coE=
From:   Dirk Gouders <dirk@gouders.net>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: if_changed: check for multiple calls in targets
In-Reply-To: <1d36bef932de0612746088388df793de99d7c129.camel@perches.com> (Joe
        Perches's message of "Mon, 16 Jul 2018 08:23:59 -0700")
References: <20180716123902.5337-1-dirk@gouders.net>
        <1d36bef932de0612746088388df793de99d7c129.camel@perches.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Tue, 17 Jul 2018 11:32:36 +0200
Message-ID: <ghy3eafbrf.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Mon, 2018-07-16 at 14:39 +0200, Dirk Gouders wrote:
>> Because the kbuild function if_changed writes the command line to a
>> .cmd file for later tests, multiple calls of that function within a
>> target would result in overwrites of previous values and effectively
>> render the command line test meaningless, resulting in flip-flop
>> behaviour.
>> 
>> Produce an error for targets with multiple calls to if_changed.
>
> Hi.  Some questions:
>
> How is the existing use in arch/microblaze/boot/Makefile incorrect?
>
> $(obj)/simpleImage.%: vmlinux FORCE
> 	$(call if_changed,cp,.unstrip)
> 	$(call if_changed,objcopy)
> 	$(call if_changed,uimage)
> 	$(call if_changed,strip,.strip)
> 	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'

Hi Joe,

thank you for the review.

Perhaps I should have started the commit message with:

"The kbuild function if_changed should not be called more than once for a
target." and then the explanatory text.

In case you are interested in the thread where Masahiro explained in detail the
real issues with those Makefiles that made them use if_changed too often:

https://marc.info/?l=linux-kernel&m=153149389303034&w=2

>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -2911,6 +2911,14 @@ sub process {
>>  			     "Use of $flag is deprecated, please use \`$replacement->{$flag} instead.\n" . $herecurr) if ($replacement->{$flag});
>>  		}
>>  i
>> +		# Check for multiple calls of if_changed within a target in Makefiles
>> +		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
>
> Why is any Kbuild file check useful?

Because Kbuild files are makefiles and if we want to check makefiles
they are also meant.

>> +		    ($prevline =~ /^[ +]\t\$\(call if_changed,/) &&
>> +		    ($line =~ /^[ +]\t\$\(call if_changed,/)) {
>
> What about if_changed_dep and if_changed_rule?

This patch tries to avoid just one single issue that actually showed
up and caused irritation.

>
>> +				ERROR("MULTIPLE_IF_CHANGED",
>> +				      "Multiple calls of if_changed within a target.\n" . $herecurr);
>> +		}
>
> And some more style things:
>
> There are instances with multiple tabs so probably
> these should use '\t*' or '\s*' and not '\t'.

Oh yes, I missed that.
I guess, you mean e.g. arch/x86/purgatory/Makefile:

$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
		$(call if_changed,ld)

I did not check the log but it seems there was one commit that for some
reason used \t\t for the recipes.

Anyway, the first TAB is mandatory, because we want to check recipes,
only.

> This should probably not require a single space after
> if_changed so likely:
>
> 	'call\s+if_changed'

Treewide, I did not find a single call of if_changed that uses other than
a single space but you are right, me might see variations.

So, according to your remarks, I would change the pattern to:

/^[ +]\t\s*\$\(call\s+if_changed,/

Dirk
