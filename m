Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117DFC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9252082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9252082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeKBPqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:46:17 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41202 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeKBPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:46:17 -0400
Received: by mail-ot1-f49.google.com with SMTP id c32so818709otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 23:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ND9oIeCB2F32D0IPWhQHkiX172YcQysCXSZRS7US7M0=;
        b=GbLCA+X/X3R3edxCf/lbVr8M3f6mhdnHblO26F1Wcxh+4zuiDEDnFX4apXjsh+EDkQ
         pnkXeVwZCyQfQPOzgbJi9Sv+p3HNr+6xIgc1CKj4IXL0924h/spDirT/QdXc43JghWFw
         l4aob+mbZ60OQeyzPrme761BXSIe7L1l55bgCDqO6PZEORKJTQp5q+OInxE+0uN/z6Jc
         d4G5eyX0XQtTxsQbvzA0EI02e4PAKyVeIB0AjRIRs2TsGb7/Qlj3pLO1Mx9Tj+0u+5PO
         cg8ednsF95YcabeXVjS/AREDCA8KUB9gUhqxii3UnXWRsz6YCAGmqXfohd7Bck6OGNjm
         UJyg==
X-Gm-Message-State: AGRZ1gL+VMYmiKZhmwNbF795k+j+tu9CyoJc/WIp7jSN/oOED1TPyzdF
        Ja7d9lKGXg+iIdBEr/aGogWRXHLavtM0PRlK2sZKgQ==
X-Google-Smtp-Source: AJdET5cT6oacOjcsCtliWVaFXVy9r72O7SqeIgAwCuur+O3Ma/5ROolSD3WnlTskTCrlRP6io2ME83MzOMQqiGP2+Xg=
X-Received: by 2002:a9d:7043:: with SMTP id x3mr5972568otj.173.1541140811588;
 Thu, 01 Nov 2018 23:40:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:faf:0:0:0:0:0 with HTTP; Thu, 1 Nov 2018 23:40:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1811011630310.1642@nanos.tec.linutronix.de>
References: <1541085133-32534-1-git-send-email-neelx@redhat.com> <alpine.DEB.2.21.1811011630310.1642@nanos.tec.linutronix.de>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Fri, 2 Nov 2018 07:40:10 +0100
Message-ID: <CACjP9X-aZ4-6h7KkgZO6TtPCY4teiBTzVn-c11ULPwbPid8qWQ@mail.gmail.com>
Subject: Re: [PATCH] tsc: make calibration refinement more robust
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

thanks for checking.

On Thu, Nov 1, 2018 at 4:34 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Daniel,
>
> On Thu, 1 Nov 2018, Daniel Vacek wrote:
>
> Please use 'x86/tsc:' as prefix. git log path/to/file usually gives you a
> reasonable hint about prefixes.

Oh, sure thing. The dmesg always prints 'tsc:' - I somehow sticked to it...

>> -#define MAX_RETRIES     5
>> -#define SMI_TRESHOLD    50000
>> +#define MAX_RETRIES  5
>> +#define TSC_THRESHOLD        (tsc_khz >> 5)
>
> This breaks pit_hpet_ptimer_calibrate_cpu() because at that point tsc_hkz is 0.

That did not show up with my testing, sorry. I guess
pit_calibrate_tsc() never failed for me. Hmm, actually it looks like
quick_pit_calibrate() does the job for me so
pit_hpet_ptimer_calibrate_cpu() is likely not even called. Would this:

#define TSC_THRESHOLD   (tsc_khz? tsc_khz >> 5: 0x20000)

work for you instead? Or alternatively at some point when chasing this
down I used:

#define TSC_THRESHOLD (0x10000 + (tsc_khz >> 6))

The first one seems better though. I can send v2 next week if you like it.

--nX

> Thanks,
>
>         tglx
