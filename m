Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84F1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898932089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4Xu4x23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898932089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJPTYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeJPTYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:24:25 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D34C20881;
        Tue, 16 Oct 2018 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539689663;
        bh=0xwbWQWhIpc0MU+Sq4wY9BGDQjLerJV3ZVtdB0R5TSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4Xu4x23jgxqlthtuaPOF0xlKko9ZhiDHfu7TgKlBoiegfTCZvsqb3PDEWdmav2Jl
         RD2sp//9DWlP8m9irxFB9CRnoagQwh9f22WHRQTAAW7hUbXnGvc590h1ahNmkFLnFc
         oxeX3TB3regWfaCaLeYDs2GSLc+7al5HKrfhrkMA=
Date:   Tue, 16 Oct 2018 13:34:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: storage: Fix Spectre v1 vulnerability
Message-ID: <20181016113421.GA21169@kroah.com>
References: <20181016101645.GA24870@embeddedor.com>
 <8736t6p1v0.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736t6p1v0.fsf@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:28:19PM +0300, Felipe Balbi wrote:
> 
> Hi Greg,
> 
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
> 
> > num can be indirectly controlled by user-space, hence leading to
> > a potential exploitation of the Spectre variant 1 vulnerability.
> >
> > This issue was detected with the help of Smatch:
> >
> > drivers/usb/gadget/function/f_mass_storage.c:3177 fsg_lun_make() warn:
> > potential spectre issue 'fsg_opts->common->luns' [r] (local cap)
> >
> > Fix this by sanitizing num before using it to index
> > fsg_opts->common->luns
> >
> > Notice that given that speculation windows are large, the policy is
> > to kill the speculation on the first load and not worry if it can be
> > completed with a dependent load/store [1].
> >
> > [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Can you still take this as an urgent fix?
> 
> Acked-by: Felipe Balbi <felipe.balbi@intel.com>

Yes, will do so, thanks.

greg k-h

> 
> -- 
> balbi
