Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBEXHj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:07:39 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44884 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeBEXHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:07:32 -0500
X-Google-Smtp-Source: AH8x22635YThnJKEhF1o0FxGu1+/aWvvcJx019L4aENeAUgZ+mknP9zI/Q/jZPtWWXyYdoH3EX4tQA==
Date: Mon, 5 Feb 2018 15:07:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhang Bo <zbsdta@126.com>
Cc: DRivshin@allworx.com, robh@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhang.bo19@zte.com.cn
Subject: Re: [PATCH v3] Input: matrix_keypad - fix keypad does not response
Message-ID: <20180205230729.GD46524@dtor-ws>
References: <20180204001922.32084-1-zbsdta@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204001922.32084-1-zbsdta@126.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2018 at 08:19:22AM +0800, Zhang Bo wrote:
> If matrix_keypad_stop() is calling and the keypad interrupt is triggered,
> disable_row_irqs() is called by both matrix_keypad_interrupt() and
> matrix_keypad_stop() at the same time. then disable_row_irqs() is called
> twice, and the device enter suspend state before keypad->work is executed.
> At this condition the device will start keypad and enable irq once after
> resume. and then irqs are disabled yet because irqs are disabled twice and
> only enable once.
> 
> Take lock around keypad->stopped to ensure irqs operation is in atomic
> operation.
> 
> Signed-off-by: Zhang Bo <zbsdta@126.com>

Applied, thank you.

> ---
> Changes in v3:
>   - delete no needed lock protection, only add lock in matrix_keypad_stop().
> Changes in v2:
>   - Change commit message and full name in the signed-off-by tag.
> 
>  drivers/input/keyboard/matrix_keypad.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> index 1f316d66e6f7..41614c185918 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -218,8 +218,10 @@ static void matrix_keypad_stop(struct input_dev *dev)
>  {
>  	struct matrix_keypad *keypad = input_get_drvdata(dev);
>  
> +	spin_lock_irq(&keypad->lock);
>  	keypad->stopped = true;
> -	mb();
> +	spin_unlock_irq(&keypad->lock);
> +
>  	flush_work(&keypad->work.work);
>  	/*
>  	 * matrix_keypad_scan() will leave IRQs enabled;
> -- 
> 2.14.3
> 
> 

-- 
Dmitry
