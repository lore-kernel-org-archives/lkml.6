Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeCORwU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbeCORwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:52:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1669E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, srinivas.kandagatla@linaro.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180315143724.13859-1-srinivas.kandagatla@linaro.org>
Cc: david.brown@linaro.org, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20180315143724.13859-1-srinivas.kandagatla@linaro.org>
Message-ID: <152113633637.107923.1559162375425599621@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] clk: qcom: rpmcc: Add support to XO buffered clocks
Date: Thu, 15 Mar 2018 10:52:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting srinivas.kandagatla@linaro.org (2018-03-15 07:37:24)
> diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
> index c60f61b10c7f..261f5505e714 100644
> --- a/drivers/clk/qcom/clk-rpm.c
> +++ b/drivers/clk/qcom/clk-rpm.c
> @@ -56,6 +57,19 @@
>                 },                                                            \
>         }
>  
> +#define DEFINE_CLK_RPM_XO_BUFFER(_platform, _name, _active, offset)          \
> +       static struct clk_rpm _platform##_##_name = {                         \
> +               .rpm_clk_id = QCOM_RPM_CXO_BUFFERS,                           \
> +               .xo_offset = (offset),                                        \
> +               .rate = 19200000,                                             \

Shouldn't these rates also come from parent, i.e. pxo_board? So drop
this line?

> +               .hw.init = &(struct clk_init_data){                           \
> +                       .ops = &clk_rpm_fixed_ops,                            \
> +                       .name = #_name,                                       \
> +                       .parent_names = (const char *[]){ "pxo_board" },      \
> +                       .num_parents = 1,                                     \
> +               },                                                            \
> +       }
> +
>  #define DEFINE_CLK_RPM_FIXED(_platform, _name, _active, r_id, r)             \
>         static struct clk_rpm _platform##_##_name = {                         \
>                 .rpm_clk_id = (r_id),                                         \
> @@ -128,6 +142,8 @@
>  
>  struct clk_rpm {
>         const int rpm_clk_id;
> +       const int xo_offset;
> +       u32 xo_buffer_value;
>         const bool active_only;
>         unsigned long rate;
>         bool enabled;
> @@ -308,6 +330,11 @@ static void clk_rpm_fixed_unprepare(struct clk_hw *hw)
>         u32 value = 0;
>         int ret;
>  
> +       if (r->rpm_clk_id == QCOM_RPM_CXO_BUFFERS) {
> +               r->xo_buffer_value &= ~(QCOM_RPM_XO_MODE_ON << r->xo_offset);
> +               value = r->xo_buffer_value;
> +       }
> +

I seem to recall that the xo buffers are within the same "word" or
something like that for each of the buffers. So we would need to make
sure we don't overwrite the bits in there between clks that are
enabling/disabling stuff. Maybe make some sort of shared variable they
all point to and then put a mutex around it? May also be worth making
more clk_ops at that point to not conflate with the simpler on/off code.
