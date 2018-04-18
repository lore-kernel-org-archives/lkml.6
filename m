Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDRODG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeDRODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:03:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4542178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 18 Apr 2018 23:03:01 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        systemtap@sourceware.org, Mark Wielaard <mark@klomp.org>
Subject: Re: perf probe line numbers + CONFIG_DEBUG_INFO_SPLIT=y
Message-Id: <20180418230301.fd26676ece5b2dc16d98b266@kernel.org>
In-Reply-To: <20180418122343.67575c580c0dc5cf11b6ddeb@kernel.org>
References: <20180417174701.GD3625@kernel.org>
        <20180418122343.67575c580c0dc5cf11b6ddeb@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 12:23:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Arnaldo,
> 
> On Tue, 17 Apr 2018 14:47:01 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Hi Masami,
> > 
> > 	I just tried building the kernel using:
> > 
> > CONFIG_DEBUG_INFO=y
> > # CONFIG_DEBUG_INFO_REDUCED is not set
> > CONFIG_DEBUG_INFO_SPLIT=y
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> 
> Yeah, this is what I have to solve...
> 
> > 
> > 	that info split looked interesting, and I thought that since we
> > use elfutils we'd get that for free somehow, so I tried getname_flags
> > and got the output at the end of this message, with these artifacts:
> > 
> > 1) the function signature doesn't appear at the start of the '-L
> > getname_flags' output
> > 
> > 2) offsets are not calculated, just the line numbers in fs/namei.c (it
> > matches the first line :130 with the first line number.
> 
> I think we need to use elfutils with different way, maybe passing
> correct debuginfo file, instead of vmlinux.
> Oh, did you got the source code lines? I'll try to reproduce it.

OK, I found this gcc article what actually happen if we enable that option.

https://gcc.gnu.org/wiki/DebugFission

With CONFIG_DEBUG_INFO_SPLIT=y, we will get very limited debuginfo
in vmlinux. It seems only have address-to-line information in
vmlinux, and the main DIE tree will be stored in .dwo files,
which is generated for each .o file.

That is why you could get source lines by "perf probe -L", but
failed to get variables etc. by "perf probe -a". (Note that perf-probe
always search DIE tree for finding correct "subprogram"(function) info.)


$ eu-readelf --debug-dump=info ~/kbin/linux.x86_64/vmlinux
DWARF section [63] '.debug_info' at offset 0x23f1db0:
 [Offset]
 Compilation unit at offset 0:
 Version: 2, Abbreviation section offset: 0, Address size: 8, Offset size: 4
 [     b]  compile_unit
           stmt_list            (data4) 0
           ranges               (data4) range list [     0]
           name                 (strp) "/home/mhiramat/ksrc/linux/arch/x86/kerne
l/head_64.S"
           comp_dir             (strp) "/home/mhiramat/kbin/linux.x86_64"
           producer             (strp) "GNU AS 2.27"
           language             (data2) Mips_Assembler (32769)
 Compilation unit at offset 34:
 Version: 4, Abbreviation section offset: 18, Address size: 8, Offset size: 4
 [    2d]  compile_unit
           ranges               (sec_offset) range list [   3b0]
           low_pc               (addr) 000000000000000000 <irq_stack_union>
           stmt_list            (sec_offset) 409
           lo_user+0x130        (strp) "arch/x86/kernel/head64.dwo"
           comp_dir             (strp) "/home/mhiramat/kbin/linux.x86_64"
           lo_user+0x134        (flag_present) yes
 Compilation unit at offset 86:
 Version: 4, Abbreviation section offset: 47, Address size: 8, Offset size: 4
 [    61]  compile_unit
           ranges               (sec_offset) range list [   470]
           low_pc               (addr) 000000000000000000 <irq_stack_union>
           stmt_list            (sec_offset) 4388
           lo_user+0x130        (strp) "arch/x86/kernel/ebda.dwo"
           comp_dir             (strp) "/home/mhiramat/kbin/linux.x86_64"
           lo_user+0x134        (flag_present) yes

It shows where we can see the .dwo file.
However, it seems elfutils doesn't support dwo.

$ eu-readelf --debug-dump=info ~/kbin/linux.x86_64/fs/namei.dwo 
eu-readelf: cannot get debug context descriptor: No DWARF information found

As above gcc article said, the section name has been changed.

$ eu-readelf -S ~/kbin/linux.x86_64/fs/namei.dwo There are 10 section headers, starting at offset 0x49440:

Section Headers:
[Nr] Name                 Type         Addr             Off      Size     ES Flags Lk Inf Al
[ 0]                      NULL         0000000000000000 00000000 00000000  0        0   0  0
[ 1] .debug_info.dwo      PROGBITS     0000000000000000 00000040 000252d7  0 E      0   0  1
[ 2] .debug_abbrev.dwo    PROGBITS     0000000000000000 00025317 00000f2f  0 E      0   0  1
[ 3] .debug_loc.dwo       PROGBITS     0000000000000000 00026246 00004f9b  0 E      0   0  1


And I found below description in systemtap document(man/error::dwarf.7stap).
===
debuginfo configuration
Some tools may generate debuginfo that is unsupported by systemtap, such
as the linux kernel CONFIG_DEBUG_INFO_SPLIT (\f2.dwo\f1 files) option.
Stick with plain ELF/DWARF (optinally split, Fedora-style), if possible.
===

So, it seems that elfutils may not support this split debuginfo yet.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
