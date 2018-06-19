Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB26C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AB520693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Mx7ZJ9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AB520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966286AbeFSNyi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965681AbeFSNyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:54:36 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C882083D;
        Tue, 19 Jun 2018 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529416476;
        bh=1nhY4RYV8AsZ8AGYddmdO1Vd7noDswZOhZm+yS3D1MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Mx7ZJ9z2I9YYAPytx9hgGxp4ttIVId9F9Rl1lKUEnSUXAysg2D5YgFcbOEDDLZt1
         xtUCvjQqM/TGdxkD2zTZq7tKCfA7qZ7p8CqGR4cgixAytGw2WaEohhRPQdgQN5yOlX
         L7+V72YDtwsdG/gWRCe6RmzGHybmLsh1rg5wiZwY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id D195F1413AA; Tue, 19 Jun 2018 10:54:28 -0300 (-03)
Date:   Tue, 19 Jun 2018 10:54:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1]: perf tests: check that complex event name is parsed
 correctly
Message-ID: <20180619135428.GE20477@kernel.org>
References: <ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 19, 2018 at 11:45:40AM +0300, Alexey Budankov escreveu:
> 
> Extend regression testing to cover case of complex event names enabled 
> by the patch "perf record: enable arbitrary event names thru name= modifier".
> 
> tools/perf/perf test
>  1: vmlinux symtab matches kallsyms                       : Skip
>  2: Detect openat syscall event                           : Ok
>  3: Detect openat syscall event on all cpus               : Ok
>  4: Read samples using the mmap interface                 : Ok
>  5: Test data source output                               : Ok
>  6: Parse event definition strings                        : Ok		<===!
>  7: Simple expression parser                              : Ok
> ...

Applied and added this to the commit log:

Committer testing:

  # perf test "event definition"
   6: Parse event definition strings                        : Ok
  # perf test -v 6 2> /tmp/before
  # perf test -v 6 2> /tmp/after
  # diff -u /tmp/before /tmp/after
  --- /tmp/before       2018-06-19 10:50:21.485572638 -0300
  +++ /tmp/after        2018-06-19 10:50:40.886572896 -0300
  @@ -1,6 +1,6 @@
    6: Parse event definition strings                        :
   --- start ---
  -test child forked, pid 24259
  +test child forked, pid 24904
   running test 0 'syscalls:sys_enter_openat'Using CPUID GenuineIntel-6-3D
   registering plugin: /root/.traceevent/plugins/plugin_kvm.so
   registering plugin: /root/.traceevent/plugins/plugin_hrtimer.so
  @@ -136,9 +136,11 @@
   running test 50 '4:0x6530160/name=numpmu/'
   running test 51 'L1-dcache-misses/name=cachepmu/'
   running test 52 'intel_pt//u'
  +running test 53 'cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk'
   running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
   running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
   running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
  +running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp'
   el-capacity -> cpu/event=0x54,umask=0x2/
   el-conflict -> cpu/event=0x54,umask=0x1/
   el-start -> cpu/event=0xc8,umask=0x1/

