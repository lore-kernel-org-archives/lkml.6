Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805D6C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBAE2243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuYm+2vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBAE2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeKMD40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbeKMD4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:56:25 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C002243E;
        Mon, 12 Nov 2018 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542045726;
        bh=MG+IgKm1DIZEBxJbtRLoTiXmo9ejBrVa96FbJxxFPRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuYm+2vjcLF7bW9gID/d3kh9TeZeNu+KCV919VCNu06BPUieOSGVbhz4BylohYpOp
         5+oPB1+S5mUQ/2ZoBuYcwh3OAioX9mxNGQApMXJHtCaDsIctcVPglv998Sy2sH/qkd
         xQlOpqZKtMovKASec/EfeCmfL2JRd/hFgAeduwCg=
Date:   Mon, 12 Nov 2018 10:02:06 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH 5/5] fpga: dfl-fme-region: Use platform_get_drvdata()
Message-ID: <20181112180206.GA28739@kroah.com>
References: <20180912144327.3130-1-atull@kernel.org>
 <20180912144327.3130-6-atull@kernel.org>
 <20180930154845.GA13200@kroah.com>
 <CANk1AXR=psRx319i_2S3fqM+4WsK6YgwJMPn=2o3zw5AQ3mr6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXR=psRx319i_2S3fqM+4WsK6YgwJMPn=2o3zw5AQ3mr6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 09:46:53AM -0600, Alan Tull wrote:
> On Sun, Sep 30, 2018 at 10:48 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> 
> Hi Greg,
> 
> >
> > On Wed, Sep 12, 2018 at 09:43:27AM -0500, Alan Tull wrote:
> > > From: Moritz Fischer <mdf@kernel.org>
> > >
> > > Use platform_get_drvdata() in remove() function of
> > > the platform driver rather than dev_get_drvdata()
> > > to match the platform_set_drvdata in the probe().
> > >
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > Acked-by: Alan Tull <atull@kernel.org>
> > > ---
> > >  drivers/fpga/dfl-fme-region.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> > > index 51a5ac2..3fa0de2 100644
> > > --- a/drivers/fpga/dfl-fme-region.c
> > > +++ b/drivers/fpga/dfl-fme-region.c
> > > @@ -66,7 +66,7 @@ static int fme_region_probe(struct platform_device *pdev)
> > >
> > >  static int fme_region_remove(struct platform_device *pdev)
> > >  {
> > > -     struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> > > +     struct fpga_region *region = platform_get_drvdata(pdev);
> >
> > This is nice, but not a bugfix.  I'll wait for 4.20-rc1 for this patch.
> 
> Could you take patch 4/5 and 5/5?  They didn't make it into a 4.20 rc yet.

Can you resend them please?  I don't see either of these in my queue
anywhere.

thanks,

greg k-h
