Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091DFECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B3320854
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjyISPGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B3320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeGSEFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 00:05:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36138 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeGSEFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 00:05:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id m19-v6so2930792pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QsAXvSAlittPmnuZxtOURpfBnIHPXYoLGzUk3pARK7w=;
        b=ZjyISPGwRSoDQ4AKgKIryOkwsDfRxO/hWkfN7DUJ6N7DHNpVn+gNKb7zFGWnc7EZZM
         ET2vSx1+UsbEw1cFX1eWIDrXDZyrDFYhioaNUbspnSSQXOLzdXi0ICX7B9mtbSBIE5zI
         jw9AwCLj/rCHvwhUD32keH2ZuF8oxFUylK39E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsAXvSAlittPmnuZxtOURpfBnIHPXYoLGzUk3pARK7w=;
        b=AW9iq0QN+H4ABZF511R8YtgVDPn0aoiOWFj10TeOMaFMOP4RvmYhBKbKVZW6DGKlfq
         I6iPG+03hM2M+JdaMZAfivvbSKUx8ldWhMO7oy33tJ8dnO7svZXyLEcWz5jgqSQuiJ36
         XcYhNzt0h0AMUOCLQjVu9AsPvsPyMTgrmuuiAxzlELiMAXORteiGgJDm4EtHYmaiWgZt
         CCk2H6i3XujYrgZM9N42oO30KHdyomu5Nq1zmhkGLIsniM//3NUOhS7ACdhXVHdcdpmC
         +n/9xymp509Iytvgdf4BHlGj69dooYEOaKUSeSjYw9DIvgxu+zHPB0LRIFJNdoX8dYBH
         RcRw==
X-Gm-Message-State: AOUpUlELKHslWlp6Pit3nZWTbrk7gQDYE5f+XUBeZKsQjtHdFSQS60GZ
        jwmv0B8rU4ueHKVFC4o6Nv2KlUpCYDA=
X-Google-Smtp-Source: AAOMgpcuTH4O651A5yK9BEljppC/FYOyr1iDFOcBvQzK7KvItGb+L/ZG3oHOYcA/L3tctTKgl9Fb2g==
X-Received: by 2002:a63:342:: with SMTP id 63-v6mr8007641pgd.290.1531970697291;
        Wed, 18 Jul 2018 20:24:57 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id p20-v6sm6597328pff.90.2018.07.18.20.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 20:24:56 -0700 (PDT)
Date:   Thu, 19 Jul 2018 08:54:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
Message-ID: <20180719032454.2bxp4eil7lfaijji@vireshk-i7>
References: <1531896889-21377-1-git-send-email-Anson.Huang@nxp.com>
 <20180719032002.GT4576@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719032002.GT4576@dragon>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-18, 11:20, Shawn Guo wrote:
> On Wed, Jul 18, 2018 at 02:54:49PM +0800, Anson Huang wrote:
> > Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> > added "operating-points" property for all CPUs, but missed i.MX7D's cpu0,
> > this patch adds it.
> > 
> > Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> In general, when you send a patch fixing a commit, you should have the
> author of that commit copied.  I added Viresh here.
> 
> It looks like a wrong fix to me.  It seems that commit b97872d4eb22
> shouldn't change imx7d.dtsi at all.  So the correct fix would be
> reverting the change on imx7d.dtsi, @Viresh?

Wow! Can't believe such a stupid mistake got merged and no one noticed
:(

Please revert that patch and I will resend the right fix Shawn.

-- 
viresh
