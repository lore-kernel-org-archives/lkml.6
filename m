Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A049C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0FE21719
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0FE21719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeHHIot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:44:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34786 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbeHHIot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:44:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271137A9;
        Tue,  7 Aug 2018 23:26:38 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B8213F5D0;
        Tue,  7 Aug 2018 23:26:35 -0700 (PDT)
Date:   Wed, 8 Aug 2018 07:26:32 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND RFC 1/4] drivers: pinctrl: qcom: add wakeup
 capability to GPIO
Message-ID: <20180808072632.21f076b6@why.wild-wind.fr.eu.org>
In-Reply-To: <153370830708.220756.4595316550560511917@swboyd.mtv.corp.google.com>
References: <20180801020021.9782-1-ilina@codeaurora.org>
        <20180801020021.9782-2-ilina@codeaurora.org>
        <86600uy4vh.wl-marc.zyngier@arm.com>
        <20180801194538.GA6422@codeaurora.org>
        <86wot9wb9u.wl-marc.zyngier@arm.com>
        <20180802065104.GA27850@codeaurora.org>
        <86sh3xw7m9.wl-marc.zyngier@arm.com>
        <20180802125827.GB27850@codeaurora.org>
        <153370830708.220756.4595316550560511917@swboyd.mtv.corp.google.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018 23:05:07 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Lina Iyer (2018-08-02 05:58:27)
> > On Thu, Aug 02 2018 at 01:27 -0600, Marc Zyngier wrote:  
> > >
> > >Sure. But once woken up (GIC *and* TLMM), the gpio line (which I
> > >assume is level) is still high at the TLMM input. So why isn't it
> > >registering that state once it has been woken up?
> > >
> > >I can understand that it would be missing an edge. But that doesn't
> > >hold for level signalling.
> > >  
> > Sure, yes. Sorry for not registering your point in my response.
> > Once woken up we should see the level interrupt in TLMM.  
> 
> And the level type gpio interrupt will trigger the TLMM summary
> interrupt line after the wakeup? So then the only thing that needs to be
> replayed is edge interrupts? How are edge interrupts going to be
> replayed?

Level interrupts should be taken care of without doing anything, by the
very nature of being a level signal.

Edge interrupts should be replayed using check_irq_resend() after
taking the right locks and making the interrupt pending. Or, if there
is a way for SW to make the interrupt pending at the TLMM level, to use
that as a way to reinject the interrupt (which would be the preferred
way, as it avoids all kind of ugly locking considerations).

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
