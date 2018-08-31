Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7A8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C420839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbzQx5W1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985C420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeHaFWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:22:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39065 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeHaFWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:22:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so4688634pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQNdIZ3TLfc4d09Pdg3V38c+0nG11ntMF7QPjaRIi3Q=;
        b=FbzQx5W1L2N3hk0AEMBxRJXRHnvQEb47HFDyOMQgGOcyKei6Ij2IPt8jbSsp4FI0wQ
         mVyYtBvUUxtd+2eGSRN4w9p6LYKR6M8+V0Fo0I97UAaWPtdPg+mLxeJNB44HcHQsF/Mr
         m32pwcXll0zejXBBQcnBg6i9Pj/duldVFCxE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQNdIZ3TLfc4d09Pdg3V38c+0nG11ntMF7QPjaRIi3Q=;
        b=rpdLO6KPTdwhIxIhPqzuC959t0C3AnOexth6/zPdbJNE98C4ovog0JT8b9UKcjbdon
         mzyAAeYIq3qmBUko+qi4IWV9NvQ/MLNX8Dp22lu/bql3tbRiEEu/zYiJDFXXE2Aoy7ub
         yBLfMUdgR6WPXi6BOv38i8BICd5RvLG/VTfmq9jKjKOR9sz2f38Xb6CdZUjaef+LHoNH
         f1KnYD2GChwh0JtY3BSh6YolxJ73v+KnoCBd//yhchwh39Y6UHt/9/0h0twJvtFKXVbx
         iXdCP3tPrhsQ9ZfB7fT4fLUAXuAKViwOEeDUfb8wtyFZIW6cbIE6SHCRhcdQ3OEFbMgN
         3L4g==
X-Gm-Message-State: APzg51DNRZh8R6dqAOS9WwCFDz6M4R9qkJiUm6WIGnB/Y6iA/Q5l04xX
        urAUvDvfVBphx1U2PhzDKeka3Q==
X-Google-Smtp-Source: ANB0VdZbvuOzQrMfLTUff2+zQWq7kbQ9LgWOsb4Qt+3Zox30QurC84nRf3RLLALDzrmiXuIlbH9TgQ==
X-Received: by 2002:a63:2906:: with SMTP id p6-v6mr12171854pgp.204.1535678263945;
        Thu, 30 Aug 2018 18:17:43 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a16-v6sm9458137pgv.29.2018.08.30.18.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 18:17:43 -0700 (PDT)
Date:   Thu, 30 Aug 2018 18:17:41 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH 0/3] firmware: qcom: scm: Improve clock handling
Message-ID: <20180831011741.GO2523@minitux>
References: <20180829231505.22660-1-bjorn.andersson@linaro.org>
 <153567767852.93865.5427679731919930718@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153567767852.93865.5427679731919930718@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Aug 18:07 PDT 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-08-29 16:15:02)
> > We're currently facing the issue that every new platform requires the addition
> > of a compatible to the DT binding as well as the driver.
> > 
> > The DT binding patch to allow us to use qcom,scm for all these new platforms
> > that doesn't require any clocks and the driver is reworked to make the qcom,scm
> > still pick up specified clocks in this case but won't require them.
> > 
> > This makes it possible to add new platforms by simply add the new compatible to
> > the list in the DT binding, but no changes needs to be done in the driver.
> > Which is what is done in patch 3.
> > 
> 
> I still think it may be even simpler to move to the "get all the clks"
> API and then stop caring completely. Any reason to not do that?
> 

I love working with drivers that tells me things like "hey you forgot to
add the 'core' clock", rather than having to spend hours bisecting which
register access it is that's causing that reboot and then try to drill
that down to a particular clock.

Apart from that, the "get-all-the-clocks" would work fine as well. Does
this API exist yet?

Regards,
Bjorn
