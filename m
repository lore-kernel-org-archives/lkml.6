Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75020C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B54214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544094334;
	bh=0Vg14cJswUdu4Guq0VJrDrciXp8LM6AgTjCKoE1fN+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lY57jxP4InLYxGWpOSmnVrLE/FyvlFuKJOBsircFMeM+ZF2y9swt2tIXghtWK7QH8
	 KJ4rD8fMTOFTqvVuZ3oKp4mgKnE4kx1yPx4bjzvL70nP3f4E7D3/TFOvyO5QTptcAq
	 xQAWuzXLjcKCJKcfi9ASKoa6dLFIiaVuDzZj3j/0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B54214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeLFLFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbeLFLFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:05:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CC720838;
        Thu,  6 Dec 2018 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544094331;
        bh=0Vg14cJswUdu4Guq0VJrDrciXp8LM6AgTjCKoE1fN+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGslOcTt2OGkq2X+AW+ArpJDfnU9a//f/x96pH6Cnc8M5j9RfVeqAGGV+W9qf98l7
         RE8o3GKJeZzNAO2UTb+yJMnhD/1ixzJwMABiZKUZ0xcuBq1yhaHDTzPoNJOihj12mQ
         M3/TpgKu3MsZKIzI3r42RNW50M7cUy/CaDZWloWA=
Date:   Thu, 6 Dec 2018 12:05:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: v4.14 fix for Hikey 960 unbalanced IRQ enablement
Message-ID: <20181206110528.GM19891@kroah.com>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
 <20181203141442.GA19335@kroah.com>
 <dc468512-7a73-3d69-fe9e-d660db85ee5b@linaro.org>
 <20181203151946.GG235790@sasha-vm>
 <20181203180521.GA15996@kroah.com>
 <e0eb7f46-e619-7198-eb78-2b55246b1159@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0eb7f46-e619-7198-eb78-2b55246b1159@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 04:24:48PM -0200, Rafael David Tinoco wrote:
> >> Greg,
> >>
> >> Patch 5 in this series seems to explain the best what is happening here:
> >>
> >>> With the following changes, we fix all in one:
> >>>
> >>> - Do the setup, one time, at probe time
> >>>
> >>> - Add the IRQF_ONESHOT, ack the interrupt in the threaded handler
> >>>
> >>> - Remove the interrupt handler
> >>>
> >>> - Set the correct value for the LAG register
> >>>
> >>> - Remove all the irq_enabled stuff in the code as the interruption
> >>>   handling is fixed
> >>>
> >>> - Remove the 3ms delay
> >>>
> >>> - Reorder the initialization routine to be in the right order
> >>
> >> We can't revert anything because the breakage was there since the driver
> >> was introduced.
> > 
> > So the driver was broken in 4.14, why not just use 4.19 instead?  This
> > isn't a 4.14 regression, it's something that obviously no one has
> > noticed for a year now, so why backport these big patches to 4.14 now?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> This was caught during our functional tests. No direct complains, but,
> since it included a trace, and there was a fix for it, I thought it
> could be accepted for upstream v4.14 (it is included in other v4.14
> kernels, like Android's).

Ok, all now queued up, thanks.

greg k-h
