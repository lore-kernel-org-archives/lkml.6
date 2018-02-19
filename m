Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeBSONF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750978AbeBSOND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:13:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E9A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 19 Feb 2018 11:13:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: changbin.du@intel.com
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] perf ftrace: Append an EOL when write tracing files
Message-ID: <20180219141300.GE14978@kernel.org>
References: <1519007609-14551-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519007609-14551-1-git-send-email-changbin.du@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 19, 2018 at 10:33:29AM +0800, changbin.du@intel.com escreveu:
> From: Changbin Du <changbin.du@intel.com>
> 
> Before this change, the '--graph-funcs', '--nograph-funcs' and
> '--trace-funcs' options didn't work as expected when the <func> doesn't
> exist. Because the kernel side hid possible errors.
> 
> $ sudo ./perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
>  0)   0.140 us    |  rcu_all_qs();
>  3)   0.304 us    |  mutex_unlock();
>  0)   0.153 us    |  find_vma();
>  3)   0.088 us    |  __fsnotify_parent();
>  0)   6.145 us    |  handle_mm_fault();
>  3)   0.089 us    |  fsnotify();
>  3)   0.161 us    |  __sb_end_write();
>  3)   0.710 us    |  SyS_close();
>  3)   7.848 us    |  exit_to_usermode_loop();
> 
> On above example, I specified function filter 'abcdefg' but all functions
> are enabled. The expected error is hidden.
> 
> The original fix is to make the kernel support '\0' as end of string:
> https://lkml.org/lkml/2018/1/16/116
> 
> But above fix cannot be compatible with old kernels. Then Namhyung Kim
> suggest adding a space after function name.
> 
> This patch will append an '\n' when write tracing file. After this fix,
> the perf will report correct error state. Also let it print an error if
> reset_tracing_files() fails.

Ok, now it prints:

[root@jouet ~]# perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
failed to set tracing filters
[root@jouet ~]#

which is too vague, i.e. the user is left without knowing what was it
that didn't work in setting the filter.

It would be better to have:

[root@jouet ~]# perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
failed to set tracing filters: function 'abcdefg' not found.
[root@jouet ~]#

Anyway, this improves the current situation, so I'm applying it.

- Arnaldo
