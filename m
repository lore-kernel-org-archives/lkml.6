Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B12C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0804F21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548166954;
	bh=Ugm9A63IkmN0PQ9ZZ400uFNrVixmuS+U0eQBkPL1yA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1P6Mjl9k09XndPZ3xl24gzO9q8HpJYMVyqvkhOqBrqMim13fgKyKt5/ENvHyJJlFm
	 rV/95t180b5Kmy2ShWXDsV2y4WKHErlnPP6PaRFg/QsPzQgeJe2z2+KVG9/tTJd4q0
	 R0hVXUFMTUQkSG9JawrDdI4kBMRPk+SS+rD9RHRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfAVOWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbfAVOWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:22:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43BAE20870;
        Tue, 22 Jan 2019 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548166950;
        bh=Ugm9A63IkmN0PQ9ZZ400uFNrVixmuS+U0eQBkPL1yA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WtL6zPaJVbDQ1cJf6oSl4G21GWaKDoLMLcQgimfo2hhmUCZbsXy1U8MJc1XEkaXYP
         4G0NTJGi8P6Vos6ZMLykZbGrvtcz/4fhBCMU6jG2FZ7ra+ZQi6CxRp/hOLRCx/cMgU
         s4bwl1l517ayRFm4rBT2voKEHQISOFBBNv8us038=
Date:   Tue, 22 Jan 2019 15:22:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     James Bottomley <jejb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <jth@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 03/10] SCSI: fcoe: convert to use BUS_ATTR_WO
Message-ID: <20190122142228.GA18225@kroah.com>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
 <20181221075442.17109-4-gregkh@linuxfoundation.org>
 <1545406185.2765.8.camel@linux.ibm.com>
 <5691ac07-ec5d-893f-09e4-ff1acd889abd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5691ac07-ec5d-893f-09e4-ff1acd889abd@suse.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 01:50:53PM +0100, Hannes Reinecke wrote:
> On 12/21/18 4:29 PM, James Bottomley wrote:
> > [scsi list cc added]
> > On Fri, 2018-12-21 at 08:54 +0100, Greg Kroah-Hartman wrote:
> > > We are trying to get rid of BUS_ATTR() and the usage of that in the
> > > fcoe driver can be trivially converted to use BUS_ATTR_WO(), so use
> > > that instead.
> > > 
> > > At the same time remove a unneeded EXPORT_SYMBOL() marking for the
> > > sysfs callback function we are renaming, no idea of how that got into
> > > the tree...
> > 
> > The EXPORT_SYMBOL removal is fine, but
> > 
> > [...]
> > > --- a/include/scsi/libfcoe.h
> > > +++ b/include/scsi/libfcoe.h
> > > @@ -405,10 +405,8 @@ int fcoe_transport_attach(struct fcoe_transport
> > > *ft);
> > >   int fcoe_transport_detach(struct fcoe_transport *ft);
> > > 
> > >   /* sysfs store handler for ctrl_control interface */
> > > -ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
> > > -			       const char *buf, size_t count);
> > > -ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
> > > -				const char *buf, size_t count);
> > > +ssize_t ctlr_create_store(struct bus_type *bus, const char *buf,
> > > size_t count);
> > > +ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf,
> > > size_t count);
> > 
> > You're really damaging our prefix namespace here.  It looks like the
> > ctlr_ name is a farly recent addition for sysfs (only myra/b) use it in
> > SCSI but it's inviting symbol clashes.
> > 
> Hmm. I was under the impression that all sysfs functions from myrb/myrs are
> local, hence I would not need to prefix them.
> If this isn't the case I definitely will be fixing them.
> 
> But in any case, if possible any sysfs function should be local to the
> driver; no-one else should ever attempt to use them.
> And we should be making it so if that's not the case.

This is all in the same "driver", just that the driver is spread out
over multiple files.

James, thanks for the fixup, I'll go respin this and break this up into
two patches and resend in a bit.

thanks,

greg k-h
