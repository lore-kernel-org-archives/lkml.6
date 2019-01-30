Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF518C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8762A218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548876833;
	bh=BPlEQH+U/bnY6PnlU3AcTWtT2I3p4HH7404MougbRnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CRAmBWfg9PLxnCKu6QaKWS6qwbfwvMHzy8++I6uHYOI/tR6W3/3e/gboL3Bj/qQjE
	 C/DfdIlC8lRpaN5e8kRMke5aoTamcst4/DOgk1bxXs4NkcXzKkCn9CZADauLcvf573
	 9ygdhNRuZCVYR+cLbVrsFf7Qp+25xYmHwU2ph00w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfA3Tdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfA3Tdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:33:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E69218A4;
        Wed, 30 Jan 2019 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548876831;
        bh=BPlEQH+U/bnY6PnlU3AcTWtT2I3p4HH7404MougbRnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cz1sufCOo0cnVukVf7WWGKhlH3dH+4drmdLKXF/bBrh59twqGNpwVmAZEGf4UNcnG
         x69OuPi708GaUqq/40s5MneEtmPeok2Ta2UBmVxx2ITQDqIY5EVU7zxFcIMfTUXfKJ
         yAoIY0sI6RgbHkEY2kCQNyokz9iNaGE+gX7qEc50=
Date:   Wed, 30 Jan 2019 20:33:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peng Donglin <dolinux.peng@gmail.com>
Subject: Re: [PATCH 1/4] arm64: dump: no need to check return value of
 debugfs_create functions
Message-ID: <20190130193348.GC20667@kroah.com>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
 <20190122144114.9816-2-gregkh@linuxfoundation.org>
 <20190130182102.GK18558@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130182102.GK18558@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:21:02PM +0000, Will Deacon wrote:
> Hi Greg,
> 
> On Tue, Jan 22, 2019 at 03:41:11PM +0100, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Peng Donglin <dolinux.peng@gmail.com>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/arm64/include/asm/ptdump.h | 9 +++------
> >  arch/arm64/mm/dump.c            | 4 ++--
> >  arch/arm64/mm/ptdump_debugfs.c  | 7 ++-----
> >  3 files changed, 7 insertions(+), 13 deletions(-)
> 
> Are you taking this via your tree, or would you like us to queue it in
> arm64?

What ever is easiest for you is fine with me, I can handle it either
way, just let me know.

thanks,

greg k-h
