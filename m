Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA138C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA9420664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA9420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeK0AEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:04:51 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:60679 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeK0AEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:04:50 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 979A55C0F44; Mon, 26 Nov 2018 13:10:09 +0000 (UTC)
Date:   Mon, 26 Nov 2018 14:10:09 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devel@driverdev.osuosl.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: check for devm_kasprint()
 failure
Message-ID: <20181126131009.GA19931@osadl.at>
References: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
 <20181126130032.GJ3088@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126130032.GJ3088@unbuntlaptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:00:32PM +0300, Dan Carpenter wrote:
> On Mon, Nov 26, 2018 at 10:39:04AM +0100, Nicholas Mc Guire wrote:
> > devm_kasprintf() may return NULL on failure of internal allocation thus
> > the assignments to  attr.name  are not safe if not checked. On error
> > ad7280_attr_init() returns a negative return so -ENOMEM should be
> > OK here (passed on as return value of the probe function).
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")
> > ---
> > 
> > Problem located with an experimental coccinelle script
> > 
> > As using   if(!st->iio_attr[cnt].dev_attr.attr.name)  seamed quite
> > unreadable in this case the  (var  == NULL)  variant was used. Not
>                                    ^^
> Why two spaces?

just a typo 

> 
> > sure if there are objections against this (checkpatch.pl issues
> > a CHECK on this).
> > 
> 
> You should just follow checkpatch rules here.  If you don't, someone
> else will just send a patch to make it checkpatch compliant.  One thing
> you could do is at the start of the loop do:
> 
> 	struct iio_dev_attr *attr = &st->iio_attr[cnt];
> 
> Then it becomes:
> 
> 	if (!attr->dev_attr.attr.name)
> 
> It's slightly more readable that way.  Keep in mind that we increment
> cnt++ in the middle of the loop so you'll have to update attr as well.
>
My understanding was that CHECK: notes are not strict rules but
those that may vary from case to case - anyway you solution
sounds reasonable and in any case better than:

       if (!st->iio_attr[cnt].dev_attr.attr.name)

which just looked bad to me.

thx!
hofrat
