Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5169C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974EE20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974EE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLILz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:55:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeLILz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:55:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C9C086663;
        Sun,  9 Dec 2018 11:55:27 +0000 (UTC)
Received: from krava (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id E738660C47;
        Sun,  9 Dec 2018 11:55:24 +0000 (UTC)
Date:   Sun, 9 Dec 2018 12:55:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: perf: perf_fuzzer triggers GPF in perf_prepare_sample
Message-ID: <20181209115523.GA3501@krava>
References: <alpine.DEB.2.21.1812041039220.19558@macbook-air>
 <20181205124538.GA19343@krava>
 <20181205163838.GA3836@krava>
 <alpine.DEB.2.21.1812051208580.29892@macbook-air>
 <20181205183326.GE3836@krava>
 <alpine.DEB.2.21.1812061033180.2368@macbook-air>
 <20181206154425.GA21381@krava>
 <alpine.DEB.2.21.1812082105500.12282@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812082105500.12282@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 09 Dec 2018 11:55:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 09:08:28PM -0500, Vince Weaver wrote:
> On Thu, 6 Dec 2018, Jiri Olsa wrote:
> 
> > On Thu, Dec 06, 2018 at 10:35:28AM -0500, Vince Weaver wrote:
> > > On Wed, 5 Dec 2018, Jiri Olsa wrote:
> > > Maybe it is a corruption issue.  I had applied my own debug patch that 
> > > would dump some info if data->callchain was NULL.
> > > 
> > > But my debug code didn't trigger this time because it looks like 
> > > data->callchain was "1" rather than "0".
> > > 
> > > [27764.840179] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
> > > [27764.840179] PGD 0 P4D 0 
> > > [27764.840180] Oops: 0000 [#1] SMP PTI
> > > [27764.840180] CPU: 1 PID: 18687 Comm: perf_fuzzer Tainted: G        W         4.20.0-rc5+ #125
> > > [27764.840180] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
> > 
> > actually, you could try that patch from my previous email?
> > 
> still crashes with your patch (see below)
> 
> I've also been able to replicate this crash on a skylake machine in 
> addition to the haswell machine.
> 
> Vince
> 
> [28269.147232] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [28269.155628] PGD 0 P4D 0 
> [28269.158360] Oops: 0000 [#1] SMP PTI
> [28269.162087] CPU: 0 PID: 1189 Comm: perf_fuzzer Tainted: G        W         4.20.0-rc5+ #128
> [28269.171011] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
> [28269.178935] RIP: 0010:perf_prepare_sample+0x82/0x4a0
> [28269.184239] Code: 06 4c 89 ea 4c 89 e6 e8 3c 54 ff ff 40 f6 c5 01 0f 85 28 01 00 00 40 f6 c5 20 74 1c 48 85 ed 0f 89 04 01 00 00 49 8b 44 24 70 <48> 8b 00 8d 04 c5 08 00 00 00 66 01 43 06 f7 c5 00 04 00 00 74 41
> [28269.204249] RSP: 0000:ffffc9000aca7a40 EFLAGS: 00010082
> [28269.209832] RAX: 0000000000000000 RBX: ffffc9000aca7a98 RCX: ffffc9000aca7ad8
> [28269.217484] RDX: 0000000000000000 RSI: ffffc9000aca7b80 RDI: ffffc9000aca7a9e
> [28269.225129] RBP: 80000000000bb068 R08: 0000000000000002 R09: 00000000000215c0
> [28269.232760] R10: ffff8880ce552000 R11: 0000000000000000 R12: ffffc9000aca7b80
> [28269.240380] R13: ffff88803696c800 R14: ffffc9000aca7ad8 R15: ffffe8ffffc06300
> [28269.248014] FS:  00007f5927fe7500(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
> [28269.256606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [28269.262739] CR2: 0000000000000000 CR3: 0000000116d98001 CR4: 00000000001607f0
> [28269.270349] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [28269.277968] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> [28269.285639] Call Trace:
> [28269.288266]  intel_pmu_drain_bts_buffer+0x151/0x220
> [28269.293476]  ? radix_tree_delete_item+0x69/0xc0
> [28269.298378]  x86_pmu_stop+0x3b/0x90
> [28269.302113]  x86_pmu_del+0x57/0x160

nice, at least it's in different callstack context, that might help

thanks,
jirka
