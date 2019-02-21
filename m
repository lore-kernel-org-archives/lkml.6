Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2627C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B593720818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550784796;
	bh=irY+/5PALgB+L+zeN8czt5RJIiXzW8DIYcm8+fBZVdY=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=NFxAM2ofsNeRhMhOxqbNCm9yXo69EZjzVduJwLaEaZpx0cOLhClMErx6rRIJGylB1
	 v1MDbDYwwdfDaMhpkcu9KT2ILZMkhEjUsskBwjqnaM/bACdnEiPo+YRTI46eUH7J+A
	 q5uBOLxIlKKxBWq+txqkUa8gjq/za9mMhfnWific=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfBUVdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfBUVdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:33:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA4420836;
        Thu, 21 Feb 2019 21:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550784793;
        bh=irY+/5PALgB+L+zeN8czt5RJIiXzW8DIYcm8+fBZVdY=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=ulw0VhcHPn+eRnAFOyscVEw+JirvCTX37j7mROtyeIAJYUiMTGALGIHPUjLwJzJOI
         Lp6iuK8BmEiq4do+LMZuYo+F8bYMkfEekmTcKDoowalfohX/Nqx5gB29k4yYL9gffj
         BBV2fN0VjDK246UPMimLTxxtdBTgBDropSHwF6J8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] clk: samsung: exynos5: Fix kfree() of const memory on setting driver_override
Message-ID: <155078479299.77512.7336673875297969172@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550749552-8133-1-git-send-email-krzk@kernel.org> <1550749552-8133-3-git-send-email-krzk@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550749552-8133-3-git-send-email-krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     stable@vger.kernel.org
Date:   Thu, 21 Feb 2019 13:33:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2019-02-21 03:45:52)
> Platform driver driver_override field should not be initialized from
> const memory because the core later kfree() it.  If driver_override is
> manually set later through sysfs, kfree() of old value leads to:
>=20
>     $ echo "new_value" > /sys/bus/platform/drivers/.../driver_override
>=20
>     kernel BUG at ../mm/slub.c:3960!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>     ...
>     (kfree) from [<c058e8c0>] (platform_set_driver_override+0x84/0xac)
>     (platform_set_driver_override) from [<c058e908>] (driver_override_sto=
re+0x20/0x34)
>     (driver_override_store) from [<c031f778>] (kernfs_fop_write+0x100/0x1=
dc)
>     (kernfs_fop_write) from [<c0296de8>] (__vfs_write+0x2c/0x17c)
>     (__vfs_write) from [<c02970c4>] (vfs_write+0xa4/0x188)
>     (vfs_write) from [<c02972e8>] (ksys_write+0x4c/0xac)
>     (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
>=20
> The clk-exynos5-subcmu driver uses override only for the purpose of
> creating meaningful names for children devices (matching names of power
> domains, e.g. DISP, MFC).  The driver_override was not developed for
> this purpose so just switch to default names of devices to fix the
> issue.
>=20
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next

