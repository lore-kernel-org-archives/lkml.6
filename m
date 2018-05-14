Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeENIvZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:51:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42070 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752051AbeENIvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:51:23 -0400
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: clk: stm32mp1: Fix a memory leak in
 'clk_stm32_register_gate_ops()'
Thread-Topic: clk: stm32mp1: Fix a memory leak in
 'clk_stm32_register_gate_ops()'
Thread-Index: AQHT62CnufmN5HES/kC6Q8epw1ZX5A==
Date: Mon, 14 May 2018 08:50:48 +0000
Message-ID: <3d149e1f-3290-8b6f-9b5b-1a1133461ed0@st.com>
References: <20180513111704.31842-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20180513111704.31842-1-christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <04F20131616C294B9FEA75E749BD8571@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E8pUQ1012389

Hi Christophe,

Many thanks !

Acked-by: Gabriel Fernandez <gabriel.fernandez@st.com>


On 05/13/2018 01:17 PM, Christophe Jaillet wrote:
> We allocate some memory which is neither used, nor referenced by anything.
> So axe it.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch as not been compile-tested, I don't have the corresponding arch
> and have not taken time to cross-compile it.
> ---
>   drivers/clk/clk-stm32mp1.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
> index edd3cf451401..dfb9cb5bd0c4 100644
> --- a/drivers/clk/clk-stm32mp1.c
> +++ b/drivers/clk/clk-stm32mp1.c
> @@ -579,14 +579,9 @@ clk_stm32_register_gate_ops(struct device *dev,
>   			    spinlock_t *lock)
>   {
>   	struct clk_init_data init = { NULL };
> -	struct clk_gate *gate;
>   	struct clk_hw *hw;
>   	int ret;
>   
> -	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> -	if (!gate)
> -		return ERR_PTR(-ENOMEM);
> -
>   	init.name = name;
>   	init.parent_names = &parent_name;
>   	init.num_parents = 1;
> @@ -604,10 +599,8 @@ clk_stm32_register_gate_ops(struct device *dev,
>   	hw->init = &init;
>   
>   	ret = clk_hw_register(dev, hw);
> -	if (ret) {
> -		kfree(gate);
> +	if (ret)
>   		hw = ERR_PTR(ret);
> -	}
>   
>   	return hw;
>   }
