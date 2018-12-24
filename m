Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43CBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B5C21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeLXHyj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:54:39 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38018 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbeLXHyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:54:39 -0500
Received: from [46.183.103.8] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gbL4K-0003Aj-4f; Mon, 24 Dec 2018 08:54:32 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     "zhangqing@rock-chips.com" <zhangqing@rock-chips.com>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: rockchip: fix frac settings of GPLL clock for rk3328
Date:   Mon, 24 Dec 2018 08:54:31 +0100
Message-ID: <2107849.4rvOjsJc15@phil>
In-Reply-To: <20181224154804602776216@rock-chips.com>
References: <20181222164249.25620-1-katsuhiro@katsuster.net> <1587344.DIk9eYpvKM@phil> <20181224154804602776216@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Am Montag, 24. Dezember 2018, 08:48:05 CET schrieb zhangqing@rock-chips.com:
> Hi: Heiko:
> 
> This explanation and the change is OK. Thanks for Katsuhiro's correction.

thanks for your quick confirmation. Can I make this an

Acked-by: Elaine Zhang <zhangqing@rock-chips.com>

when applying the patch?

Thanks
Heiko


> 张晴
> 福州瑞芯微电子股份有限公司
> Fuzhou Rockchip Electronics Co.,Ltd
> 地址：福建省福州市铜盘路软件大道89号软件园A区21号楼
> Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 350003, P.R.China
> Tel:+86-0591-83991906-8601
> 邮编：350003
> E-mail:elaine.zhang@rock-chips.com
>  
> From: Heiko Stuebner
> Date: 2018-12-24 15:34
> To: Katsuhiro Suzuki; Finley Xiao; Elaine Zhang
> CC: linux-rockchip; linux-arm-kernel; linux-kernel
> Subject: Re: [PATCH] clk: rockchip: fix frac settings of GPLL clock for rk3328
> Hi,
>  
> Am Samstag, 22. Dezember 2018, 17:42:49 CET schrieb Katsuhiro Suzuki:
> > This patch fixes settings of GPLL frequency in fractional mode for
> > rk3328. In this mode, FOUTVCO is calcurated by following formula:
> >   FOUTVCO = FREF * FBDIV / REFDIV + ((FREF * FRAC / REFDIV) >> 24)
> > 
> > The problem is in FREF * FRAC >> 24 term. This result always lacks
> > one from target value is specified by rate member. For example first
> > itme of rk3328_pll_frac_rate originally has
> >   - rate  : 1016064000
> >   - refdiv: 3
> >   - fbdiv : 127
> >   - frac  : 134217
> >   - FREF * FBDIV / REFDIV        = 1016000000
> >   - (FREF * FRAC / REFDIV) >> 24 = 63999
> > Thus calculated rate is 1016063999. It seems wrong.
> > 
> > If frac has 134218 (it is increased 1 from original value), second
> > term is 64000. All other items have same situation. So this patch
> > adds 1 to frac member in all items of rk3328_pll_frac_rate.
> > 
> > Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>  
> so while this sounds all quite right to me, I've added some Rockchip
> people that have clock experience to hopefully get an Ack on the
> change :-)
>  
> @Elaine + Finley: does this explanation and the below change look right?
>  
>  
> Thanks
> Heiko
>  
> > ---
> >  drivers/clk/rockchip/clk-rk3328.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
> > index faa94adb2a37..65ab5c2f48b0 100644
> > --- a/drivers/clk/rockchip/clk-rk3328.c
> > +++ b/drivers/clk/rockchip/clk-rk3328.c
> > @@ -78,17 +78,17 @@ static struct rockchip_pll_rate_table rk3328_pll_rates[] = {
> >  
> >  static struct rockchip_pll_rate_table rk3328_pll_frac_rates[] = {
> >  /* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
> > - RK3036_PLL_RATE(1016064000, 3, 127, 1, 1, 0, 134217),
> > + RK3036_PLL_RATE(1016064000, 3, 127, 1, 1, 0, 134218),
> >  /* vco = 1016064000 */
> > - RK3036_PLL_RATE(983040000, 24, 983, 1, 1, 0, 671088),
> > + RK3036_PLL_RATE(983040000, 24, 983, 1, 1, 0, 671089),
> >  /* vco = 983040000 */
> > - RK3036_PLL_RATE(491520000, 24, 983, 2, 1, 0, 671088),
> > + RK3036_PLL_RATE(491520000, 24, 983, 2, 1, 0, 671089),
> >  /* vco = 983040000 */
> > - RK3036_PLL_RATE(61440000, 6, 215, 7, 2, 0, 671088),
> > + RK3036_PLL_RATE(61440000, 6, 215, 7, 2, 0, 671089),
> >  /* vco = 860156000 */
> > - RK3036_PLL_RATE(56448000, 12, 451, 4, 4, 0, 9797894),
> > + RK3036_PLL_RATE(56448000, 12, 451, 4, 4, 0, 9797895),
> >  /* vco = 903168000 */
> > - RK3036_PLL_RATE(40960000, 12, 409, 4, 5, 0, 10066329),
> > + RK3036_PLL_RATE(40960000, 12, 409, 4, 5, 0, 10066330),
> >  /* vco = 819200000 */
> >  { /* sentinel */ },
> >  };
> > 
>  
>  
>  
>  
>  
> 




