Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD254C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52A32083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550779344;
	bh=WTKDTr2v0ygCzAtrSj1n4A83MC3rN5fX8gxVTO5OxZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c+22xTg/FW9t+oYda3fWmVptX2pej8WRnMt4YnFZyHsRCmTBJVDThKSVi/9eV/X5S
	 npxQk79oFPVAiY5Ut7moE9OelP5BqzPMTg6j4IosFkc5wStcRaaEgnrtuBAxpH4Yw5
	 L8E1p2ta/kJaL+WqSacc1c/6XoDYBhRdLjFISSGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfBUUCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:02:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfBUUCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:02:22 -0500
Received: from quaco.ghostprotocols.net (177-59-142-252.3g.claro.net.br [177.59.142.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7057120836;
        Thu, 21 Feb 2019 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550779341;
        bh=WTKDTr2v0ygCzAtrSj1n4A83MC3rN5fX8gxVTO5OxZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hed6d4nVbVqH3V2NxCcjkexUJDtudPYVuQiRLotrhO3f4Bt1v20NURuQJjrkraRgz
         e5YtmrA8Mx0Z5tXV/nfy2tLwCQo0K0ma8X/n758iJ2HnDiCgJH5KcWZ/FDYf69wJO+
         kDrovkOJReA5IrzSG/+OVALu0fO32NKvIcWt/h3E=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 49E0B4039C; Thu, 21 Feb 2019 17:02:17 -0300 (-03)
Date:   Thu, 21 Feb 2019 17:02:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: fix getting source line failure in annotate
Message-ID: <20190221200217.GG9755@kernel.org>
References: <20190221095716.39529-1-liwei391@huawei.com>
 <20190221110559.GF10990@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221110559.GF10990@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 21, 2019 at 12:05:59PM +0100, Jiri Olsa escreveu:
> On Thu, Feb 21, 2019 at 05:57:16PM +0800, Wei Li wrote:
> 
> SNIP
> 
> > liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf record ./common_while_1
> > [ perf record: Woken up 2 times to write data ]
> > [ perf record: Captured and wrote 0.488 MB perf.data (12500 samples) ]
> > liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf annotate -l -s hotspot_1 --stdio
> > 
> > Sorted summary for file /home/liwei/main_code/hulk_work/hulk/tools/perf/common_while_1
> > ----------------------------------------------
> > 
> >    33.34 common_while_1.c:5
> >    33.34 common_while_1.c:6
> >    33.32 common_while_1.c:7
> >  Percent |      Source code & Disassembly of common_while_1 for cycles:ppp (12482 samples, percent: local period)
> > -----------------------------------------------------------------------------------------------------------------
> >          :
> >          :
> >          :
> >          :         Disassembly of section .text:
> >          :
> >          :         00000000000005fa <hotspot_1>:
> >          :         hotspot_1():
> >          :         void hotspot_1(void)
> >          :         {
> >     0.00 :   5fa:   push   %rbp
> >     0.00 :   5fb:   mov    %rsp,%rbp
> >          :                 volatile int i;
> >          :
> >          :                 for (i = 0; i < 0x10000000; i++);
> >     0.00 :   5fe:   movl   $0x0,-0x4(%rbp)
> >     0.00 :   605:   jmp    610 <hotspot_1+0x16>
> >     0.00 :   607:   mov    -0x4(%rbp),%eax
> >  common_while_1.c:5    4.70 :   60a:   add    $0x1,%eax
> >     4.89 :   60d:   mov    %eax,-0x4(%rbp)
> >  common_while_1.c:5   19.03 :   610:   mov    -0x4(%rbp),%eax
> >  common_while_1.c:5    4.72 :   613:   cmp    $0xfffffff,%eax
> >     0.00 :   618:   jle    607 <hotspot_1+0xd>
> >          :                 for (i = 0; i < 0x10000000; i++);
> >     0.00 :   61a:   movl   $0x0,-0x4(%rbp)
> >     0.00 :   621:   jmp    62c <hotspot_1+0x32>
> >     0.00 :   623:   mov    -0x4(%rbp),%eax
> >  common_while_1.c:6    4.54 :   626:   add    $0x1,%eax
> >     4.73 :   629:   mov    %eax,-0x4(%rbp)
> >  common_while_1.c:6   19.54 :   62c:   mov    -0x4(%rbp),%eax
> >  common_while_1.c:6    4.54 :   62f:   cmp    $0xfffffff,%eax
> > ...
> > 
> > Fixes: 425859ff0de33 ("perf annotate: No need to calculate notes->start twice")
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Tested and applied.

Thanks for the Fixes: tag!

- Arnaldo
