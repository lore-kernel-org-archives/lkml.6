Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF54C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D3C2196F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548403353;
	bh=cGh0IocJ7lU4wE2QvEYRzp/poazYx57IcZn9jatOyB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CmoofThRdmvr1YhIbiaRPv5IuMvGeYZhMvj3lRmKyxT8sExVJp2mASVLc7e0BPI5q
	 HYynGB9uY4Upr76gRInpjjmUfNWhNMWxTDvZ3IgnmFqGY0S2eeLICgORRGtAEUrBWW
	 DQ3pEzh7HzTS71J67Gxf1ToeVTzUR4gpd4C27WyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfAYICb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfAYICa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:02:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9802B20820;
        Fri, 25 Jan 2019 08:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548403350;
        bh=cGh0IocJ7lU4wE2QvEYRzp/poazYx57IcZn9jatOyB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGgfpaYbvjXxdB4erx0keVzEKiLpiuypxyeszLb72uxv2zHr/2HRUTYTBD5tx/xds
         MHg30OVG9V1FP1z047ttTCmkfjpwbToQlgjJwPF63Il4kzrUWjT+OoCCHm+fZWaTjp
         PeBb2UPgew3Q4a2BPayFJMHV/9ckAUQdkOWFAmM0=
Date:   Fri, 25 Jan 2019 09:02:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: Fix vep_free_request() null pointer checks on
 input args
Message-ID: <20190125080227.GA21576@kroah.com>
References: <20190118212931.18482-1-skhan@linuxfoundation.org>
 <20190119081708.GA8204@kroah.com>
 <0b87d2b7-3200-7f6f-c4ee-e9e1fe6161fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b87d2b7-3200-7f6f-c4ee-e9e1fe6161fe@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:05:28PM -0700, shuah wrote:
> On 1/19/19 1:17 AM, Greg KH wrote:
> > On Fri, Jan 18, 2019 at 02:29:30PM -0700, Shuah Khan wrote:
> > > From: Shuah Khan <shuah@kernel.org>
> > > 
> > > Fix vep_free_request() to return when usb_ep and usb_request are null
> > > instead of calling WARN_ON.
> > > 
> > > Signed-off-by: Shuah Khan <shuah@kernel.org>
> > > ---
> > >   drivers/usb/usbip/vudc_dev.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
> > > index 1634d8698e15..bfc8218e3fb6 100644
> > > --- a/drivers/usb/usbip/vudc_dev.c
> > > +++ b/drivers/usb/usbip/vudc_dev.c
> > > @@ -297,7 +297,7 @@ static void vep_free_request(struct usb_ep *_ep, struct usb_request *_req)
> > >   {
> > >   	struct vrequest *req;
> > > -	if (WARN_ON(!_ep || !_req))
> > > +	if (!_ep || !_req)
> > 
> > It's impossible for _ep to be NULL in this callback (see
> > usb_ep_free_request() for where this is called from to prove that), so I
> > don't think you need to check that.  It's almost impossible for _req to
> > be NULL, so you might as well leave that check in.
> > 
> 
> Yes. ep can never be null here in vep_free_request(). I will leave
> this alone.

You can drop the !_ep check at the least, no need to check something
that is impossible to hit :)

thanks,

greg k-h
