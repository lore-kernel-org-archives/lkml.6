Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F80BECDE5F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB34E20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RqIPTK7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB34E20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeGYW6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:58:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38835 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbeGYW6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:58:12 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so3833275pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 14:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=teMttmPRaEUtKqWDccATRsQ0OGV7SBbG8NxnMweL0dE=;
        b=RqIPTK7VlwjB70VqY7/rnbyAxU0BgTOBWkOSpyQpYC9+BBkpPYp/TO83rQVYjf5RvV
         zQh+BjKdDUpnPVd8gPfo9ezxucVPqaV997iMyft5WwIB1LMg2FAP67lyD6T5aDETJIMo
         +RxZu/3Ka7n3XwnBmLquI6DwuoBftaSvs9dj/W+4HtRw7omhLJX2h5m4dR0xyaMg+bZQ
         MZV1aHULcqx7rX6c038YOoycMemP7jtQyTcsoSFPUImdW1aTw27wnGiGP39oMLSnGAWq
         7aE7kayycMsg+xwchxDvMrEy9SzJ34VvuRSa3GjLrgRruSkiKPZWsZdx6suHWU2hVEQo
         ZQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=teMttmPRaEUtKqWDccATRsQ0OGV7SBbG8NxnMweL0dE=;
        b=H+yKT6A9qhGndvPlun7rvZ0YRtBfKBCp3UXw2P+8CACdDocF5XRTGoKoT+X//v2+7e
         dOx9hveRERO8c7uZLzzMCRgaesAJ2a91OietV3/s+ftVq5B5Qj1Aw3FBvT1ErTmjrdeU
         pErPRBGQ0f+PHJbHb9XYmFoQPgKyvwOKaqTPc9pd1fT89JaTMlRAm3pUIt/NoFjxlm5w
         WA+NIyl/KmF/w+tLKrPE8sR6SL0+mpk5utqFtuJr3VErIr+V52qJbXAFyjzFaiS/wuWR
         lCDrliVu5SNw0VLQDA6cJ505TDSidtBnXFk0/6o+3YEV5W/WpTk4pijjoTujLPkfwWOc
         ZmWg==
X-Gm-Message-State: AOUpUlGFQbJpCnrQ6EFR3mGJM2uN/w3wApSY2DZ79/snwLVIsP6z2/hY
        gldy95KTGdo9AGGQWDJt67GWdw==
X-Google-Smtp-Source: AAOMgpdHD+zZq8BnZTyQ8m3A4Kr680UI0JbBYW4FuxS8BsGf2C1G4yRjxyH9Xg9A+l4vzCeV3PSZ7w==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7-v6mr22518090plr.215.1532555076010;
        Wed, 25 Jul 2018 14:44:36 -0700 (PDT)
Received: from localhost (96-90-200-139-static.hfc.comcastbusiness.net. [96.90.200.139])
        by smtp.gmail.com with ESMTPSA id c12-v6sm35646437pfl.20.2018.07.25.14.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 14:44:35 -0700 (PDT)
Date:   Wed, 25 Jul 2018 14:44:35 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Jul 2018 14:42:51 PDT (-0700)
Subject:     Re: [PATCH 2/6] RISC-V: remove INTERRUPT_CAUSE_* defines from asm/irq.h
In-Reply-To: <20180725093649.32332-3-hch@lst.de>
CC:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-a0410fc4-7f2e-4818-acf0-6a7616ba0010@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 02:36:45 PDT (-0700), Christoph Hellwig wrote:
> These are only of use to the local irq controller driver, so add them in
> that driver implementation instead, which will be submitted soon.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/irq.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index 4dee9d4c13c0..93eb75eac4ff 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -17,10 +17,6 @@
>
>  #define NR_IRQS         0
>
> -#define INTERRUPT_CAUSE_SOFTWARE    1
> -#define INTERRUPT_CAUSE_TIMER       5
> -#define INTERRUPT_CAUSE_EXTERNAL    9
> -
>  void riscv_timer_interrupt(void);
>
>  #include <asm-generic/irq.h>

Acked-by: Palmer Dabbelt <palmer@sifive.com>
