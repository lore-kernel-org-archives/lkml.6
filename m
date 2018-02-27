Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeB0KHh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:07:37 -0500
Received: from exmail.andestech.com ([59.124.169.137]:59815 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeB0KHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:07:33 -0500
Date: Tue, 27 Feb 2018 18:04:26 +0800
From: Alan Kao <alankao@andestech.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        <sw-dev@groups.riscv.org>, <linux-kernel@vger.kernel.org>
CC: <greentime@andestech.com>, <zong@andestech.com>
Subject: ftrace: Proposal for an Alternative RecordMcount framework
Message-ID: <20180227100425.GB20904@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w1RA4qfS073557
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Current recordmcount framework collects the mcount call-sites by grep'ing
the relocation info in each *.o file right after it is compiled, and then
puts them into the __mcount_loc_start array.  This works fine in many 
architectures, but as mentioned in this riscv/ftrace patch[1], aggressive 
relaxing optimizations corrupt the collected offsets, resulting in panics 
due to wrong call-site patching in runtime.

Meanwhile, some architectures, such as RISC-V and the on-going nds32, highly 
rely on linker relaxation as a link-time optimization to reduce code size 
and improve performance.  It would be very undesirable to sacrifice them for
ftrace only.  But, why can't we collect the call-sites after all of them 
are fixed?

We propose an alternative framework, for architectures that cannot
properly record call-sites because of relaxing.  Here is the rough 
procedure:

1. During the final linking stages, do "objdump vmlinux.o | grep ..." [2]
2. Form the output as an ELF objecj
3. Link the object to __mcount_loc_start symbol
4. Done

With the similar reason as the patch [3], we should mark _mcount to be
a weak symbol to prevent it from being relaxed later.

We would like to know your opinion and comments on this.
Thanks!

Alan Kao

[1] riscv/ftrace dynamic support [patch v4 1/6]: 
    https://lkml.org/lkml/2018/2/13/12
[2] This used to not collect some call-sites since their jumps has no
    target symbol hint. It becomes possible after the fix in 2.30 release.
    See https://github.com/riscv/riscv-binutils-gdb/issues/129 for more
    details.
[3] https://lkml.org/lkml/2016/5/14/101
