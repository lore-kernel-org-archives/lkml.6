Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A394C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135D021479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zCSfKWPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135D021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeKUSrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbeKUSrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:47:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43BC821479;
        Wed, 21 Nov 2018 08:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542788061;
        bh=X3QglRAzDBYNVP78eXCVgCI+KD9FftARxrsJMAZE/r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zCSfKWPBD1Q6mmUliz23VkAaPAXW8L3a/1syRdqJ6EWuz3R++cII44nMRAPe/FUJT
         K9ffIOfAHnPfqG9so4TbNeMCE/SrOD7aB78W6Za0xre3yimIF3E4r5LbPjDKJllqev
         UgsTc3STLuztbHNx0NS2kdhqM4ywqHURW99Cy7CY=
Date:   Wed, 21 Nov 2018 09:14:18 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add fsl-mc userspace support
Message-ID: <20181121081418.GD8162@kroah.com>
References: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
 <1542728371-6972-3-git-send-email-ioana.ciornei@nxp.com>
 <20181120164850.GC27531@kroah.com>
 <VI1PR0402MB2800989D7FB9856EA9D2A083E0D90@VI1PR0402MB2800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB2800989D7FB9856EA9D2A083E0D90@VI1PR0402MB2800.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 05:59:26PM +0000, Ioana Ciornei wrote:
> > > +static int fsl_mc_uapi_send_command(unsigned long arg,
> > > +				    struct fsl_mc_io *mc_io)
> > > +{
> > > +	struct fsl_mc_command mc_cmd;
> > > +	int error;
> > > +
> > > +	error = copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_cmd));
> > > +	if (error)
> > > +		return -EFAULT;
> > > +
> > > +	error = mc_send_command(mc_io, &mc_cmd);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	error = copy_to_user((void __user *)arg, &mc_cmd, sizeof(mc_cmd));
> > > +	if (error)
> > > +		return -EFAULT;
> > > +
> > > +	return 0;
> > > +}
> > 
> > I know you said that "the firmware will properly verify the command"
> > already, but given that I used to be a firmware developer a long time ago, I can
> > almost guarantee that this will cause problems in the future.
> > 
> > Want to make a friendly bet about this?
> > 
> > What is the odds that your firmware api/interface has been properly fuzzed such
> > that all possible combinations of bad commands will really not do horrible things
> > to the hardware/system?
> > 
> > Are you all willing to bet the system intregrity on this?  If so, ok, it's your systems
> > :)
> > 
> > Personally, I think you need to add a "known whitelist" and do some sort of
> > sanity checking here.
> > 
> 
> I can add a whitelist on the command ids that can be received from userspace but
> leave the parameter parsing to the firmware to process and interpret depending on the
> current system settings.
> 
> Would that be a viable option from your point of view?

That might be a good start.  Again, how well have you tested this
firmware interface can handle invalid data?  Are you willing to bet your
system integrity on it?  :)

thanks,

greg k-h
