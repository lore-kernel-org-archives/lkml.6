Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5751C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0A720645
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0A720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJDKKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:10:51 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36535 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbeJDKKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:10:51 -0400
Received: from [192.168.0.4] (ip5f5bd26f.dynamic.kabel-deutschland.de [95.91.210.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E80132012D0DC1;
        Thu,  4 Oct 2018 05:19:39 +0200 (CEST)
Subject: Re: Symbols not found for some files
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <c5e4d596-0805-a45e-b6b2-cda43c9f6953@molgen.mpg.de>
 <20181003205725.GD11343@kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <4781b2a6-3ace-451c-2e00-4d3de711560d@molgen.mpg.de>
Date:   Thu, 4 Oct 2018 05:19:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003205725.GD11343@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arnaldo,


Am 03.10.2018 um 22:57 schrieb Arnaldo Carvalho de Melo:
> Em Wed, Oct 03, 2018 at 10:42:39PM +0200, Paul Menzel escreveu:

>> For profiling the boot on my Debian Sid/unstable system (32-bit user space),
>> the following service unit is used.
> 
> You forgot to mention what is the version of the perf tool in that
> system, so that I could check if this got fixed somehow after that
> version.
> 
> Can you please provide it?

Sorry for not mentioning it. I built it from Linus’ Linux master branch.

     $ perf --version
     perf version 4.19.rc5.gd7887c


Kind regards,

Paul


>> ```
>> $ systemctl cat perf
>> # /etc/systemd/system/perf.service
>>
>> [Unit]
>> Description=Perf 10 s
>> DefaultDependencies=no
>>
>> [Service]
>> ExecStart=/usr/local/bin/perf record -F 999 -g -a -o /dev/shm/perf.data
>> sleep 10
>>
>> [Install]
>> WantedBy=sysinit.target
>> ```
>>
>> Running `perf.data` through `perf script`, the messages below are shown.
>>
>> ```
>> [vdso] with build id 69dd0f0c522f0d3e2a87722d70245ab9725c8b42 not found,
>> continuing without symbols
>> /lib/systemd/libsystemd-shared-239.so with build id
>> 196c7922a15fa971d68775522dd16e82da46ebb3 not found, continuing without
>> symbols
>> /lib/systemd/systemd-journald with build id
>> 9e31591e8c9bb88de06e96a251f34d8a7e201f6c not found, continuing without
>> symbols
>> /lib/systemd/systemd with build id 1b92f342a959b6ff370b82092bfadaf1d470a7b9
>> not found, continuing without symbols
>> /lib/systemd/systemd-networkd with build id
>> 9fa8f6abc1f2e5c1018d0a33be058c22e25efaff not found, continuing without
>> symbols
>> /lib/systemd/systemd-logind with build id
>> 63d664b5f8f8e85274aff6730ec9e924d74c8fed not found, continuing without
>> symbols
>> ```
>>
>> But, the debug symbol packages are installed (`systemd-dbgsym`), and GDB
>> loads the debug symbols just fine.
>>
>> ```
>> $ gdb --quiet /lib/systemd/libsystemd-shared-239.so
>> Reading symbols from /lib/systemd/libsystemd-shared-239.so...Reading symbols
>> from /usr/lib/debug/.build-id/19/6c7922a15fa971d68775522dd16e82da46ebb3.debug...done.
>> done.
>> (gdb)
>> ```
>>
>> Tracing `perf`, it also seems to find them, but does not use them.
>>
>> ```
>> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f",
>> 0xbfbd54ac) = -1 ENOENT (No such file or directory)
>> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f/elf",
>> 0xbfbd75bc) = -1 ENOENT (No such file or directory)
>> stat64("03af6935d5ab00f79fe12b4098d27d3f70c19f.debug", 0xbfbd1bfc) = -1
>> ENOENT (No such file or directory)
>> stat64("/lib/i386-linux-gnu/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
>> 0xbfbd1bfc) = -1 ENOENT (No such file or directory)
>> stat64("/lib/i386-linux-gnu/.debug/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
>> 0xbfbd1bfc) = -1 ENOENT (No such file or directory)
>> stat64("/usr/lib/debug/lib/i386-linux-gnu/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
>> 0xbfbd1bfc) = -1 ENOENT (No such file or directory)
>> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f",
>> 0xbfbd1b5c) = -1 ENOENT (No such file or directory)
>> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f/elf",
>> 0xbfbd3c6c) = -1 ENOENT (No such file or directory)
>> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f",
>> 0xbfbd1b5c) = -1 ENOENT (No such file or directory)
>> stat64("/home/kodi/.debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f/debug",
>> 0xbfbd3c6c) = -1 ENOENT (No such file or directory)
>> stat64("/usr/lib/debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
>> {st_mode=S_IFREG|0644, st_size=4524336, ...}) = 0
>> openat(AT_FDCWD,
>> "/usr/lib/debug/.build-id/a2/03af6935d5ab00f79fe12b4098d27d3f70c19f.debug",
>> O_RDONLY|O_LARGEFILE) = 91
>> ```
>>
>> Looking into `perf` with GDB, the code in `util/symbol.c` below is not
>> setting `runtime_ss`, because `symsrc__possibly_runtime(ss)` returns false.
>> Then the for loop is not quit, and continues.
>>
>> ```
>>                  if (!syms_ss && symsrc__has_symtab(ss)) {
>>                          syms_ss = ss;
>>                          next_slot = true;
>>                          if (!dso->symsrc_filename)
>>                                  dso->symsrc_filename = strdup(name);
>>                  }
>>
>>                  if (!runtime_ss && symsrc__possibly_runtime(ss)) {
>>                          runtime_ss = ss;
>>                          next_slot = true;
>>                  }
>>
>>                  if (next_slot) {
>>                          ss_pos++;
>>
>>                          if (syms_ss && runtime_ss)
>>                                  break;
>>                  } else {
>>                          symsrc__destroy(ss);
>>                  }
>>
>> ```
>>
>> Do you have an idea, why the files from the systemd Debian package cause
>> problems for `perf` but not GDB? The Debian maintainers mentioned, that LTO
>> is enabled for the Debian package.
>>
>> Please tell me, if you need other information to look into the problem.
>>
>>
>> Kind regards,
>>
>> Paul
