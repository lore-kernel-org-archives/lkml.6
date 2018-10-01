Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2D4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7F4213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7F4213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJBHyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:54:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeJBHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:54:02 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32F9482;
        Tue,  2 Oct 2018 01:13:27 +0000 (UTC)
Date:   Mon, 1 Oct 2018 13:58:52 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH] firmware: Always initialize the fw_priv list object
Message-ID: <20181001205852.GA24030@kroah.com>
References: <20180920010938.10315-1-bjorn.andersson@linaro.org>
 <20180920052204.GA15695@kroah.com>
 <20180920073415.GC1367@tuxbook-pro>
 <20181001132703.GA12193@centauri.lan>
 <20181001181835.GG5238@garbanzo.do-not-panic.com>
 <20181001183216.GM2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001183216.GM2523@minitux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 11:32:16AM -0700, Bjorn Andersson wrote:
> On Mon 01 Oct 11:18 PDT 2018, Luis Chamberlain wrote:
> 
> > On Mon, Oct 01, 2018 at 03:27:03PM +0200, Niklas Cassel wrote:
> > > On Thu, Sep 20, 2018 at 12:34:15AM -0700, Bjorn Andersson wrote:
> > > > On Wed 19 Sep 22:22 PDT 2018, Greg Kroah-Hartman wrote:
> > > > 
> > > > > On Wed, Sep 19, 2018 at 06:09:38PM -0700, Bjorn Andersson wrote:
> > > > > > When freeing the fw_priv the item is taken off the list. This causes an
> > > > > > oops in the FW_OPT_NOCACHE case as the list object is not initialized.
> > > > > > 
> > > > > > Make sure to initialize the list object regardless of this flag.
> > > > > > 
> > > > > > Fixes: 422b3db2a503 ("firmware: Fix security issue with request_firmware_into_buf()")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > > > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > ---
> > > > > >  drivers/base/firmware_loader/main.c | 7 +++++--
> > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > 
> > > > > Is this being triggered by some hardware somewhere today?  Or is this
> > > > > just a fix found by code inspection?
> > > > > 
> > > > 
> > > > Hi Greg,
> > > > 
> > > > Yes, I found this issue while attempting to load the firmware and boot
> > > > one of the DSPs on one of my Qualcomm dev boards after v4.19-rc4 and it
> > > > can be reproduced on the upstream Dragonboard 820c.
> > > 
> > > I still see this issue on v4.19-rc6.
> > > 
> > > It would be nice if this fix gets merged before v4.19 gets released.
> > 
> > This is the first I hear of this and this patch, so you should re-send
> > it and I can review it. Also please Cc Rishabh.
> > 
> > Rishabh, had you heard of this and can you confirm as well as
> > 422b3db2a503 was your commit?
> > 
> 
> Thanks Luis,
> 
> It seems like Greg did pick the patch yesterday [1], so hopefully he
> sends himself a pull request this week for inclusion in v4.19-rc7.

That was going to be my plan :)

thanks,

greg k-h
