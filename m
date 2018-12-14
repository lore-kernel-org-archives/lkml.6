Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74004C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DF92080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DF92080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeLNDAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:00:02 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47824 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725949AbeLNDAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:00:01 -0500
X-IronPort-AV: E=Sophos;i="5.56,351,1539619200"; 
   d="scan'208";a="49739267"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2018 10:59:43 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id A5F4C4B5CD7A;
        Fri, 14 Dec 2018 10:59:42 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 10:59:42 +0800
Date:   Fri, 14 Dec 2018 10:59:17 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181214025917.GF24409@localhost.localdomain>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
 <20181213125059.GC25287@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181213125059.GC25287@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: A5F4C4B5CD7A.AFA75
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
>> +{
>> +	union {
>> +		u64 v64;
>> +		u32 v32[2];
>> +	} d = { dividend };
>> +	u32 upper;
>> +
>> +	upper = d.v32[1];
>> +	d.v32[1] = 0;
>> +	if (upper >= divisor) {
>> +		d.v32[1] = upper / divisor;
>> +		upper %= divisor;
>> +	}
>> +	asm ("divl %2" : "=a" (d.v32[0]), "=d" (*remainder) :
>> +		"rm" (divisor), "0" (d.v32[0]), "1" (upper));
>> +	return d.v64;
>> +}
>
>Why aren't you using the simple one from include/linux/math64.h ?

Cant't use div_u64() in math64.h directly, because  that will cause ld error.

Even in 64-bit environment, arch/x86/boot/*.o will be built as 32-bit
binary. In 64-bit binary, the dividend is handled as 64-bit value,
that's OK, but in 32-bit binary, that's wrong. So it's necessary
to separate the dividend to upper and lower in 32-bit binary.
That's why copy the needed div_u64() here.

So, when copying kstrtoull(), we should copy div_u64().
When trying to include lib/kstrtox.c, even if other error in make period
are solved, we will also meet this error. We should also copy div_u64
also. And then cover the math64.h in boot/string.c, and hanlde the other
error and warining who comes together.

So just like Baoquan said, it's a good choice to use simple_strtoull()
for now.

Thanks,
Chao Fan

>
>Rest looks ok.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


