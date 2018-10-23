Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76617C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9971D20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiN596Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9971D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeJWJ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbeJWJ1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:27:06 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A0902064C;
        Tue, 23 Oct 2018 01:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540256768;
        bh=4Jjj1C6ElfuQVh9qn5XTKaf9YikveYNTtZsYlo6uVGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WiN596UtcpV8nLePTj0Nn3BJOh2IMzV2IdQl7wb2IOr6ZSOWjT+3gN2WEk/egr8+R
         9yTIdRiUQbhkG790n8gtyo4KUpa45UcqTfT0VG/u/oUYLO1HjhVBfh999uO/DDby8I
         h0ny7fk2j0ZBy7UhJlZBOE6kOvrTgww78frUeH6g=
Date:   Tue, 23 Oct 2018 10:06:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: kprobes: Fix false positive with FORTIFY_SOURCE
Message-Id: <20181023100604.ea7a1a9b5c1c8904aab1b36b@kernel.org>
In-Reply-To: <20181022093023.GA8920@beast>
References: <20181022093023.GA8920@beast>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 02:30:23 -0700
Kees Cook <keescook@chromium.org> wrote:

> The arm compiler internally interprets an inline assembly label
> as an unsigned long value, not a pointer. As a result, under
> CONFIG_FORTIFY_SOURCE, the size of the array pointed to by an address
> of a label is 4 bytes, which was tripping the runtime checks. Instead,
> we can just cast the label (as done with the size calculations earlier)
> to avoid the problem.
> 
> Reported-by: William Cohen <wcohen@redhat.com>
> Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Good catch! This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,


> ---
>  arch/arm/probes/kprobes/opt-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index b2aa9b32bff2..2c118a6ab358 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>  	}
>  
>  	/* Copy arch-dep-instance from template. */
> -	memcpy(code, &optprobe_template_entry,
> +	memcpy(code, (unsigned char *)optprobe_template_entry,
>  			TMPL_END_IDX * sizeof(kprobe_opcode_t));
>  
>  	/* Adjust buffer according to instruction. */
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security


-- 
Masami Hiramatsu <mhiramat@kernel.org>
