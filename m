Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeCTXYV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:24:21 -0400
Received: from mleia.com ([178.79.152.223]:59270 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbeCTXYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:24:20 -0400
Subject: Re: [PATCH 2/3] i2c: mux: pca9541: namespace cleanup
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>,
        Ken Chen <chen.kenyy@inventec.com>, joel@jms.id.au,
        linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-3-peda@axentia.se>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <b472b2e4-8360-6f5a-b753-fa8fc7083d04@mleia.com>
Date: Wed, 21 Mar 2018 01:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320093200.19179-3-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180320_232419_188635_A0212A53 
X-CRM114-Status: GOOD (  15.75  )
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 03/20/2018 11:31 AM, Peter Rosin wrote:
> In preparation for PCA9641 support, convert the mybus and busoff macros
> to functions, and in the process prefix them with pca9541_. Also prefix
> remaining chip specific macros with PCA9541_.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/muxes/i2c-mux-pca9541.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> index ad168125d23d..47685eb4e0e9 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -59,10 +59,8 @@
>  #define PCA9541_ISTAT_MYTEST	BIT(6)
>  #define PCA9541_ISTAT_NMYTEST	BIT(7)
>  
> -#define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
> -#define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
> -#define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
> -#define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) == BUSON)
> +#define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
> +#define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>  
>  /* arbitration timeouts, in jiffies */
>  #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
> @@ -93,6 +91,20 @@ static const struct of_device_id pca9541_of_match[] = {
>  MODULE_DEVICE_TABLE(of, pca9541_of_match);
>  #endif
>  
> +static int pca9541_mybus(int ctl)

static inline?

> +{
> +	if (!(ctl & PCA9541_MYBUS))
> +		return 1;
> +	return (ctl & PCA9541_MYBUS) == PCA9541_MYBUS;
> +}
> +
> +static int pca9541_busoff(int ctl)

static inline?

> +{
> +	if (!(ctl & PCA9541_BUSON))
> +		return 1;
> +	return (ctl & PCA9541_BUSON) == PCA9541_BUSON;
> +}

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
