Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B835ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD38F206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KXoQHZCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD38F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeGQRbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:31:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47016 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbeGQRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fVWTy2ohgEXk/bUFvMxGKZ5oIAmYzoBmKRhS5tZBc3c=; b=KXoQHZCKpQNh3R0l1rRzEApZ8L
        iOPIQEqsxgTaTOlleaKtuar2aKubPkjWaBho4PaRnvDZixnSZwi9HNkOz508fGwINVZweD42OCum6
        hOH4tk9bdxSBhCWrYg3dDx7isqXr3ckzKYNpXXl/E1nJvmmErmR6P0C+JgZ7jeJTGxhk1OzKmsRi2
        FRa8rEQ7p3bseezt9Doa/cvuRgxcPO4lPQWjvJSu/HOR9XAH/5YRGNBkX665/SrSDNdlztWrUipBb
        3OYgLssdbR1y4xHbAoviapPVqHKltHW0ZwTzyQ0hznJGtGmAiEC1b0uM04yAZgtNpGZ/5zYyQY7U0
        uLfzG0/w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffTI6-0002Cn-7M; Tue, 17 Jul 2018 16:57:34 +0000
Subject: Re: [PATCH v3 3/3] lib/test_crc: Add test cases for crc calculation
To:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180717145525.50852-1-colyli@suse.de>
 <20180717145525.50852-4-colyli@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <346998e5-8798-e8f0-ccaa-a9d4810b68f5@infradead.org>
Date:   Tue, 17 Jul 2018 09:57:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717145525.50852-4-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/17/2018 07:55 AM, Coly Li wrote:

> diff --git a/lib/test_crc.c b/lib/test_crc.c
> new file mode 100644
> index 000000000000..441bf835fbd3
> --- /dev/null
> +++ b/lib/test_crc.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CRC test driver
> + *
> + * Copyright (C) 2018 Coly Li <colyli@suse.de>
> + *

> +
> +static int __init test_crc_init(void)
> +{
> +	int i;
> +	int v, err = 0;
> +
> +	pr_info("Kernel CRC consitency testing:\n");

	                    consistency

> +	for (i = 0; test_data[i].name; i++) {
> +		v = test_data[i].handler(&test_data[i]);
> +		if (v < 0)
> +			err++;
> +	}
> +
> +	if (err == 0)
> +		pr_info("test_crc: all %d tests passed\n", i);
> +	else
> +		pr_err("test_crc: %d cases tested, %d passed, %d failed\n",
> +		       i, i - err, err);
> +
> +	return (err == 0) ? 0 : -EINVAL;
> +}


-- 
~Randy
