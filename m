Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE376C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01F321700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01F321700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeHHJny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:43:54 -0400
Received: from ozlabs.org ([203.11.71.1]:38465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeHHJny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:43:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ljbD4Zxgz9ryt;
        Wed,  8 Aug 2018 17:25:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
In-Reply-To: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
Date:   Wed, 08 Aug 2018 17:25:25 +1000
Message-ID: <87mutxb9qy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
> index 3f415d8101f3..626f580b4ff7 100644
> --- a/lib/test_hexdump.c
> +++ b/lib/test_hexdump.c
> @@ -32,16 +32,33 @@ static const char * const test_data_2_le[] __initconst = {
>  	"d14c", "9919", "b143", "0caf",
>  };
>  
> +static const char * const test_data_2_be[] __initconst = {
> +	"be32", "db7b", "0a18", "93b2",
> +	"70ba", "c424", "7d83", "349b",
> +	"a69c", "31ad", "9c0f", "ace9",
> +	"4cd1", "1999", "43b1", "af0c",
> +};
> +
>  static const char * const test_data_4_le[] __initconst = {
>  	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
>  	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
>  };
>  
> +static const char * const test_data_4_be[] __initconst = {
> +	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
> +	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
> +};
> +

Is there a reason we can't do it all at compile time?

eg:

static const char * const test_data_4[] __initconst = {
#ifdef CONFIG_CPU_LITTLE_ENDIAN
	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
#else
	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
#endif
};


cheers
