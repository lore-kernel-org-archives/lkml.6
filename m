Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DEAC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016DE20856
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016DE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJXSVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:21:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40059 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJXSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:21:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id m15so2964107otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 02:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lgnOzwnsNnnLXv9SQwxy0vJde9p8lNroVpDu/rzYXqI=;
        b=BEfSm6yF9m29X0IhgfEO/KmGC/MT0Zg3sBP0AA4f82Yuu+D2P9qpwaE07Rpr3/rB0w
         kBL4/f9mIljZBhHJ7BhtF5jZ29ZgI+wVxDJv105HqlThYBtxjhkSVjAmlqYBbMsylItA
         qllvHINQBj5ENua60O03sJYoOzvkVy8wLIBf9c146dkHSCQ4tq5o2y3SN/4WwJJ1WnQy
         FDi1FTD8yT4EgEFsYZoWBDqA17IoAxC2JpVHYwLQotgcXd7UuJ2fc33cGybf5GViYuzp
         EdbSd2MvFRPrHpF9QWQ17hpdPXrnBZkvNUdp9PxWOZkg21raT+jx4Q+nTPSoXKXOZNSj
         5z0g==
X-Gm-Message-State: AGRZ1gI01fcASK/LPy7sei00GUmN+P1ZnKunO4nX3or0EmlUjTm4uol5
        XhADnsYr2T6snPd5gI2ezAXphw==
X-Google-Smtp-Source: AJdET5dPXnZQKTiUCBDfJFQ+7gtoRlMmfC/PlwoJhzzbekQUNE615XU6IS47l4wpUPNi565HPA6+0A==
X-Received: by 2002:a9d:2c65:: with SMTP id f92mr1307300otb.260.1540374829990;
        Wed, 24 Oct 2018 02:53:49 -0700 (PDT)
Received: from localhost ([185.7.230.215])
        by smtp.gmail.com with ESMTPSA id c29sm935638otj.58.2018.10.24.02.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 02:53:49 -0700 (PDT)
Date:   Wed, 24 Oct 2018 10:51:35 +0100
From:   Moritz Fischer <mdf@kernel.org>
To:     Andreas Puhm <puhm@oregano.at>
Cc:     Anatolij Gustschin <agust@denx.de>,
        Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        matthew.gerlach@linux.intel.com
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Message-ID: <20181024095135.GA1382@archbook>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
 <20181023182649.047f1f93@crub>
 <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anatolij, Andreas,

On Tue, Oct 23, 2018 at 06:46:47PM +0000, Andreas Puhm wrote:
> Hi Anatolij,
> 
> > The CvP docs says that on some FPGAs (e.g. Arria 10) the assertion of CVP
> > status can take up to 500ms. However it is not clear whether this delay
> > might be required after peripheral image configuration and after PCIe
> > link activation. The diagram describing configuration sequence suggests
> > that CVP_EN should be polled until it is asserted. I can imaging the
> > situation that this bit is still not asserted when the device is being
> > probed. Maybe we should better defer device probing if CVP_EN bit is
> > cleared? When deferred probing fails again and sufficient period for
> > CVP_EN bit assertion elapsed, then stop deferred probing and return
> > -ENODEV?
> > 
> > Thanks,
> > 
> > Anatolij
> 
> Anatolij, thank you for your feedback.
> 
> My rationale behind the patch is as follows:
> 
> The CVP_EN is part of the Hard PCIe IP core configuration,
> and therefore, has a defined and static value right from "the start".
> 
> Remark in [1, fig 12]
> " For high density devices such as Intel Cyclone 10 GX, 
> it may be necessary to wait up to 500 ms for the CvP
> status register bit assertion."
> According to [2] the Cyclone 10 GX devices achieve proper operation
> within 100 ms (via the PCIe IP core and CvP).
> 
> I think (and here the documentation is a bit lacking), 
> that this remark is valid only for other bits of the status register,
> e.g., CVP_CONFIG_DONE or USERMODE.
> I also think, that the 500 ms delay is calculated from peripheral + core image programming
> and that the time for peripheral image programming is far lower than that 
> (i.e., low enough to allow PCI enumeration).
> 
> But if this actually means that it can take up to 500 ms to program the peripheral image, 
> than such FPGAs would have different problems.
> I.e., missing the deadline for PCI enumeration. 
> This would need a solution outside of the scope of the
> altera_cvp module (e.g., soft-reset to re-start enumeration with a stable system).
> 
> Bottom line: 
> The CVP_EN should be deemed stable when altera_cvp is called, 
> if not, 
> the programming of the Intel/Altera FPGA and PCIe IP core has not been completed in time
> for the enumeration of the PCI device. Hence it would be questionable or, more likely, would not
> have completed successfully in the first place, i.e., altera_cvp would not have been called.

Yeah I think this makes sense. If your config space isn't up on boot you
would run into issues. I agree the docs are soemwhat vague here. Maybe Matthew or Alan can shoot
an email to their HW folks internally to clarify?

Thanks,
Moritz
