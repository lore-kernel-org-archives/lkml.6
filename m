Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0214020870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547197804;
	bh=9arHHS7YO4gvuwzMJK9ShkUqsJ2dpzCoBa938rXLkN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2fie4PvdkOXmZVVAqOWFisTG2V8f1ONnTvRnNH07hqgg1XvaX2NbBaQWMBpHRQpMj
	 GG6UL3udKxrEc4/hL36CxDUB888GJO4iguwymGj4HimMBBskEuk8kibLRGE+hHXLj4
	 scBbXfYl2vTL042ST0252JjE1rXb+lqt9wsida9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfAKJKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbfAKJKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:10:02 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D4E20870;
        Fri, 11 Jan 2019 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547197801;
        bh=9arHHS7YO4gvuwzMJK9ShkUqsJ2dpzCoBa938rXLkN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZTio7UhHklVaMICVxaTQaVLze+mkkCfjIsPCgOl0hJkHhXIJFEs4dQAWZ56xVpG9
         nACWGK6QZ2hFkyBRMuwxZRNW0ehh9/UYiKPNX5t4A3ai2Thniolck2H2L5DHw6UGrD
         uqS+hUNXAVzQTY7g7DA5upPoYV7SbRtcmWBQuUSo=
Date:   Fri, 11 Jan 2019 10:09:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kyle Williams <kdgwill@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/2] USB: quirks: Check device interface LPM capability
Message-ID: <20190111090957.GA15610@kroah.com>
References: <20181205093902.GA18633@kroah.com>
 <20181208014724.951-1-kdgwill@google.com>
 <20181208014724.951-2-kdgwill@google.com>
 <20181212113709.GA20058@kroah.com>
 <20190110154909.GB142026@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110154909.GB142026@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:49:09AM -0500, Kyle Williams wrote:
> On Wed, Dec 12, 2018 at 12:37:09PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Dec 07, 2018 at 08:47:21PM -0500, Kyle Williams wrote:
> > > From: Kyle Williams <kdgwill@chromium.org>
> > > 
> > > Description: enable the ability to disable LPM for all devices matched
> > > by interface information
> > 
> > Why have "Description:" in here?  Of course this is the description :)
> > 
> > And the subject doesn't make much sense, what does this have to do with
> > quirks?
> > 
> > Also, you need more information here in the description about why you
> > are doing all of this, as it is, I have no idea why this patch is needed
> > at all.
> > 
> > thanks,
> > 
> > greg k-h
> 
> It seems the underlying issue has been solved in
> 0472bf0 xhci: Prevent U1/U2 link pm states if exit latency is too long
> 
> However, the patch to fix the issue when matching the USB_QUIRK_NO_LPM
> quirk by iterface could be useful in the future. Currently nothing will
> happen that quirk is matched by interface instead of by vid/pid pair.
> Is their anything that would need to be changed besides removing the
> Description tag?

Don't add code to the kernel that is not used now.  If in the future
someone needs to add this type of functionality, worry about it then...

thanks,

greg k-h
