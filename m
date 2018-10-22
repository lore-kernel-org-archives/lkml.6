Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B00C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9987F20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9987F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeJVSsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:48:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40909 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeJVSsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:48:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so9783089wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 03:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WBDt7ATtnemw4hAlr7IxXxJeCvTYWg5allddh1RhHQY=;
        b=tCTU/it86wLWD5GKthAY90ev9ZenjYi0xtpsMPCyhk06vMnv31RpeIDyRNwj7PIKeJ
         Ew5GoaUEvQ3tJ6erl/pomPGEsWSaNxl781vAk5ZK9AcV77C0+fzH7pQWVcX0mCM1/oP3
         0fMU9GhGJPsk8b/Sitcq4P+TozRYaxdlvZ7iyLgJVe0yJp21XJgPUG9oAd0gWJ1W97m5
         K/X/7WUun9fzmZsx5X7Ym/H+AmSW4grOTKQWXWHTx+DiOWkM979sacz3ky7mFrASODm0
         jFL7W2DbZhQa+lIB66pLgaxStNzedTdjZENsGtXI9NymbeaKhdrlkgUKlI57/a7GgQhj
         bn3Q==
X-Gm-Message-State: ABuFfoiojqHMjBUEObsbbxDG1KT1yLwZ3rj5FGFtoq8RFfoCWxjbo1nZ
        qRfW5a8j6MUPEzlRzjClSQJfl0KJ3vk=
X-Google-Smtp-Source: ACcGV60+z6GSTQBKY+JTdVjWswN8zq74l8WoqxycDZVrkl9LA8MKiNd/R5+6Ld8ArQJIWYQGpF0txg==
X-Received: by 2002:a1c:dc42:: with SMTP id t63-v6mr15323255wmg.17.1540204220893;
        Mon, 22 Oct 2018 03:30:20 -0700 (PDT)
Received: from [172.22.36.222] ([167.98.65.38])
        by smtp.gmail.com with ESMTPSA id e14-v6sm26326341wrs.69.2018.10.22.03.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 03:30:19 -0700 (PDT)
Subject: Re: [PATCH] ARM: kprobes: Fix false positive with FORTIFY_SOURCE
To:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     William Cohen <wcohen@redhat.com>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20181022093023.GA8920@beast>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <b9a37141-8d4a-f86e-a994-f4cdefb78150@redhat.com>
Date:   Mon, 22 Oct 2018 03:30:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022093023.GA8920@beast>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2018 02:30 AM, Kees Cook wrote:
> The arm compiler internally interprets an inline assembly label
> as an unsigned long value, not a pointer. As a result, under
> CONFIG_FORTIFY_SOURCE, the size of the array pointed to by an address
> of a label is 4 bytes, which was tripping the runtime checks. Instead,
> we can just cast the label (as done with the size calculations earlier)
> to avoid the problem.
>

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1639397

Acked-by: Laura Abbott <labbott@redhat.com>
  
> Reported-by: William Cohen <wcohen@redhat.com>
> Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   arch/arm/probes/kprobes/opt-arm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index b2aa9b32bff2..2c118a6ab358 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>   	}
>   
>   	/* Copy arch-dep-instance from template. */
> -	memcpy(code, &optprobe_template_entry,
> +	memcpy(code, (unsigned char *)optprobe_template_entry,
>   			TMPL_END_IDX * sizeof(kprobe_opcode_t));
>   
>   	/* Adjust buffer according to instruction. */
> 

