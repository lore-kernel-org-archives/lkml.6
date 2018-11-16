Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081DDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3642208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRKqXA5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3642208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeKPVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:05:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41548 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeKPVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:05:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so120091plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ub0jFUuuOXY4BS8hjw1KlbGzgantkBulGj3poKRf0ys=;
        b=HRKqXA5TvZc5kW2FKbWKBFikuMMpg4tEFBVHEY7EWmPAkdfXtbWagcU6/s539Vbmpa
         HZ95tFgKPh8Rz7CqCCLNmGfB+rrKmyxG5183QLpm5DbM/05CyM/4M3zqW3RL5KTAcij+
         DOT1drtR6k/NR1fsIJ85kh8uXpeloVCi7ZdhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ub0jFUuuOXY4BS8hjw1KlbGzgantkBulGj3poKRf0ys=;
        b=j1u9sl5CiL1Czauj1jg50sONZdzG8R/t31JiW6cwlGiBvZoYs7vjWzNUcQoFiIjyZV
         SH8+iVh2ojGKS2Mha9kOsrgW++zFOV82XNqSrkUWDcsNO+bDs9Ma8dLromCRknI2iTwg
         uYal8TSNrcDDQ/6qemu9PisdgamRamfD11LqhXnY4GcSsoKJu3uGapuWiUcsm/S3dsAO
         WsffCdwQCLAEo+kP5IPVZAqpfgvzH9qAoUPVDOExVyMcvjpHykcCs6VCKrt+Hk6NJisE
         XFXKEdoBcFPfE8bGthPaC8WrWfLQwGPeso6IPUvoOqxjdD94rFu8Li2fNrHre7rO4Hy3
         yCOw==
X-Gm-Message-State: AGRZ1gJMZsmkA7qnK65yLi+4TPwhNsQjjhAQdYY9yjSPifbj+rilbt4Y
        W/gVjOE0pBUjxvxejOHabiKN5w==
X-Google-Smtp-Source: AJdET5c0BcGQk3STSkZJDaKg+Cn96E3MyK0MCnzRjfl+dTuwMYFF9NHZAu/hlRXOFdV66qsiOKteEQ==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8-v6mr10059772plo.94.1542365601696;
        Fri, 16 Nov 2018 02:53:21 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id n23-v6sm52345775pfg.84.2018.11.16.02.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:53:20 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:23:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, srinivas.kandagatla@linaro.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] boot_constraint: Add constraints for earlycon on
 dragonboard 410c
Message-ID: <20181116105317.5zpbzhgt5cnssuki@vireshk-i7>
References: <20181116104607.26671-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116104607.26671-1-saiprakash.ranjan@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16-11-18, 16:16, Sai Prakash Ranjan wrote:
> iface clock is shared with other drivers, which may reconfigure
> this before the serial driver comes up. This may lead to
> crashes like the one below where GCC_BLSP1_AHB_CLK is same across
> multiple drivers like bam dma.
> 
> <0>[    3.164471] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
> <4>[    3.164479] Modules linked in:
> <4>[    3.164495] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc8-00008-ge033b9909fff-dirty #175
> <4>[    3.164501] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> <4>[    3.164508] pstate: 40000085 (nZcv daIf -PAN -UAO)
> <4>[    3.164514] pc : msm_read.isra.2+0x20/0x50
> <4>[    3.164520] lr : msm_read.isra.2+0x1c/0x50
> <4>[    3.164526] sp : ffff000008033a50
> <4>[    3.164531] x29: ffff000008033a50 x28: ffff000009486018
> <4>[    3.164548] x27: 0000000000000001 x26: ffff7dfffe7ff070
> <4>[    3.164565] x25: 0000000000000034 x24: ffff000009486000
> <4>[    3.164582] x23: 0000000000000000 x22: ffff00000978e190
> <4>[    3.164599] x21: ffff0000095e8228 x20: 0000000000000034
> <4>[    3.164616] x19: ffff7dfffe7ff008 x18: ffffffffffffffff
> <4>[    3.164632] x17: 0000000000000000 x16: 0000000000000000
> <4>[    3.164649] x15: ffff0000094a96c8 x14: ffff00008978e6bf
> <4>[    3.164666] x13: ffff00000978e6cd x12: 0000000000000038
> <4>[    3.164683] x11: ffff0000094c6000 x10: 0000000000000c24
> <4>[    3.164699] x9 : ffff80003c89b400 x8 : ffff000008033970
> <4>[    3.164716] x7 : ffff80000eb04100 x6 : 00000000000af304
> <4>[    3.164732] x5 : 0000000000000c40 x4 : ffff80003c06f000
> <4>[    3.164750] x3 : ffff80003c89b498 x2 : 0000000000000000
> <4>[    3.164766] x1 : ffff80003ca68000 x0 : 0000000000000800
> <0>[    3.164785] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> <4>[    3.164791] Call trace:
> <4>[    3.164797]  msm_read.isra.2+0x20/0x50
> <4>[    3.164804]  msm_reset_dm_count+0x44/0x80
> <4>[    3.164810]  __msm_console_write+0x1c8/0x1d0
> <4>[    3.164816]  msm_serial_early_write_dm+0x3c/0x50
> <4>[    3.164823]  console_unlock.part.6+0x468/0x528
> <4>[    3.164829]  vprintk_emit+0x210/0x218
> <4>[    3.164835]  vprintk_default+0x48/0x58
> <4>[    3.164841]  vprintk_func+0xf0/0x1c0
> <4>[    3.164847]  printk+0x74/0x94
> <4>[    3.164853]  sci_init+0x24/0x3c
> <4>[    3.164859]  do_one_initcall+0x54/0x248
> <4>[    3.164866]  kernel_init_freeable+0x210/0x378
> <4>[    3.164872]  kernel_init+0x18/0x118
> <4>[    3.164878]  ret_from_fork+0x10/0x1c
> <0>[    3.164884] Code: aa1e03e0 8b214273 97e616f7 d503201f (b9400260)
> 
> Link: https://lore.kernel.org/lkml/1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org/
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> 
> This is purely dependent on boot constraint subsystem by Viresh.
> 
> Link: https://lore.kernel.org/lkml/cover.1519380923.git.viresh.kumar@linaro.org/
> ---
>  drivers/soc/qcom/boot_constraint.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Nice to see that the new subsystem has fixed your issue as well and
thanks for the patch. I am afraid though that this patch isn't going
to get merged anywhere as the subsystem isn't merged yet as Greg
wasn't too confident [1] about it. We are looking for more use-cases
apart from earlycon and clcd.

Thanks.

--
viresh

[1] lore.kernel.org/lkml/20180323150420.GA21152@kroah.com
