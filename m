Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0667DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6C42075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6C42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJaCew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:34:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbeJaCew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:34:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDFD6307D96B;
        Tue, 30 Oct 2018 17:40:27 +0000 (UTC)
Received: from [10.13.129.51] (dhcp129-51.rdu.redhat.com [10.13.129.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79366177A9;
        Tue, 30 Oct 2018 17:40:27 +0000 (UTC)
Subject: Re: [PATCH] ARM: kprobes: Fix false positive with FORTIFY_SOURCE
To:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20181022093023.GA8920@beast>
From:   William Cohen <wcohen@redhat.com>
Message-ID: <cbeccaf1-33ec-0e54-0cfa-8cff81bbc1cd@redhat.com>
Date:   Tue, 30 Oct 2018 13:40:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022093023.GA8920@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 30 Oct 2018 17:40:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 5:30 AM, Kees Cook wrote:
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
> 

The patch fixes the issue for kretprobes.  It looks good to me.

Thanks,

-Will
