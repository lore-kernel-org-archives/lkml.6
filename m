Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB17C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BB82177D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BA218GHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BB82177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeHHTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:50:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46388 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeHHTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:50:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14-v6so1390647pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iAS7wY4Pp/oD5Yj6cpKCHhf+glGjIKLKyfBFf4LnlKk=;
        b=BA218GHBOBZOvgo4Q3X1npwoLIvSUZFNIZymtkSYbXK8X3feVXn3ka0iUNhmU0Vuxv
         pO8Y8mPoh6MQwH0sZL8G/Menho06+guUrKerVvVvem96Y/bAjd/i4pATzN5WsAlwm8ZJ
         /F3suDDHmxD0IQe0NCK43kxFQw3HUr5py2fcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iAS7wY4Pp/oD5Yj6cpKCHhf+glGjIKLKyfBFf4LnlKk=;
        b=CSo+lZg0KuucGi3TbS5Ime22rbW6vJ+P75Bw1Jo7cO+56ND6O2ICOPkJ2QuvZtJMPC
         QAieSc2s4qNdEAoTfRNt14SBlSyYkUOj+u4+Yt9zLqRhs3pymmEoxFfGNpdevltiRjMZ
         OgqPp0XRqeRS3cNB0ihW6DGf8Y4ShVECNHs8kts+gvTc/VQL1bd7EfRBTdDeWZt+XX6M
         whDmZU0TofVKQqGwNl8edKXGl+9BI1lQe8hiIssFn1zAY2z9120ESU9KRb9zDE95yEjM
         ttfmSY6S86rZxT9lggPo6McjFBl8zpt90fqn8BARZsc6DwBS0T4SAXi0AGY4SbDCbXL9
         /xsA==
X-Gm-Message-State: AOUpUlELeG7ixiiRF+X4l2iRxKf5VlakWz/vjPYQTQbwqfs1Sm77uQ0u
        1w/tecbaOaKewmrFBv6tHKgv
X-Google-Smtp-Source: AA+uWPy153Iyg7oldBWUNrzxi0D0PuqdYY17g1O95Y4r65Z+JeuTDVkYYgehPs/3MZIDYc183vGuKw==
X-Received: by 2002:a65:498c:: with SMTP id r12-v6mr3484244pgs.112.1533749402334;
        Wed, 08 Aug 2018 10:30:02 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:80e:9093:d993:ed93:4c98:74f8])
        by smtp.gmail.com with ESMTPSA id w70-v6sm9700660pgd.18.2018.08.08.10.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 10:30:01 -0700 (PDT)
Date:   Wed, 8 Aug 2018 22:59:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com
Subject: Re: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl
 SoCs
Message-ID: <20180808172946.GA4188@Mani-XPS-13-9360>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
 <20180730151131.GA28633@mani>
 <20180807184710.GA26423@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180807184710.GA26423@rob-hp-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Aug 07, 2018 at 12:47:10PM -0600, Rob Herring wrote:
> On Mon, Jul 30, 2018 at 08:41:31PM +0530, Manivannan Sadhasivam wrote:
> > Hi Andreas,
> > 
> > On Mon, Jul 30, 2018 at 12:26:07PM +0200, Andreas Färber wrote:
> > > Hi Mani,
> > > 
> > > Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> > > > This patchset adds Reset Controller (RMU) support for Actions Semi
> > > > Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> > > > the clock subsystem in hardware. Hence, in software we integrate RMU
> > > > support into common clock driver inorder to maintain compatibility.
> > > 
> > > Can this not be placed into drivers/reset/ by using mfd-simple with a
> > > sub-node in DT?
> 
> That is exactly what I tell folks not to do. Design the DT based on h/w 
> blocks, not current desired driver split for some OS.
> 
> > Actually I was not sure where to place this reset controller driver. When I
> > looked into other similar ones such as sunxi, they just integrated into the
> > clk subsystem. So I just chose that path. But yeah, this is hacky!
> > 
> > But this RMU is not MFD by any means. Since the CMU (Clock) and RMU (Reset)
> > are two separate IPs inside SoC, we shouldn't describe it as a MFD driver. Since
> > RMU has only 2 registers, the HW designers decided to use up the CMU memory
> > map. So, maybe syscon would be best option I think. What is your opinion?
> 
> If there's nothing shared then it is not a syscon. If you can create 
> separate address ranges, then 2 nodes is probably okay. If the registers 
> are all mixed up, then 1 node.
> 

I don't quite understand the reason for not being syscon. The definition
of syscon says that, "System controller node represents a register region
containing a set of miscellaneous registers. The registers are not cohesive
enough to represent as any specific type of device." which exactly fits
this case. Only the registers of CMU & RMU are shared and not the HW block!

Can you please clarify?

Thanks,
Mani

> Rob
