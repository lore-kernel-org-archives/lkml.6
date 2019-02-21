Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3323C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8936C2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550742762;
	bh=ysQ9j7txDBJHvSpEs1cDZNc7CMsex9K2+XyKuc0KYC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TIn2Evoc4qVefwoRdT32M4VoksH0CsQJ85jPabK9yQZqstc8n1q6HFU419JtUXpve
	 kgP7HHRo5udipKx2bl2+o+lPO69MMbyez/yLTFwqiueboZaoidJdiDVlp50hAduOPp
	 x6a7SIBOyJn67ZHmh1t09+whVhxEhwJdqcydZgoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfBUJwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:52:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfBUJwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:52:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A41E720880;
        Thu, 21 Feb 2019 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550742760;
        bh=ysQ9j7txDBJHvSpEs1cDZNc7CMsex9K2+XyKuc0KYC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDoQdl6nM5Xnie5ZdveVb3iujlPflv85A8LTVF9wU6AXkmAoV0jLm0MW7JZEL6Jxf
         k6grTcbo7IsDhi1dC6ly9h03cgz7ayaPop2SD/qB0Ze/0vCpE2ZYp4kYwJS+TGSByb
         v3Hy8enbR3setwyQpyPHHhZqQf4wtnimtGAlowPI=
Date:   Thu, 21 Feb 2019 10:52:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
Message-ID: <20190221095236.GA26960@kroah.com>
References: <20180425142209.30745-1-heikki.krogerus@linux.intel.com>
 <20190220110017.BFA344CE86@mail.steuer-voss.de>
 <20190220125731.02E274CFE0@mail.steuer-voss.de>
 <20190220150227.GA17103@kroah.com>
 <alpine.DEB.2.20.1902201618090.8597@fox.voss.local>
 <20190220162214.GA2017@kroah.com>
 <alpine.DEB.2.20.1902210915480.18662@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1902210915480.18662@fox.voss.local>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:37:33AM +0100, Nikolaus Voss wrote:
> Hi Greg,
> 
> On Wed, 20 Feb 2019, Greg Kroah-Hartman wrote:
> > On Wed, Feb 20, 2019 at 04:22:00PM +0100, Nikolaus Voss wrote:
> > > > > v2: fix tps6598x_exec_cmd also
> > > > > ---
> > > > >  drivers/usb/typec/tps6598x.c | 26 ++++++++++++++++++++------
> > > > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> > > > > index c84c8c189e90..c54b73fb2a2f 100644
> > > > > --- a/drivers/usb/typec/tps6598x.c
> > > > > +++ b/drivers/usb/typec/tps6598x.c
> > > > > @@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
> > > > >  	return 0;
> > > > >  }
> > > > > 
> > > > > +static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
> > > > > +				void *val, size_t len)
> > > > > +{
> > > > > +	u8 data[len + 1];
> > > > 
> > > > I thought the build system now warned when you did this :(
> > > 
> > > I must admit I'm developing on 4.19 stable series, so no warnings...
> > 
> > Ick, no, you are 6 months behind where the rest of us are :(
> > 
> > Always, at the very least, work off of Linus's tree.  For best results,
> > work off of linux-next.
> 
> we are a medical device manufacturer and our prototypes run stable kernels
> because our main development goal is the patient therapy.

That's great, and fine, but testing on newer kernels is always a good
idea, that way you are not over a year behind when you have to move to
the next LTS release :)

thanks,

greg k-h
