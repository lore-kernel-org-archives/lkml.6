Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46607C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6091208E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuaSNXI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6091208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbeGIFbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754183AbeGIFbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:31:35 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 818EC208DB;
        Mon,  9 Jul 2018 05:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531114294;
        bh=s2shKuUnWT5gBiS1iTgp5ZW1XVZq3PMqRgctdQ7Wub0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=CuaSNXI1ru0g530UrXeK5Cnhp/2HxQRCrUYIE4nQ5BrYPxev3/0SpENiX97+nCpn5
         3Msov/2E5iOlxyJvKSwkDLDhfMr/X2rsigzV5BLUTFdDuFuI4IJvjGR+1a1uoCudnV
         DBdW4LGclfKRrnv4zx0dq0Ni/JaACSR527xjrHBA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        hkallweit1@gmail.com, keescook@chromium.org,
        linux-clk@vger.kernel.org, mark.rutland@arm.com,
        matt@codeblueprint.co.uk, michal.simek@xilinx.com,
        mingo@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        sboyd@codeaurora.org, sudeep.holla@arm.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1529516435-7315-6-git-send-email-jollys@xilinx.com>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jolly Shah <jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-6-git-send-email-jollys@xilinx.com>
Message-ID: <153111429376.143105.16639313603352498865@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 05/10] firmware: xilinx: Add clock APIs
Date:   Sun, 08 Jul 2018 22:31:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2018-06-20 10:40:30)
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/z=
ynqmp.c
> index 86d9bb8..c764d6e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -269,14 +269,196 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_=
id, u32 arg1, u32 arg2,
>   */
>  static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *=
out)
>  {
> -       return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
> -                                  qdata.arg2, qdata.arg3, out);
> +       int ret;
> +
> +       ret =3D zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
> +                                 qdata.arg2, qdata.arg3, out);
> +
> +       /*
> +        * For clock name query, all bytes in SMC response are clock name
> +        * characters and return code is always success. For invalid cloc=
ks,
> +        * clock name bytes would be 0s.

write the word 'zeroes' or 'zeros' please.

> +        */
> +       return qdata.qid =3D=3D PM_QID_CLOCK_GET_NAME ? 0 : ret;
> +}
> +
[...]
> +
> +/**
> + * zynqmp_pm_clock_setrate() - Set the clock rate for given id
> + * @clock_id:  ID of the clock
> + * @rate:      rate value in hz
> + *
> + * This function is used by master to set rate for any clock.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
> +{
> +       return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
> +                                  rate & 0xFFFFFFFF,
> +                                  (rate >> 32) & 0xFFFFFFFF,

Use upper_32_bits() and lower_32_bits().

> +                                  0, NULL);
> +}
> +
