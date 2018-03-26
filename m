Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeCZO0I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751750AbeCZO0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:26:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114652172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 26 Mar 2018 11:26:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com
Subject: Re: [PATCH] perf mmap: Fix accessing unmapped mmap in
 perf_mmap__read_done()
Message-ID: <20180326142604.GE18897@kernel.org>
References: <1522071729-16776-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522071729-16776-1-git-send-email-kan.liang@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 26, 2018 at 09:42:09AM -0400, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> There is segmentation fault when running perf trace. For example,
>   [root@jouet e]# perf trace -e *chdir -o /tmp/bla perf report
>   --ignore-vmlinux -i ../perf.data
> 
> The perf_mmap__consume() could unmap the mmap. It needs to check the
> refcnt in perf_mmap__read_done().
> 
> Fixes: ee023de05f35 ("perf mmap: Introduce perf_mmap__read_done()")
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Seems insuficient:

[root@jouet ~]# perf trace -e *chdir -o /tmp/bla perf report --ignore-vmlinux
perf: Segmentation fault
Obtained 9 stack frames.
perf(sighandler_dump_stack+0x3e) [0x4fe31e]
/lib64/libc.so.6(+0x346df) [0x7fc0c3ced6df]
perf(perf_mmap__read_init+0x26) [0x4ccd06]
perf(cmd_trace+0x1bf6) [0x47bb76]
perf() [0x4a824e]
perf() [0x4a8550]
perf(main+0x331) [0x42bef1]
/lib64/libc.so.6(__libc_start_main+0xe9) [0x7fc0c3cd9f29]
perf(_start+0x29) [0x42c319]
Segmentation fault (core dumped)
[root@jouet ~]#

- Arnaldo
