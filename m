Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C81C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0D1213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILzoCu91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0D1213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJDDra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeJDDra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:47:30 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7791F21470;
        Wed,  3 Oct 2018 20:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538600247;
        bh=19sq0Qmx7QEULAEBz9FZYX4EDh/Fxc0muhnnw2Ah9lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILzoCu91MMk9gVCMYNDduPrFpD4jzoXzIlNTTldJEUDorGupzQ2RoPhVvQ07ebnRL
         HDoffMHDRhbBCDsdRcTHUeshlppF3d/pCnwm628u9f0SkrQLZAXHuo+GRrpvz3f3cm
         R+Nvx2Tp0r67g7SU9C8Q9Ll7gQTL2Oof1NSmeeW8=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 582A5141CFD; Wed,  3 Oct 2018 17:57:25 -0300 (-03)
Date:   Wed, 3 Oct 2018 17:57:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Symbols not found for some files
Message-ID: <20181003205725.GD11343@kernel.org>
References: <c5e4d596-0805-a45e-b6b2-cda43c9f6953@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e4d596-0805-a45e-b6b2-cda43c9f6953@molgen.mpg.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 03, 2018 at 10:42:39PM +0200, Paul Menzel escreveu:
> Dear Linux folks,
> 
> 
> For profiling the boot on my Debian Sid/unstable system (32-bit user space),
> the following service unit is used.

You forgot to mention what is the version of the perf tool in that
system, so that I could check if this got fixed somehow after that
version.

Can you please provide it?

Thanks,

- Arnaldo
 
> ```
> $ systemctl cat perf
> # /etc/systemd/system/perf.service
> 
> [Unit]
> Description=Perf 10 s
> DefaultDependencies=no
> 
> [Service]
> ExecStart=/usr/local/bin/perf record -F 999 -g -a -o /dev/shm/perf.data
> sleep 10
> 
> [Install]
> WantedBy=sysinit.target
> ```
> 
> Running `perf.data` through `perf script`, the messages below are shown.
> 
> ```
> [vdso] with build id 69dd0f0c522f0d3e2a87722d70245ab9725c8b42 not found,
> continuing without symbols
> /lib/systemd/libsystemd-shared-239.so with build id
> 196c7922a15fa971d68775522dd16e82da46ebb3 not found, continuing without
> symbols
> /lib/systemd/systemd-journald with build id
> 9e31591e8c9bb88de06e96a251f34d8a7e201f6c not found, continuing without
> symbols
> /lib/systemd/systemd with build id 1b92f342a959b6ff370b82092bfadaf1d470a7b9
> not found, continuing without symbols
> /lib/systemd/systemd-networkd with build id
> 9fa8f6abc1f2e5c1018d0a33be058c22e25efaff not found, continuing without
> symbols
> /lib/systemd/systemd-logind with build id
> 63d664b5f8f8e85274aff6730ec9e924d74c8fed not found, continuing without
> symbols
> ```
> 
> But, the debug symbol packages are installed (`systemd-dbgsym`), and GDB
> loads the debug symbols just fine.
> 
> ```
> $ gdb --quiet /lib/systemd/libsystemd-shared-239.so
> Reading symbols from /lib/systemd/libsystemd-shared-239.so...Reading symbols
> from /usr/lib/debug/.build-id/19/6c7922a15fa971d68775522dd16e82da46ebb3.debug...done.
> done.
> (gdb)
> ```
> 
> Tracing `perf`, it also seems to find them, but does not use them.
> 
> ```
> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f",
> 0xbfbd54ac) = -1 ENOENT (No such file or directory)
> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f/elf",
> 0xbfbd75bc) = -1 ENOENT (No such file or directory)
> stat64("03af6935d5ab00f79fe12b4098d27d3f70c19f.debug", 0xbfbd1bfc) = -1
> ENOENT (No such file or directory)
> stat64("/lib/i386-linux-gnu/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
> 0xbfbd1bfc) = -1 ENOENT (No such file or directory)
> stat64("/lib/i386-linux-gnu/.debug/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
> 0xbfbd1bfc) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/debug/lib/i386-linux-gnu/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
> 0xbfbd1bfc) = -1 ENOENT (No such file or directory)
> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f",
> 0xbfbd1b5c) = -1 ENOENT (No such file or directory)
> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f/elf",
> 0xbfbd3c6c) = -1 ENOENT (No such file or directory)
> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f",
> 0xbfbd1b5c) = -1 ENOENT (No such file or directory)
> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f/debug",
> 0xbfbd3c6c) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
> {st_mode=S_IFREG|0644, st_size=4524336, ...}) = 0
> openat(AT_FDCWD,
> "/usr/lib/debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
> O_RDONLY|O_LARGEFILE) = 91
> ```
> 
> Looking into `perf` with GDB, the code in `util/symbol.c` below is not
> setting `runtime_ss`, because `symsrc__possibly_runtime(ss)` returns false.
> Then the for loop is not quit, and continues.
> 
> ```
>                 if (!syms_ss && symsrc__has_symtab(ss)) {
>                         syms_ss = ss;
>                         next_slot = true;
>                         if (!dso->symsrc_filename)
>                                 dso->symsrc_filename = strdup(name);
>                 }
> 
>                 if (!runtime_ss && symsrc__possibly_runtime(ss)) {
>                         runtime_ss = ss;
>                         next_slot = true;
>                 }
> 
>                 if (next_slot) {
>                         ss_pos++;
> 
>                         if (syms_ss && runtime_ss)
>                                 break;
>                 } else {
>                         symsrc__destroy(ss);
>                 }
> 
> ```
> 
> Do you have an idea, why the files from the systemd Debian package cause
> problems for `perf` but not GDB? The Debian maintainers mentioned, that LTO
> is enabled for the Debian package.
> 
> Please tell me, if you need other information to look into the problem.
> 
> 
> Kind regards,
> 
> Paul
