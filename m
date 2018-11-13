Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8B8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB67223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1KeSWPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB67223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbeKMQf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:35:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45705 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbeKMQf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:35:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id k15-v6so11888967wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cHXBjmXnlS0+8ifj0CCy7IRgX5uXnH86NfFlBkWP63o=;
        b=j1KeSWPmJ2KSxpQaAJ7mSMH7KPXzIf55SF+tkyZ31x6BIgUOeMkcbYhcoALAeg5/Ie
         oJyO7MH71y2wckvRcNhZgBHIvtWFpaSJVLXf/aLFyRi8RwGd0foSWIzDhY7D4TU83T6D
         avsblGWLxyLN2XAoPoY1pVwkDlnSBMH5hZPvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cHXBjmXnlS0+8ifj0CCy7IRgX5uXnH86NfFlBkWP63o=;
        b=e/MR7mi6KFJkMUUoqysv96WZmr+BThq6KHpuerazeYquUr77x4LixnKHl5HHz3tYn/
         6vJrE/rRm2X4IvbaBtN8li3/utiMvrLhyeUyQCUWb7DcxNihGEvnb7lkWQnLKSHnsWK6
         wuIGArj5lOxjfVWmJaDq36kNL6DBvlRG2hmIEBj3VSdfohigkRxGHfe6Gn7sv67dp860
         tqrTOTIGBfK6rR74awDxygDHROCsM7gukVbgX9deNOZXyGqKj80KwjFDxsrBNqoYpC/2
         2ILr9pC22P2+gbVo6tcmy6I73uJoaTkBE1Za5W95UlMIHiA2oeglgAWFIxTdk/qZdX6h
         dj6Q==
X-Gm-Message-State: AGRZ1gIyd7ZtHNvmlfElssKLy3qSpS3NBOuJbJz/DsSJLYEc6RliF3+S
        CzLForV/YmeKB7as7XT4wHllaw==
X-Google-Smtp-Source: AJdET5e+5/tWDkje44BRAdzkM0h7CJEx5hlIBwNWNQxz3OuxCnIt283G3BwrzDY9CTrZGq2MT2S76g==
X-Received: by 2002:a5d:4450:: with SMTP id x16-v6mr3694614wrr.308.1542091155814;
        Mon, 12 Nov 2018 22:39:15 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id b5-v6sm11320832wrs.34.2018.11.12.22.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 22:39:15 -0800 (PST)
Date:   Tue, 13 Nov 2018 06:39:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     peppe.cavallaro@st.com, dinguyen@kernel.org, linux@armlinux.org.uk,
        alexandre.torgue@st.com, joabreu@synopsys.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, arnd@arndb.de, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Add SOCFPGA System Manager
Message-ID: <20181113063913.GB5342@dell>
References: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
 <021aaa02-1138-e538-3d02-ff639541d0f3@linux.intel.com>
 <a095071e-bd46-e440-fc01-7e2bbaf5964a@linux.intel.com>
 <20181019061635.GH4939@dell>
 <c08bf646-bf9f-5dad-acc8-6975acd6cff3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c08bf646-bf9f-5dad-acc8-6975acd6cff3@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Nov 2018, Thor Thayer wrote:

> Hi
> 
> On 10/19/18 1:16 AM, Lee Jones wrote:
> > On Wed, 17 Oct 2018, Thor Thayer wrote:
> > 
> > 
> > > On 10/10/2018 09:42 AM, Thor Thayer wrote:
> > > > Hi
> > > > On 09/24/2018 05:09 PM, thor.thayer@linux.intel.com wrote:
> > > > > From: Thor Thayer <thor.thayer@linux.intel.com>
> > > > > 
> > > > > Add MFD driver for ARM64 SOCFPGA System Manager to steer
> > > > > System Manager calls appropriately.
> > > > > The SOCFPGA System Manager includes registers from several
> > > > > SOC peripherals.
> > > > > 
> > > > > On ARM32, syscon handles this aggregated register grouping.
> > > > > Redirect System Manager calls to syscon for ARM32 SOCFPGA
> > > > > systems.
> > > > > 
> > > > > The ARM64 System Manager can only be accessed from priority
> > > > > level EL3 so this new MFD driver handles the calls to EL3.
> > > > > 
> > > > > Thor Thayer (4):
> > > > >     mfd: altera-sysmgr: Add SOCFPGA System Manager abstraction
> > > > >     ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
> > > > >     arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
> > > > >     net: stmmac: socfpga: Convert to shared System Manager driver
> > > > > 
> > > > >    MAINTAINERS                                        |   6 +
> > > > >    arch/arm/configs/socfpga_defconfig                 |   1 +
> > > > >    arch/arm64/configs/defconfig                       |   1 +
> > > > >    drivers/mfd/Kconfig                                |   9 +
> > > > >    drivers/mfd/Makefile                               |   1 +
> > > > >    drivers/mfd/altera-sysmgr.c                        | 310
> > > > > +++++++++++++++++++++
> > > > >    .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   4 +-
> > > > >    include/linux/mfd/altera-sysmgr.h                  | 113 ++++++++
> > > > >    8 files changed, 444 insertions(+), 1 deletion(-)
> > > > >    create mode 100644 drivers/mfd/altera-sysmgr.c
> > > > >    create mode 100644 include/linux/mfd/altera-sysmgr.h
> > > > > 
> > > > Gentle ping.
> > > 
> > > Gentle ping again...
> > > 
> > > Any comments on this patch series?
> > 
> > "Please don't send content free pings and please allow a reasonable time
> > for review.  People get busy, go on holiday, attend conferences and so
> > on so unless there is some reason for urgency (like critical bug fixes)
> > please allow at least a couple of weeks for review.  If there have been
> > review comments then people may be waiting for those to be addressed.
> > Sending content free pings just adds to the mail volume (if they are
> > seen at all) and if something has gone wrong you'll have to resend the
> > patches anyway so resending with any comments addressed is generally a
> > much better approach."
> > 
> > In this case, the we are too late in the series to have these
> > applied.  Maintainers are generally preparing their submissions for
> > the merge-window.  The MFD component of this set is marked as "To
> > Review" and I will get around to it when time is more abundant.
> > 
> 
> Gentle ping now that the merge window is over.
> 
> I'm not clear on the scolding for content free pings.
> 
> Other pings I've seen just reference the patch series summary instead of
> each patch individually. It seems like pings for each patch would add more
> to the mail volume than the summary but perhaps I'm misunderstanding
> something.  I'm happy to ping each patch separately if that is preferable.

Please don't ping at all.  If you would like to attract attention,
please resend your patch-set with s/[PATCH]/[RESEND]/.

> Series can be found here:
> https://patchwork.kernel.org/cover/10612891/
> 
> [PATCH 1/4] mfd: altera-sysmgr: Add SOCFPGA System Manager
> [PATCH 2/4] ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
> [PATCH 3/4] arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
> [PATCH 4/4] net: stmmac: socfpga: Use shared System Manager driver
> 
> Thanks,
> 
> Thor

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
