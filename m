Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D9FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEC620839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4fA6qiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEC620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeHaFPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:15:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42272 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeHaFPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:15:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so4667899pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sYbxiKtqEPlXxVQhoHNaZMm9sVyoKWCbUjt4ADkdQ1Y=;
        b=D4fA6qiRvsKQQwlZI6IDZGmpzyMH9o0YLW8VQeQ1y25cU52ZZ46ylZbEZDtsCJb3nx
         0pzSBbON7yZZly/p7i/vb13HwtXIJtah6Tx/hWrBRckwofcs4SuXJJ0JREhOgqJcsbmi
         tSJHGDiCNpGcoRJSEipf3azMADl08PPDBG6Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sYbxiKtqEPlXxVQhoHNaZMm9sVyoKWCbUjt4ADkdQ1Y=;
        b=h4ue3O/1oLKfcQC+beahi5A0sRHf3pUCxTg2l4PsCPb+tp83lwiYVNPN6KbXDg7ZZA
         JJsm4JTgvQzOhgIk4YAGZ/gF7Nwu7ychGK7RjYA/FLubWrIOdnycjJJajhHIbaKUxVW7
         hmQBnhJxtxn6708NFkgsSe/r8EUw58alu6vkDstGMTiANUA+IyCrxAYTBj1IxtHYE4rY
         g9dlnUO0nXSJc8G1sOh4XPQOTVWxchgDA/+sxzlR87DupjWqb4OCUbExt3cYmzuRVjpk
         8zfSrYV6rFQLuK3cPY2SqOjKILrRhft7H3rG5E5ZZ25Bg4iouM1MfNuLY3faFudQn3CG
         8CEw==
X-Gm-Message-State: APzg51D2kx4PDsXF+MEQkHmnT5HlsNYV8W9Q0Wm850I0S76B5mZk4a29
        1z3QdbimIdiDcDMK2cGCgRxZ2Q==
X-Google-Smtp-Source: ANB0VdY2hvWFWGnAjHPtGVB3sqoXGy1jY7Xc1yiRKHIBs2GWAR4wYhV+v54ytahp9uUovSepyodwgw==
X-Received: by 2002:a63:4a09:: with SMTP id x9-v6mr11802377pga.34.1535677837042;
        Thu, 30 Aug 2018 18:10:37 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u13-v6sm10759896pfn.59.2018.08.30.18.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 18:10:36 -0700 (PDT)
Date:   Thu, 30 Aug 2018 18:10:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        asutoshd@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon <kishon@ti.com>, robh+dt <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v8 0/5] Support for Qualcomm UFS QMP PHY on SDM845
Message-ID: <20180831011033.GN2523@minitux>
References: <20180731100914.19856-1-cang@codeaurora.org>
 <20180830061604.GM2523@minitux>
 <CAFp+6iGDvt9UX8y7HCwC+QdTdyCLxuj5pNWbbttJAHGEPW+tyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iGDvt9UX8y7HCwC+QdTdyCLxuj5pNWbbttJAHGEPW+tyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Aug 03:44 PDT 2018, Vivek Gautam wrote:

> On Thu, Aug 30, 2018 at 11:46 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Tue 31 Jul 03:09 PDT 2018, Can Guo wrote:
> >
> > > This patch series adds support for UFS QMP PHY on SDM845 and the
> > > compatible string for it. This patch series depends on the current
> > > proposed QMP V3 USB3 UNI PHY support for sdm845 driver [1], on
> > > the DT bindings for the QMP V3 USB3 PHYs based dirver [2], and also
> > > rebased on updated pipe_clk initialization sequence [3]. This series
> > > can only be merged once the dependent patches do.
> > > [1] http://lists-archives.com/linux-kernel/29071659-dt-bindings-phy-qcom-qmp-update-bindings-for-sdm845.html
> > > [2] http://lists-archives.com/linux-kernel/29071660-phy-qcom-qmp-add-qmp-v3-usb3-uni-phy-support-for-sdm845.html
> > > [3] https://patchwork.kernel.org/patch/10376551/
> > >
> >
> > Hi Can,
> >
> > We still have the issue that the older non-QMP phy driver takes a direct
> > call to ufs_qcom_phy_set_tx_lane_enable(), which means that pointing
> > UFSHCD to this phy implementation results in a kernel panic.
> 
> Hi Bjorn,
> 
> I have a series that removes couple of these function calls -
> ufs_qcom_phy_set_tx_lane_enable(), and
> ufs_qcom_phy_save_controller_version() from ufs-qcom, and
> make phy-qcom-ufs-qmp-20nm as broken.
> I can post it out if that sounds okay.
> 

That sounds really good, please do sent that out.

Regards,
Bjorn
