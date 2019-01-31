Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6958C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BD1218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfAaJjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:39:10 -0500
Received: from www62.your-server.de ([213.133.104.62]:43784 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfAaJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:39:09 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gp8oJ-00014f-Rd; Thu, 31 Jan 2019 10:39:03 +0100
Received: from [178.197.249.18] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gp8oJ-000SMa-KZ; Thu, 31 Jan 2019 10:39:03 +0100
Subject: Re: [PATCH] include/linux/bpf.h - fix missing prototype warnings...
To:     valdis.kletnieks@vt.edu, Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6349.1548741865@turing-police.cc.vt.edu>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5ff21ff7-fd7e-5e90-86a6-d06f9ab4fa3d@iogearbox.net>
Date:   Thu, 31 Jan 2019 10:39:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <6349.1548741865@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25345/Thu Jan 31 07:13:04 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/2019 07:04 AM, valdis.kletnieks@vt.edu wrote:
> Compiling with W=1 generates warnings:
> 
>   CC      kernel/bpf/core.o
> kernel/bpf/core.c:721:12: warning: no previous prototype for ?bpf_jit_alloc_exec_limit? [-Wmissing-prototypes]
>   721 | u64 __weak bpf_jit_alloc_exec_limit(void)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~
> kernel/bpf/core.c:757:14: warning: no previous prototype for ?bpf_jit_alloc_exec? [-Wmissing-prototypes]
>   757 | void *__weak bpf_jit_alloc_exec(unsigned long size)
>       |              ^~~~~~~~~~~~~~~~~~
> kernel/bpf/core.c:762:13: warning: no previous prototype for ?bpf_jit_free_exec? [-Wmissing-prototypes]
>   762 | void __weak bpf_jit_free_exec(void *addr)
>       |             ^~~~~~~~~~~~~~~~~
> 
> All three are weak functions that archs can override, although none do so
> currently.  Provide prototypes for when a new arch provides its own.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Applied all 3 to bpf-next, thanks Valdis!

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3851529062ec..99e55313123f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -472,6 +472,10 @@ _out:							\
>  #define BPF_PROG_RUN_ARRAY_CHECK(array, ctx, func)	\
>  	__BPF_PROG_RUN_ARRAY(array, ctx, func, true)
>  
> +u64 __weak bpf_jit_alloc_exec_limit(void);
> +void *__weak bpf_jit_alloc_exec(unsigned long size);
> +void __weak bpf_jit_free_exec(void *addr);
> +

(I moved these to include/linux/filter.h while applying where we have all the
 other prototypes from JIT core already.)

>  #ifdef CONFIG_BPF_SYSCALL
>  DECLARE_PER_CPU(int, bpf_prog_active);
>  
> 

