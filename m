Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAFDC6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C355920882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbkvAipr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C355920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeJHJhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHJhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:37:12 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60F9C2075C;
        Mon,  8 Oct 2018 02:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538965671;
        bh=Cln9UcDm7MwB+k7Bo+IayuVRQSpPJkJm7yVlSqa5NLM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=EbkvAiprKiYN5onJPd8APDgcGuLvVdnWQV99aD1fLxuFujR/87CD5dAdgEYI7k666
         NmEj1WqqsLF8p+S/990rijvPfZHfkMYgZzZ9+OnhRe4ogGzg+ePsUBlO0b6vIpHWvr
         IoFhcq0PwJY9x+ivyGuDasXl121jkv0PZrP6h1u4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jolly Shah <jolly.shah@xilinx.com>, arm@kernel.org,
        linux-clk@vger.kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, olof@lixom.net, sboyd@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1538173080-7597-5-git-send-email-jollys@xilinx.com>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejasp@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
 <1538173080-7597-5-git-send-email-jollys@xilinx.com>
Message-ID: <153896567067.119890.7785076104115447392@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 4/4] drivers: clk: Add ZynqMP clock driver
Date:   Sun, 07 Oct 2018 19:27:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2018-09-28 15:18:00)
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> new file mode 100644
> index 0000000..1b07d77
> --- /dev/null
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -0,0 +1,716 @@
[...]
> + * @type:      Clock type: CLK_TYPE_OUTPUT or CLK_TYPE_EXTERNAL
> + *
> + * Return: 0 on success else error code
> + */
> +static int zynqmp_get_clock_type(u32 clk_id, u32 *type)
> +{
> +       int ret;
> +
> +       ret =3D zynqmp_is_valid_clock(clk_id);
> +       if (ret =3D=3D 1) {
> +               *type =3D clock[clk_id].type;
> +               return 0;
> +       }
> +
> +       return ret =3D=3D 0 ? -EINVAL : ret;
> +}
> +
> +/**
> + * zynqmp_pm_clock_get_num_clocks() - Get number of clocks in system
> + * @nclocks:   Number of clocks in system/board.
> + *
> + * Call firmware API to get number of clocks.
> + *
> + * Return: 0 on success else error code.
> + */
> +static int zynqmp_pm_clock_get_num_clocks(u32 *nclocks)
> +{
> +       struct zynqmp_pm_query_data qdata =3D {0};
> +       __le32 ret_payload[PAYLOAD_ARG_CNT];

I asked about endianess but this isn't the right fix. Just marking
something as __le32 but then not using that type and just passing it to
some function that takes a u32 pointer doesn't work. So is the firmware
side always little endian? If so, maybe the ioctls can do the byte swap
and then the kernel API can be native CPU endian while the firmware
layer can be aware that things may need swapping. I'm suggesting that
this type is just u32 and then the eemi_ops functions accept u32 and do
the swapping themselves.

If you put back u32 here and elsewhere in this patch you can have my

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

The fix to the underlying ops for endian correctness can come later, so
don't feel like it needs to be fixed right now.

