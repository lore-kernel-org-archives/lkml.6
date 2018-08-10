Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB936C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A59D2242C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WWdjiQYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A59D2242C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeHJVCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:02:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22919 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeHJVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533925869; x=1565461869;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ldhzcVml41Adc2TCwYXwL6c7zw4O5g/A1W338IHl3tw=;
  b=WWdjiQYk47G0R4wdIA+FjKFHQJ7DHIgV0g9sEXBDzfcuagTQwL3OFotA
   pfhBvWKZ9L2VJfm1dBsFpt4ZWD3d169nI0rWMG2dCU3odq/yVDyqdQLGR
   VQVCQYNKeyKU1B2wQAAzxqf3vmg7ULuIjd5wFZcng33HrWAfMzrYXowYD
   bO1OaYCnb6Gr3eWYyzTQlT7hw7VwqDmD1T27tIcdKLPKOT2g9WO39LhiD
   LJQ2xu9KyHIdSAsjasXvwxkGcnpJc08s87TVBznPa0tey3JsF80IHC/uz
   YsDAbjYQoKRJ4Umjep/LOh9Aj+GdEjtNaoTYrg03tjJ0OAmVq2XxJYgY3
   A==;
X-IronPort-AV: E=Sophos;i="5.53,220,1531756800"; 
   d="scan'208";a="87319221"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2018 02:31:09 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Aug 2018 11:18:43 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2018 11:31:08 -0700
Subject: Re: [RFC] RISC-V: Fix !CONFIG_SMP compilation error
From:   Atish Patra <atish.patra@wdc.com>
To:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "sols@sifive.com" <sols@sifive.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1533597456-245169-1-git-send-email-atish.patra@wdc.com>
Message-ID: <b77401db-2bd5-3290-86b3-b173b06f964d@wdc.com>
Date:   Fri, 10 Aug 2018 11:31:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533597456-245169-1-git-send-email-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/18 4:17 PM, Atish Patra wrote:
> Enabling both CONFIG_PERF_EVENTS without !CONFIG_SMP
> generates following compilation error.
> 
> arch/riscv/include/asm/perf_event.h:80:2: error: expected
> specifier-qualifier-list before 'irqreturn_t'
> 
>    irqreturn_t (*handle_irq)(int irq_num, void *dev);
>    ^~~~~~~~~~~
> 
> Include interrupt.h in proper place to avoid compilation
> error.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>   arch/riscv/include/asm/perf_event.h | 1 +
>   arch/riscv/kernel/perf_event.c      | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index 0e638a0c..aefbfaa6 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -10,6 +10,7 @@
>   
>   #include <linux/perf_event.h>
>   #include <linux/ptrace.h>
> +#include <linux/interrupt.h>
>   
>   #define RISCV_BASE_COUNTERS	2
>   
> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
> index b0e10c4e..a243fae1 100644
> --- a/arch/riscv/kernel/perf_event.c
> +++ b/arch/riscv/kernel/perf_event.c
> @@ -27,7 +27,6 @@
>   #include <linux/mutex.h>
>   #include <linux/bitmap.h>
>   #include <linux/irq.h>
> -#include <linux/interrupt.h>
>   #include <linux/perf_event.h>
>   #include <linux/atomic.h>
>   #include <linux/of.h>
> 
ping ?

Regards,
Atish
