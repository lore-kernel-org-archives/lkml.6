Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F97ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5E82077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5E82077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeGQTY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:24:59 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:38768 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729708AbeGQTY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:24:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D91E5181D341B;
        Tue, 17 Jul 2018 18:51:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wound31_42e495171143f
X-Filterd-Recvd-Size: 2251
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Jul 2018 18:50:59 +0000 (UTC)
Message-ID: <5c8b56fabd1644b50dd7ca14d8e7e49aa92750a7.camel@perches.com>
Subject: Re: [PATCH 16/32] staging: gasket: always allow root open for write
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Date:   Tue, 17 Jul 2018 11:50:57 -0700
In-Reply-To: <20180717102234.3spplwaf5n5wmpcl@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
         <20180717020926.176408-17-toddpoynor@gmail.com>
         <20180717102234.3spplwaf5n5wmpcl@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 13:22 +0300, Dan Carpenter wrote:
> On Mon, Jul 16, 2018 at 07:09:10PM -0700, Todd Poynor wrote:
> > --- a/drivers/staging/gasket/apex_driver.c
> > +++ b/drivers/staging/gasket/apex_driver.c
> > @@ -630,13 +630,10 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
> >  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
> 
> This function name is a bit of out of date.
> 
> >  {
> >  	struct gasket_dev *gasket_dev = filp->private_data;
> > -	int root = capable(CAP_SYS_ADMIN);
> > -	int is_owner = gasket_dev->dev_info.ownership.is_owned &&
> > -		       current->tgid == gasket_dev->dev_info.ownership.owner;
> > +	fmode_t write;
> >  
> > -	if (root || is_owner)
> > -		return 1;
> > -	return 0;
> > +	write = filp->f_mode & FMODE_WRITE;
> > +	return write;
> 
> This doesn't match the comment because it returns 0x2 or zero.
> 
> 	return !!(filp->f_mode & FMODE_WRITE);

Or maybe change the functions to return bool

