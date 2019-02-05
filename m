Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7435DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE9B20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549405005;
	bh=zjjFjM8sR4vK4rxNHikRhBp4Th88nUBzeXV9dOrgbU4=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=ccTH11Yn8wIQLNCZOQGa84zl5yf/9yb8kXT3BEgCMj2qnLJjyvv5Uf8SslQL4r8m4
	 9Q74h6s+H2y6EW3sR5WnvvMhlkS7XfKmXSKC3xEqDAVUhANaIy4+ZSQC/zp8L5g5Bo
	 Lp35Eaneb7LL2Y6vjfGaDqdOZxKd0Iot3Ca0KUzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfBEWQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:16:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfBEWQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:16:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B40420823;
        Tue,  5 Feb 2019 22:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549405002;
        bh=zjjFjM8sR4vK4rxNHikRhBp4Th88nUBzeXV9dOrgbU4=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=mxwgMEvQ9BQstkBKMhxI06bru9GK1wH/pJPzMlkkiJ63y5w30gLQa/WMe0t2aefFB
         Ch95o9PmIqS8fKZACwDE13NginLK9b4QHhnumPKhZ0tGL7gHs7HoveitUxkpFOlzDj
         2vjAJxRUrg1QthF1wy6P8snWpm4Uhhs25EAsNub8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/4] clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940500172.169292.7462110370898212066@swboyd.mtv.corp.google.com>
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org> <1548866171-30341-1-git-send-email-jhugo@codeaurora.org> <154940436246.169292.7591382350282828249@swboyd.mtv.corp.google.com> <54750df0-245c-74ab-2a33-ce1588f3e38e@codeaurora.org>
User-Agent: alot/0.8
To:     Jeffrey Hugo <jhugo@codeaurora.org>, bjorn.andersson@linaro.org,
        mturquette@baylibre.com
In-Reply-To: <54750df0-245c-74ab-2a33-ce1588f3e38e@codeaurora.org>
Date:   Tue, 05 Feb 2019 14:16:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-02-05 14:12:00)
> On 2/5/2019 3:06 PM, Stephen Boyd wrote:
> > Quoting Jeffrey Hugo (2019-01-30 08:36:11)
> > [..]
> >> +};
> >> +MODULE_DEVICE_TABLE(of, mmcc_msm8998_match_table);
> >> +
> >> +static int mmcc_msm8998_probe(struct platform_device *pdev)
> >> +{
> >> +       struct device *dev =3D &pdev->dev;
> >> +       int i, ret;
> >> +       struct regmap *regmap;
> >> +       struct clk *c;
> >> +
> >> +       c =3D devm_clk_get(dev, "xo");
> >> +       if (!IS_ERR(c))
> >> +               dummy_xo_init.parent_names =3D
> >> +                                       (const char *[]){__clk_get_nam=
e(c)};
> >> +       else
> >> +               return PTR_ERR(c);
> >> +
> >> +       c =3D devm_clk_get(dev, "gpll0");
> >> +       if (!IS_ERR(c))
> >> +               dummy_gpll0_init.parent_names =3D
> >> +                                       (const char *[]){__clk_get_nam=
e(c)};
> >> +       else
> >> +               return PTR_ERR(c);
> >=20
> > Urgh, my parent mapping series can't come be merged fast enough it
> > seems!
>=20
> Sorry, I'm not familiar with the context.  Something I should incorporate?
>=20

https://lkml.kernel.org/r/20190129061021.94775-1-sboyd@kernel.org
