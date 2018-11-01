Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9981EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572D120820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wTfgoxsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572D120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeKAXoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbeKAXoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:44:21 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6E62081B;
        Thu,  1 Nov 2018 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541083265;
        bh=Fj3spcqpyIj9z8XTS0x+jk3+jcYVF4EUhv/wUnSwNto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wTfgoxsi6v9cnv2ZfFGgCxy+GrN8vWW8tg/URJTWS5S1YAzfeGcIvf2KdlM7BvV6Y
         euTbAH9yrMgHnffKyRw5i4w87Qae+lv2k3fzGMX5Od5eBXXY+gfegVPDMFWq5H2cNb
         Nom15Vgqlju+0LbxtVsb8oDIYPcHFcDk490Q9B+M=
Date:   Thu, 1 Nov 2018 23:41:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     William Cohen <wcohen@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: kprobes: Fix false positive with FORTIFY_SOURCE
Message-Id: <20181101234102.5fd16894fefffe18fccd6999@kernel.org>
In-Reply-To: <cbeccaf1-33ec-0e54-0cfa-8cff81bbc1cd@redhat.com>
References: <20181022093023.GA8920@beast>
        <cbeccaf1-33ec-0e54-0cfa-8cff81bbc1cd@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 13:40:27 -0400
William Cohen <wcohen@redhat.com> wrote:

> On 10/22/18 5:30 AM, Kees Cook wrote:
> > The arm compiler internally interprets an inline assembly label
> > as an unsigned long value, not a pointer. As a result, under
> > CONFIG_FORTIFY_SOURCE, the size of the array pointed to by an address
> > of a label is 4 bytes, which was tripping the runtime checks. Instead,
> > we can just cast the label (as done with the size calculations earlier)
> > to avoid the problem.
> > 
> > Reported-by: William Cohen <wcohen@redhat.com>
> > Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm/probes/kprobes/opt-arm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> > index b2aa9b32bff2..2c118a6ab358 100644
> > --- a/arch/arm/probes/kprobes/opt-arm.c
> > +++ b/arch/arm/probes/kprobes/opt-arm.c
> > @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
> >  	}
> >  
> >  	/* Copy arch-dep-instance from template. */
> > -	memcpy(code, &optprobe_template_entry,
> > +	memcpy(code, (unsigned char *)optprobe_template_entry,
> >  			TMPL_END_IDX * sizeof(kprobe_opcode_t));
> >  
> >  	/* Adjust buffer according to instruction. */
> > 
> 
> The patch fixes the issue for kretprobes.  It looks good to me.

This looks good to me too. Thank you for finding and fixing it :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Thanks,
> 
> -Will


-- 
Masami Hiramatsu <mhiramat@kernel.org>
