Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4EF2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfBVPs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:48:27 -0500
Received: from ms.lwn.net ([45.79.88.28]:52562 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfBVPs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:48:27 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 828C4891;
        Fri, 22 Feb 2019 15:48:26 +0000 (UTC)
Date:   Fri, 22 Feb 2019 08:48:25 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?QXVyw6lsaWVu?= Cedeyn <aurelien.cedeyn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] scripts/spdxcheck.py: fix C++ comment style detection
Message-ID: <20190222084825.4c2405e1@lwn.net>
In-Reply-To: <9b8ba571688ec58361a502dc93693b2bfb1752dc.1550692590.git.aurelien.cedeyn@gmail.com>
References: <9b8ba571688ec58361a502dc93693b2bfb1752dc.1550692590.git.aurelien.cedeyn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 22:18:34 +0100
Aurélien Cedeyn <aurelien.cedeyn@gmail.com> wrote:

> With the last commit to support the SuperH boot code files, we have the
> following regression:
> 
> $ ./scripts/checkpatch.pl -f <(echo '/* SPDX-License-Identifier: MIT */')
> WARNING: 'SPDX-License-Identifier: MIT */' is not supported in LICENSES/..
> +/* SPDX-License-Identifier: MIT */
> 
> total: 0 errors, 1 warnings, 1 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
> mechanically convert to the typical style using --fix or --fix-inplace.
> 
> /dev/fd/63 has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> This is not obvious, but spdxcheck.py is launched in checkpatch.pl with :
>     ...
>     } elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
>         my $spdx_license = $1;
>         if (!is_SPDX_License_valid($spdx_license)) {
>             WARN("SPDX_LICENSE_TAG",
>                  "'$spdx_license' is not supported in LICENSES/...\n" . \
>                  $herecurr);
>         }
>     ...
>     sub is_SPDX_License_valid {
>         my ($license) = @_;
>         ...
>         my $status = `cd "$root_path"; echo "$license" |
>                       python scripts/spdxcheck.py -`;
>         ...
>     }
> 
> The first chars before 'SPDX-License-Identifier:' are ignored.
> This commit fixes this regression.
> 
> Fixes:959b49687838 (scripts/spdxcheck.py: Handle special quotation mark comments)
> Signed-off-by:Aurélien Cedeyn <aurelien.cedeyn@gmail.com>

I've applied this, thanks, though that parsing code still looks a little
fragile.  It needs a proper regex perhaps someday...:)

Thanks,

jon
