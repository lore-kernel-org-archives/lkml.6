Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E96C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716D220853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716D220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeJVSv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:51:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46222 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbeJVSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:51:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id i4-v6so5610400wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 03:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+vDzutpy4i3aGDuAO9GDJV8l9Toex6uwQ2H12nSR/AU=;
        b=J97eFLqqawvXBYpgOx1ck71z6wT6jxXWpgzNyDPt/GiasSkAoqDbKQU1W6yEgMxeMf
         zMmKlAjIrn9AT46Fy2mxBJ5yyNKdhdXOE871xalWT0qmpwKBcaXyNyy7Z6+KE4lvoi8a
         yUJcmy4XWbD6lFUSq+ekfMABLpTS3amBbX29M1dLUO6NUTvreS2IlpBeSWTb99zhqchY
         gtNFgk5buY7A5zclDQ/GyWX20Ui7cGxayfSntvIgNznZssC1de7FqIT9OD9/Zq23poIs
         Vu98R6k5YCXwZf6hfJ1TdFBeis8DLw6k+YBfqrZESG2CUC/BJEM885zVoas0qnqyXtgP
         9A7w==
X-Gm-Message-State: ABuFfojqby5nY+P73BO4J4TzZjhyTubBcFYCKmIiYafQbO5daxpslKPX
        FAAob6hpo28q5HyXFqyPjSzW/w==
X-Google-Smtp-Source: ACcGV602Bo9NF4lzIWYtolUbjcHpu7BCV8zypmv+aCFw2uXeidkfY9Yq4KBB1hB3R4PK14CSUhZEPQ==
X-Received: by 2002:adf:a352:: with SMTP id d18-v6mr45322201wrb.31.1540204406038;
        Mon, 22 Oct 2018 03:33:26 -0700 (PDT)
Received: from localhost ([185.7.230.215])
        by smtp.gmail.com with ESMTPSA id a1-v6sm28297167wrt.79.2018.10.22.03.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 03:33:25 -0700 (PDT)
Date:   Mon, 22 Oct 2018 03:33:24 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Andreas Puhm <puhm@oregano.at>
Cc:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Bug] altera_cvp registers a PCI device (Altera/Intel FPGA)
 without verifying that it supports CVP
Message-ID: <20181022103324.GA6888@archbook>
References: <2c6313a3f7c04b70b8a06a50934fe27a@SRV177.busymouse24.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6313a3f7c04b70b8a06a50934fe27a@SRV177.busymouse24.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Fri, Oct 19, 2018 at 03:53:02PM +0000, Andreas Puhm wrote:
> Hello,
> 
> I hope the following information is descriptive enough.
> If this is no the case, I will provide further details.
> 
> --------------------------------------------------------------------
> Full description:
> The altera_cvp probe function only checks, 
> if the Altera/Intel PCI device configuration space contains a vendor specific entry (VSEC Capability Header 0x000b) at offset 0x200.
>  But the probe function does not verify, if the PCI device (and further the FPGA), 
> for which it has been called, actually supports the Configure-via-Protocol feature.
> 
> The PCI device (FPGA) can explicitly disable the Configur-via-Protocol (CvP) feature by setting the CVP_EN bit, index 20 of CVP_STATUS register, to '0'. 
> As the altera_cvp probe function does not check this it registers the device in any way. 
> At this point, the altera_cvp module cannot be used to program this device via CvP. 
> In addition no other module can use the device, as it is still registered by altera_cvp.
> 
> Keywords: altera_cvp module, PCI, Configure-via-Protocol
> 
> Kernel version: problem occured with v4.15, should occur from 4.14+
> 
> Instructions to reproduce: 
> Proper hardware is necessary to reproduce this, i.e., FPGA with instantiated Altera/Intel PCIe IP Core with disabled CvP feature.
> 
> Workaround:
> It is possible to circumvent this problem by manually unloading or blacklisting the altera_cvp module.
> 
> Suggested Patch:
> This patch was successfully build and tested for 4.15 and 4.18
> 
> Subject: [PATCH] register device only, if it supports CvP operation

Could you make this: 'fpga: altera_cvp: Conditionalize registration' or
something along those lines?
> 
> This patch is based on: git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tag/?h=v4.18

Put some of the extensive description you made above in the git commit
message, please, such that future us will know why the change was made
:)

Thanks for your patch,

Moritz
