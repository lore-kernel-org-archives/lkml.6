Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DDBC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C9420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730103;
	bh=nLmhhOidzO6lg+xbApmuZDdtiXnVp8VFIXqT/N5kF2M=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=dmaY4n6RCZd3AUMk26jqtCmq619YevgCY32gutdBEtCC6YkH402kA1hTFgZYnXdjR
	 Cw3RfFUpUgxXbDgvoZbhiEADCvdEnSo3u5zwD7FLX11IlTG7fJGjhwEVgo7CoAThTZ
	 TYTCuHH/EmhivolM0zsp4TixPyIoXjyXvyO3SaAE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C9420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeLMTll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbeLMTll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:41:41 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E582086D;
        Thu, 13 Dec 2018 19:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730100;
        bh=nLmhhOidzO6lg+xbApmuZDdtiXnVp8VFIXqT/N5kF2M=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=uLAXStnLOabSIfW5Cms5tLz7wzivlZgukBei+M3kLNLUbxr6/iqKv7zJc16hxQGq7
         17jJp3XGIx/NzXSZGmVKHnFGzk8OGytz1WHTa8ycnQMyQZT6vGBErg+JEr4Ldj5Loh
         9PbkBZIdQCBBgV/+hmEXJCXII7PFQBbybPHHjELY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181213160746.GA13531@ulmo>
Subject: Re: [PATCH] soc/tegra: pmc: Drop SMP dependency from CPU APIs
To:     Thierry Reding <thierry.reding@gmail.com>
References: <1544694374-21231-1-git-send-email-jonathanh@nvidia.com> <154469574166.19322.12426804406101736786@swboyd.mtv.corp.google.com> <20181213160746.GA13531@ulmo>
Message-ID: <154473009969.19322.6318653154876468527@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     Arnd Bergmann <arnd@arndb.de>, Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Dec 2018 11:41:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thierry Reding (2018-12-13 08:07:46)
> On Thu, Dec 13, 2018 at 02:09:01AM -0800, Stephen Boyd wrote:
> > Quoting Jon Hunter (2018-12-13 01:46:14)
> > > When CONFIG_SMP is disabled, the tegra clk driver now fails to build:
> > >=20
> > > drivers/clk/tegra/clk-tegra30.c: In function =E2=80=98tegra30_cpu_rai=
l_off_ready=E2=80=99:
> > > drivers/clk/tegra/clk-tegra30.c:1151:2: error: implicit declaration o=
f function =E2=80=98tegra_pmc_cpu_is_powered=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
> > >   cpu_pwr_status =3D tegra_pmc_cpu_is_powered(1) ||
> > >     ^
> > > Fix the above error by removing the CONFIG_SMP ifdef around the
> > > declaration around the PMC CPU APIs because although these are not
> > > needed for non-SMP configurations, there is no harm in including these
> > > for non-SMP builds either.
> > >=20
> > > Fixes: 61866523ed6e ("clk: tegra30: Use Tegra CPU powergate helper fu=
nction")
> > > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >=20
> > Can I pick this into clk tree? That would make the compilation bisection
> > hole very small. I could even reorder the clk-tegra branch to have this
> > before the user so the bisection hole doesn't exist.
>=20
> Fine with me:
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

Ok thanks. I'll reorder things soon, but for now I'll just pick this
atop the tegra branch and merge it up to next.

