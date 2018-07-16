Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71E2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EBA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EBA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeGPV6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:58:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37471 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeGPV6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:58:10 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so77584495oib.4;
        Mon, 16 Jul 2018 14:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z4LTUphqrMF2ZUQkliDnej/gPLyoQjbEBwgTd9g6gvo=;
        b=MnEdgsmepfH3oGWAJrAZUdgk4sYMNwPC3BWT8OTROPnQRgXXSHtpYbddjBEg6umQml
         ByCdKlaGjP7uDpp5EqSwC7RUEzAW94K4VGJ34Q7ZQn710jCgcXOzNSuYpYt7RCVDfAUr
         De58pxY1KvyLtbe/xAHGY2yl4tZRbKWIMjVY+m45RWVJNV9Po+KeyvXHdDJd6owAZ6hW
         ASNjDZq9HMO83stDmpqjCCQ677kcojqKXBS4/D78tYqkRkBHzTotb3WH0mdq1C9oiL3s
         jqmyy+yxudk+D2Y+GjzhK81ADpTN7qp4lY20gGW2YK5/ETg1g6CK+l1ntY32nOzs3x00
         X7/Q==
X-Gm-Message-State: AOUpUlEsPg3rPJyPCW/6H56i6cW56NttKc6zCq1ZG47lHcfOnWiAxHqZ
        J8oP19Hbjm6aC4AmfKVZLvllP+o=
X-Google-Smtp-Source: AAOMgpeZD5rBFhgJQpDu4ehuJR2dtHJPUmFlHhzDv1eC+rbBSiwkybQp+GHo4PbeB0kWRShOBnWs8w==
X-Received: by 2002:aca:a64d:: with SMTP id p74-v6mr1034454oie.149.1531776534378;
        Mon, 16 Jul 2018 14:28:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r133-v6sm30021629oia.33.2018.07.16.14.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:28:53 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:28:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Vinod <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
Message-ID: <20180716212852.GA6323@rob-hp-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-3-paul@crapouillou.net>
 <20180709170359.GI22377@vkoul-mobl>
 <1531237019.17118.1@crapouillou.net>
 <20180711121655.GS3219@vkoul-mobl>
 <20180711232715.djxrbgmcski5xtjp@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711232715.djxrbgmcski5xtjp@pburton-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:27:15PM -0700, Paul Burton wrote:
> Hi Vinod,
> 
> On Wed, Jul 11, 2018 at 05:46:55PM +0530, Vinod wrote:
> > > > >  -	jzdma->base = devm_ioremap_resource(dev, res);
> > > > >  -	if (IS_ERR(jzdma->base))
> > > > >  -		return PTR_ERR(jzdma->base);
> > > > >  +	jzdma->chn_base = devm_ioremap_resource(dev, res);
> > > > >  +	if (IS_ERR(jzdma->chn_base))
> > > > >  +		return PTR_ERR(jzdma->chn_base);
> > > > >  +
> > > > >  +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > > >  +	if (!res) {
> > > > >  +		dev_err(dev, "failed to get I/O memory\n");
> > > > >  +		return -EINVAL;
> > > > >  +	}
> > > > 
> > > > okay and this breaks if you happen to get probed on older DT. I think DT
> > > > is treated as ABI so you need to continue support older method while
> > > > finding if DT has split resources
> > > 
> > > See my response to PrasannaKumar. All the Ingenic-based boards do compile
> > > the devicetree within the kernel, so I think it's still fine to add breaking
> > > changes. I'll wait on @Rob to give his point of view on this, though.
> > > 
> > > (It's not something hard to change, but I'd like to know what's the policy
> > > in that case. I have other DT-breaking patches to submit)
> > 
> > The policy is that DT is an ABI and should not break :)
> 
> I think in general that's a good policy to have for compatibility, but
> if it's known for certain that the DT for all users of a driver is
> always built into the kernel then I don't see why we shouldn't feel free
> to change a binding. I agree with Paul that it'd be interesting to hear
> the DT binding maintainers take on this.

If the platform maintainers (and their users) don't care, then I don't 
have an issue with the change. It should still be an exception and not 
just any change goes. The commit message should still highlight that 
compatibility is being broken and why.

Rob

