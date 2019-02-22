Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7913EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480C22086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JhEFVJ5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfBVJv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:51:57 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:57282 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfBVJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:51:57 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9E6D49;
        Fri, 22 Feb 2019 10:51:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550829115;
        bh=FZivtZvNhvBEpNCgWk/P6hAdkG9BRSP4aHrmPCbVZ9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhEFVJ5NW4f/jX5Pmn3PqYkXLn/Of6dh/gpvGDLw1VnGFV+X6OcaEvOu8/Wfnjs2F
         pFMgb1oGB3myDsTZVEKmIkLYEd01i2Gig/R6PxCvvSuvbhSeCdWTG9kdSpYTqcAqkM
         he1TKq9ITFQQfBITmrSrCwFNxI7G1lNMhMCMjAfk=
Date:   Fri, 22 Feb 2019 11:51:45 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 3/5] soc: qcom: socinfo: Expose custom attributes
Message-ID: <20190222095145.GA3522@pendragon.ideasonboard.com>
References: <20190220045829.6852-1-vaishali.thakkar@linaro.org>
 <20190221121841.GA32108@pendragon.ideasonboard.com>
 <20190221155742.GD2122@tuxbook-pro>
 <20190221221359.GD3485@pendragon.ideasonboard.com>
 <20190222071616.GA2306@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222071616.GA2306@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Feb 22, 2019 at 08:16:16AM +0100, Greg KH wrote:
> On Fri, Feb 22, 2019 at 12:13:59AM +0200, Laurent Pinchart wrote:
> > On Thu, Feb 21, 2019 at 07:57:42AM -0800, Bjorn Andersson wrote:
> > > On Thu 21 Feb 04:18 PST 2019, Laurent Pinchart wrote:
> > > > On Wed, Feb 20, 2019 at 10:28:29AM +0530, Vaishali Thakkar wrote:
> > > > > The Qualcomm socinfo provides a number of additional attributes,
> > > > > add these to the socinfo driver and expose them via debugfs
> > > > > functionality.
> > > > 
> > > > What is the use case for these attributes ? I fear they will be used in
> > > > production systems, and that would require debugfs in production, which
> > > > isn't a good idea. If you need to expose those attributes for anything
> > > > else than debugging then we need a proper API, likely sysfs-based.
> > > 
> > > The use case of these attributes, beyond development/debugging, are
> > > unfortunately somewhat unknown and is the reason why they where moved to
> > > debugfs from the earlier attempts to upstream this.
> > > 
> > > I think the production requirements at hand prohibits debugfs to be
> > > present, so attributes that are required beyond development/debugging
> > > purposes would have to be migrated out to sysfs - but the idea here is
> > > that such migration would have come with the missing motivation to add
> > > them there today.
> > 
> > If the use case is just debug/development, would it be enough to print
> > this information in the kernel log at boot time ? I may be a bit
> > paranoid, but I always worry about API abuse :-(
> 
> Putting stuff in debugfs should be fine.  No system should ever rely on
> debugfs for a properly running system as it is being disabled on almost
> all "sane" systems (Android included).  If a vendor relies on this
> information for a properly working system, then it does not belong in
> debugfs.

There's certainly no disagreement about that, my concern is about
vendors who will enable debugfs to access information they need just
because it's there. Do I assume correctly we can "break the debugfs ABI"
in mainline by changing the format of the information if needed ?

-- 
Regards,

Laurent Pinchart
