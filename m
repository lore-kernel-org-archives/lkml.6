Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D308C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055CC2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCBIGE6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055CC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbeJEV2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:28:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37418 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbeJEV2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:28:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so10544842oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+bQ+nIKK23/pQ9pgt7siDaAu7vcak/3LBclGmIw2Vp4=;
        b=XCBIGE6ixca2o2nk2T5Zq7DdhF/vN0jE80nKy6SfBW10OsKa/h6BLh4leH4Hpjb5xr
         3c7v0Qjg4NtW/KMt1yvigIUtkSl1D6uqNvdLTYF06moY6TyKIo82rA3ZnOlwVZec2Jkt
         /IS/lrCxHo4kSV6IddpXzCJE3l9WNp+htnDhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+bQ+nIKK23/pQ9pgt7siDaAu7vcak/3LBclGmIw2Vp4=;
        b=GCS9C2jkihWekF6rF+yFVad8pIzPusVKPWEzV1Jj0lLHjN6teTm+2BiMQvgHnuKKpS
         Rpp5aNH7Bj5OykQmqU0yoEfkSsAevs5UqjS+XIRxMSSwBbtudgccnVGuiQZaklNyvqzo
         iBjSPser7X07Y6uog0G3UuYf4AYZkP8x2xJtgIzV+jSwzCEJ+K9GHGAfcGs6ib942NcE
         UV7fkhSPW7faBlufztMMrfAIqG5r1GCRCHvMVzZZ8Np/iFshDC4ek6ZMS2lE+Wr7GkOH
         j48f9aVCjHMzE3KHNRlpHdyfg9NM2YXxO6XoMmNo8IGgXoQf5cLPo86K2IbsbONWRJb8
         65GQ==
X-Gm-Message-State: ABuFfoib63/TPCzCmz6V1FRkkEjyReb1qpl2d7Hy1iEVqEaD/Z7X3YT3
        P0wMT8HTUfq5cZhEE8z5wdum4g==
X-Google-Smtp-Source: ACcGV60U/QhyOztmSN8Yn/USlkNyPjCmedLD7KtdsnWsMnI0gN9paVD8hHsYlFNvpsHqiL1xDPBLxQ==
X-Received: by 2002:aca:ccd2:: with SMTP id c201-v6mr4161713oig.357.1538749752763;
        Fri, 05 Oct 2018 07:29:12 -0700 (PDT)
Received: from localhost ([64.157.242.222])
        by smtp.gmail.com with ESMTPSA id m11-v6sm2611386oif.27.2018.10.05.07.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 07:29:11 -0700 (PDT)
Date:   Fri, 5 Oct 2018 09:29:11 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm-soc <arm@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 4.20
Message-ID: <20181005142911.GC15665@hector.nxp.com>
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
 <1538332682-12018-2-git-send-email-andy.gross@linaro.org>
 <CAK8P3a1UyHEATAhg_AP2oK8vkVHx+VKGX9aFBmRzzLpZECjxnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1UyHEATAhg_AP2oK8vkVHx+VKGX9aFBmRzzLpZECjxnA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:30:29AM +0200, Arnd Bergmann wrote:
> On Sun, Sep 30, 2018 at 8:38 PM Andy Gross <andy.gross@linaro.org> wrote:
> >
> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> >
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.20
> >
> > for you to fetch changes up to 6db0483cf622fc690e32e0804f8b86061f13962a:
> >
> >   Revert "dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'" (2018-09-30 12:59:52 -0500)
> >
> > ----------------------------------------------------------------
> > Qualcomm ARM64 Updates for v4.20
> >
> > * Update Coresight for MSM8916
> > * Switch to use mailbox for smp2p and smd on MSM8996
> > * Add dispcc, dsp, USB, regulator, and other nodes for SDM845
> > * Drop model/compatible from MSM8916 and MSM8996
> > * Add compat for db820c
> > * Add MSM8998 SoC and board support along with associated nodes
> > * Add RESIN/PON for Qualcomm PM8916 and PM8994
> 
> Pulled into next/dt, thanks.
> 
> There is a small chance that the two reverts end up causing more
> problems than they help: they might conflict with the patches merged
> into the iio branch, or they could end up being applied on top of
> the iio branch and revert the changes during the release. I think
> it will be fine, but it's obviously better to avoid this.
> 

Agreed, I'll check in on this once -rc1 hits to make sure they weren't removed.


Andy
