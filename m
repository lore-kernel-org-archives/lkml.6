Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BD0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C245321104
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544695744;
	bh=4KZrYhuv+BjbMc4+Wo/IAXPh9npge/nL0CZtitRKs78=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=LEFkvupYb4lckL5OL1NENVhwGuC9+hbFxD3MOWMlskuzq/DQ/RqRIlzHcoIn1FhPb
	 eVnvTO64wY2gkqZkL+UznY1dkYmiiDt8Vc+clYS5YXUEradmqCSdoTMLqsp+HMIZE6
	 UO9tVa1w4ooeIodO26A0Vspy7TLA1eQwybmfITLo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C245321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeLMKJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:09:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbeLMKJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:09:03 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717F220873;
        Thu, 13 Dec 2018 10:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544695742;
        bh=4KZrYhuv+BjbMc4+Wo/IAXPh9npge/nL0CZtitRKs78=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=iywQkorT9MeT61z77QAQlQEWGa+ZYpN5Av7KorPB9jsk2jjmCyZ6i2mfMqpRfivey
         ppV5sdasybAt2sYaC7v6EiE7RoyTSDxDjcghsoDEHZ1eaebyvSTR57ilS3f9TvbdUo
         Q7FFGSIygMytYrVmFLkD0H23UUso+UmnpmaIm+TY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544694374-21231-1-git-send-email-jonathanh@nvidia.com>
Subject: Re: [PATCH] soc/tegra: pmc: Drop SMP dependency from CPU APIs
To:     Arnd Bergmann <arnd@arndb.de>, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <1544694374-21231-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <154469574166.19322.12426804406101736786@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jon Hunter <jonathanh@nvidia.com>
Date:   Thu, 13 Dec 2018 02:09:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jon Hunter (2018-12-13 01:46:14)
> When CONFIG_SMP is disabled, the tegra clk driver now fails to build:
>=20
> drivers/clk/tegra/clk-tegra30.c: In function =E2=80=98tegra30_cpu_rail_of=
f_ready=E2=80=99:
> drivers/clk/tegra/clk-tegra30.c:1151:2: error: implicit declaration of fu=
nction =E2=80=98tegra_pmc_cpu_is_powered=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
>   cpu_pwr_status =3D tegra_pmc_cpu_is_powered(1) ||
>     ^
> Fix the above error by removing the CONFIG_SMP ifdef around the
> declaration around the PMC CPU APIs because although these are not
> needed for non-SMP configurations, there is no harm in including these
> for non-SMP builds either.
>=20
> Fixes: 61866523ed6e ("clk: tegra30: Use Tegra CPU powergate helper functi=
on")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Can I pick this into clk tree? That would make the compilation bisection
hole very small. I could even reorder the clk-tegra branch to have this
before the user so the bisection hole doesn't exist.

