Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0789DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FE020855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfBULGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:06:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfBULGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:06:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 079AC882F2;
        Thu, 21 Feb 2019 11:06:02 +0000 (UTC)
Received: from krava (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4726C6014E;
        Thu, 21 Feb 2019 11:06:00 +0000 (UTC)
Date:   Thu, 21 Feb 2019 12:05:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: fix getting source line failure in annotate
Message-ID: <20190221110559.GF10990@krava>
References: <20190221095716.39529-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221095716.39529-1-liwei391@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 21 Feb 2019 11:06:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:57:16PM +0800, Wei Li wrote:

SNIP

> liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf record ./common_while_1
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.488 MB perf.data (12500 samples) ]
> liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf annotate -l -s hotspot_1 --stdio
> 
> Sorted summary for file /home/liwei/main_code/hulk_work/hulk/tools/perf/common_while_1
> ----------------------------------------------
> 
>    33.34 common_while_1.c:5
>    33.34 common_while_1.c:6
>    33.32 common_while_1.c:7
>  Percent |      Source code & Disassembly of common_while_1 for cycles:ppp (12482 samples, percent: local period)
> -----------------------------------------------------------------------------------------------------------------
>          :
>          :
>          :
>          :         Disassembly of section .text:
>          :
>          :         00000000000005fa <hotspot_1>:
>          :         hotspot_1():
>          :         void hotspot_1(void)
>          :         {
>     0.00 :   5fa:   push   %rbp
>     0.00 :   5fb:   mov    %rsp,%rbp
>          :                 volatile int i;
>          :
>          :                 for (i = 0; i < 0x10000000; i++);
>     0.00 :   5fe:   movl   $0x0,-0x4(%rbp)
>     0.00 :   605:   jmp    610 <hotspot_1+0x16>
>     0.00 :   607:   mov    -0x4(%rbp),%eax
>  common_while_1.c:5    4.70 :   60a:   add    $0x1,%eax
>     4.89 :   60d:   mov    %eax,-0x4(%rbp)
>  common_while_1.c:5   19.03 :   610:   mov    -0x4(%rbp),%eax
>  common_while_1.c:5    4.72 :   613:   cmp    $0xfffffff,%eax
>     0.00 :   618:   jle    607 <hotspot_1+0xd>
>          :                 for (i = 0; i < 0x10000000; i++);
>     0.00 :   61a:   movl   $0x0,-0x4(%rbp)
>     0.00 :   621:   jmp    62c <hotspot_1+0x32>
>     0.00 :   623:   mov    -0x4(%rbp),%eax
>  common_while_1.c:6    4.54 :   626:   add    $0x1,%eax
>     4.73 :   629:   mov    %eax,-0x4(%rbp)
>  common_while_1.c:6   19.54 :   62c:   mov    -0x4(%rbp),%eax
>  common_while_1.c:6    4.54 :   62f:   cmp    $0xfffffff,%eax
> ...
> 
> Fixes: 425859ff0de33 ("perf annotate: No need to calculate notes->start twice")

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
