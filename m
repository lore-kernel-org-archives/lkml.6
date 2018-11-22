Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71847C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E8F20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="NLj+94fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E8F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbeKVNnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:43:40 -0500
Received: from mail.servus.at ([193.170.194.20]:60420 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732940AbeKVNnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:43:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id 4EE6B3000678;
        Thu, 22 Nov 2018 04:06:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1542855977; x=1544670378; bh=MnMbhMpp3wARe2LlEPgoT48y6WtcvAhykbZ
        K1qAgYco=; b=NLj+94fgnB2KhkZj70XuQDpKeymcCcc9Ix+PRJoRnQ3oZ+6nJJi
        CZV5W2Zbk4CUCNaUx0P9bX/qOMBtgV6Gu2+kr1Q5y/5FofaZPVGOLhu3WMUALyaV
        mFBqp3TuPtN8RlUCIOBztm/9yNm8PJPWg1ck8I4TWrShYnaXvfQ8mH0s=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5QtV7LLd4d4v; Thu, 22 Nov 2018 04:06:17 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id 1D48F3000676;
        Thu, 22 Nov 2018 04:06:16 +0100 (CET)
Subject: Re: [PATCH 2/6] lib/lzo: enable 64-bit CTZ on Arm
To:     Christoph Hellwig <hch@infradead.org>,
        Dave Rodgman <dave.rodgman@arm.com>
References: <20181121115922.22864-2-dave.rodgman@arm.com>
 <20181121115922.22864-3-dave.rodgman@arm.com>
 <20181121173114.GA14352@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>
From:   "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
Message-ID: <5BF61D27.5000002@oberhumer.com>
Date:   Thu, 22 Nov 2018 04:06:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20181121173114.GA14352@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-21 18:31, Christoph Hellwig wrote:
>>  #define LZO_USE_CTZ32	1
>>  #elif defined(__i386__) || defined(__powerpc__)
>>  #define LZO_USE_CTZ32	1
>> -#elif defined(__arm__) && (__LINUX_ARM_ARCH__ >= 5)
>> +#elif defined(__arm__)
>> +#if (__LINUX_ARM_ARCH__ >= 5)
>>  #define LZO_USE_CTZ32	1
>>  #endif
>> +#if (__LINUX_ARM_ARCH__ >= 6) && (CONFIG_THUMB2_KERNEL)
>> +#define LZO_USE_CTZ64	1
> 
> All of this really needs to be driven by Kconfig symbols that
> the architecture selects instead of magic arch ifdefs here.

LZO_USE_CTZ32 and LZO_USE_CTZ64 should only be defined if there
is a *fast* hardware instruction.

It would be nice if there exists a kernel #define we could
use for detecting that.

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
