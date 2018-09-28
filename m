Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A0FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650B8216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650B8216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeI1OjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:39:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60696 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbeI1OjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:39:07 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vadTL9s3aa79; Fri, 28 Sep 2018 10:16:32 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA5700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:5700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CE701EC032B;
        Fri, 28 Sep 2018 10:16:32 +0200 (CEST)
Date:   Fri, 28 Sep 2018 10:16:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thor Thayer <thor.thayer@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Frey <dpfrey@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, altera: work around int-to-pointer-cast warnings
Message-ID: <20180928081634.GB20768@zn.tnic>
References: <20180927100949.973078-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927100949.973078-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:09:26PM +0200, Arnd Bergmann wrote:
> The altera edac driver passes a token from a DT resource as
> resource_size_t into an SMC call, but casts it to an __iomem pointer
> and then a plain void pointer inbetween, mixing three or four
> incompatible types in the process. The compiler complains about
> one of the conversions:
> 
> drivers/edac/altera_edac.c: In function 'altr_init_a10_ecc_block':
> drivers/edac/altera_edac.c:1053:10: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    base = (void __iomem *)res.start;
>           ^
> drivers/edac/altera_edac.c: In function 'altr_edac_a10_probe':
> drivers/edac/altera_edac.c:2062:10: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    base = (void __iomem *)res.start;
> 
> Using a static checker probably also notices the __iomem cast.  Solving
> this properly isn't trivial, but simply casting to a 'uintptr_t' instead
> of 'void __iomem *' makes it less wrong and should avoid the warnings.
> 
> Fixes: d5fc9125566c ("EDAC, altera: Combine Stratix10 and Arria10 probe functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/altera_edac.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
