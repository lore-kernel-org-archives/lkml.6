Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FA9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3E6217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545225035;
	bh=EirWnonmdEeATWfdq3lU8Lj5RB0pGfCNthRCwjpkzkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hqVNZ0Ottxaz6vWWpQV689XpZhnMAd1x4MpPc7pWkjquEFh2vXFcq8OjROaLKZv6i
	 6X+Tic3UHSxEYWD0wJTpcbup6F27urnNXl6FJvE3t/g59c1zZGC0uQzTCY2Ch9B30A
	 F/v+AL+zWjfUQh1+qiq8xtg4SLwF1p8iVSHF94B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeLSNKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeLSNKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:10:33 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1072133F;
        Wed, 19 Dec 2018 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545225032;
        bh=EirWnonmdEeATWfdq3lU8Lj5RB0pGfCNthRCwjpkzkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVsMNuG9eAeW94jn0KZnm2HyKm8QqLK3Jxp0ZuM4sqj8IuBMk/Nc+z219Ty05yERy
         PwXfOHwoXV2VpXs0ctJRuv7E0ppv1skxDvBbZ6nRy6fSM1t8VBvjw1iYYOxbf6roPi
         e9fe+RFJKpdCL9D7E86nmCi6S0DcgVexVpeZ2yGE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFAEE41B1D; Wed, 19 Dec 2018 10:10:29 -0300 (-03)
Date:   Wed, 19 Dec 2018 10:10:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?iso-8859-1?Q?Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
Subject: Re: [PATCH 57/63] perf beauty mmap: Print PROT_READ before PROT_EXEC
 to match strace output
Message-ID: <20181219131029.GB16225@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
 <20181218220733.15839-58-acme@kernel.org>
 <20181219091500.GB18068@danjae.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219091500.GB18068@danjae.aot.lge.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 19, 2018 at 06:15:00PM +0900, Namhyung Kim escreveu:
> On Tue, Dec 18, 2018 at 07:07:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > Helps with comparing 'strace' and 'perf trace' output, for mutual
> > regression testing.

<SNIP>

> > +++ b/tools/perf/trace/beauty/mmap.c
> > @@ -17,8 +17,8 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,

> > -	P_MMAP_PROT(EXEC);
> >  	P_MMAP_PROT(READ);
> > +	P_MMAP_PROT(EXEC);
> >  	P_MMAP_PROT(WRITE);
 
> EXEC should be printed after WRITE..
 
>   $ cat mmap.c
>   #include <sys/mman.h>
   
>   int main(void)
>   {
>     mmap(0, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>     return 0;
>   }
   
>   $ strace -e mmap ./a.out
>   ...
>   mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4c643ec000
>   +++ exited with 0 +++

Thanks, will change that as well, and probably use your test proggie as
the first of a series of 'perf test' for the beautifiers :-)

Now, with your program:

[root@seventh c]# cat mmap.c
#include <sys/mman.h>

int main(void)
{
	mmap(0, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	return 0;
}
[root@seventh c]# strace -e mmap ./mmap |& grep -v ^+++
mmap(NULL, 103484, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f5bae400000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5bae3fe000
mmap(NULL, 3889792, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f5bade40000
mmap(0x7f5bae1ec000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ac000) = 0x7f5bae1ec000
mmap(0x7f5bae1f2000, 14976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f5bae1f2000
mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5bae419000
[root@seventh c]# trace -e mmap ./mmap |& grep -v ^+++
mmap(NULL, 103484, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f6646c25000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f6646c23000
mmap(NULL, 3889792, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f6646665000
mmap(0x7f6646a11000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ac000) = 0x7f6646a11000
mmap(0x7f6646a17000, 14976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS) = 0x7f6646a17000
mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f6646c3e000
[root@seventh c]#

- Arnaldo
