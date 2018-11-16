Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ED12146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F9cIwxYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09ED12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbeKPL5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:57:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35683 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389257AbeKPL5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 06:57:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id v9-v6so10591107pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 17:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TESYRWkq52QoCA5ZKcBbzbLtTSQ3eqXztqZm8kciZPA=;
        b=F9cIwxYkfh8zTJCOk3wIQ0nBNyUfUxYdvojR9cwS0dP0AHUQAS0oU+eLosybQbzLep
         5LtfDTENSg0Z2LEFXyLUCGLcQVtE9OBGSqEO0iLlDFRSNrL7706AFKag3UvqIiIjRfrS
         Pk0iSQeH6cXb9IZ+UHax2YssoQpalh8SYWE+UHaHN6DJFKqb2Ic4AsBAmqrcaWERf8oq
         rVePgub9yveIeeX2nW2XWhqU3TIMLNjz2D2ljGkSOa6RhfTn6lIBRBNhnYpCZjjoQiaI
         5ymeZWebySoKF4rG0rXSsO4bAfEaRYzZB/YZMKQW3+Q49I3QUAgAlgEnCHAr5TcHFjIw
         /JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TESYRWkq52QoCA5ZKcBbzbLtTSQ3eqXztqZm8kciZPA=;
        b=FOGAISm3DbwzVZbgklcNXprtmNYrM75+9n02RM4qaeq/EkkYokzEDVC5SEkGlWvHto
         ItvhFTeq/mb0HhAJ5FF2p6lgS99k72tiI/FcY25O1YXBui3/0PluMzve9Y8RGygdL+Pv
         sUit3jPYXVEZTKeyzWucYy1oYiYrobRVohknsEMeJbaFZnRBuNJYjf4n/1xEkSZw33M/
         UC3MbL12i5SbdbgHVJ4kOPYWy87V2FvCwUGEOJ0inHzcV7DGyVIybiaXCSlmq27SySjA
         bZdvqg+VY2vLOec0TiRP/o6Wg/639qNSM9Op9YVvSb5LQFDo9E8MlxCciM3byucsX4cD
         tQWQ==
X-Gm-Message-State: AGRZ1gJmqJFnIkbVNWj/I2pvQZhWwBYEJcLcJKB5J4AV1JamsnveoWYg
        1FVBQhbnR7wHYCbtF8A7Qq1voA==
X-Google-Smtp-Source: AJdET5d5H8OmHTidxfuIOTND6mQ7p9QPuaFXATOoe/LYxNEmSxsne2TxBaiU1Maf3A52Sitb6SpoNQ==
X-Received: by 2002:a63:5407:: with SMTP id i7mr8062759pgb.413.1542332847579;
        Thu, 15 Nov 2018 17:47:27 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id 196-v6sm89185626pfc.71.2018.11.15.17.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 17:47:26 -0800 (PST)
Date:   Thu, 15 Nov 2018 17:47:26 -0800 (PST)
X-Google-Original-Date: Thu, 15 Nov 2018 17:45:00 PST (-0800)
Subject:     Re: [PATCH 1/2] csky, h8300, riscv: remove <asm/scatterlist.h> leftovers
In-Reply-To: <20181109090008.24150-2-hch@lst.de>
CC:     iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-328f3881-d91e-4e25-b711-c5d7d91c62e6@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Nov 2018 01:00:07 PST (-0800), Christoph Hellwig wrote:
> There has been no <asm/scatterlist.h> for a long time, which also means
> there is no point in using it from asm-generic.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/csky/include/asm/Kbuild  | 1 -
>  arch/h8300/include/asm/Kbuild | 1 -
>  arch/riscv/include/asm/Kbuild | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> index 2a0abe8f2a35..7c48a123300d 100644
> --- a/arch/csky/include/asm/Kbuild
> +++ b/arch/csky/include/asm/Kbuild
> @@ -34,7 +34,6 @@ generic-y += pci.h
>  generic-y += percpu.h
>  generic-y += preempt.h
>  generic-y += qrwlock.h
> -generic-y += scatterlist.h
>  generic-y += sections.h
>  generic-y += serial.h
>  generic-y += shm.h
> diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
> index a5d0b2991f47..32f0c8952147 100644
> --- a/arch/h8300/include/asm/Kbuild
> +++ b/arch/h8300/include/asm/Kbuild
> @@ -36,7 +36,6 @@ generic-y += parport.h
>  generic-y += percpu.h
>  generic-y += pgalloc.h
>  generic-y += preempt.h
> -generic-y += scatterlist.h
>  generic-y += sections.h
>  generic-y += serial.h
>  generic-y += sizes.h
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 6a646d9ea780..011cc7c7b3ad 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -37,7 +37,6 @@ generic-y += poll.h
>  generic-y += posix_types.h
>  generic-y += preempt.h
>  generic-y += resource.h
> -generic-y += scatterlist.h
>  generic-y += sections.h
>  generic-y += sembuf.h
>  generic-y += serial.h

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
