Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932116AbeCJSTA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:19:00 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33686 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeCJSS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:18:59 -0500
X-Google-Smtp-Source: AG47ELsfqrK5RZlsg1wV8/sT2AO7YD4+X/0cMS6I2/yu5Jfk14hJR+6K5KcMA3/+qVKmC1Suoysfyw==
Date: Sat, 10 Mar 2018 10:18:56 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH v2] Input: stmpe-keypad - remove VLA usage
Message-ID: <20180310181856.GC260013@dtor-ws>
References: <20180310033612.GA8010@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310033612.GA8010@embeddedgus>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:36:12PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with a fixed-length array instead.
> 
> Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
> Changes in v2:
>  - Update the code based on Dmitry Torokhov comments. Thanks Dmitry.
> 
>  drivers/input/keyboard/stmpe-keypad.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
> index 8c6c0b9..d69e631 100644
> --- a/drivers/input/keyboard/stmpe-keypad.c
> +++ b/drivers/input/keyboard/stmpe-keypad.c
> @@ -48,6 +48,14 @@
>  #define STMPE_KEYPAD_KEYMAP_MAX_SIZE \
>  	(STMPE_KEYPAD_MAX_ROWS * STMPE_KEYPAD_MAX_COLS)
>  
> +
> +#define STMPE1601_NUM_DATA	5
> +#define STMPE2401_NUM_DATA	3
> +#define STMPE2403_NUM_DATA	5
> +
> +/* Make sure it covers all cases above */
> +#define MAX_NUM_DATA		5
> +
>  /**
>   * struct stmpe_keypad_variant - model-specific attributes
>   * @auto_increment: whether the KPC_DATA_BYTE register address
> @@ -74,7 +82,7 @@ struct stmpe_keypad_variant {
>  static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>  	[STMPE1601] = {
>  		.auto_increment		= true,
> -		.num_data		= 5,
> +		.num_data		= STMPE1601_NUM_DATA,
>  		.num_normal_data	= 3,
>  		.max_cols		= 8,
>  		.max_rows		= 8,
> @@ -84,7 +92,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>  	[STMPE2401] = {
>  		.auto_increment		= false,
>  		.set_pullup		= true,
> -		.num_data		= 3,
> +		.num_data		= STMPE2401_NUM_DATA,
>  		.num_normal_data	= 2,
>  		.max_cols		= 8,
>  		.max_rows		= 12,
> @@ -94,7 +102,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>  	[STMPE2403] = {
>  		.auto_increment		= true,
>  		.set_pullup		= true,
> -		.num_data		= 5,
> +		.num_data		= STMPE2403_NUM_DATA,
>  		.num_normal_data	= 3,
>  		.max_cols		= 8,
>  		.max_rows		= 12,
> @@ -156,7 +164,7 @@ static irqreturn_t stmpe_keypad_irq(int irq, void *dev)
>  	struct stmpe_keypad *keypad = dev;
>  	struct input_dev *input = keypad->input;
>  	const struct stmpe_keypad_variant *variant = keypad->variant;
> -	u8 fifo[variant->num_data];
> +	u8 fifo[MAX_NUM_DATA];
>  	int ret;
>  	int i;
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
