Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7A1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD346214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549982130;
	bh=a22hgIJfKTxp2TLmQ004144lHYBgq6DUZ48ZbFSBcj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fpb6+ESCWukkMcVF8YuGYWjq5sypxQrWYYBa6X+0eupVynhL653p99LwVSFZhjtap
	 yYQsfAdCQLSFjKXruN+JPRcDeTvtmhqRe0biZHJ0aFC0E95uLwLy8jpofooxMm1Wzm
	 k3J6MMgu2zpLnYqANZ5Z+mwcD9lDqQvX5mbL0ABo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfBLOf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLOf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:35:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6234F214DA;
        Tue, 12 Feb 2019 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549982127;
        bh=a22hgIJfKTxp2TLmQ004144lHYBgq6DUZ48ZbFSBcj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2da0fwEimUqkcAObxU8CA5e7LHbtwh0c22yZdOqSZ5AY96XmkzTQLR38B26hBm0SG
         q8/CnLIMWMEFwDHglqnjuwA3BvcCxXtr9z/pC6G4/KGliPv+JO5xH6BoTm1XQGSCB0
         1/QP1/mYzjuJJOuHtUQJSZ0mUSomBevnhe4nbo1I=
Date:   Tue, 12 Feb 2019 15:35:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     jcrouse@codeaurora.org, robdclark@gmail.com, evgreen@chromium.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: Add support for an interconnect path
Message-ID: <20190212143525.GA15405@kroah.com>
References: <20190212095238.12306-1-georgi.djakov@linaro.org>
 <20190212101624.GA20915@kroah.com>
 <99ab72bf-9e06-bcaf-85ec-33d4037a54cd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ab72bf-9e06-bcaf-85ec-33d4037a54cd@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:07:35PM +0200, Georgi Djakov wrote:
> Hi Greg,
> 
> On 2/12/19 12:16, Greg KH wrote:
> > On Tue, Feb 12, 2019 at 11:52:38AM +0200, Georgi Djakov wrote:
> >> From: Jordan Crouse <jcrouse@codeaurora.org>
> >>
> >> Try to get the interconnect path for the GPU and vote for the maximum
> >> bandwidth to support all frequencies. This is needed for performance.
> >> Later we will want to scale the bandwidth based on the frequency to
> >> also optimize for power but that will require some device tree
> >> infrastructure that does not yet exist.
> >>
> >> v6: use icc_set_bw() instead of icc_set()
> >> v5: Remove hardcoded interconnect name and just use the default
> >> v4: Don't use a port string at all to skip the need for names in the DT
> >> v3: Use macros and change port string per Georgi Djakov
> >>
> >> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> >> Acked-by: Rob Clark <robdclark@gmail.com>
> >> Reviewed-by: Evan Green <evgreen@chromium.org>
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>
> >> Hi Greg,
> >>
> >> If not too late, could you please take this patch into char-misc-next.
> >> It is adding the first consumer of the interconnect API. We are just
> >> getting the code in place, without making it functional yet, as some
> >> DT bits are still needed to actually enable it. We have Rob's Ack to
> >> merge this together with the interconnect code. This patch has already
> >> spent some time in linux-next without any issues.
> > 
> > I have a question about the interconnect code.  Last week I saw a
> > presentation about the resctrl/RDT code from ARM that is coming (MPAM),
> > and it really looks like the same functionality as this interconnect
> > code.  In fact, this code looks like the existing resctrl stuff, right?
> 
> Thanks for the question! It's nice that MPAM is moving forward. When i
> looked into the MPAM draft spec an year ago, it was an optional
> extension mentioning mostly use-cases with VMs on server systems.
> 
> But anyway, MPAM is only available for ARMv8.2+ cores as an optional
> extension and aarch32 is not supported. In contrast to that, the
> interconnect code is generic and does not put any limitations on the
> platform/architecture that can use it - just the platform specific
> implementation would be different. We have discussed in that past that
> it can be used even on x86 platforms to provide hints to firmware.

Yes, but resctrl is arch independant.  It's not the "backend" that I'm
concerned about, it's the userspace and in-kernel api that I worry
about.

> > So why shouldn't we just drop the interconnect code and use resctrl
> > instead as it's already merged?
> 
> I haven't seen any MPAM code so far, but i assume that we can have an
> interconnect provider that implements this MPAM extension for systems
> that support it (and want to use it). Currently there are people working
> on various interconnect platform drivers from 5 different SoC vendors
> and we have agreed to use a common DT bindings (and API). I doubt that
> even a single one of these platforms is based on v8.2+. Probably such
> SoCs would be coming in the future and then i expect people making use
> of MPAM in some interconnect provider driver.

Again, don't focus on MPAM as-is, it's the resctrl api that I would like
to see explained why interconnect can't use.

thanks,

greg k-h
