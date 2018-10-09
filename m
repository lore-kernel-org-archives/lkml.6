Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A64BECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48601214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48601214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJJAFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:05:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbeJJAFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:05:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 079273082E03;
        Tue,  9 Oct 2018 16:47:46 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1EADE84F7;
        Tue,  9 Oct 2018 16:47:43 +0000 (UTC)
Date:   Tue, 9 Oct 2018 18:47:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Anthony LaTorre <tlatorre9@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: perf report segfault
Message-ID: <20181009164743.GA22886@krava>
References: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Oct 2018 16:47:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:27:04AM -0500, Anthony LaTorre wrote:
> Hi,
> 
> I'm currently running Linux kernel 4.18.10-100.fc27.x86_64 and have a
> problem profiling a program that used to work. Currently when I
> profile the program with the following command:
> 
> $ perf record -F 99 -p PID --call-graph dwarf sleep 10
> 
> it produces a data file which causes perf report to segfault:
> 
> $ perf report
> perf: Segmentation fault
> -------- backtrace --------
> perf(+0x325302)[0x55860ae79302]
> /lib64/libc.so.6(+0x347d0)[0x7fbc8f3987d0]
> perf(+0x273e80)[0x55860adc7e80]
> perf(unwind__get_entries+0x1d9)[0x55860ae4ace9]
> perf(thread__resolve_callchain+0xfd)[0x55860adce7dd]
> perf(sample__resolve_callchain+0x58)[0x55860adc45b8]
> perf(hist_entry_iter__add+0x98)[0x55860adfa908]
> perf(+0x1ab8d9)[0x55860acff8d9]
> perf(+0x280603)[0x55860add4603]
> perf(+0x283c63)[0x55860add7c63]
> perf(+0x280e04)[0x55860add4e04]
> perf(perf_session__process_events+0x8ae)[0x55860add6bee]
> perf(cmd_report+0x190f)[0x55860ad01a4f]
> perf(+0x21a961)[0x55860ad6e961]
> perf(+0x21ac6e)[0x55860ad6ec6e]
> perf(main+0x361)[0x55860ace8411]
> /lib64/libc.so.6(__libc_start_main+0xea)[0x7fbc8f384fea]
> perf(_start+0x2a)[0x55860ace889a]
> 
> I've attached the data file which is causing the issue.
> 
> The perf version is:
> 
> $ perf --version
> perf version 4.18.10
> 
> and I'm running Fedora 27 if that makes a difference.
> 
> I've tried to reproduce with simpler programs so I could send a
> minimal working example, but it doesn't appear to cause the issue.

please do, I can't reproduce this

thanks,
jirka
