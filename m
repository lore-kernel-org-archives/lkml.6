Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E3C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A00208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzreFmL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A00208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeFPM0O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 08:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932805AbeFPM0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 08:26:13 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 458FD208AF;
        Sat, 16 Jun 2018 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529151972;
        bh=bMh4vJDQIHC0e2Q/Ctv2yZOqA1oPb2Ct5zeOtpUwp+U=;
        h=Date:From:To:Cc:Subject:From;
        b=HzreFmL6TcAwHlaU8K/wAQiCZDXnqt5Z3GKmcZmBOx3dR3RjSaRNufl2/6Sl6sLP2
         Tbj6/fy1RoN1uP5aMAI4EUkd9x5ka0LbZJDCXbcHj57GLN74g6La5c5O81jdm4PHky
         XkAeXuze5FLtdJVXrfWbYLonNT4fef+74l7C6qaI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 5AE2114699E; Sat, 16 Jun 2018 09:26:08 -0300 (-03)
Date:   Sat, 16 Jun 2018 09:26:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: perf tools: LIBCLANGLLVM=1 build broken with llvm 7/clang 6
Message-ID: <20180616122608.GM30043@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang, Yogong,

	While reviewing the BTF patches for pahole, I updated llvm/clang
to HEAD and then building perf with clang embedded I noticed this, will
investigate, posting here to document the regression, maybe this is
something you came across in other scenario:

 $ make LIBCLANGLLVM=1 -C tools/perf/
 <SNIP>
  CC       /tmp/tmp.t53Qo38zci/tests/kmod-path.o
util/c++/clang.cpp: In function ‘std::unique_ptr<llvm::SmallVectorImpl<char> > perf::getBPFObjectFromModule(llvm::Module*)’:
util/c++/clang.cpp:150:43: error: no matching function for call to ‘llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::PassManager&, llvm::raw_svector_ostream&, llvm::TargetMachine::CodeGenFileType)’
             TargetMachine::CGFT_ObjectFile)) {
                                           ^
In file included from util/c++/clang.cpp:25:0:
/usr/local/include/llvm/Target/TargetMachine.h:254:16: note: candidate: virtual bool llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::PassManagerBase&, llvm::raw_pwrite_stream&, llvm::raw_pwrite_stream*, llvm::TargetMachine::CodeGenFileType, bool, llvm::MachineModuleInfo*)
   virtual bool addPassesToEmitFile(PassManagerBase &, raw_pwrite_stream &,
                ^~~~~~~~~~~~~~~~~~~
/usr/local/include/llvm/Target/TargetMachine.h:254:16: note:   candidate expects 6 arguments, 3 provided
mv: cannot stat '/tmp/tmp.t53Qo38zci/util/c++/.clang.o.tmp': No such file or directory
make[7]: *** [/home/acme/git/perf/tools/build/Makefile.build:101: /tmp/tmp.t53Qo38zci/util/c++/clang.o] Error 1
make[6]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: c++] Error 2
make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[5]: *** Waiting for unfinished jobs....
  CC       /tmp/tmp.t53Qo38zci/tests/thread-map.o

- Arnaldo
