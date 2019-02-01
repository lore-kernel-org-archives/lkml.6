Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5B4C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0523521726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549008657;
	bh=+zqkzQBlKoTieb7Fw0ulPWd8TVjqJu4xotMimUbRwBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CNVXNPTdSV0t7/LtfjUt9NF6e+VgSCu9cMgCEyt+xQKUCzz6skfVpJr09Tej/b2XP
	 +ko71ZnO4DSl2AVJueezFduP81sJ69/N9JqpomqONrKUjBfCPSn0JsBI5bQBo5Sp0K
	 1N5rx5vN3dONvdf7o2qs3lstMQfrE8S9wanZBEU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfBAIKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:10:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBAIKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:10:54 -0500
Received: from quaco.ghostprotocols.net (unknown [94.113.247.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771442184A;
        Fri,  1 Feb 2019 08:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549008653;
        bh=+zqkzQBlKoTieb7Fw0ulPWd8TVjqJu4xotMimUbRwBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wHUPyKOAdY4WBtDnqVMJEKpdVKRq/pm1eNipJy/LlYgUINL9Om+5QHlvBN1aJKPzC
         n0p8DygxSlSr9z9ovXxMLRwa2Qo9M73x003TR0fIPMU7DOWQb34yTOLt59oa9ssLw+
         fg2BU+9qrMwf//LG/KV2GH9QumVzYmXiA4lAR2fk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E94DC4034F; Fri,  1 Feb 2019 09:10:50 +0100 (CET)
Date:   Fri, 1 Feb 2019 09:10:50 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Add doc for bpf event selection
Message-ID: <20190201081050.GA8839@kernel.org>
References: <20190201030641.4046-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201030641.4046-1-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 01, 2019 at 03:06:41AM +0000, Changbin Du escreveu:
> Add document for how to pass bpf program with perf.

That is a good start, see some comments below.
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index d232b13ea713..0925d987cad0 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -88,6 +88,19 @@ OPTIONS
>            If you want to profile write accesses in [0x1000~1008), just set
>            'mem:0x1000/8:w'.
>  
> +        - a bpf source file or object file to select events by a bpf program.

             A source file (ending in .c) or a precompiled object file (ending in .o)
	     selects one or more BPF events.

> +          The bpf program can attach to variant perf events based on section
             The BPFa                      various
> +          names.
> +
> +          When passing '.c', perf searches installed LLVM to compile it into
                                             a
> +          object file first. Optional clang options can be pased by option
           an
> +          '--clang-opt'.
> +
> +          perf record --clang-opt "-DLINUX_VERSION_CODE=0x50000" \
> +                      -e ./tests/bpf-script-example.c
> +
> +          Note: '--clang-opt' must place before '--event'.

Please mention ~/.perfconfig, that needs a section in the
tools/perf/Documentation/perf-config.txt, for instance I have right now:

[root@quaco ~]# cat ~/.perfconfig
[llvm]
	dump-obj = true
	clang-opt = -g

The 'clang-opt' is the same as the command line arg you documented
above, dump object may be used to update a .o file, like:

[root@quaco ~]# vim /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c 
 
 # Do some changes, save

[root@quaco ~]# perf record -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.023 MB perf.data ]
[root@quaco ~]# 

And if you are up to documenting the remaining features, which I'd
encourage you, please take a look at:

tools/perf/util/llvm-utils.c

In the perf_llvm_config function. there are more things that needs
documenting, and doing a:

  git blame tools/perf/util/llvm-utils.c

Helps in getting the needed explanations, for instance, the original
patch adding the .perfconfig section was this:

git show aa61fd05ca796

And it has, for instance, among others:

            # kbuild directory. If not set, use /lib/modules/`uname -r`/build.
            # If set to "" deliberately, skip kernel header auto-detector.
            kbuild-dir = "/path/to/kernel/build"

            # Options passed to 'make' when detecting kernel header options.
            kbuild-opts = "ARCH=x86_64"

Thanks for working on documenting these features!

- Arnaldo


> +
>  	- a group of events surrounded by a pair of brace ("{event1,event2,...}").
>  	  Each event is separated by commas and the group should be quoted to
>  	  prevent the shell interpretation.  You also need to use --group on
> -- 
> 2.17.1

-- 

- Arnaldo
