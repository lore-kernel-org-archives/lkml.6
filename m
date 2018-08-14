Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA1BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA91B21741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgrA0ekT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA91B21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbeHNQON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:14:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35425 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:14:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id g1-v6so17232387wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GsWTMFGYFcxpsxmOW4OQEyxu/FWI0LaQi7x6AaaVFaM=;
        b=dgrA0ekTyVRGPSyByTjflEWDjbRvmc6GzWUUlEfZeBhiTYNchDf5+M781qO7UOkI5f
         3/6SPJCqhSfQKRrhTDwTYA+maSEO4IUNiJhB3mJD4fyAQkO+G4SB8Qp6ztjO18xKfU1Q
         iQ1c9uXUHy1n/5KmqE6VnXrH6/+WqHtjUWYk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GsWTMFGYFcxpsxmOW4OQEyxu/FWI0LaQi7x6AaaVFaM=;
        b=XEiMUzS9Mitmgd0oO5pgpli2iZWPKIgZEId+920Mi0S+Ms06alV+KHoVtRdfgGA2wl
         dFF0CG8lCwbSptFpu8tlvqro2HMBDuJGz0lliQlT1Ibq5iTPrbKXwu7whb9PnCswdZvv
         DNfgS8j8d17Hcoy3Sa31ZnkN5+cHB1CfzazmgNFipbwoeTzbqfE3pO33bpWiznpS/w4Z
         akSC8vOi58fHzX8iYWa5tVfXtjBLjTx+B/h9o86ksiPIziLKL7FZnNWHtJ1F4RYvFe18
         kPjBjCEjOZyeENVoL6y98RrqHAVdrI8JnnL/cMHROatnhapOHj0Eb9fTuDEGOFVe3AaW
         B5pQ==
X-Gm-Message-State: AOUpUlHrzd/yeHgoCBKTWDl3aiBwo5X/m4ovEGUg00httXVpdKFf4r3o
        OzYw1sxpHCMRmnuyCKexd7cMqw==
X-Google-Smtp-Source: AA+uWPzPNJzQk3mY4Hd+b1sOfFpH1ld2FNUsMg/NYIsc2O8IABidJ3RzwxI1zJIkif6ufDC6qgk5jg==
X-Received: by 2002:a5d:69ca:: with SMTP id s10-v6mr13598853wrw.77.1534253221722;
        Tue, 14 Aug 2018 06:27:01 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f17-v6sm14592819wrs.1.2018.08.14.06.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 06:27:00 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:26:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     zhe.he@windriver.com
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kgdboc: Passing ekgdboc to command line causes
 panic
Message-ID: <20180814132658.nadasqcwi3f44duv@holly.lan>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 08:46:00PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> kgdboc_option_setup does not check input argument before passing it
> to strlen. The argument would be a NULL pointer if "ekgdboc", without
> its value, is set in command line and thus cause the following panic.
> 
> PANIC: early exception 0xe3 IP 10:ffffffff8fbbb620 error 0 cr2 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18-rc8+ #1
> [    0.000000] RIP: 0010:strlen+0x0/0x20
> ...
> [    0.000000] Call Trace
> [    0.000000]  ? kgdboc_option_setup+0x9/0xa0
> [    0.000000]  ? kgdboc_early_init+0x6/0x1b
> [    0.000000]  ? do_early_param+0x4d/0x82
> [    0.000000]  ? parse_args+0x212/0x330
> [    0.000000]  ? rdinit_setup+0x26/0x26
> [    0.000000]  ? parse_early_options+0x20/0x23
> [    0.000000]  ? rdinit_setup+0x26/0x26
> [    0.000000]  ? parse_early_param+0x2d/0x39
> [    0.000000]  ? setup_arch+0x2f7/0xbf4
> [    0.000000]  ? start_kernel+0x5e/0x4c2
> [    0.000000]  ? load_ucode_bsp+0x113/0x12f
> [    0.000000]  ? secondary_startup_64+0xa5/0xb0
> 
> This patch adds a check to prevent the panic.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2:
> - Split out printk cleanups
> - Add cc to stable@vger.kernel.org
> 
>  drivers/tty/serial/kgdboc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index b4ba2b1..206f8c2 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -130,6 +130,11 @@ static void kgdboc_unregister_kbd(void)
>  
>  static int kgdboc_option_setup(char *opt)
>  {
> +	if (!opt) {
> +		pr_err("kgdboc: null option\n");

Apologies... I should have picked this up when I replied earlier but
this error message describes what the function gets when I think it
should report what the user actually did. So should be something like:

		pr_err("kgdboc: config string not provided\n");
	
With that (or a very similar) change:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> +		return -EINVAL;
> +	}
> +
>  	if (strlen(opt) >= MAX_CONFIG_LEN) {
>  		printk(KERN_ERR "kgdboc: config string too long\n");
>  		return -ENOSPC;
> -- 
> 2.7.4
> 
