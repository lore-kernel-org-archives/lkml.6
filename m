Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88CBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC73222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550048888;
	bh=JsaF4YeH/sz6+7v6O4ySyW7HgACXtdz+dE+eQx38WS8=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=PUJ8FiQ4MhHiOAzoZbrBNcSBv8G4ddD5uIDQkoRcuYGuOPQOxi3Nj1fLjPsr4JOX+
	 HFbFHbBRnr+45HKAbr6MwpzaEtCo2d1hXEVqa68eJD0OpgGrTLtnZJ+iYb9HYEV/Yd
	 DTgXIzwHbHwBevFIo1MEUAl6Oq9hWp2xKqBvI+FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391267AbfBMJIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfBMJIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:08:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD339222BB;
        Wed, 13 Feb 2019 09:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550048886;
        bh=JsaF4YeH/sz6+7v6O4ySyW7HgACXtdz+dE+eQx38WS8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=BATWDy70BsCq3LHnzpawB9RYMUV+Flboo9MbtvD4fdszeZHFjxjjRILoUF2deu46w
         5daD9sbmFLu41umV1NU54Q1p2VZzeReDzKXl3mNzRHbb6f6MzT+hCi8P880OTqzmWF
         Z9QvU38J3V/fJKcoRemJtCNY/p8kbIcC9QsYcCIk=
Date:   Wed, 13 Feb 2019 10:08:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bin Liu <b-liu@ti.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] USB: musb: mark expected switch fall-through
Message-ID: <20190213090804.GB1347@kroah.com>
References: <20190212192357.GA15275@embeddedor>
 <20190212194754.GA28664@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212194754.GA28664@uda0271908>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 01:47:54PM -0600, Bin Liu wrote:
> Hi Greg,
> 
> On Tue, Feb 12, 2019 at 01:23:57PM -0600, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> > 
> > This patch fixes the following warning:
> > 
> > drivers/usb/musb/musb_host.c: In function ‘musb_advance_schedule’:
> > drivers/usb/musb/musb_host.c:374:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >     if (qh->mux == 1) {
> >        ^
> > drivers/usb/musb/musb_host.c:383:3: note: here
> >    case USB_ENDPOINT_XFER_ISOC:
> >    ^~~~
> > 
> > Warning level 3 was used: -Wimplicit-fallthrough=3
> > 
> > Notice that, in this particular case, the code comment is modified
> > in accordance with what GCC is expecting to find.
> > 
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I've closed my musb tree for v5.1-rc1, if you want to directly pick this
> patch, here is my Acked-by, or I will take it for v5.2-rc1.
> 
> Acked-by: Bin Liu <b-liu@ti.com>

I'll take it directly, thanks.

greg k-h
