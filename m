Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9098FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB0420852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKhHUY4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB0420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbeGIGfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbeGIGfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:35:10 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC6720852;
        Mon,  9 Jul 2018 06:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531118109;
        bh=YDnaCwLSuT9PDsVBufSSgPeFwg24VsuJ1Cg0w5BC8UA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=SKhHUY4RKOvA9UaLfixJezOXHPbanZHTOmw6b7O/hlh3tK7fHFg8IfYSpBUeTDyq7
         9o7tx4YfDZiXNBxrps9q+htLElaXPhAUnF3+XurxSn0vCp+mBauxfGsqXJjuFiv+dk
         GjftpRrUvf3q2slIh2NhsAnnegs36aIBmvYmZ8yk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1530186451-24648-3-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1530186451-24648-1-git-send-email-tdas@codeaurora.org>
 <1530186451-24648-3-git-send-email-tdas@codeaurora.org>
Message-ID: <153111810881.143105.16566097827979485161@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] clk: qcom: gcc: Register QUPv3 RCGs for DFS on SDM845
Date:   Sun, 08 Jul 2018 23:35:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-06-28 04:47:31)
> @@ -3437,7 +3457,12 @@ static int gcc_sdm845_probe(struct platform_device=
 *pdev)
>         regmap_update_bits(regmap, 0x48190, BIT(0), 0x1);
>         regmap_update_bits(regmap, 0x52004, BIT(22), 0x1);
> =

> -       return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
> +       ret =3D qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
> +       if (ret)
> +               return ret;
> +
> +       return qcom_cc_register_rcg_dfs(pdev, gcc_dfs_clocks,
> +                                       ARRAY_SIZE(gcc_dfs_clocks));

This looks backwards. We shouldn't expose the clks to drivers and then
make their functionality work by registering dfs clks. The order should
be swapped.

