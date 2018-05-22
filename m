Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeEVWBr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:01:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46303 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753170AbeEVWBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:01:45 -0400
X-ME-Proxy: <xmx:SJMEW422uzNj-PN_5bC7-pap0ODWW75WZ691I0uqphXGZmvzyfP68Q>
X-ME-Proxy: <xmx:SJMEW4j9gw2w4TVpcpnu6EBXPxQuUir6sw0byFhuAu7ZTVGdSv3GYA>
X-ME-Proxy: <xmx:SJMEW1pCYtM-snEH8bm9prad8FbXrp2WkcKzPk4BV3MjEnv7uUkGLw>
X-ME-Proxy: <xmx:SJMEWyyF3sNwrNaqcfsOy4uORGScxpGENy7xleDv1W0EKzTNSU5vUw>
X-ME-Proxy: <xmx:SJMEW4niodCbok1vGhVBN6gq7A3ECZM3gJAQKh59kDMtF85T8gfE1Q>
X-ME-Proxy: <xmx:SZMEW3RFvSxGLDGbQaLeY4ELMeqkMF6wMmwfokEPsFWk0meXuwYQ5A>
X-ME-Sender: <xms:SJMEW64bv6J-fzPpszVjCbSjV6uzG-7oYHpC-pKaQiQpQsuBC0p1Iw>
Date: Wed, 23 May 2018 08:01:40 +1000
From: "Tobin C . Harding" <me@tobin.cc>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_printf.c: call wait_for_random_bytes() before
 plain %p tests
Message-ID: <20180522220140.GG31095@eros>
References: <20180522174114.9197-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522174114.9197-1-thierry.escande@linaro.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 07:41:14PM +0200, Thierry Escande wrote:
> If the test_printf module is loaded before the crng is initialized, the
> plain 'p' tests will fail because the printed address will not be hashed
> and the buffer will contain '(ptrval)' instead.
> This patch adds a call to wait_for_random_bytes() before plain 'p' tests
> to make sure the crng is initialized.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> ---
>  lib/test_printf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 71ebfa43ad05..839be9385a8a 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -260,6 +260,13 @@ plain(void)
>  {
>  	int err;
>  
> +	/*
> +	 * Make sure crng is ready. Otherwise we get "(ptrval)" instead
> +	 * of a hashed address when printing '%p' in plain_hash() and
> +	 * plain_format().
> +	 */
> +	wait_for_random_bytes();
> +
>  	err = plain_hash();
>  	if (err) {
>  		pr_warn("plain 'p' does not appear to be hashed\n");
> -- 
> 2.14.1

Not sure if I'm qualified for this but here goes

Acked-by: Tobin C. Harding <me@tobin.cc>

thanks,
Tobin.
