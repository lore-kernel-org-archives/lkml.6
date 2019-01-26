Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3440C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BDF218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548499151;
	bh=5o3OLg0GVknK3mlEtjPXAoUnWaJ3mz9iHEdq/G9EUpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zwm293y1zYMNRbp6I3u/AlG2ONeB4pR0gmnfJRVEmnw1fh/p+6p446UppQ+w9QfjN
	 RuQ0VV/PT7RQYHhEae+gHrR2BcIKcQTcbN1Q8s2c5oiDGkUSYQCcTu6qsw8BfnFOZD
	 ZPbQx02LWTUSfTgXP34y9Vn/Q4aJmfQqRPNKVcbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfAZKjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:39:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfAZKjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:39:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 640A7218A6;
        Sat, 26 Jan 2019 10:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548499148;
        bh=5o3OLg0GVknK3mlEtjPXAoUnWaJ3mz9iHEdq/G9EUpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zz4GJF7d69N7G4aIsVNd+g/cmACUZDwechhoJ3ajxW8X+5uKXHhf/lHiXbPHnsQqq
         AmOczPM1CYtn5Nk06BdyLS9kwJJZDYAShkzzkhzXoq53RnblDZ+ZjVArUiTv9AwWrk
         hKfN98aIpUxtawY95pflLqTOwSlJ68Box+dMjY/4=
Date:   Sat, 26 Jan 2019 11:39:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] SCSI: fcoe: convert to use BUS_ATTR_WO
Message-ID: <20190126103906.GA9483@kroah.com>
References: <20190122142735.GB18225@kroah.com>
 <3e91c991-8090-405a-58cf-0686e9a82a51@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e91c991-8090-405a-58cf-0686e9a82a51@suse.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 11:26:47AM +0100, Hannes Reinecke wrote:
> On 1/22/19 3:27 PM, Greg Kroah-Hartman wrote:
> > We are trying to get rid of BUS_ATTR() and the usage of that in the fcoe
> > driver can be trivially converted to use BUS_ATTR_WO(), so use that
> > instead.
> > 
> > Cc: Johannes Thumshirn <jth@kernel.org>
> > Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> > Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: Made simpler with wrapper functions to call the "real" show/store
> >      functions, thanks to James for the idea.
> >      Removed the EXPORT_SYMBOL() removal line, that belongs in a separate
> >      patch
> > 
> >   drivers/scsi/fcoe/fcoe_sysfs.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
> > index 5c8310bade61..c3dcbdc3aa64 100644
> > --- a/drivers/scsi/fcoe/fcoe_sysfs.c
> > +++ b/drivers/scsi/fcoe/fcoe_sysfs.c
> > @@ -671,8 +671,19 @@ static const struct device_type fcoe_fcf_device_type = {
> >   	.release = fcoe_fcf_device_release,
> >   };
> > -static BUS_ATTR(ctlr_create, S_IWUSR, NULL, fcoe_ctlr_create_store);
> > -static BUS_ATTR(ctlr_destroy, S_IWUSR, NULL, fcoe_ctlr_destroy_store);
> > +static ssize_t ctlr_create_store(struct bus_type *bus, const char *buf,
> > +				 size_t count)
> > +{
> > +	return fcoe_ctlr_create_store(bus, buf, count);
> > +}
> > +static BUS_ATTR_WO(ctlr_create);
> > +
> > +static ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf,
> > +				  size_t count)
> > +{
> > +	return fcoe_ctlr_destroy_store(bus, buf, count);
> > +}
> > +static BUS_ATTR_WO(ctlr_destroy);
> >   static struct attribute *fcoe_bus_attrs[] = {
> >   	&bus_attr_ctlr_create.attr,
> > 
> Why not renaming the functions and drop the wrapper?

I did that in v1 of this patch, but people complained I was messing up
their function namespace :)

thanks,

greg k-h
