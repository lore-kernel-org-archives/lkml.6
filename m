Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9109C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9B42145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545055907;
	bh=8cVS+Q/Q8Sw9seQvLuc3PgbOs5lVlr6dplm/BPEy2JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RwFXgI3/qq5+zxWh+KMNoVewLpDD9MdvZqDUYIcCpKEav00EwmZ3BMFJUIX3aBA56
	 s/lmzJ9W2e5hVKf93GTkPFXwm90mliMdNijCrj+HQJb/ih96AjsM2znNtuwYPABXoo
	 1reWmLNRDX1yysAxxAiOFz+ndZMgACRdquXqOyOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbeLQOLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbeLQOLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:11:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4FBB2133F;
        Mon, 17 Dec 2018 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545055905;
        bh=8cVS+Q/Q8Sw9seQvLuc3PgbOs5lVlr6dplm/BPEy2JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itQFMkqNX84Wjj4VZK70t5pYsZV/QiTQLSO01+SBW4NiZ4HjoNdcFWhz1la9SH5VH
         qpam8y7CJQwBVSacSb/9lIknXFcdw3EbMXHT+dyt31HXm3vERa/qyBp2X3CdcNpvbk
         Z4Sbm0DuRdiYY6cb/fVIX9MvaSAg/8AvD6bgXctA=
Date:   Mon, 17 Dec 2018 15:11:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>, oneukum@suse.com,
        sandeep.singh@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: fix 'broken_suspend' placement in struct xchi_hcd
Message-ID: <20181217141142.GA26880@kroah.com>
References: <20181217133740.5342-1-nsaenzjulienne@suse.de>
 <7ea44e0c-5268-b898-4d27-048921eaab69@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea44e0c-5268-b898-4d27-048921eaab69@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:59:28PM +0200, Mathias Nyman wrote:
> On 17.12.2018 15:37, Nicolas Saenz Julienne wrote:
> > As commented in the struct's definition there shouldn't be anything
> > underneath it's 'priv[0]' member as it would break some macros.
> > 
> > The patch converts the broken_suspend into a bit-field and relocates it
> > next to to the rest of bit-fields.
> > 
> > Fixes: a7d57abcc8a5 ("xhci: workaround CSS timeout on AMD SNPS 3.0 xHC")
> > Reported-by: Oliver Neukum  <oneukum@suse.com>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >   drivers/usb/host/xhci.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index c3515bad5dbb..011dd45f8718 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1863,6 +1863,8 @@ struct xhci_hcd {
> >   	unsigned		sw_lpm_support:1;
> >   	/* support xHCI 1.0 spec USB2 hardware LPM */
> >   	unsigned		hw_lpm_support:1;
> > +	/* Broken Suspend flag for SNPS Suspend resume issue */
> > +	unsigned		broken_suspend:1;
> >   	/* cached usb2 extened protocol capabilites */
> >   	u32                     *ext_caps;
> >   	unsigned int            num_ext_caps;
> > @@ -1880,8 +1882,6 @@ struct xhci_hcd {
> >   	void			*dbc;
> >   	/* platform-specific data -- must come last */
> >   	unsigned long		priv[0] __aligned(sizeof(s64));
> > -	/* Broken Suspend flag for SNPS Suspend resume issue */
> > -	u8			broken_suspend;
> >   };
> >   /* Platform specific overrides to generic XHCI hc_driver ops */
> > 
> 
> Thanks, not sure how I missed that.
> 
> Greg, in case you want to pick this simple fix to 4.20 still:
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

I can queue it up, thanks!

greg k-h
