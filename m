Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB67CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C37D20890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ohx3GYbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C37D20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeG3QrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:47:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42798 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeG3QrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:47:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id z7-v6so5682531plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7/qGbcYNWuaF9+n2xN3ko6zeMnNRz9p8aXSyP49nfm0=;
        b=Ohx3GYbH+ZJlKj+jFYwCUK9aSLjTHwZ2LlIwL11VobydAOcmIBR/viXeEwNS6D586C
         TX0rCjOfXAGyj4x6YcgTj9r1sChjYP9eK3l11m1Dc4GQa+VR3Uj9sMOUgypOuwOYzRPs
         v2Ce7ycirDOjfTrJXNaxSQRiuBaW+5TmgKEX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7/qGbcYNWuaF9+n2xN3ko6zeMnNRz9p8aXSyP49nfm0=;
        b=cg4By4MmIeu723PTyBy8pQOOyg4K/TdbFelrfGUcS9gk5+S3x3mxh0bNy8lQNrLGPe
         E7Cw2+rZhT2Jf7sewW3hctMwBHvLtlNBS+Uc/hRxbWDrdGMfB1Cjptno41V5y/WiTYfR
         VtdhYOewTjmkRFB1n+RuByV+xG6+ilhF48B8SylIiqQh3y0xp+qvYLiQg+v+pbG3q2RU
         /lXjGadDVcPsakdYH3hTGgxzY9E7XbsRAHCREXi4xL3+YieGVa/QAlJEw0sF0R5sywZv
         x32fdQOE84oCuzrKkIbYG3BZ2/dhbNpJkmLOE+RlM8ki6fOoBYcBjDiI8ZCGnZErqnPM
         FlZA==
X-Gm-Message-State: AOUpUlHuLJf/zKExVY+abn5slUyky2BXywFRNWKG3czbomBHwZ3nrFmS
        qoao9hqdBKhnG731gAqOhDNO
X-Google-Smtp-Source: AAOMgpfJ+pKzricxBVeqnSzRYAePlfxjJ9OlGcyVNjNGfinNAnxgWotG+k2oAlxZ340hGnLu9qT0+g==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr16725167plb.108.1532963502735;
        Mon, 30 Jul 2018 08:11:42 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id d13-v6sm13236156pgq.42.2018.07.30.08.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:11:42 -0700 (PDT)
Date:   Mon, 30 Jul 2018 20:41:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, linux-clk@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        sravanhome@gmail.com
Subject: Re: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl
 SoCs
Message-ID: <20180730151131.GA28633@mani>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Mon, Jul 30, 2018 at 12:26:07PM +0200, Andreas Färber wrote:
> Hi Mani,
> 
> Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> > This patchset adds Reset Controller (RMU) support for Actions Semi
> > Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> > the clock subsystem in hardware. Hence, in software we integrate RMU
> > support into common clock driver inorder to maintain compatibility.
> 
> Can this not be placed into drivers/reset/ by using mfd-simple with a
> sub-node in DT?
> 

Actually I was not sure where to place this reset controller driver. When I
looked into other similar ones such as sunxi, they just integrated into the
clk subsystem. So I just chose that path. But yeah, this is hacky!

But this RMU is not MFD by any means. Since the CMU (Clock) and RMU (Reset)
are two separate IPs inside SoC, we shouldn't describe it as a MFD driver. Since
RMU has only 2 registers, the HW designers decided to use up the CMU memory
map. So, maybe syscon would be best option I think. What is your opinion?

Even if we go for syscon, we should place the reset driver within clk
framework as I can see other SoCs like Mediatek are doing the same. But again
I'm not sure!

Thanks,
Mani

> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
