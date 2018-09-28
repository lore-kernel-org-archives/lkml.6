Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D76C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9075204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ZJ093PMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9075204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeI1Uye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:54:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45673 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeI1Uye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:54:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23-v6so4437267pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=C10pPrxQZsgncFbuhvA3QlXsQ7xIxnM2i3AG0UKHjnA=;
        b=ZJ093PMhczJgVstKIEkKO/fZJAgF3AIjw1T0H3tQg+KADEhZV2gALhxtKkTQk4Dkjg
         HD+Z4JV4C3le8dnfEshLuHsTWJzrJGeuZ6tHU+sVX7kG5InWk5EXZaZAdFABKCgh8aT+
         97C23F0CAzTpA3X4Lg3Qjvw9H/xOqb0ZCbsIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=C10pPrxQZsgncFbuhvA3QlXsQ7xIxnM2i3AG0UKHjnA=;
        b=UkNmMs/udTsEQkgdaccb3wk9pJOskcPY4/OqzoWR2SDN5jvz0pw8XHrwjEZUD9fxpv
         4qxiogO/6+/QIJ+i9DPcH3SVBNc7NuWXRGEpQx7CoaI/wF0HWDVD95ezTID6ihsjedW0
         7HMFmjs16LjdabXX50XNC77g1Bj33Nt9grnv5HKRcJZYX2zZWWmFuKBs6QZTg18R/dk4
         lyOX/wCu9DKBahYkQ9WY3QsHUzlXxWg6sjEx/1J/zh74UwxN1+dZ0btNx2WcYImo3X84
         YwrsHn8ZhRigStVzqCdL+t4FzLtqqy+7iM/Kc20Vetx3DbAoen/RqUmbqZQ43fNWz+ej
         gBww==
X-Gm-Message-State: ABuFfogKvWZZ/tQSvp6GSJ5ByGlcofan1Awfog4r3aQNabRdkIJOkffY
        CkQMrmadlGbfAVHew5Nj9DwPbQ==
X-Google-Smtp-Source: ACcGV62zTdlgnIqln5jxrt3XWK8+vMeRjoLUK5e1jYyBNb1rCoUdgcLEFqlCp4ytx8kgDlbTEacXgw==
X-Received: by 2002:a63:2703:: with SMTP id n3-v6mr15630860pgn.113.1538145031002;
        Fri, 28 Sep 2018 07:30:31 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4356])
        by smtp.gmail.com with ESMTPSA id 25-v6sm8595113pfm.36.2018.09.28.07.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 07:30:29 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: wire up memtest
In-Reply-To: <5ccbb0b1ce0a86ef7a77e7b8dbb85c3637bf4628.1538087238.git.christophe.leroy@c-s.fr>
References: <5ccbb0b1ce0a86ef7a77e7b8dbb85c3637bf4628.1538087238.git.christophe.leroy@c-s.fr>
Date:   Sat, 29 Sep 2018 00:30:22 +1000
Message-ID: <874le9k83l.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> Add call to early_memtest() so that kernel compiled with
> CONFIG_MEMTEST really perform memtest at startup when requested
> via 'memtest' boot parameter.
>
This works for me on an e6500.

Tested-by: Daniel Axtens <dja@axtens.net>

However, you should also change Documentation/admin-guide/kernel-parameters.txt
to reflect that memtest is supported natively on ppc with your patch.

Regards,
Daniel

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: moved the test after initmem_init() as PPC64 sets max_low_pfn later than PPC32.
>
>  arch/powerpc/kernel/setup-common.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 93fa0c99681e..9ca9db707bcb 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -33,6 +33,7 @@
>  #include <linux/serial_8250.h>
>  #include <linux/percpu.h>
>  #include <linux/memblock.h>
> +#include <linux/bootmem.h>
>  #include <linux/of_platform.h>
>  #include <linux/hugetlb.h>
>  #include <asm/debugfs.h>
> @@ -966,6 +967,8 @@ void __init setup_arch(char **cmdline_p)
>  
>  	initmem_init();
>  
> +	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
> +
>  #ifdef CONFIG_DUMMY_CONSOLE
>  	conswitchp = &dummy_con;
>  #endif
> -- 
> 2.13.3
