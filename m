Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78AFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7150F2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7150F2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeI0EtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:49:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55927 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbeI0EtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:49:11 -0400
X-UUID: c3ba819f430640d7b0b6e44870344225-20180927
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1635596465; Thu, 27 Sep 2018 06:33:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Sep 2018 06:33:53 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Sep 2018 06:33:53 +0800
Message-ID: <1538001233.30348.20.camel@mtkswgap22>
Subject: Re: [PATCH] pinctrl: mediatek: mark dummy helpers as 'static inline'
From:   Sean Wang <sean.wang@mediatek.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Sep 2018 06:33:53 +0800
In-Reply-To: <20180926193818.2481220-1-arnd@arndb.de>
References: <20180926193818.2481220-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 96382A5D435B95B3C81DEBD9C66DA93A3ADA607BF9289CDF4DA644BAE10235C72000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2018-09-26 at 21:38 +0200, Arnd Bergmann wrote:
> mtk_eint_set_debounce and mtk_eint_find_irq are defined as stub functions
> in a header file, but without marking them as 'static inline', we get
> a copy for each file that includes the header:
> 
> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_set_debounce':
> pinctrl-mtk-common-v2.c:(.text+0x134): multiple definition of `mtk_eint_set_debounce'
> drivers/pinctrl/mediatek/pinctrl-moore.o:pinctrl-moore.c:(.text+0x7d0): first defined here
> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_find_irq':
> pinctrl-mtk-common-v2.c:(.text+0x13c): multiple definition of `mtk_eint_find_irq'
> 
> Fixes: e46df235b4e6 ("pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl can fit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Thank for the fixes for that I miss to mark the two functions as 'static
inline'. The other functions in the same header file seem fine.

Acked-by: Sean Wang <sean.wang@mediatek.com>

> ---
>  drivers/pinctrl/mediatek/mtk-eint.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
> index c286a9b940f2..48468d0fae68 100644
> --- a/drivers/pinctrl/mediatek/mtk-eint.h
> +++ b/drivers/pinctrl/mediatek/mtk-eint.h
> @@ -92,13 +92,13 @@ static inline int mtk_eint_do_resume(struct mtk_eint *eint)
>  	return -EOPNOTSUPP;
>  }
>  
> -int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
> +static inline int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
>  			  unsigned int debounce)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> -int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
> +static inline int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
>  {
>  	return -EOPNOTSUPP;
>  }


