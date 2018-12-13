Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2313C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB8D20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544729783;
	bh=5Lk5CdTHmRY4t+blL2zeIHiMM+B3ZNO9k98hvL6UXHg=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=m0Xq38mHnH06g61jHDkev70uXjQBdh8pS9ZekgK2BZzDXhCvIylwr+ZsZ5KBl4bro
	 Gj7duw8+bc5w5ZE72ScMAdFY8Ld2YHIlt0r2VTUNtihUvx5VT7EQJqfrNGyJGk8WBm
	 MPaZ2zvUSRWnpj/9ZTOCZx3uZYmr0Yz5FMGHhVyY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB8D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeLMTgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeLMTgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:36:22 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F8D2086D;
        Thu, 13 Dec 2018 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544729781;
        bh=5Lk5CdTHmRY4t+blL2zeIHiMM+B3ZNO9k98hvL6UXHg=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=LCzIXalZPXtfVERJAzxnCfKY65QjxaYZ+WlibU+E5TZAHuoFYtF/OyPeaiThd9fFc
         plMaZWx6ZmwgeOeYc1qp+nMvt/ewHv96ZQNRHQJFzOD1yu+MYWr3/g8ihMlBICpFxL
         4/AYZ1KttPv98u8FioHAOGCNatP/nIqLJfHhU+i4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544720370-11598-1-git-send-email-jhugo@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: Leave mmss noc on for 8998
To:     Jeffrey Hugo <jhugo@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com
References: <1544720370-11598-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154472978059.19322.5895645487468845661@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, Jeffrey Hugo <jhugo@codeaurora.org>
Date:   Thu, 13 Dec 2018 11:36:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-13 08:59:30)
> Similar to other qcom targets, gcc_mmss_noc_cfg_ahb_clk should not be
> disabled.  Any mmss access depends on this clock, and its been observed
> that enabling mmssnoc_axi_rpm_clk with rpmcc results in an implicit
> access to mmss and will crash the system if gcc_mmss_noc_cfg_ahb_clk is
> disabled.
>=20
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-msm8998.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm899=
8.c
> index 4b75a09..b371308 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -2014,6 +2014,7 @@ enum {
>                 .hw.init =3D &(struct clk_init_data){
>                         .name =3D "gcc_mmss_noc_cfg_ahb_clk",
>                         .ops =3D &clk_branch2_ops,
> +                       .flags =3D CLK_IGNORE_UNUSED,

It should be marked as CLK_IS_CRITICAL and a comment should be added to
the code indicating why it's critical.

