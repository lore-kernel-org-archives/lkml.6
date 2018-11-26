Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59EDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A0320659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Paex8Nks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A0320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeK0Dm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:42:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46925 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeK0Dm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:42:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so6406368pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=voQZBGSCPwDuHbNWjRsaXWRQKOMCpB1zqAx9MYJffnY=;
        b=Paex8NkstvwA6QTMcr+LG7SaixSZzZFE1I0a94fM/xlOL42hBira7rtyHSTD1XJtS8
         lfgPqKZHCRfdpmBunQzVfwfTP5qdifhYHgkV/7G3M3LqqH/Gh5maBlLyuCxrUTDvneud
         MOsR3vdIfWXU39Q1nVx1POyS/lz5fNCfj6JXZSsmOAycAb6MMCMHfwQ6CdzAISG13ddI
         43fIipXpmBMtu1fOv5UrC5yZFXYirRsVtiPaa60OcAo30Osc/aDklqc7nAK8vQaSRw3A
         uzua3wH8xgJn95ONa1/8Y4gl6EQD+6dimnvkdjpuik145xhgD5xHlobZZkxSsm22VjlB
         xyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=voQZBGSCPwDuHbNWjRsaXWRQKOMCpB1zqAx9MYJffnY=;
        b=U42KHoe5I3alcdeeznqzlrhfmtioEyqAX3BeNoDRLH21o+2KX6BXbZlsRjhnXTCeXJ
         io8Ofbyez6AeZUY7MIQVDoKOTUcXAtdhPpE91JHwosfoEWJTH2hsPDMNQ07yvAZOD8s2
         F6cUqU7eq1SQRLahGy4WQNq1zJ2T3SUcBCeQJtFm8I+OkFl4wueniUzLOpWEtuqtYY5Z
         /jroSx9d+ZVjBzH5MDuEawR8QpG6ghClMIz2uRxvPITdqkwF5gL8TU8NzBr48+zu9Od6
         ubN1R8VDuiqcnGEtYSVnTN+OFfTqW6QJi64mjIh45SVBnvxNYz9oW1QuN3xtktsqtKfr
         P6eg==
X-Gm-Message-State: AA+aEWZ6abgLrwa6MbM2+0HMTVWOAFiz1o0PU7VEesdD335AJHqQxPhr
        VDYoMsFBZ5Z7OR/TG0zGQjk2vXPr5J0=
X-Google-Smtp-Source: AFSGD/WbmRU1D5GFgMwQPcBrqGJoyV3ClHwB6RyvQBQEpnwvtCTOqBHm9AZC7omWb+SC6vdnzN0aAQ==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr24942674pgk.406.1543250868232;
        Mon, 26 Nov 2018 08:47:48 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l184sm1399081pfc.112.2018.11.26.08.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:47:47 -0800 (PST)
Date:   Mon, 26 Nov 2018 08:47:47 -0800 (PST)
X-Google-Original-Date: Mon, 26 Nov 2018 08:47:42 PST (-0800)
Subject:     Re: [for-next][PATCH 10/18] riscv/function_graph: Simplify with function_graph_entry()
In-Reply-To: <20181122003332.793493004@goodmis.org>
CC:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mingo@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, linux-arch@vger.kernel.org,
        joel@joelfernandes.org, mhiramat@kernel.org, jpoimboe@redhat.com,
        luto@kernel.org, frederic@kernel.org, greentime@andestech.com,
        alankao@andestech.com, stable@kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     rostedt@goodmis.org
Message-ID: <mhng-b0e40c1e-307d-47cd-aba9-f7d648a4f8bc@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 16:28:11 PST (-0800), rostedt@goodmis.org wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> The function_graph_entry() function does the work of calling the function
> graph hook function and the management of the shadow stack, simplifying the
> work done in the architecture dependent prepare_ftrace_return().
>
> Have riscv use the new code, and remove the shadow stack management as well as
> having to set up the trace structure.
>
> This is needed to prepare for a fix of a design bug on how the curr_ret_stack
> is used.
>
> Cc: Greentime Hu <greentime@andestech.com>
> Cc: Alan Kao <alankao@andestech.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: stable@kernel.org
> Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/riscv/kernel/ftrace.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 1157b6b52d25..c433f6d3dd64 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -132,7 +132,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>  {
>  	unsigned long return_hooker = (unsigned long)&return_to_handler;
>  	unsigned long old;
> -	struct ftrace_graph_ent trace;
>  	int err;
>
>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
> @@ -144,17 +143,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>  	 */
>  	old = *parent;
>
> -	trace.func = self_addr;
> -	trace.depth = current->curr_ret_stack + 1;
> -
> -	if (!ftrace_graph_entry(&trace))
> -		return;
> -
> -	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
> -				       frame_pointer, parent);
> -	if (err == -EBUSY)
> -		return;
> -	*parent = return_hooker;
> +	if (function_graph_enter(old, self_addr, frame_pointer, parent))
> +		*parent = return_hooker;
>  }
>
>  #ifdef CONFIG_DYNAMIC_FTRACE

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
