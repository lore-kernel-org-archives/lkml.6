Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeE1HUo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:20:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51106 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753638AbeE1HUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:20:39 -0400
Subject: Re: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE
 disabled
To: Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180525210843.1821071-1-arnd@arndb.de>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <91444ee7-40fa-5022-ca4d-1c15e0807347@st.com>
Date: Mon, 28 May 2018 09:20:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525210843.1821071-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2018 11:08 PM, Arnd Bergmann wrote:
> Without dmaengine support, we get a harmless warning about an
> unused function:
> 
> drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but not used [-Werror=unused-function]
> 
> Changing the #ifdef to an IS_ENABLED() check shuts up that warning
> and is slightly nicer to read.
> 
> Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/pwm-stm32.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
Hi Arnd,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 60bfc07c4912..97bbc1f18fd6 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -484,9 +484,7 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
>  static const struct pwm_ops stm32pwm_ops = {
>  	.owner = THIS_MODULE,
>  	.apply = stm32_pwm_apply_locked,
> -#if IS_ENABLED(CONFIG_DMA_ENGINE)
> -	.capture = stm32_pwm_capture,
> -#endif
> +	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
>  };
>  
>  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> 
