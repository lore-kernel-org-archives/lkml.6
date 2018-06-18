Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D20C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD05208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/8555gY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD05208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934864AbeFROb4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934470AbeFRObz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:31:55 -0400
Received: from jouet.infradead.org (unknown [187.65.76.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC0720852;
        Mon, 18 Jun 2018 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529332314;
        bh=UyFM/mdQBXQTqQEBDRVobpnTK15uQ0JBtdOMZ2HTFxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/8555gYgYuUIW34nTy1ZuAy+gM/QQtZJLXEZJXwpe0dHCin3fx7Uwdy38b59IChz
         oINwD4MZfYOSKlmRx9dOyuHu6xaHowX2YZ75bOPTZYi0MzrJLUY2fzXopGeAVfqFu3
         3x5Aa28Tp5VPq3Gyyzf2bbXx8qIPnZqrbJPJVUtc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 676451457B8; Mon, 18 Jun 2018 11:31:39 -0300 (-03)
Date:   Mon, 18 Jun 2018 11:31:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: perf tools: LIBCLANGLLVM=1 build broken with llvm 7/clang 6
Message-ID: <20180618143139.GA20477@kernel.org>
References: <20180616122608.GM30043@kernel.org>
 <91a76633-54e4-984d-cb68-ca0445146b15@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91a76633-54e4-984d-cb68-ca0445146b15@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 16, 2018 at 10:20:21AM -0700, Yonghong Song escreveu:
> 
> 
> On 6/16/18 5:26 AM, Arnaldo Carvalho de Melo wrote:
> > Hi Wang, Yogong,
> > 
> > 	While reviewing the BTF patches for pahole, I updated llvm/clang
> > to HEAD and then building perf with clang embedded I noticed this, will
> > investigate, posting here to document the regression, maybe this is
> > something you came across in other scenario:
> > 
> >   $ make LIBCLANGLLVM=1 -C tools/perf/
> >   <SNIP>
> >    CC       /tmp/tmp.t53Qo38zci/tests/kmod-path.o
> > util/c++/clang.cpp: In function ‘std::unique_ptr<llvm::SmallVectorImpl<char> > perf::getBPFObjectFromModule(llvm::Module*)’:
> > util/c++/clang.cpp:150:43: error: no matching function for call to ‘llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::PassManager&, llvm::raw_svector_ostream&, llvm::TargetMachine::CodeGenFileType)’
> >               TargetMachine::CGFT_ObjectFile)) {
> >                                             ^
> > In file included from util/c++/clang.cpp:25:0:
> > /usr/local/include/llvm/Target/TargetMachine.h:254:16: note: candidate: virtual bool llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::PassManagerBase&, llvm::raw_pwrite_stream&, llvm::raw_pwrite_stream*, llvm::TargetMachine::CodeGenFileType, bool, llvm::MachineModuleInfo*)
> >     virtual bool addPassesToEmitFile(PassManagerBase &, raw_pwrite_stream &,
> >                  ^~~~~~~~~~~~~~~~~~~
> > /usr/local/include/llvm/Target/TargetMachine.h:254:16: note:   candidate expects 6 arguments, 3 provided
> > mv: cannot stat '/tmp/tmp.t53Qo38zci/util/c++/.clang.o.tmp': No such file or directory
> > make[7]: *** [/home/acme/git/perf/tools/build/Makefile.build:101: /tmp/tmp.t53Qo38zci/util/c++/clang.o] Error 1
> > make[6]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: c++] Error 2
> > make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> > make[5]: *** Waiting for unfinished jobs....
> >    CC       /tmp/tmp.t53Qo38zci/tests/thread-map.o
> 
> There is an interface change in llvm 7.0 (trunk) for function
> llvm::TargetMachine::addPassesToEmitFile. The following patch
> should fix the problem.

Please submit it, I just tested and the the build finishes Ok.

- Arnaldo
 
> -bash-4.2$ git diff
> diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
> index bf31cea..11dee58 100644
> --- a/tools/perf/util/c++/clang.cpp
> +++ b/tools/perf/util/c++/clang.cpp
> @@ -146,8 +146,15 @@ getBPFObjectFromModule(llvm::Module *Module)
>         raw_svector_ostream ostream(*Buffer);
> 
>         legacy::PassManager PM;
> -       if (TargetMachine->addPassesToEmitFile(PM, ostream,
> - TargetMachine::CGFT_ObjectFile)) {
> +       bool NotAdded;
> +#if CLANG_VERSION_MAJOR < 7
> +       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
> + TargetMachine::CGFT_ObjectFile);
> +#else
> +       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
> + TargetMachine::CGFT_ObjectFile);
> +#endif
> +       if (!NotAdded) {
>                 llvm::errs() << "TargetMachine can't emit a file of this
> type\n";
>                 return
> std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
>         }
> -bash-4.2$
> 
> Will submit a formal patch soon.
> 
> > 
> > - Arnaldo
> > 
