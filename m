Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeFENlr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751750AbeFENlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:41:46 -0400
Date: Tue, 5 Jun 2018 10:41:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix object code reading for PTI entry
 trampolines
Message-ID: <20180605134142.GE4899@kernel.org>
References: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 05, 2018 at 10:30:00AM +0300, Adrian Hunter escreveu:
> Fix object code reading and the "Object code reading" test for PTI entry
> trampolines.
> 
> perf tools uses map__rip_2objdump() to calculate objdump virtual addresses.
> map__rip_2objdump() needs to be amended to deal with PTI entry trampolines.
> Also the "Object code reading" test will not create maps for the PTI entry
> trampolines unless the machine environment exists to show that the arch is
> x86_64.

So, I split it into two patches, right at the "Also" part in your
description:

[acme@seventh perf]$ git log --oneline -2
36800a71b000 (HEAD -> perf/core) perf map: Consider PTI entry trampolines in rip_2objdump()
2f6777b74f6d perf test code-reading: Fix perf_env setup for PTI entry trampolines
[acme@seventh perf]$

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core

And this test fails way less often, but still does, for instance:

# while true ; do perf test -v object 2>out.txt ; grep -i fail out.txt && break ; done
dso__data_read_offset failed
Object code reading: FAILED!
#
[root@seventh ~]# tail out.txt 
File is: /proc/kcore
On file address is: 0x7fff892300df
kcore map tested already - skipping
Reading object code for memory address: 0x4a020f
File is: /home/acme/bin/perf (deleted)
On file address is: 0xa020f
dso__data_read_offset failed
test child finished with -1
---- end ----
Object code reading: FAILED!
[root@seventh ~]#

I start that loop and then try running 'make -C tools/perf O=/tmp/build/perf install-bin',
to generate some load.

But now at least on a quiet system it works.

- Arnaldo
