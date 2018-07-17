Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F62ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707992145D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707992145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbeGQNmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:42:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731464AbeGQNmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:42:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BCCBCCB8;
        Tue, 17 Jul 2018 13:10:15 +0000 (UTC)
Date:   Tue, 17 Jul 2018 15:10:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4.4 14/43] tools build: fix # escaping in .cmd files for
 future Make
Message-ID: <20180717131013.GB5171@kroah.com>
References: <20180716073511.796555857@linuxfoundation.org>
 <20180716073513.350026232@linuxfoundation.org>
 <d1a883c6-1b7c-8bf5-49e6-3e29a60ca117@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a883c6-1b7c-8bf5-49e6-3e29a60ca117@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:57:21PM +0300, Konstantin Khlebnikov wrote:
> This commit depends on commit 9564a8cf422d7b58f6e857e3546d346fa970191e
> "Kbuild: fix # escaping in .cmd files for future Make"
> which is missing in 4.4.141
> 
> 
> this breaks compilation of tools/perf for me
> 
> make -C tools/perf V=1 JOBS=24 WERROR=0 NO_GTK2=1 LDFLAGS=-static all
> make[1]: Entering directory `/tmp/buildd/linux-yandex-4.4.141/tools/perf'
>   BUILD:   Doing 'make -j24' parallel build
> 
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ OFF ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ OFF ]
> ...                      libaudit: [ on  ]
> ...                        libbfd: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ on  ]
> ...        numa_num_possible_cpus: [ on  ]
> ...                       libperl: [ OFF ]
> ...                     libpython: [ OFF ]
> ...                      libslang: [ on  ]
> ...                     libunwind: [ on  ]
> ...            libdw-dwarf-unwind: [ OFF ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ on  ]
> ...                     get_cpuid: [ on  ]
> ...                           bpf: [ on  ]
> 
> config/Makefile:274: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR
> config/Makefile:282: Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157
> config/Makefile:458: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
> config/Makefile:501: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
> $(:)
> make -C /tmp/buildd/linux-yandex-4.4.141/tools/build fixdep
> /bin/sh util/PERF-VERSION-GEN
> make -f /tmp/buildd/linux-yandex-4.4.141/tools/build/Makefile.build dir=. obj=fixdep
> . util/generate-cmdlist.sh > common-cmds.h+ && mv common-cmds.h+ common-cmds.h
> .fixdep.o.cmd:1: *** missing separator.  Stop.
> make[3]: *** [fixdep-in.o] Error 2
> make[2]: *** [fixdep] Error 2

Ick.

Ok, let me go backport the original patch to 4.4.y now to try to fix
this up, sorry about that.

greg k-h
