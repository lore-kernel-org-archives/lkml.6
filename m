Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B992086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZOLDO7/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B992086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIYX1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:27:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44798 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIYX1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:27:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so4031971pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+K42w9hAoCw3bXE0J05cc60xYmthfUb/628tvNagX78=;
        b=ZOLDO7/ajuarS58qVuWOa1VUlpT0ijP2FvWUx3k1MYDcYPxCSthL92f96XKsCw8BdJ
         Or414jIdi4MeokOSm44kEHZvLb9pu9wyh8bdjmJjlsySwGFLFQ04ihjqhqccmDXk07hL
         aG3UCiZmKcH0njlykcqK2c+Nvyjnln8NndEYcqXilqmFSfns3HaxScu2n1ARstOcc3hr
         3FvY+CGy46B7xp2Cuu7NmHK2ADP8PXxx5bEgNsV4IrBtetywYK7b1mybNGh6nikkgwec
         XQNz/8G4hyNkYehtUKxN2ibXZ0oP7thADFuRZx+ywlA+4FlFE19DPQ9TrHDUyvrNGhy8
         NtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+K42w9hAoCw3bXE0J05cc60xYmthfUb/628tvNagX78=;
        b=JLnz0dFhOSP0VLHz/YZsDhr47hDEqJYUongJneS8i2kDMo79qCGq88BBhJsmMAyX+Y
         GCNTWSIPsrFkWw0ru8O0lmwxQy51MebOSrAnS/R+EpyuShxCsYr8rEwiAbWvIMEkl32q
         AAn/YTTVzpLUm/PhQUYqQSzDVyD4Gf0Y9JdxmImvkQ1vnRbxjBpir6f90FI2LtWJK9BW
         XVpfPoksKWcDg0I2eJwtuL3TfNUF+HCi7GhXKCb6AfWJaVmCYbHitGsnZH3FsC6p3z2Z
         kMQWXqZir3O4oryTxbOCcSMHMpC/04b5Ao1KReOdb3PrBpvpuZ3gbl8s36UmI/FHgO1S
         fcOA==
X-Gm-Message-State: ABuFfojmy4zG4k8jTxpgeJ+4TqPKqIdtVqJRTW6j24SH3+gWV4URZ7AM
        JsHKFEB4dP/AlKX8ajlCWN87NdrDh+c=
X-Google-Smtp-Source: ACcGV63zR3/C4ATCedx9MET4AdW5ULDk02O4wnIeuXEC+pqKRD/kscsegj5j3CTKJyT+yfyImGlTwQ==
X-Received: by 2002:a63:f848:: with SMTP id v8-v6mr1969286pgj.82.1537895965274;
        Tue, 25 Sep 2018 10:19:25 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c88-v6sm6295725pfe.132.2018.09.25.10.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:19:24 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:19:24 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Sep 2018 10:12:56 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv/bitops: Remove smp_mb__{before,after}_clear_bit()
In-Reply-To: <20180925121225.9917-2-andrea.parri@amarulasolutions.com>
CC:     linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     andrea.parri@amarulasolutions.com
Message-ID: <mhng-2c59d90d-9cf9-4462-bfb6-5c90ffa0c6d0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 05:12:24 PDT (-0700), andrea.parri@amarulasolutions.com wrote:
> The barriers are unused; remove their definition.
>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: <linux-riscv@lists.infradead.org>
> ---
>  arch/riscv/include/asm/bitops.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index f30daf26f08f4..01db98dfd0435 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -23,11 +23,6 @@
>  #include <asm/barrier.h>
>  #include <asm/bitsperlong.h>
>
> -#ifndef smp_mb__before_clear_bit
> -#define smp_mb__before_clear_bit()  smp_mb()
> -#define smp_mb__after_clear_bit()   smp_mb()
> -#endif /* smp_mb__before_clear_bit */
> -
>  #include <asm-generic/bitops/__ffs.h>
>  #include <asm-generic/bitops/ffz.h>
>  #include <asm-generic/bitops/fls.h>

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Do you want me to take this via the RISC-V tree?  I only ended up with patch 
1/2 in my inbox, and I probably shouldn't take both.

Thanks!
