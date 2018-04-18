Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753917AbeDROZo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:25:44 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:43484 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeDROZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:25:42 -0400
Message-ID: <1524061197.17523.10.camel@klomp.org>
Subject: Re: perf probe line numbers + CONFIG_DEBUG_INFO_SPLIT=y
From: Mark Wielaard <mark@klomp.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        systemtap@sourceware.org
Date: Wed, 18 Apr 2018 16:19:57 +0200
In-Reply-To: <20180418230301.fd26676ece5b2dc16d98b266@kernel.org>
References: <20180417174701.GD3625@kernel.org>
         <20180418122343.67575c580c0dc5cf11b6ddeb@kernel.org>
         <20180418230301.fd26676ece5b2dc16d98b266@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.22.6 (3.22.6-14.el7) 
Mime-Version: 1.0
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-18 at 23:03 +0900, Masami Hiramatsu wrote:
> It shows where we can see the .dwo file.
> However, it seems elfutils doesn't support dwo.
> 
> $ eu-readelf --debug-dump=info ~/kbin/linux.x86_64/fs/namei.dwo 
> eu-readelf: cannot get debug context descriptor: No DWARF information
> found
> 
> As above gcc article said, the section name has been changed.
> 
> $ eu-readelf -S ~/kbin/linux.x86_64/fs/namei.dwo There are 10 section
> headers, starting at offset 0x49440:
> 
> Section Headers:
> [Nr]
> Name                 Type         Addr             Off      Size     
> ES Flags Lk Inf Al
> [ 0]                      NULL         0000000000000000 00000000
> 00000000  0        0   0  0
> [ 1] .debug_info.dwo      PROGBITS     0000000000000000 00000040
> 000252d7  0 E      0   0  1
> [ 2] .debug_abbrev.dwo    PROGBITS     0000000000000000 00025317
> 00000f2f  0 E      0   0  1
> [ 3] .debug_loc.dwo       PROGBITS     0000000000000000 00026246
> 00004f9b  0 E      0   0  1
> 
> 
> And I found below description in systemtap
> document(man/error::dwarf.7stap).
> ===
> debuginfo configuration
> Some tools may generate debuginfo that is unsupported by systemtap,
> such
> as the linux kernel CONFIG_DEBUG_INFO_SPLIT (\f2.dwo\f1 files)
> option.
> Stick with plain ELF/DWARF (optinally split, Fedora-style), if
> possible.
> ===
> 
> So, it seems that elfutils may not support this split debuginfo yet.

No, it doesn't yet. I am working on it. Work in progress patches here:
https://code.wildebeest.org/git/user/mjw/elfutils/log/?h=dwarf5

That includes work on DWARF5 (which also supports split DWARF, but
slightly different from how GNU DebugFission works...).

I am trying to keep the interface of libdw completely the same. In most
cases things should work as is, even though the DIEs or locations come
from different sections/files. But have added some new functions to
"jump" from the skeleton DIEs to split DIEs in case the user needs to
know about the difference (and you probably want to, because otherwise
it will look like you just get "empty" skeleton DIE trees - see the
patches for eu-readelf --debug-dump=info+ and --dwarf-skeleton - but
those are very much WIP, don't use them as is, they are more to
figuring out what interfaces we need).

elfutils 0.171 with support for DWARF5, split DWARF and those new
interfaces should be out as soon as those WIP patches have been cleaned
up.

Once that is done, I'll use the new interfaces to add support to
systemtap.

Cheers,

Mark
