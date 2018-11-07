Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A01C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1585320882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PifX1xRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1585320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbeKGKBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:01:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46409 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388832AbeKGKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:01:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id c13-v6so7002073plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=SelDEmOfMAVrtkn80IJq8uB2tJSaeYXNm6xN79i+y60=;
        b=PifX1xROUl0seQNVGelT/WY5SbPGdg14Y1c5TSvAJdB2mV2sLkhTF2xGcLJn9heeWO
         4FrI8LNP5pHaLo4xKTZbMpAROx+KqOY4WA/g4nV1jhsrOKn8lb9uOM/dHqs+Z9pp7aEy
         nAvEoBnOi/VfsYKVgk2Cwq1UAkbZdwsDC7dmMuS1L3x4Rcykjce4GvVkQjETBas9F5QZ
         T7cnIDdChd5WyK+4tqcyaRVw0QP2YkFytTKCUKElRMy0MqBEPc11sSiG0YxlPOMZp0iY
         9musVoeP7EZt+5osD1ZagP37WtneOEDOEfBmbCNmeT3FPlVoV44kgjAf6DrynpUdQSC2
         RfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=SelDEmOfMAVrtkn80IJq8uB2tJSaeYXNm6xN79i+y60=;
        b=PdwkVelwL4qm25ksYXlj5kgChlTHa1lbhA78UuCq6h1rEtzZWKwYLmpDUmkWzhD9jU
         GEQFd/Lzztj5x+xLZkK2eE3Mz+sbmLUFor1SRN5au3UBZ7Ewd0i/cbPOeDCbPFT9Z/y9
         /sGuUzHbN+4l/SdPYTnOXJh8IqrXaElP7lzA7/DC3Gu25W7zaspaOU6/NiydsahDgUJe
         wpyl4yJQv3qyNULGseNHOB73EcySPHWvlLE9r+60zHp51FEUnKk09rTva2Y/s9dxwPd/
         +HtLY46MzNTrreHSf18O7l9EaghXxC3cP8sbaPurysEElHBJNTH9dg6UKzv4eh2jReDz
         hbJw==
X-Gm-Message-State: AGRZ1gKPvPXQsbFYC52Y2/j8gdruE/MWxr3Ypsrkgk+ZA1ZGs3XUpICb
        eCPykvR4azO+CjIsSa7W318S+w==
X-Google-Smtp-Source: AJdET5ecbazupfq2BghswK9/UuUj5zsG+mrni86YAJ0DWTlo2hzkv/dDttoIyykvTVqYTKx5ZPk2UA==
X-Received: by 2002:a17:902:25ab:: with SMTP id y40-v6mr28282598pla.258.1541550787211;
        Tue, 06 Nov 2018 16:33:07 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e127-v6sm47584911pfe.142.2018.11.06.16.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:06 -0800 (PST)
Date:   Tue, 06 Nov 2018 16:33:06 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 16:32:27 PST (-0800)
Subject:     Re: [PATCH] riscv: fix spacing in struct pt_regs
In-Reply-To: <20181105144004.28267-1-david.abdurachmanov@gmail.com>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-0fc17080-b4cc-4aa4-b269-b3140af7421d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov 2018 06:40:04 PST (-0800), david.abdurachmanov@gmail.com wrote:
> Replace 8 spaces with tab to match styling.
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> ---
>  arch/riscv/include/asm/ptrace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index 2c5df945d43c..bbe1862e8f80 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -56,8 +56,8 @@ struct pt_regs {
>  	unsigned long sstatus;
>  	unsigned long sbadaddr;
>  	unsigned long scause;
> -        /* a0 value before the syscall */
> -        unsigned long orig_a0;
> +	/* a0 value before the syscall */
> +	unsigned long orig_a0;
>  };
>
>  #ifdef CONFIG_64BIT

Thanks.  I'll also include this for next week's PR.
