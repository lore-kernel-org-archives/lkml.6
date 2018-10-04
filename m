Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB5C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4944F2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4944F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeJDWZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:25:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42531 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJDWZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:25:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id g20-v6so5991158qke.9;
        Thu, 04 Oct 2018 08:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRUjTd5lbmx1zwUzfGmFm5AR3LSBQR44E8qEpwE9/ng=;
        b=Ju895hVzqGemLKNZ8AcQNDLcO66ed9Mp8V/+oxMFUNhYMKiHgEZmWDkMPzlcVVzgbH
         gRm5VTS3Fy0HW2ugb79R4LD94sEj3dNaCCmWWbHRaz/kIKWYaYQenVXoJgvFrGb01Nmg
         keFz29BD8tK5SKoUFUIHWBYsUnat3KnJ61VV8JWdPPxNTE8WgPpUtquB4AxiX2EON85N
         m0Xcr4pvT6wR34zdn8bVOk/TtJCTVa9nLyDPwoNHGMa7KWOGK7nBWcgbY+0DS0q7nk1t
         VyExzKjANkcrhLkCX+siVRG4d3tSjjHJiwug9mFo0c7Cy2SeHFbpZ8uyHlxWSBl6QXLK
         aC8A==
X-Gm-Message-State: ABuFfohySYuO3i6OlddhPdF97mIvXrfh5IPRtI87Kqf0DOl7Wlc1gx5E
        oWBSzB5bGJljPUW/7iNf+QVFIRSbXQjpojM+eBVqFg==
X-Google-Smtp-Source: ACcGV61CYRq7ITZNGyJSKjczDJBtgRZJzZ4h1ohpJCkSJ28D/rhKeDbuLvPdnuyghxwj3SuA/sWbNNQjhVwb4olQoLs=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr5506938qki.330.1538667077739;
 Thu, 04 Oct 2018 08:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181002212208.2971433-1-arnd@arndb.de> <64a99db8-85e4-52ab-d0fa-0faa5bb7187a@nvidia.com>
 <31707122-ae73-c608-e9f6-c114d6db2b25@nvidia.com>
In-Reply-To: <31707122-ae73-c608-e9f6-c114d6db2b25@nvidia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 17:31:01 +0200
Message-ID: <CAK8P3a1j_Gowa-aK=-3cdgvnhReVyJLigQtceDwXYNZH_tMdbQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: tegra-bpmp: mark PM function as __maybe_unused
To:     talho@nvidia.com
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 5:11 PM Timo Alho <talho@nvidia.com> wrote:
> On 03.10.2018 11:26, Jonathan Hunter wrote:
> > On 02/10/18 22:21, Arnd Bergmann wrote:
> >> The newly added tegra_bpmp_resume function is unused when CONFIG_PM
> >> is disabled:
> >>
> >> drivers/firmware/tegra/bpmp.c:847:12: error: 'tegra_bpmp_resume' defined but not used [-Werror=unused-function]
> >>   static int tegra_bpmp_resume(struct device *dev)
> >>
> >> Mark it as __maybe_unused to avoid the warning and let the compiler
> >> drop it silently.
> >>
> >> Fixes: cd40f6ff124c ("firmware: tegra: bpmp: Implement suspend/resume support")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>   drivers/firmware/tegra/bpmp.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
> >> index 41448ba78be9..a3d5b518c10e 100644
> >> --- a/drivers/firmware/tegra/bpmp.c
> >> +++ b/drivers/firmware/tegra/bpmp.c
> >> @@ -844,7 +844,7 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
> >>      return err;
> >>   }
> >>
> >> -static int tegra_bpmp_resume(struct device *dev)
> >> +static int __maybe_unused tegra_bpmp_resume(struct device *dev)
> >>   {
> >>      struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
> >>      unsigned int i;
> >
> > Arnd, is this seen with 32-bit ARM configs?

This was with a randconfig build on 64-bit ARM. I don't know exactly
what combination of options caused it.

> > Timo, does it make sense to make BPMP dependent on ARCH_TEGRA_186_SOC
> > and ARCH_TEGRA_194_SOC instead of just ARCH_TEGRA? For 64-bit Tegra we
> > have a dependency on PM so this should not be seen for 64-bit Tegra.

CONFIG_PM does not imply CONFIG_PM_SLEEP, so probably it
was just broken for PM=y, PM_SLEEP=n.

> Jon, there will be eventually a BPMP driver for ARCH_TEGRA_210_SOC as
> well. So it is probably more appropriate to make BPMP dependent on ARM64
> & ARCH_TEGRA.

Generally speaking, we are trying to allow building all drivers at least
with CONFIG_COMPILE_TEST, in order to get the best build coverage.

       Arnd
