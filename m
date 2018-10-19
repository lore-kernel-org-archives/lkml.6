Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4471FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9452086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYk4Eni7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9452086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJSOVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:21:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36174 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJSOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:21:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so36106941wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 23:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Aimow2ProajN7DU8WTDTFboPJh+9P3zQemmuxA1ErfY=;
        b=MYk4Eni7XtJGBKx8yrweCgmZHVSynSrudZRlajO8Zp421GmSzy6S+u8LCS0djUevyo
         H/waYQHsi2ghOXWR/yom5Lqr+PzDd5yDYkydFRPEUBp8XB8KN8wfvSf1b2HJZjZfVwX+
         GNN4DNIGD2Y07DWedUot2pONb+VIp9AP+swjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Aimow2ProajN7DU8WTDTFboPJh+9P3zQemmuxA1ErfY=;
        b=hG444rLJKmyTN6cB7lHplJKHvtgatRIFD3ahC0xbEHZCBVx4kB9qHpYPPrXMBOoa/3
         pxSBoAY7tC9PMRAUCK4kXK6/EGeORuPft60HWBNQ27Sp/lsGa1bheZdNcGeIbfY8oaz0
         O73MK3GUxQWGAiy8aETcgojBPB9K2ESmeSg3sY0w01oJU0JGIsrE7RXxHjskqIF/D/pC
         s6lfq3TdXqcSgOYjLNYrDm9ahAJnJAWr7rUQwIOtlEptdszPOKty2y0+JUtI0Xm2Q7fH
         RCA7mo8gYGYAsOIb/Wpx17/LuGIqz3h7EMjVXIcaQVAHTRqsRDngpiPYDXNC1J9vHBFf
         rW7w==
X-Gm-Message-State: ABuFfoiRD4hCIkvkH3SY0rksJS/gkZXMTBHWsD0fDQxFmSXFfccHXHQP
        ibXjUdEHQ52wfDUffdcsomQovw==
X-Google-Smtp-Source: ACcGV61lxMHT10YO1rSFN0gERXaGS+QxKS8fpfTz0FZFKvC3Krby02ZmNDGilLVJjWPW1gURXwFE8Q==
X-Received: by 2002:adf:ed06:: with SMTP id a6-v6mr30027178wro.262.1539929798017;
        Thu, 18 Oct 2018 23:16:38 -0700 (PDT)
Received: from dell ([2.27.167.33])
        by smtp.gmail.com with ESMTPSA id c24-v6sm35838285wre.44.2018.10.18.23.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 23:16:37 -0700 (PDT)
Date:   Fri, 19 Oct 2018 07:16:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     peppe.cavallaro@st.com, dinguyen@kernel.org, linux@armlinux.org.uk,
        alexandre.torgue@st.com, joabreu@synopsys.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, arnd@arndb.de, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Add SOCFPGA System Manager
Message-ID: <20181019061635.GH4939@dell>
References: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
 <021aaa02-1138-e538-3d02-ff639541d0f3@linux.intel.com>
 <a095071e-bd46-e440-fc01-7e2bbaf5964a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a095071e-bd46-e440-fc01-7e2bbaf5964a@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Thor Thayer wrote:


> On 10/10/2018 09:42 AM, Thor Thayer wrote:
> > Hi
> > On 09/24/2018 05:09 PM, thor.thayer@linux.intel.com wrote:
> > > From: Thor Thayer <thor.thayer@linux.intel.com>
> > > 
> > > Add MFD driver for ARM64 SOCFPGA System Manager to steer
> > > System Manager calls appropriately.
> > > The SOCFPGA System Manager includes registers from several
> > > SOC peripherals.
> > > 
> > > On ARM32, syscon handles this aggregated register grouping.
> > > Redirect System Manager calls to syscon for ARM32 SOCFPGA
> > > systems.
> > > 
> > > The ARM64 System Manager can only be accessed from priority
> > > level EL3 so this new MFD driver handles the calls to EL3.
> > > 
> > > Thor Thayer (4):
> > >    mfd: altera-sysmgr: Add SOCFPGA System Manager abstraction
> > >    ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
> > >    arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
> > >    net: stmmac: socfpga: Convert to shared System Manager driver
> > > 
> > >   MAINTAINERS                                        |   6 +
> > >   arch/arm/configs/socfpga_defconfig                 |   1 +
> > >   arch/arm64/configs/defconfig                       |   1 +
> > >   drivers/mfd/Kconfig                                |   9 +
> > >   drivers/mfd/Makefile                               |   1 +
> > >   drivers/mfd/altera-sysmgr.c                        | 310
> > > +++++++++++++++++++++
> > >   .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   4 +-
> > >   include/linux/mfd/altera-sysmgr.h                  | 113 ++++++++
> > >   8 files changed, 444 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/mfd/altera-sysmgr.c
> > >   create mode 100644 include/linux/mfd/altera-sysmgr.h
> > > 
> > Gentle ping.
> 
> Gentle ping again...
> 
> Any comments on this patch series?

"Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway so resending with any comments addressed is generally a
much better approach."

In this case, the we are too late in the series to have these
applied.  Maintainers are generally preparing their submissions for
the merge-window.  The MFD component of this set is marked as "To
Review" and I will get around to it when time is more abundant.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
