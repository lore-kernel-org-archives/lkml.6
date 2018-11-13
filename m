Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30964C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C9322419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UTH0u/Ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C9322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbeKMLsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:48:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44934 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:48:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so5173232plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 17:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lPIYX214JFzy507QtU7I3//hmmsVsRBy3z9ehCqlawc=;
        b=UTH0u/AoyFVkKhK3tExRMZBbrM48ERyEBlo2wy/wbcrWINZUC0GyxQ8nyutpfrVeVG
         Sqi997WbAJ2M4AXVu3hjh1OFMwd3Q5liFCOUAqTpYzghCEL8GvG9/xHTQzx/P5V8rNaX
         6cRMMRcrlDTdFNGNGQEnY3jcQ1/m4rcEGvRhQRLUYKCy9iBKTTw4/JKKPbj3P1NzrtKY
         BRoA5/LxlmDX3IWCDXqf6AGApaUYRO5vJXnzzlIoZztNc2PkAR2s/K5t2XfDnwMYaa4F
         7Bbbws1gx+kGhZwVx6vKHE45V+YoUrt0k7LarY4SLt54c6oMKnvbr0SNFPw8ZkTNRhBQ
         ETlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lPIYX214JFzy507QtU7I3//hmmsVsRBy3z9ehCqlawc=;
        b=UmrMPv2tH0s74mYH8SQ+Jln2qHRubf4IWmhzGwHg7hxJaFsANtHc/63SjpzlrSfO5D
         HWCdvCQafNbBwQtbcZ4g3CetOiu5Jir91fwS7XUFlIV1af3sYEr3lDIkP8Ac7DJAslpA
         uB0nssapsjUXh4QPz+QtzaVqUivphUvVPEt8YSFrSreE9dQqEsDVMswiIRijbkRHyVcV
         BTVNMXsFbUG+MW9san23sl7iKX5DIx/XuUmbBC1nE/4RVhAEa8n+w2AGVii1oH4qt8xd
         3tf+MQnFLwqkKePZtgKicXIbKGzRNnTNQMNMqgXUMQvD9pVeSVCcqek9djwIE/xI9g1Y
         pTWA==
X-Gm-Message-State: AGRZ1gLbe02VVWdCOFm/82JPPmGm3/9wMa3PsYp1/85CkJfqOFFi3B08
        N5LyPMVPsh4tx9Lihbe7iUYalw==
X-Google-Smtp-Source: AJdET5dGex4LXZTkM3jPIdtyNmxs7V3cB0CnV99A70bX4jV5NKuUYJ6pIBppNW/tQq7DVcanuhYd9Q==
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10-v6mr3100060plb.166.1542073943795;
        Mon, 12 Nov 2018 17:52:23 -0800 (PST)
Received: from localhost ([216.9.110.5])
        by smtp.gmail.com with ESMTPSA id v74-v6sm27958211pfk.12.2018.11.12.17.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 17:52:23 -0800 (PST)
Date:   Mon, 12 Nov 2018 17:52:23 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 17:38:59 PST (-0800)
Subject:     Re: [PATCH] riscv: fix trace_sys_exit hook
In-Reply-To: <20181029121516.29574-1-david.abdurachmanov@gmail.com>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-8eb10330-a87b-4bd6-8f91-e9e177d2992b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 05:15:16 PDT (-0700), david.abdurachmanov@gmail.com wrote:
> Depends on:
> http://lists.infradead.org/pipermail/linux-riscv/2018-October/001931.html
>
> Why we don't have HAVE_SYSCALL_TRACEPOINTS in arch/riscv/Kconfig?
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> ---
>  arch/riscv/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 9f82a7e34c64..9db7d0076375 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -120,6 +120,6 @@ void do_syscall_trace_exit(struct pt_regs *regs)
>
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> -		trace_sys_exit(regs, regs->regs[0]);
> +		trace_sys_exit(regs, regs_return_value(regs));
>  #endif
>  }

I'm dropping this onto next-audit on top of the other two.

Thanks!
