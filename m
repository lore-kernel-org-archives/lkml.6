Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40791C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E9A218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546933035;
	bh=RAiJVbPdYaMOeZ7D/Jyak8u6RdKJwSBuaImwPCOQ05Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Omd2haQfVRh2hWw2fIrUrAtpQhmERpM/TaKz64qGKKzpFmOs/1DtC+FqpXriGFMrw
	 sG8AnXzso5sBDd+PUOqAcKr5bhy5FEqwCs9SKJJ7B8qAWeLAu1OndpnA6d6H47V7MJ
	 fgNAWyA1cwms6RsabgM6oxswjf+bhCM0Ph0lnzsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfAHHhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHHhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:37:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE822087F;
        Tue,  8 Jan 2019 07:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546933033;
        bh=RAiJVbPdYaMOeZ7D/Jyak8u6RdKJwSBuaImwPCOQ05Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhFN75tc3JmQ3e24DCiDzO4boxezJyoYDMKB7S8tVq3nNE2Jd/VMgK3l3lOg/xhti
         DM4CMBCg8kJp6rmzYRy1GtxFp/xO/8y6t8gc2CgKHC983FmgDM9fddyaSLC8ZYBNir
         +VN4vdIi3HT9jqYMleTRaVLtqVmlnBYmCApFcyR8=
Date:   Tue, 8 Jan 2019 08:37:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4.14 069/101] spi: bcm2835: Fix race on DMA termination
Message-ID: <20190108073710.GB2102@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
 <20190107105336.765968953@linuxfoundation.org>
 <CADVatmNmc1mkcaJ4wKjufFcTwE_6=iMUTR811Gdcop9y0_LLVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNmc1mkcaJ4wKjufFcTwE_6=iMUTR811Gdcop9y0_LLVg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:15:20PM +0000, Sudip Mukherjee wrote:
> HI Greg,
> 
> On Mon, Jan 7, 2019 at 1:15 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Lukas Wunner <lukas@wunner.de>
> >
> > commit e82b0b3828451c1cd331d9f304c6078fcd43b62e upstream.
> 
> This has been fixed later by 29bdedfd9cf4 ("spi: bcm2835: Unbreak the
> build of esoteric configs")

Thanks for this, now queued up.

greg k-h
