Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC37C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1695920879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544548875;
	bh=bIupKJXndQrvoZl7qrIQ8LtY8Dq6t80vBt/IGmb1j7M=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=X1Siq85OUyf8J3yJHPS5NtzIve0Eh4ZmLa6qeSaZCntKlE9NMo+sohAyv8t/3gGxA
	 HkH9jsq6So92rSjYpjBcjbdr13aT/jh38d75SC9ANZ4nTvixFwvG9DIiw+yrg/6Tea
	 HnYnm7PzaW3F8NLDellHwKOB7xEFqA9P6eMXGTZ0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1695920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeLKRVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:21:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbeLKRVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:21:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD9820851;
        Tue, 11 Dec 2018 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544548872;
        bh=bIupKJXndQrvoZl7qrIQ8LtY8Dq6t80vBt/IGmb1j7M=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=PzVVPE0Q124CvIkWgAIHvcGIZd2EcmCqWJL9Wgi2yQOOUTLkWhulDHQp6s5ujr50S
         /yBLiUMpGIUtUmIUQW+UeoK2aWCDYnjOZBkhNrTzbD5OrD5mKWUHjBbKO5gGVD44qV
         YrH80X1TB4nyyr6dqg0YNePuTJLR8CiWR6p4XsPY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211143528.2024488-1-arnd@arndb.de>
Message-ID: <154454887151.17204.5632248748272979028@swboyd.mtv.corp.google.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Subject: Re: [PATCH] clk: tegra: fix SMP build
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181211143528.2024488-1-arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Aapo Vienamo <avienamo@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Dec 2018 09:21:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2018-12-11 06:35:07)
> When CONFIG_SMP is disabled, the tegra clk driver now fails to build:
>=20
> drivers/clk/tegra/clk-tegra30.c: In function 'tegra30_cpu_rail_off_ready':
> drivers/clk/tegra/clk-tegra30.c:1151:19: error: implicit declaration of f=
unction 'tegra_pmc_cpu_is_powered'; did you mean 'tegra_powergate_is_powere=
d'? [-Werror=3Dimplicit-function-declaration]
>   cpu_pwr_status =3D tegra_pmc_cpu_is_powered(1) ||
>=20
> I don't know if tegra works without CONFIG_SMP, but we can get it to
> build by making the calls conditional, and removing the pointless
> ifdef around the declaration. The assumption now is that in a
> non-SMP system, the secondary CPUs are always disabled.
>=20
> Fixes: 61866523ed6e ("clk: tegra30: Use Tegra CPU powergate helper functi=
on")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Not sure if this is the best solution. If you think it's not, please
> submit a different fix.

Hmm.. Is there any reason why the implementation of
tegra_pmc_cpu_is_powered() is under an ifdef CONFIG_SMP? I'd rather not
have to think about SMP or not in this clk code and have the
tegra_pmc_cpu_is_powered() function do the UP vs SMP code optimization.

