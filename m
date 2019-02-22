Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73910C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C9820818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550819782;
	bh=kaiAZgn9n5WahUSplRgXmg9YVQLTnA77Yl+dj2eNnqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iHaJhgBf6Oo7GS/vWMGhAVCePXBaSsAiE6eYW1Wdwuc9gwlOBdcKS5lYXncUw7+aT
	 AtGK1XlfS32Q74fx44E5GkA11Y7q50188SyVtJMFfahvoerG5ocC5g05HUxUuc6daD
	 wvYVXLE0f9tkabPkBtVUSjOQBucCItQt76lFM+OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfBVHQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:16:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfBVHQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:16:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842EC20818;
        Fri, 22 Feb 2019 07:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550819779;
        bh=kaiAZgn9n5WahUSplRgXmg9YVQLTnA77Yl+dj2eNnqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9+NEj6XzEKfMY7W77eR9egby/EOeshsqC5A96bYjHhnq5EyTGHiJfyvT9ugqoo4M
         H3zdVc+ZHbOBvPmZ/Yei+VEJh+f+5BIX5S7Eb5bHU3I2vA9ZwYx4LNFdYYaAyKHyKC
         z8NSR5ex+9LRip+Dry61qhXGyWsHMfHCZL1WD3B0=
Date:   Fri, 22 Feb 2019 08:16:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 3/5] soc: qcom: socinfo: Expose custom attributes
Message-ID: <20190222071616.GA2306@kroah.com>
References: <20190220045829.6852-1-vaishali.thakkar@linaro.org>
 <20190221121841.GA32108@pendragon.ideasonboard.com>
 <20190221155742.GD2122@tuxbook-pro>
 <20190221221359.GD3485@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221221359.GD3485@pendragon.ideasonboard.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:13:59AM +0200, Laurent Pinchart wrote:
> Hi Bjorn,
> 
> On Thu, Feb 21, 2019 at 07:57:42AM -0800, Bjorn Andersson wrote:
> > On Thu 21 Feb 04:18 PST 2019, Laurent Pinchart wrote:
> > 
> > > Hi Vaishali,
> > > 
> > > Thank you for the patch.
> > > 
> > > On Wed, Feb 20, 2019 at 10:28:29AM +0530, Vaishali Thakkar wrote:
> > > > The Qualcomm socinfo provides a number of additional attributes,
> > > > add these to the socinfo driver and expose them via debugfs
> > > > functionality.
> > > 
> > > What is the use case for these attributes ? I fear they will be used in
> > > production systems, and that would require debugfs in production, which
> > > isn't a good idea. If you need to expose those attributes for anything
> > > else than debugging then we need a proper API, likely sysfs-based.
> > 
> > The use case of these attributes, beyond development/debugging, are
> > unfortunately somewhat unknown and is the reason why they where moved to
> > debugfs from the earlier attempts to upstream this.
> > 
> > I think the production requirements at hand prohibits debugfs to be
> > present, so attributes that are required beyond development/debugging
> > purposes would have to be migrated out to sysfs - but the idea here is
> > that such migration would have come with the missing motivation to add
> > them there today.
> 
> If the use case is just debug/development, would it be enough to print
> this information in the kernel log at boot time ? I may be a bit
> paranoid, but I always worry about API abuse :-(

Putting stuff in debugfs should be fine.  No system should ever rely on
debugfs for a properly running system as it is being disabled on almost
all "sane" systems (Android included).  If a vendor relies on this
information for a properly working system, then it does not belong in
debugfs.

thanks,

greg k-h
