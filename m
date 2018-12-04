Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D566C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02D8206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3RzuVhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02D8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeLDSnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeLDSnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:43:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7045206B7;
        Tue,  4 Dec 2018 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543948999;
        bh=BmJ2Wy2RklIjViSxlyIadstKkbH8qI/+X2Vn6hRroX4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=T3RzuVhZgEu17ob5PHGc5IKppmwMfV88phmkrcLNIZGwRxfQOTaARujPGAiVT36so
         Feb97jG3KifjLq5OKQcWsm+QzyaYnY3YrtwOogcxeaL2ZOYLBNK+AMK79UrWRsgRPv
         fgoszVuLSp0WHN+TPHDVQBEgvpdokVER0NlDMsnw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204163403.32321-1-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181204163403.32321-1-jbrunet@baylibre.com>
Message-ID: <154394899913.88331.6973889205055781649@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: fix clk_mux_val_to_index() error value
Date:   Tue, 04 Dec 2018 10:43:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-12-04 08:34:03)
> clk_mux_val_to_index() is meant to be used by .get_parent(), which
> returns a u8, so when the value provided does not map to any valid index,
> it is not a good idea to return a negative error value.
> =

> Instead, return num_parents which we know is an invalid index and let
> CCF deal with it.
> =

> Fixes: 77deb66d262f ("clk: mux: add helper function for index/value trans=
lation")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Thanks!

> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 60c51871b04b..fc20886ef069 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -550,8 +550,8 @@ struct clk_hw *clk_hw_register_mux_table(struct devic=
e *dev, const char *name,
>                 void __iomem *reg, u8 shift, u32 mask,
>                 u8 clk_mux_flags, u32 *table, spinlock_t *lock);
>  =

> -int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int fla=
gs,
> -                        unsigned int val);
> +u8 clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flag=
s,

I wonder if we should just make this unsigned int? Does it hurt at all
to have it be a wider type even though it doesn't match the CCF decision
to make this a u8 for the parent index number space?

