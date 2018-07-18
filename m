Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C7FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2AB2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2AB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeGRMgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:36:42 -0400
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:55144 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726362AbeGRMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:36:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id F1405837F27F;
        Wed, 18 Jul 2018 11:59:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scent00_153699cad673a
X-Filterd-Recvd-Size: 1588
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Jul 2018 11:59:05 +0000 (UTC)
Message-ID: <b7c97031a347fdce25fa0562418908617353df19.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Only encode UTF-8 quoted printable mail
 headers
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Date:   Wed, 18 Jul 2018 04:59:04 -0700
In-Reply-To: <20180718113529.15652-1-geert+renesas@glider.be>
References: <20180718113529.15652-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 13:35 +0200, Geert Uytterhoeven wrote:
> As PERL uses its own internal character encoding, always calling
> encode("utf8", ...) on the author name may cause corruption, leading to
> an author signoff mismatch.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2523,7 +2523,8 @@ sub process {
>  
>  # Check the patch for a From:
>  		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> -			$author = encode("utf8", $1);
> +			$author = $1;
> +			$author = encode("utf8", $author) if $line =~ /=\?utf-8\?/i;

trivial:

checkpatch uses parentheses around tests so

			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);

